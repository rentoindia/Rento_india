package com.rentoindia.backend.myhouse;

import com.rentoindia.backend.auth.Role;
import com.rentoindia.backend.auth.User;
import com.rentoindia.backend.auth.UserRepository;
import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.ApiResponse;
import com.rentoindia.backend.common.Body;
import com.rentoindia.backend.common.CurrentUser;
import com.rentoindia.backend.common.Obj;
import com.rentoindia.backend.common.Times;
import com.rentoindia.backend.notification.NotificationService;
import com.rentoindia.backend.realtime.EventHub;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/** My House (property rental): public search, owner tools, tenant tools. */
@RestController
@RequestMapping("/api/v1/myhouse")
public class MyHouseController {

    private final PropertyRepository properties;
    private final TenancyApplicationRepository applications;
    private final VisitRepository visits;
    private final MaintenanceRequestRepository maintenance;
    private final RentPaymentRepository rent;
    private final UtilityPaymentRepository utilities;
    private final UserRepository users;
    private final NotificationService notifications;
    private final EventHub hub;

    public MyHouseController(PropertyRepository properties, TenancyApplicationRepository applications,
                             VisitRepository visits, MaintenanceRequestRepository maintenance,
                             RentPaymentRepository rent, UtilityPaymentRepository utilities,
                             UserRepository users, NotificationService notifications, EventHub hub) {
        this.properties = properties;
        this.applications = applications;
        this.visits = visits;
        this.maintenance = maintenance;
        this.rent = rent;
        this.utilities = utilities;
        this.users = users;
        this.notifications = notifications;
        this.hub = hub;
    }

    private User me() {
        return users.findById(CurrentUser.id()).orElseThrow(() -> ApiException.unauthorized("Login required"));
    }

    private static String nameOf(User u, String fallback) {
        return u.fullName == null || u.fullName.isBlank() ? fallback : u.fullName;
    }

    private Property propertyOf(String id) {
        return properties.findById(Body.parseUuid(id)).orElseThrow(() -> ApiException.notFound("Property not found"));
    }

    // ================================================================ public search

    @GetMapping("/public/properties")
    public ApiResponse<Obj> search(@RequestParam(defaultValue = "") String city,
                                   @RequestParam(defaultValue = "") String locality,
                                   @RequestParam(defaultValue = "") String bhk,
                                   @RequestParam(defaultValue = "") String furnishing,
                                   @RequestParam(defaultValue = "") String suitableFor,
                                   @RequestParam(defaultValue = "0") double minRent,
                                   @RequestParam(defaultValue = "0") double maxRent,
                                   @RequestParam(defaultValue = "") String q,
                                   @RequestParam(defaultValue = "0") int page,
                                   @RequestParam(defaultValue = "50") int size) {
        Page<Property> res = properties.search(Property.Status.APPROVED, city.trim(), locality.trim(), bhk.trim(),
                furnishing.trim(), suitableFor.trim(), Math.max(0, minRent), maxRent <= 0 ? Double.MAX_VALUE : maxRent, q.trim(),
                PageRequest.of(Math.max(0, page), Math.min(Math.max(1, size), 200), Sort.by("createdAt").descending()));
        return ApiResponse.ok(Obj.of().with("items", res.getContent().stream().map(MyHouseController::propView).toList())
                .with("total", res.getTotalElements()));
    }

    @GetMapping("/public/properties/{id}")
    public ApiResponse<Obj> one(@PathVariable String id) {
        Property p = propertyOf(id);
        if (p.status != Property.Status.APPROVED) throw ApiException.notFound("Property not found");
        return ApiResponse.ok(propView(p));
    }

    // ===================================================================== owner

    @GetMapping("/owner/properties")
    public ApiResponse<List<Obj>> ownerProperties() {
        return ApiResponse.ok(properties.findByOwnerIdOrderByCreatedAtDesc(CurrentUser.id()).stream()
                .map(MyHouseController::propView).toList());
    }

