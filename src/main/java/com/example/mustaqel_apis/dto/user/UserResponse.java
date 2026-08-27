package com.example.mustaqel_apis.dto.user;

import java.time.LocalDateTime;

public record UserResponse(
        Long id,
        String nameEn,
        String nameAr,
        String email,
        LocalDateTime emailVerifiedAt,
        String status,
        Boolean termsAndConditions,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
}