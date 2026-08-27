package com.example.mustaqel_apis.repositories.user;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.*;

import com.example.mustaqel_apis.models.User;

public interface UserRepository extends JpaRepository<User, Long> {
    List<User> findAllByDeletedAtIsNull();

    Optional<User> findByIdAndDeletedAtIsNull(Long id);

    boolean existsByEmailAndDeletedAtIsNull(String email);
}