    @PostMapping("/owner/properties")
    @Transactional
    public ApiResponse<Obj> createProperty(@RequestBody Map<String, Object> b) {
        User u = me();
        Property p = new Property();
        p.ownerId = u.id;
        p.ownerName = nameOf(u, "Owner");
        p.ownerPhone = u.phone;
        p.code = String.format("#PRPR%05d", 25000 + properties.count() + 1);
        applyProperty(p, b);
        if (p.title == null || p.title.isBlank()) throw ApiException.badRequest("Property title is required");
        p.status = Property.Status.PENDING;
        p = properties.save(p);
        u.roles.add(Role.PROPERTY_OWNER);
        users.save(u);
        notifications.notify(u.id, "Listing submitted", "\"" + p.title + "\" is waiting for admin approval.",
                "Alerts", "home", null, p.id.toString());
        hub.toAdmins("property.submitted", propView(p));
        return ApiResponse.ok(propView(p));
    }

    @PutMapping("/owner/properties/{id}")
    @Transactional
    public ApiResponse<Obj> updateProperty(@PathVariable String id, @RequestBody Map<String, Object> b) {
        Property p = propertyOf(id);
        if (!p.ownerId.equals(CurrentUser.id())) throw ApiException.forbidden("This is not your property");
        applyProperty(p, b);
        p = properties.save(p);
        hub.toAdmins("property.updated", propView(p));
        return ApiResponse.ok(propView(p));
    }

    @DeleteMapping("/owner/properties/{id}")
    public ApiResponse<Void> deleteProperty(@PathVariable String id) {
        Property p = propertyOf(id);
        if (!p.ownerId.equals(CurrentUser.id())) throw ApiException.forbidden("This is not your property");
        properties.delete(p);
        return ApiResponse.ok(null);
    }

    @GetMapping("/owner/applications")
    public ApiResponse<List<TenancyApplication>> ownerApplications() {
        return ApiResponse.ok(applications.findByOwnerIdOrderByCreatedAtDesc(CurrentUser.id()));
    }

    @PostMapping("/owner/applications/{id}/decide")
    @Transactional
    public ApiResponse<TenancyApplication> decide(@PathVariable String id, @RequestBody Map<String, Object> b) {
        TenancyApplication a = applications.findById(Body.parseUuid(id)).orElseThrow(() -> ApiException.notFound("Application not found"));
        if (a.ownerId == null || !a.ownerId.equals(CurrentUser.id())) throw ApiException.forbidden("This is not your property");
        if (a.status != TenancyApplication.Status.PENDING) throw ApiException.conflict("Already decided");
        boolean approve = Body.bool(b, "approve", false);
        a.status = approve ? TenancyApplication.Status.APPROVED : TenancyApplication.Status.REJECTED;
        a.decisionNote = Body.str(b, "note");
        a = applications.save(a);
        if (approve) {
            properties.findById(a.propertyId).ifPresent(p -> {
                p.availableUnits = Math.max(0, p.availableUnits - 1);
                properties.save(p);
            });
            users.findById(a.tenantId).ifPresent(t -> {
                t.roles.add(Role.PROPERTY_TENANT);
                users.save(t);
            });
        }
        notifications.notify(a.tenantId, approve ? "Application approved" : "Application declined",
                "Your application for " + a.propertyTitle + (approve ? " was approved." : " was declined."),
                "Alerts", "home", null, a.id.toString());
        hub.toAdmins("application.updated", Obj.of().with("id", a.id).with("status", a.status.name()));
        return ApiResponse.ok(a);
    }

    @GetMapping("/owner/visits")
    public ApiResponse<List<Visit>> ownerVisits() {
        return ApiResponse.ok(visits.findByOwnerIdOrderByCreatedAtDesc(CurrentUser.id()));
    }

    @PostMapping("/owner/visits/{id}/status")
    @Transactional
    public ApiResponse<Visit> visitStatus(@PathVariable String id, @RequestBody Map<String, Object> b) {
        Visit v = visits.findById(Body.parseUuid(id)).orElseThrow(() -> ApiException.notFound("Visit not found"));
        if (v.ownerId == null || !v.ownerId.equals(CurrentUser.id())) throw ApiException.forbidden("This is not your property");
        v.status = Body.str(b, "status", v.status).toUpperCase();
        v = visits.save(v);
        notifications.notify(v.tenantId, "Visit " + v.status.toLowerCase(), "Your visit to " + v.propertyTitle + " is " + v.status.toLowerCase() + ".",
                "Alerts", "event", null, v.id.toString());
        return ApiResponse.ok(v);
    }

    @GetMapping("/owner/maintenance")
    public ApiResponse<List<MaintenanceRequest>> ownerMaintenance() {
        return ApiResponse.ok(maintenance.findByOwnerIdOrderByCreatedAtDesc(CurrentUser.id()));
    }

