package com.example.mustaqel_apis.common;

public record ApiResponse<T>(
        int status,
        String message,
        T data
) {
}