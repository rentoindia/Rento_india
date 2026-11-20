package com.rentoindia.backend.delivery;

import com.rentoindia.backend.auth.Role;
import com.rentoindia.backend.auth.User;
import com.rentoindia.backend.auth.UserRepository;
import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.ApiResponse;
import com.rentoindia.backend.common.Body;
import com.rentoindia.backend.common.CurrentUser;
import com.rentoindia.backend.common.Obj;
import com.rentoindia.backend.realtime.EventHub;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Rider app API. Any logged-in user may register; everything else is restricted by the
 * rider's own status (PENDING until an admin approves the documents).
 */
@RestController
@RequestMapping("/api/v1/rider")
public class RiderController {

    private final RiderRepository riders;
    private final RiderDocumentRepository docs;
    private final UserRepository users;
    private final DispatchService dispatch;
    private final EventHub hub;

    public RiderController(RiderRepository riders, RiderDocumentRepository docs, UserRepository users,
                           DispatchService dispatch, EventHub hub) {
        this.riders = riders;
        this.docs = docs;
        this.users = users;
        this.dispatch = dispatch;
        this.hub = hub;
    }

    private static void apply(Rider r, Map<String, Object> b) {
        if (Body.has(b, "name")) r.name = Body.str(b, "name");
        if (Body.has(b, "email")) r.email = Body.str(b, "email");
        if (Body.has(b, "dob")) r.dob = Body.str(b, "dob");
        if (Body.has(b, "address")) r.address = Body.str(b, "address");
        if (Body.has(b, "aadhaar")) {
            String a = Body.str(b, "aadhaar", "").replaceAll("\\s", "");
            r.aadhaarMasked = a.length() >= 4 ? "XXXX XXXX " + a.substring(a.length() - 4) : a;
        }
        if (Body.has(b, "emergencyContact")) r.emergencyContact = Body.str(b, "emergencyContact");
        if (Body.has(b, "vehicleType")) r.vehicleType = Body.str(b, "vehicleType");
        if (Body.has(b, "vehicleNumber")) r.vehicleNumber = Body.str(b, "vehicleNumber");
        if (Body.has(b, "brandModel")) r.brandModel = Body.str(b, "brandModel");
        if (Body.has(b, "rcNumber")) r.rcNumber = Body.str(b, "rcNumber");
        if (Body.has(b, "insuranceValidTill")) r.insuranceValidTill = Body.str(b, "insuranceValidTill");
        if (Body.has(b, "bankAccountNumber")) r.bankAccountNumber = Body.str(b, "bankAccountNumber");
        if (Body.has(b, "bankIfsc")) r.bankIfsc = Body.str(b, "bankIfsc");
        if (Body.has(b, "deliveryZone")) r.deliveryZone = Body.str(b, "deliveryZone");
    }

    private void saveDocuments(Rider r, Map<String, Object> b) {
        for (Map<String, Object> d : Body.maps(b, "documents")) {
            RiderDocument.Type type = Body.enumOf(RiderDocument.Type.class, Body.str(d, "type"), null);
            if (type == null) continue;
            RiderDocument doc = docs.findFirstByRiderIdAndType(r.id, type).orElseGet(RiderDocument::new);
            doc.riderId = r.id;
            doc.type = type;
            doc.documentNumber = Body.str(d, "documentNumber", doc.documentNumber);
            doc.fileUrl = Body.str(d, "fileUrl", doc.fileUrl);
            doc.status = RiderDocument.Status.PENDING;      // re-uploaded -> needs review again
            doc.rejectReason = null;
            docs.save(doc);
        }
    }

    @PostMapping("/register")
    @Transactional
    public ApiResponse<Obj> register(@RequestBody Map<String, Object> b) {
        UUID me = CurrentUser.id();
        User u = users.findById(me).orElseThrow(() -> ApiException.unauthorized("Login required"));
        Rider r = riders.findByUserId(me).orElseGet(Rider::new);
        boolean isNew = r.id == null;
        r.userId = me;
        if (isNew) {
            r.riderCode = String.format("RID%04d", 1001 + riders.count());
            r.status = Rider.Status.PENDING;
        }
        apply(r, b);
        if (r.name == null || r.name.isBlank()) r.name = u.fullName == null ? "Rider" : u.fullName;
        r.phone = u.phone;
        r = riders.save(r);
        saveDocuments(r, b);

        u.roles.add(Role.RIDER);
        if (u.fullName == null || u.fullName.isBlank()) u.fullName = r.name;
        users.save(u);

        Obj view = RiderViews.of(r, docs.findByRiderIdOrderByCreatedAtDesc(r.id));
        hub.toAdmins("rider.registered", view);
        return ApiResponse.ok(view);
    }