    @GetMapping("/owner/rent")
    public ApiResponse<List<RentPayment>> ownerRent() {
        return ApiResponse.ok(rent.findByOwnerIdOrderByCreatedAtDesc(CurrentUser.id()));
    }

    // ==================================================================== tenant

    @PostMapping("/tenant/applications")
    @Transactional
    public ApiResponse<TenancyApplication> apply(@RequestBody Map<String, Object> b) {
        User u = me();
        Property p = properties.findById(Body.parseUuid(Body.str(b, "propertyId", "")))
                .orElseThrow(() -> ApiException.notFound("Property not found"));
        if (p.status != Property.Status.APPROVED) throw ApiException.badRequest("This property is not open for applications");
        if (applications.existsByPropertyIdAndTenantIdAndStatus(p.id, u.id, TenancyApplication.Status.PENDING)) {
            throw ApiException.conflict("You already applied for this property");
        }
        TenancyApplication a = new TenancyApplication();
        a.propertyId = p.id;
        a.propertyTitle = p.title;
        a.ownerId = p.ownerId;
        a.tenantId = u.id;
        a.tenantName = nameOf(u, "Tenant");
        a.tenantPhone = u.phone;
        a.moveInDate = Times.parse(Body.str(b, "moveInDate"));
        a.occupants = Math.max(1, Body.intv(b, "occupants", 1));
        a.message = Body.str(b, "message");
        a = applications.save(a);
        notifications.notify(p.ownerId, "New application", a.tenantName + " applied for " + p.title + ".",
                "Requests", "inbox", "tenancyApplication", a.id.toString());
        hub.toAdmins("application.created", Obj.of().with("id", a.id).with("property", p.title).with("tenant", a.tenantName));
        return ApiResponse.ok(a);
    }

    @GetMapping("/tenant/applications")
    public ApiResponse<List<TenancyApplication>> myApplications() {
        return ApiResponse.ok(applications.findByTenantIdOrderByCreatedAtDesc(CurrentUser.id()));
    }

    @PostMapping("/tenant/applications/{id}/withdraw")
    public ApiResponse<TenancyApplication> withdraw(@PathVariable String id) {
        TenancyApplication a = applications.findById(Body.parseUuid(id)).orElseThrow(() -> ApiException.notFound("Application not found"));
        if (!a.tenantId.equals(CurrentUser.id())) throw ApiException.forbidden("This is not your application");
        if (a.status != TenancyApplication.Status.PENDING) throw ApiException.conflict("Already decided");
        a.status = TenancyApplication.Status.WITHDRAWN;
        return ApiResponse.ok(applications.save(a));
    }

    @PostMapping("/tenant/visits")
    @Transactional
    public ApiResponse<Visit> requestVisit(@RequestBody Map<String, Object> b) {
        User u = me();
        Property p = properties.findById(Body.parseUuid(Body.str(b, "propertyId", "")))
                .orElseThrow(() -> ApiException.notFound("Property not found"));
        Visit v = new Visit();
        v.propertyId = p.id;
        v.propertyTitle = p.title;
        v.ownerId = p.ownerId;
        v.tenantId = u.id;
        v.tenantName = nameOf(u, "Tenant");
        v.visitDate = Times.parse(Body.str(b, "visitDate"));
        v.slot = Body.str(b, "slot");
        v = visits.save(v);
        notifications.notify(p.ownerId, "Visit requested", v.tenantName + " wants to visit " + p.title + ".",
                "Requests", "event", null, v.id.toString());
        return ApiResponse.ok(v);
    }

    @GetMapping("/tenant/visits")
    public ApiResponse<List<Visit>> myVisits() {
        return ApiResponse.ok(visits.findByTenantIdOrderByCreatedAtDesc(CurrentUser.id()));
    }

