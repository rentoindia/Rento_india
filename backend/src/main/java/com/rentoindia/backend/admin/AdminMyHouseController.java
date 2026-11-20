package com.rentoindia.backend.admin;

import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.ApiResponse;
import com.rentoindia.backend.common.Body;
import com.rentoindia.backend.common.Obj;
import com.rentoindia.backend.myhouse.MaintenanceRequest;
import com.rentoindia.backend.myhouse.MaintenanceRequestRepository;
import com.rentoindia.backend.myhouse.MyHouseController;
import com.rentoindia.backend.myhouse.Property;
import com.rentoindia.backend.myhouse.PropertyRepository;
import com.rentoindia.backend.myhouse.RentPayment;
import com.rentoindia.backend.myhouse.RentPaymentRepository;
import com.rentoindia.backend.myhouse.Room;
import com.rentoindia.backend.myhouse.RoomRepository;
import com.rentoindia.backend.myhouse.TenancyApplication;
import com.rentoindia.backend.myhouse.TenancyApplicationRepository;
import com.rentoindia.backend.myhouse.UtilityPayment;
import com.rentoindia.backend.myhouse.UtilityPaymentRepository;
import com.rentoindia.backend.notification.NotificationService;
import com.rentoindia.backend.realtime.EventHub;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/** My House admin: approve listings, manage rooms, handle maintenance, see payments. */
@RestController
@RequestMapping("/api/v1/admin/myhouse")
public class AdminMyHouseController {

    private final PropertyRepository properties;
    private final RoomRepository rooms;
    private final MaintenanceRequestRepository maintenance;
    private final TenancyApplicationRepository applications;
    private final RentPaymentRepository rent;
    private final UtilityPaymentRepository utilities;
    private final NotificationService notifications;
    private final EventHub hub;

    public AdminMyHouseController(PropertyRepository properties, RoomRepository rooms,
                                  MaintenanceRequestRepository maintenance, TenancyApplicationRepository applications,
                                  RentPaymentRepository rent, UtilityPaymentRepository utilities,
                                  NotificationService notifications, EventHub hub) {
        this.properties = properties;
        this.rooms = rooms;
        this.maintenance = maintenance;
        this.applications = applications;
        this.rent = rent;
        this.utilities = utilities;
        this.notifications = notifications;
        this.hub = hub;
    }

    private Property property(String id) {
        return properties.findById(Body.parseUuid(id)).orElseThrow(() -> ApiException.notFound("Property not found"));
    }

    // -------------------------------------------------------------- properties

    @GetMapping("/properties")
    public ApiResponse<List<Obj>> listProperties() {
        return ApiResponse.ok(properties.findAllByOrderByCreatedAtDesc().stream().map(MyHouseController::propView).toList());
    }

    @GetMapping("/properties/{id}")
    public ApiResponse<Obj> getProperty(@PathVariable String id) {
        Property p = property(id);
        return ApiResponse.ok(MyHouseController.propView(p).with("rooms", rooms.findByPropertyIdOrderByNameAsc(p.id)));
    }

    /** {status: APPROVED|REJECTED|PENDING, reason?} */
    @PostMapping("/properties/{id}/decision")
    @Transactional
    public ApiResponse<Obj> decide(@PathVariable String id, @RequestBody Map<String, Object> b) {
        Property p = property(id);
        Property.Status s = Body.enumOf(Property.Status.class, Body.str(b, "status"), null);
        if (s == null) throw ApiException.badRequest("Unknown status");
        p.status = s;
        p.rejectReason = s == Property.Status.REJECTED ? Body.str(b, "reason", "Does not meet listing guidelines") : null;
        p = properties.save(p);
        notifications.notify(p.ownerId, s == Property.Status.APPROVED ? "Listing approved" : "Listing " + s.name().toLowerCase(),
                "\"" + p.title + "\" was " + s.name().toLowerCase() + (p.rejectReason == null ? "." : ": " + p.rejectReason),
                "Alerts", "home", null, p.id.toString());
        Obj v = MyHouseController.propView(p);
        hub.toAdmins("property.updated", v);
        return ApiResponse.ok(v);
    }

