CREATE TABLE user_has_permissions (
    userId BIGINT NOT NULL,
    permissionId BIGINT NOT NULL,

    PRIMARY KEY (userId, permissionId),

    CONSTRAINT fk_user_has_permissions_user
        FOREIGN KEY (userId)
        REFERENCES users(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_user_has_permissions_permission
        FOREIGN KEY (permissionId)
        REFERENCES permissions(id)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;