    @GetMapping("/me")
    public ApiResponse<Obj> me() {
        Rider r = dispatch.riderOf(CurrentUser.id());
        return ApiResponse.ok(RiderViews.of(r, docs.findByRiderIdOrderByCreatedAtDesc(r.id)));
    }

    @PutMapping("/me")
    @Transactional
    public ApiResponse<Obj> update(@RequestBody Map<String, Object> b) {
        Rider r = dispatch.riderOf(CurrentUser.id());
        apply(r, b);
        r = riders.save(r);
        saveDocuments(r, b);
        return ApiResponse.ok(RiderViews.of(r, docs.findByRiderIdOrderByCreatedAtDesc(r.id)));
    }

    @PostMapping("/online")
    @Transactional
    public ApiResponse<Obj> online(@RequestBody Map<String, Object> b) {
        Rider r = dispatch.riderOf(CurrentUser.id());
        boolean on = Body.bool(b, "online", false);
        if (on && r.status != Rider.Status.ACTIVE) {
            throw ApiException.forbidden(r.status == Rider.Status.PENDING
                    ? "Your documents are still under review. You can go online once an admin approves them."
                    : "Your rider account is not active");
        }
        r.online = on;
        if (Body.has(b, "lat")) r.lat = Body.dbl(b, "lat", r.lat);
        if (Body.has(b, "lng")) r.lng = Body.dbl(b, "lng", r.lng);
        riders.save(r);
        hub.toAdmins("rider.status", Obj.of().with("userId", r.userId).with("name", r.name).with("online", r.online));
        return ApiResponse.ok(Obj.of().with("online", r.online).with("status", r.status.name()));
    }

    @PostMapping("/location")
    public ApiResponse<Void> location(@RequestBody Map<String, Object> b) {
        dispatch.location(CurrentUser.id(), Body.dbl(b, "lat", 0), Body.dbl(b, "lng", 0),
                Body.str(b, "jobKind"), Body.uuid(b, "jobId"));
        return ApiResponse.ok(null);
    }

    // ------------------------------------------------------------------- jobs

    @GetMapping("/jobs/available")
    public ApiResponse<List<Obj>> available() {
        return ApiResponse.ok(dispatch.available(CurrentUser.id()));
    }

    @GetMapping("/jobs/current")
    public ApiResponse<List<Obj>> current() {
        return ApiResponse.ok(dispatch.current(CurrentUser.id()));
    }

    @GetMapping("/jobs/history")
    public ApiResponse<List<Obj>> history() {
        return ApiResponse.ok(dispatch.history(CurrentUser.id()));
    }

    @GetMapping("/earnings")
    public ApiResponse<Obj> earnings() {
        return ApiResponse.ok(dispatch.earnings(CurrentUser.id()));
    }

    @PostMapping("/jobs/{kind}/{id}/accept")
    public ApiResponse<Obj> accept(@PathVariable String kind, @PathVariable String id) {
        return ApiResponse.ok(dispatch.accept(CurrentUser.id(), kind, Body.parseUuid(id)));
    }

    @PostMapping("/jobs/{kind}/{id}/verify-pickup")
    public ApiResponse<Obj> pickup(@PathVariable String kind, @PathVariable String id,
                                   @RequestBody Map<String, Object> b) {
        return ApiResponse.ok(dispatch.verifyPickup(CurrentUser.id(), kind, Body.parseUuid(id), b));
    }

    @PostMapping("/jobs/{kind}/{id}/verify-drop")
    public ApiResponse<Obj> drop(@PathVariable String kind, @PathVariable String id,
                                 @RequestBody Map<String, Object> b) {
        return ApiResponse.ok(dispatch.verifyDrop(CurrentUser.id(), kind, Body.parseUuid(id), b));
    }

    @PostMapping("/jobs/{kind}/{id}/release")
    public ApiResponse<Obj> release(@PathVariable String kind, @PathVariable String id,
                                    @RequestBody(required = false) Map<String, Object> b) {
        return ApiResponse.ok(dispatch.release(CurrentUser.id(), kind, Body.parseUuid(id), Body.str(b, "reason")));
    }
}
