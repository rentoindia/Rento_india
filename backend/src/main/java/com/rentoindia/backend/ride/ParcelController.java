package com.rentoindia.backend.ride;

import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.ApiResponse;
import com.rentoindia.backend.common.Body;
import com.rentoindia.backend.common.CurrentUser;
import com.rentoindia.backend.common.Obj;
import com.rentoindia.backend.ride.RideService.Aud;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/** Sender side of parcel delivery. */
@RestController
@RequestMapping("/api/v1/parcels")
public class ParcelController {

    private final RideService service;
    private final ParcelBookingRepository parcels;

    public ParcelController(RideService service, ParcelBookingRepository parcels) {
        this.service = service;
        this.parcels = parcels;
    }

    private ParcelBooking mine(String id) {
        ParcelBooking p = service.getParcel(Body.parseUuid(id));
        if (!p.senderId.equals(CurrentUser.id())) throw ApiException.forbidden("This is not your parcel");
        return p;
    }

    @PostMapping
    public ApiResponse<Obj> create(@RequestBody Map<String, Object> b) {
        return ApiResponse.ok(service.parcelView(service.createParcel(CurrentUser.id(), b), Aud.OWNER));
    }

    @GetMapping
    public ApiResponse<List<Obj>> list() {
        return ApiResponse.ok(parcels.findBySenderIdOrderByCreatedAtDesc(CurrentUser.id()).stream()
                .map(p -> service.parcelView(p, Aud.OWNER)).toList());
    }

    @GetMapping("/{id}")
    public ApiResponse<Obj> one(@PathVariable String id) {
        return ApiResponse.ok(service.parcelView(mine(id), Aud.OWNER));
    }

    @PostMapping("/{id}/cancel")
    public ApiResponse<Obj> cancel(@PathVariable String id, @RequestBody(required = false) Map<String, Object> b) {
        return ApiResponse.ok(service.parcelView(service.cancelParcel(mine(id), Body.str(b, "reason")), Aud.OWNER));
    }
}
