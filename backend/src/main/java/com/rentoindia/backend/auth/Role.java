package com.rentoindia.backend.auth;

/** One phone number can hold several roles at once (e.g. CUSTOMER + LENDER + RIDER). */
public enum Role {
    CUSTOMER,           // rental marketplace shopper
    LENDER,             // rental marketplace product owner
    DELIVERY_CUSTOMER,  // delivery app customer
    RIDER,              // delivery / parcel / ride driver
    PROPERTY_TENANT,    // my_house tenant
    PROPERTY_OWNER,     // my_house owner
    RIDE_PASSENGER,     // Percel&person passenger
    ADMIN,
    SUPER_ADMIN
}