    // ------------------------------------------------------------------- rooms

    @GetMapping("/properties/{id}/rooms")
    public ApiResponse<List<Room>> listRooms(@PathVariable String id) {
        return ApiResponse.ok(rooms.findByPropertyIdOrderByNameAsc(property(id).id));
    }

    @PostMapping("/properties/{id}/rooms")
    public ApiResponse<Room> addRoom(@PathVariable String id, @RequestBody Map<String, Object> b) {
        Room r = new Room();
        r.propertyId = property(id).id;
        r.name = Body.str(b, "name", "Room");
        r.rent = Body.dbl(b, "rent", 0);
        return ApiResponse.ok(rooms.save(r));
    }

    @PostMapping("/rooms/{id}/status")
    public ApiResponse<Room> roomStatus(@PathVariable String id, @RequestBody Map<String, Object> b) {
        Room r = rooms.findById(Body.parseUuid(id)).orElseThrow(() -> ApiException.notFound("Room not found"));
        r.status = Body.str(b, "status", r.status).toUpperCase();
        if (Body.has(b, "tenantName")) r.tenantName = Body.str(b, "tenantName");
        return ApiResponse.ok(rooms.save(r));
    }

    // ------------------------------------------------------------- maintenance

    @GetMapping("/maintenance")
    public ApiResponse<List<MaintenanceRequest>> listMaintenance() {
        return ApiResponse.ok(maintenance.findAllByOrderByCreatedAtDesc());
    }

    /** Any of: status, priority, assignedToName, assignedToPhone, cost, paymentStatus, note */
    @PostMapping("/maintenance/{id}")
    @Transactional
    public ApiResponse<MaintenanceRequest> updateMaintenance(@PathVariable String id, @RequestBody Map<String, Object> b) {
        MaintenanceRequest m = maintenance.findById(Body.parseUuid(id)).orElseThrow(() -> ApiException.notFound("Request not found"));
        if (Body.has(b, "status")) m.status = Body.str(b, "status", m.status).toUpperCase();
        if (Body.has(b, "priority")) m.priority = Body.str(b, "priority", m.priority).toUpperCase();
        if (Body.has(b, "assignedToName")) m.assignedToName = Body.str(b, "assignedToName");
        if (Body.has(b, "assignedToPhone")) m.assignedToPhone = Body.str(b, "assignedToPhone");
        if (Body.has(b, "cost")) m.cost = Body.dbl(b, "cost", m.cost);
        if (Body.has(b, "paymentStatus")) m.paymentStatus = Body.str(b, "paymentStatus", m.paymentStatus).toUpperCase();
        addStep(m, Body.str(b, "note", "Status: " + m.status));
        m = maintenance.save(m);
        notifications.notify(m.requesterId, "Maintenance update", m.issue + " is now " + m.status.replace('_', ' ').toLowerCase() + ".",
                "Alerts", "build", null, m.id.toString());
        hub.toAdmins("maintenance.updated", Obj.of().with("id", m.id).with("status", m.status));
        return ApiResponse.ok(m);
    }

    private static void addStep(MaintenanceRequest m, String title) {
        java.util.Map<String, Object> e = new java.util.LinkedHashMap<>();
        e.put("title", title);
        e.put("timestamp", java.time.Instant.now().toString());
        java.util.List<java.util.Map<String, Object>> list = new java.util.ArrayList<>(m.timeline);
        list.add(e);
        m.timeline = list;
    }

    // ------------------------------------------------------------ other lists

    @GetMapping("/applications")
    public ApiResponse<List<TenancyApplication>> listApplications() {
        return ApiResponse.ok(applications.findAllByOrderByCreatedAtDesc());
    }

    @GetMapping("/rent")
    public ApiResponse<List<RentPayment>> listRent() {
        return ApiResponse.ok(rent.findAllByOrderByCreatedAtDesc());
    }

    @GetMapping("/utilities")
    public ApiResponse<List<UtilityPayment>> listUtilities() {
        return ApiResponse.ok(utilities.findAllByOrderByCreatedAtDesc());
    }
}