    @PostMapping("/tenant/maintenance")
    @Transactional
    public ApiResponse<MaintenanceRequest> raiseMaintenance(@RequestBody Map<String, Object> b) {
        User u = me();
        MaintenanceRequest m = new MaintenanceRequest();
        MaintenanceRequest request = m;
        m.code = String.format("MT%05d", 10001 + maintenance.count());
        m.requesterId = u.id;
        m.requesterName = nameOf(u, "Tenant");
        m.requesterPhone = u.phone;
        m.issue = Body.str(b, "issue", "").trim();
        if (m.issue.isEmpty()) throw ApiException.badRequest("Please describe the issue");
        m.category = Body.str(b, "category", "other");
        m.priority = Body.str(b, "priority", "MEDIUM").toUpperCase().replace(" PRIORITY", "");
        m.description = Body.str(b, "description");
        m.photos = new ArrayList<>(Body.strings(b, "photos"));
        UUID pid = Body.uuid(b, "propertyId");
        if (pid != null) {
            properties.findById(pid).ifPresent(p -> {
                request.propertyId = p.id;
                request.propertyTitle = p.title;
                request.ownerId = p.ownerId;
                request.location = p.addressLine + ", " + p.city;
            });
        }
        if (m.location == null) m.location = Body.str(b, "location", "");
        step(m, "Request raised");
        m = maintenance.save(m);
        if (m.ownerId != null) {
            notifications.notify(m.ownerId, "Maintenance request", m.requesterName + ": " + m.issue,
                    "Requests", "build", null, m.id.toString());
        }
        hub.toAdmins("maintenance.created", Obj.of().with("id", m.id).with("code", m.code).with("issue", m.issue)
                .with("priority", m.priority));
        return ApiResponse.ok(m);
    }

    @GetMapping("/tenant/maintenance")
    public ApiResponse<List<MaintenanceRequest>> myMaintenance() {
        return ApiResponse.ok(maintenance.findByRequesterIdOrderByCreatedAtDesc(CurrentUser.id()));
    }

    @PostMapping("/tenant/rent")
    @Transactional
    public ApiResponse<RentPayment> payRent(@RequestBody Map<String, Object> b) {
        User u = me();
        Property p = properties.findById(Body.parseUuid(Body.str(b, "propertyId", "")))
                .orElseThrow(() -> ApiException.notFound("Property not found"));
        String month = Body.str(b, "month", Instant.now().toString().substring(0, 7));
        if (rent.existsByPropertyIdAndTenantIdAndMonth(p.id, u.id, month)) throw ApiException.conflict("Rent for " + month + " is already paid");
        RentPayment r = new RentPayment();
        r.propertyId = p.id;
        r.propertyTitle = p.title;
        r.ownerId = p.ownerId;
        r.tenantId = u.id;
        r.tenantName = nameOf(u, "Tenant");
        r.month = month;
        r.amount = Body.dbl(b, "amount", p.monthlyRent);
        r.method = Body.str(b, "method", "UPI");
        r.transactionId = Body.str(b, "transactionId", "TXN" + System.currentTimeMillis());
        r.paidAt = Instant.now();
        r = rent.save(r);
        notifications.notify(p.ownerId, "Rent received", r.tenantName + " paid \u20B9" + Math.round(r.amount) + " for " + month + ".",
                "Alerts", "payments", null, r.id.toString());
        hub.toAdmins("rent.paid", Obj.of().with("id", r.id).with("amount", r.amount));
        return ApiResponse.ok(r);
    }

    @GetMapping("/tenant/rent")
    public ApiResponse<List<RentPayment>> myRent() {
        return ApiResponse.ok(rent.findByTenantIdOrderByCreatedAtDesc(CurrentUser.id()));
    }

    @PostMapping("/tenant/utilities")
    @Transactional
    public ApiResponse<UtilityPayment> payUtility(@RequestBody Map<String, Object> b) {
        UtilityPayment up = new UtilityPayment();
        up.userId = CurrentUser.id();
        up.category = Body.str(b, "category", "Electricity");
        up.provider = Body.str(b, "provider", "");
        up.accountNumber = Body.str(b, "accountNumber", "");
        up.amount = Body.dbl(b, "amount", 0);
        if (up.amount <= 0) throw ApiException.badRequest("Amount must be greater than 0");
        up.method = Body.str(b, "method", "UPI");
        up.transactionId = Body.str(b, "transactionId", "TXN" + System.currentTimeMillis());
        up.paidAt = Instant.now();
        up = utilities.save(up);
        notifications.notify(up.userId, up.category + " bill paid", "\u20B9" + Math.round(up.amount) + " paid to " + up.provider + ".",
                "Alerts", "payments", null, up.id.toString());
        return ApiResponse.ok(up);
    }

