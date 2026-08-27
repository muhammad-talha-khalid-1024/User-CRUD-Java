package com.example.mustaqel_apis.services.user;

import com.example.mustaqel_apis.dto.user.*;
import com.example.mustaqel_apis.models.User;
import com.example.mustaqel_apis.repositories.user.UserRepository;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@Transactional
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public UserService(
            UserRepository userRepository,
            PasswordEncoder passwordEncoder
    ) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public UserResponse create(CreateUserRequest request) {

        if (userRepository.existsByEmailAndDeletedAtIsNull(
                request.getEmail()
        )) {
            throw new RuntimeException("Email already exists");
        }

        User user = new User();

        user.setNameEn(request.getNameEn());
        user.setNameAr(request.getNameAr());
        user.setEmail(request.getEmail());

        user.setPassword(
                passwordEncoder.encode(request.getPassword())
        );

        user.setStatus(request.getStatus());
        user.setTermsAndConditions(
                request.getTermsAndConditions()
        );

        return toResponse(userRepository.save(user));
    }

    @Transactional(readOnly = true)
    public List<UserResponse> findAll() {
        return userRepository
                .findAllByDeletedAtIsNull()
                .stream()
                .map(this::toResponse)
                .toList();
    }

    @Transactional(readOnly = true)
    public UserResponse findById(Long id) {

        User user = userRepository
                .findByIdAndDeletedAtIsNull(id)
                .orElseThrow(() ->
                        new RuntimeException(
                                "User not found with id: " + id
                        )
                );

        return toResponse(user);
    }

    public UserResponse update(
            Long id,
            UpdateUserRequest request
    ) {

        User user = userRepository
                .findByIdAndDeletedAtIsNull(id)
                .orElseThrow(() ->
                        new RuntimeException(
                                "User not found with id: " + id
                        )
                );

        if (!user.getEmail().equals(request.getEmail())
                && userRepository.existsByEmailAndDeletedAtIsNull(
                request.getEmail()
        )) {
            throw new RuntimeException("Email already exists");
        }

        user.setNameEn(request.getNameEn());
        user.setNameAr(request.getNameAr());
        user.setEmail(request.getEmail());
        user.setStatus(request.getStatus());

        if (request.getTermsAndConditions() != null) {
            user.setTermsAndConditions(
                    request.getTermsAndConditions()
            );
        }

        if (request.getPassword() != null
                && !request.getPassword().isBlank()) {

            user.setPassword(
                    passwordEncoder.encode(request.getPassword())
            );
        }

        return toResponse(userRepository.save(user));
    }

    public void delete(Long id) {

        User user = userRepository
                .findByIdAndDeletedAtIsNull(id)
                .orElseThrow(() ->
                        new RuntimeException(
                                "User not found with id: " + id
                        )
                );

        user.setDeletedAt(LocalDateTime.now());

        userRepository.save(user);
    }

    private UserResponse toResponse(User user) {

        return new UserResponse(
                user.getId(),
                user.getNameEn(),
                user.getNameAr(),
                user.getEmail(),
                user.getEmailVerifiedAt(),
                user.getStatus(),
                user.getTermsAndConditions(),
                user.getCreatedAt(),
                user.getUpdatedAt()
        );
    }
}