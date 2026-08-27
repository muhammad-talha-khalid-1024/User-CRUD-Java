CREATE TABLE IF NOT EXISTS `permissions` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `type` VARCHAR(255) NOT NULL,
    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_permissions_name` (`name`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `roles` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `type` VARCHAR(255) NOT NULL,
    `slug` VARCHAR(255) NOT NULL,
    `approvalLevel` TINYINT(2) NOT NULL DEFAULT 0,
    `meta` JSON NULL,
    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_roles_name` (`name`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `user_has_roles` (
    `userId` BIGINT NOT NULL,
    `roleId` BIGINT NOT NULL,
    `level` VARCHAR(100) NULL,

    PRIMARY KEY (`userId`, `roleId`),

    CONSTRAINT `fk_user_has_roles_user`
        FOREIGN KEY (`userId`)
        REFERENCES `users`(`id`)
        ON DELETE CASCADE,

    CONSTRAINT `fk_user_has_roles_role`
        FOREIGN KEY (`roleId`)
        REFERENCES `roles`(`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `user_has_permissions` (
    `userId` BIGINT NOT NULL,
    `permissionId` BIGINT NOT NULL,

    PRIMARY KEY (`userId`, `permissionId`),

    CONSTRAINT `fk_user_has_permissions_user`
        FOREIGN KEY (`userId`)
        REFERENCES `users`(`id`)
        ON DELETE CASCADE,

    CONSTRAINT `fk_user_has_permissions_permission`
        FOREIGN KEY (`permissionId`)
        REFERENCES `permissions`(`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;