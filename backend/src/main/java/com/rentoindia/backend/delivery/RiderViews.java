package com.rentoindia.backend.delivery;

import com.rentoindia.backend.common.Obj;

import java.util.List;

public final class RiderViews {

    private RiderViews() {}

    public static Obj document(RiderDocument d) {
        return Obj.of().with("id", d.id).with("riderId", d.riderId).with("type", d.type.name())
                .with("documentNumber", d.documentNumber).with("fileUrl", d.fileUrl)
                .with("status", d.status.name()).with("rejectReason", d.rejectReason)
                .with("uploadedAt", d.createdAt).with("updatedAt", d.updatedAt);
    }

    public static Obj of(Rider r, List<RiderDocument> docs) {
        return Obj.of()
                .with("id", r.id).with("userId", r.userId).with("riderCode", r.riderCode)
                .with("name", r.name).with("phone", r.phone).with("email", r.email)
                .with("dob", r.dob).with("address", r.address).with("aadhaarMasked", r.aadhaarMasked)
                .with("emergencyContact", r.emergencyContact)
                .with("vehicleType", r.vehicleType).with("vehicleNumber", r.vehicleNumber)
                .with("brandModel", r.brandModel).with("rcNumber", r.rcNumber)
                .with("insuranceValidTill", r.insuranceValidTill)
                .with("bankAccountNumber", r.bankAccountNumber).with("bankIfsc", r.bankIfsc)
                .with("deliveryZone", r.deliveryZone)
                .with("status", r.status.name()).with("online", r.online)
                .with("lat", r.lat).with("lng", r.lng).with("lastLocationAt", r.lastLocationAt)
                .with("totalJobs", r.totalJobs).with("completedJobs", r.completedJobs)
                .with("cancelledJobs", r.cancelledJobs).with("rating", r.rating)
                .with("totalEarnings", r.totalEarnings).with("pendingPayout", r.pendingPayout)
                .with("suspensionReason", r.suspensionReason).with("suspendUntil", r.suspendUntil)
                .with("additionalNote", r.additionalNote).with("suspendedOn", r.suspendedOn)
                .with("joinedAt", r.createdAt)
                .with("documents", docs.stream().map(RiderViews::document).toList());
    }
}
