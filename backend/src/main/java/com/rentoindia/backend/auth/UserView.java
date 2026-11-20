package com.rentoindia.backend.auth;

import com.rentoindia.backend.common.Obj;

import java.util.List;

/** Safe JSON view of a User (never exposes passwordHash). */
public final class UserView {

    private UserView() {}

    public static Obj of(User u) {
        List<String> roles = u.roles.stream().map(Enum::name).sorted().toList();
        return Obj.of()
                .with("id", u.id)
                .with("phone", u.phone)
                .with("fullName", u.fullName)
                .with("email", u.email)
                .with("roles", roles)
                .with("blocked", u.blocked)
                .with("verified", u.verified)
                .with("location", u.location)
                .with("profileImageUrl", u.profileImageUrl)
                .with("rating", u.rating)
                .with("disputes", u.disputes)
                .with("lenderVerified", u.lenderVerified)
                .with("homeAddress", u.homeAddress)
                .with("profileComplete", u.fullName != null && !u.fullName.isBlank())
                .with("joinedAt", u.createdAt)
                .with("lastLoginAt", u.lastLoginAt);
    }
}
