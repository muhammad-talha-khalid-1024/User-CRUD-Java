CREATE TABLE IF NOT EXISTS `requests` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `userId` BIGINT NOT NULL,

    `reqReferenceNumber` VARCHAR(50) NULL UNIQUE,
    `nameEn` VARCHAR(100) NULL,
    `nameAr` VARCHAR(255) NULL,
    `email` VARCHAR(100) NULL,
    `mobileNumber` VARCHAR(20) NULL,
    `passportNumber` VARCHAR(20) NULL,
    `qid` VARCHAR(11) NULL,
    `status` TINYINT NOT NULL DEFAULT 0,

    `submittedAt` DATE NOT NULL,

    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`),

    CONSTRAINT `requests_userid_foreign`
        FOREIGN KEY (`userId`)
        REFERENCES `users` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `request_meta_data` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `reqId` BIGINT NOT NULL,

    `key` VARCHAR(255) NOT NULL,
    `value` VARCHAR(255) NOT NULL,

    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`),

    CONSTRAINT `request_meta_data_reqid_foreign`
        FOREIGN KEY (`reqId`)
        REFERENCES `requests` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `request_type_codes` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `reqId` BIGINT NOT NULL,

    `key` BIGINT NOT NULL,
    `secureCode` VARCHAR(100) NOT NULL,
    `expiryDate` DATE NOT NULL,
    `expiry` TINYINT NOT NULL DEFAULT 1,

    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`),

    CONSTRAINT `request_type_codes_reqid_foreign`
        FOREIGN KEY (`reqId`)
        REFERENCES `requests` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `request_codes_documents` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `reqTypeCodeId` BIGINT NOT NULL,

    `key` BIGINT NOT NULL,
    `documentName` VARCHAR(100) NOT NULL,

    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`),

    CONSTRAINT `request_codes_documents_reqtypecodeid_foreign`
        FOREIGN KEY (`reqTypeCodeId`)
        REFERENCES `request_type_codes` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `request_attributes` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `reqId` BIGINT NOT NULL,

    `meta` JSON NULL,
    `type` VARCHAR(255) NOT NULL,

    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`),

    CONSTRAINT `request_attributes_reqid_foreign`
        FOREIGN KEY (`reqId`)
        REFERENCES `requests` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `request_quality_checks` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,

    `reqBy` BIGINT NOT NULL,
    `subBy` BIGINT NULL,
    `reqId` BIGINT NOT NULL,

    `descriptionEn` TEXT NULL,
    `descriptionAr` TEXT NULL,
    `meta` JSON NULL,
    `summary` JSON NULL,

    `requestedAt` TIMESTAMP NOT NULL,
    `submittedAt` TIMESTAMP NULL,
    `verifiedAt` TIMESTAMP NULL,

    `status` VARCHAR(50) NOT NULL DEFAULT 'Action Required',

    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`),

    CONSTRAINT `request_quality_checks_reqby_foreign`
        FOREIGN KEY (`reqBy`)
        REFERENCES `users` (`id`)
        ON DELETE CASCADE,

    CONSTRAINT `request_quality_checks_subby_foreign`
        FOREIGN KEY (`subBy`)
        REFERENCES `users` (`id`)
        ON DELETE CASCADE,

    CONSTRAINT `request_quality_checks_reqid_foreign`
        FOREIGN KEY (`reqId`)
        REFERENCES `requests` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `request_assignments` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,

    `reqId` BIGINT NOT NULL,
    `modelId` BIGINT NOT NULL,
    `modelType` VARCHAR(255) NOT NULL,

    `meta` JSON NULL,
    `status` TINYINT NOT NULL DEFAULT 1,

    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`),

    KEY `request_has_assignments_modelId_modelType_index`
        (`modelId`, `modelType`),

    CONSTRAINT `request_assignments_reqid_foreign`
        FOREIGN KEY (`reqId`)
        REFERENCES `requests` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;