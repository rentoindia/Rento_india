package com.rentoindia.backend.auth;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface UserRepository extends JpaRepository<User, UUID> {

    Optional<User> findByPhone(String phone);

    Optional<User> findByEmailIgnoreCase(String email);

    @Query("select u from User u where :role member of u.roles order by u.createdAt desc")
    List<User> findByRole(@Param("role") Role role);

    @Query("select count(u) from User u where :role member of u.roles")
    long countByRole(@Param("role") Role role);
}
