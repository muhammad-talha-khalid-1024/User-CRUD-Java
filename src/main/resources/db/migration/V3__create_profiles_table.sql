CREATE TABLE IF NOT EXISTS `profiles` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `userId` BIGINT NOT NULL,

    `gender` VARCHAR(20) NULL,
    `nationality` VARCHAR(50) NULL,
    `countryOfResidence` VARCHAR(50) NULL,
    `religion` VARCHAR(20) NULL,
    `dob` DATE NULL,
    `pob` VARCHAR(50) NULL,
    `maritalStatus` VARCHAR(20) NULL,
    `shortBiography` TEXT NULL,
    `status` TINYINT NOT NULL DEFAULT 1,
    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`),
    CONSTRAINT `profiles_userid_foreign`
        FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `passport_details` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `userId` BIGINT NOT NULL,

    `passportNumber` VARCHAR(20) NULL,
    `passportType` VARCHAR(50) NULL,
    `passportIssuerDate` DATE NULL,
    `passportExpiryDate` DATE NULL,
    `passportIssueBy` VARCHAR(100) NULL,
    `passportIssuingCountry` VARCHAR(50) NULL,
    `passportPlaceOfIssue` VARCHAR(100) NULL,
    `status` TINYINT NOT NULL DEFAULT 1,
    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`),
    CONSTRAINT `passport_details_userid_foreign`
        FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `communications` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `userId` BIGINT NOT NULL,

    `key` VARCHAR(255) NULL,
    `meta` JSON NULL,
    `status` TINYINT NOT NULL DEFAULT 1,
    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`),
    CONSTRAINT `communications_userid_foreign`
        FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `addresses` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `userId` BIGINT NOT NULL,

    `zip` VARCHAR(10) NULL,
    `state` VARCHAR(50) NULL,
    `city` VARCHAR(50) NULL,
    `country` VARCHAR(50) NULL,
    `address` VARCHAR(255) NULL,
    `status` TINYINT NOT NULL DEFAULT 1,
    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`),
    CONSTRAINT `addresses_userid_foreign`
        FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `qatar_info` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `userId` BIGINT NOT NULL,

    `key` VARCHAR(255) NULL,
    `meta` JSON NULL,
    `status` TINYINT NOT NULL DEFAULT 1,
    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`),
    CONSTRAINT `qatar_info_userid_foreign`
        FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;