    @GetMapping("/tenant/utilities")
    public ApiResponse<List<UtilityPayment>> myUtilities() {
        return ApiResponse.ok(utilities.findByUserIdOrderByCreatedAtDesc(CurrentUser.id()));
    }

    // ================================================================== helpers

    static void step(MaintenanceRequest m, String title) {
        Map<String, Object> e = new LinkedHashMap<>();
        e.put("title", title);
        e.put("timestamp", Instant.now().toString());
        List<Map<String, Object>> list = new ArrayList<>(m.timeline);
        list.add(e);
        m.timeline = list;
    }

    @SuppressWarnings("unchecked")
    static void applyProperty(Property p, Map<String, Object> b) {
        if (Body.has(b, "title")) p.title = Body.str(b, "title");
        if (Body.has(b, "bhk")) p.bhk = Body.str(b, "bhk");
        if (Body.has(b, "propertyType")) p.propertyType = Body.str(b, "propertyType");
        if (Body.has(b, "addressLine")) p.addressLine = Body.str(b, "addressLine");
        if (Body.has(b, "locality")) p.locality = Body.str(b, "locality");
        if (Body.has(b, "city")) p.city = Body.str(b, "city");
        if (Body.has(b, "state")) p.state = Body.str(b, "state");
        if (Body.has(b, "pincode")) p.pincode = Body.str(b, "pincode");
        if (Body.has(b, "lat")) p.lat = Body.dbl(b, "lat", p.lat);
        if (Body.has(b, "lng")) p.lng = Body.dbl(b, "lng", p.lng);
        if (Body.has(b, "monthlyRent")) p.monthlyRent = Body.dbl(b, "monthlyRent", p.monthlyRent);
        else if (Body.has(b, "rent")) p.monthlyRent = Body.dbl(b, "rent", p.monthlyRent);
        if (Body.has(b, "securityDeposit")) p.securityDeposit = Body.dbl(b, "securityDeposit", p.securityDeposit);
        if (Body.has(b, "maintenanceCharge")) p.maintenanceCharge = Body.dbl(b, "maintenanceCharge", p.maintenanceCharge);
        if (Body.has(b, "furnishing")) p.furnishing = Body.str(b, "furnishing");
        if (Body.has(b, "suitableFor")) p.suitableFor = Body.str(b, "suitableFor");
        if (Body.has(b, "areaSqft")) p.areaSqft = Body.dbl(b, "areaSqft", p.areaSqft);
        if (Body.has(b, "totalUnits")) p.totalUnits = Math.max(1, Body.intv(b, "totalUnits", p.totalUnits));
        if (Body.has(b, "availableUnits")) p.availableUnits = Math.max(0, Body.intv(b, "availableUnits", p.availableUnits));
        else if (Body.has(b, "totalUnits")) p.availableUnits = p.totalUnits;
        if (Body.has(b, "description")) p.description = Body.str(b, "description");
        if (Body.has(b, "images")) p.images = new ArrayList<>(Body.strings(b, "images"));
        if (Body.has(b, "facilities")) p.facilities = new ArrayList<>(Body.strings(b, "facilities"));
        if (b.get("details") instanceof Map<?, ?> d) p.details = new LinkedHashMap<>((Map<String, Object>) d);
    }

    public static Obj propView(Property p) {
        return Obj.of().with("id", p.id).with("code", p.code).with("title", p.title).with("bhk", p.bhk)
                .with("propertyType", p.propertyType).with("addressLine", p.addressLine)
                .with("locality", p.locality).with("city", p.city).with("state", p.state).with("pincode", p.pincode)
                .with("lat", p.lat).with("lng", p.lng).with("monthlyRent", p.monthlyRent)
                .with("securityDeposit", p.securityDeposit).with("maintenanceCharge", p.maintenanceCharge)
                .with("furnishing", p.furnishing).with("suitableFor", p.suitableFor).with("areaSqft", p.areaSqft)
                .with("totalUnits", p.totalUnits).with("availableUnits", p.availableUnits)
                .with("description", p.description).with("images", p.images).with("facilities", p.facilities)
                .with("details", p.details).with("status", p.status.name()).with("rejectReason", p.rejectReason)
                .with("ownerId", p.ownerId).with("ownerName", p.ownerName).with("ownerPhone", p.ownerPhone)
                .with("createdAt", p.createdAt).with("updatedAt", p.updatedAt);
    }
}
