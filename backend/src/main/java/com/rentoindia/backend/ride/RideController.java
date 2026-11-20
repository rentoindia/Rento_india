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

/** Passenger side of person rides. */
@RestController
@RequestMapping("/api/v1/rides")
public class RideController {

    private final RideService service;
    private final RideBookingRepository rides;

    public RideController(RideService service, RideBookingRepository rides) {
        this.service = service;
        this.rides = rides;
    }

    private RideBooking mine(String id) {
        RideBooking r = service.getRide(Body.parseUuid(id));
        if (!r.passengerId.equals(CurrentUser.id())) throw ApiException.forbidden("This is not your ride");
        return r;
    }

    @PostMapping
    public ApiResponse<Obj> create(@RequestBody Map<String, Object> b) {
        return ApiResponse.ok(service.rideView(service.createRide(CurrentUser.id(), b), Aud.OWNER));
    }

    @GetMapping
    public ApiResponse<List<Obj>> list() {
        return ApiResponse.ok(rides.findByPassengerIdOrderByCreatedAtDesc(CurrentUser.id()).stream()
                .map(r -> service.rideView(r, Aud.OWNER)).toList());
    }

    @GetMapping("/{id}")
    public ApiResponse<Obj> one(@PathVariable String id) {
        return ApiResponse.ok(service.rideView(mine(id), Aud.OWNER));
    }

    @PostMapping("/{id}/cancel")
    public ApiResponse<Obj> cancel(@PathVariable String id, @RequestBody(required = false) Map<String, Object> b) {
        return ApiResponse.ok(service.rideView(service.cancelRide(mine(id), Body.str(b, "reason")), Aud.OWNER));
    }

    @PostMapping("/{id}/sos")
    public ApiResponse<Obj> sos(@PathVariable String id) {
        return ApiResponse.ok(service.rideView(service.triggerSos(mine(id)), Aud.OWNER));
    }
}
