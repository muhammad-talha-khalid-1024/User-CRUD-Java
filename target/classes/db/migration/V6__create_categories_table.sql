CREATE TABLE IF NOT EXISTS `categories` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `nameAr` VARCHAR(255) NULL,
    `slug` VARCHAR(20) NOT NULL,
    `status` TINYINT NOT NULL DEFAULT 1,

    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `sectors` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `nameAr` VARCHAR(255) NULL,
    `slug` VARCHAR(20) NOT NULL,
    `status` TINYINT NOT NULL DEFAULT 1,

    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `sub_categories` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `categoryId` BIGINT NOT NULL,

    `name` VARCHAR(255) NOT NULL,
    `nameAr` VARCHAR(255) NULL,
    `slug` VARCHAR(20) NOT NULL,
    `status` TINYINT NOT NULL DEFAULT 1,

    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`),

    CONSTRAINT `sub_categories_categoryid_foreign`
        FOREIGN KEY (`categoryId`)
        REFERENCES `categories` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `category_sector` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `categoryId` BIGINT NOT NULL,
    `sectorId` BIGINT NOT NULL,

    PRIMARY KEY (`id`),

    UNIQUE KEY `category_sector_categoryid_sectorid_unique`
        (`categoryId`, `sectorId`),

    CONSTRAINT `category_sector_categoryid_foreign`
        FOREIGN KEY (`categoryId`)
        REFERENCES `categories` (`id`)
        ON DELETE CASCADE,

    CONSTRAINT `category_sector_sectorid_foreign`
        FOREIGN KEY (`sectorId`)
        REFERENCES `sectors` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `activities` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `sectorId` BIGINT NOT NULL,

    `name` VARCHAR(255) NOT NULL,
    `nameAr` VARCHAR(255) NULL,
    `slug` VARCHAR(20) NOT NULL,
    `status` TINYINT NOT NULL DEFAULT 1,

    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`),

    CONSTRAINT `activities_sectorid_foreign`
        FOREIGN KEY (`sectorId`)
        REFERENCES `sectors` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `sub_activities` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `activityId` BIGINT NOT NULL,

    `name` VARCHAR(255) NOT NULL,
    `nameAr` VARCHAR(255) NULL,
    `slug` VARCHAR(20) NOT NULL UNIQUE,
    `status` TINYINT NOT NULL DEFAULT 1,

    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`),

    CONSTRAINT `sub_activities_activityid_foreign`
        FOREIGN KEY (`activityId`)
        REFERENCES `activities` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `entities` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,

    `name` VARCHAR(255) NOT NULL UNIQUE,
    `nameAr` VARCHAR(255) NULL,
    `slug` VARCHAR(20) NOT NULL UNIQUE,
    `status` TINYINT NOT NULL DEFAULT 1,

    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `activity_entity` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,

    `activityId` BIGINT NOT NULL,
    `entityId` BIGINT NOT NULL,

    PRIMARY KEY (`id`),

    UNIQUE KEY `activity_entity_activityid_entityid_unique`
        (`activityId`, `entityId`),

    CONSTRAINT `activity_entity_activityid_foreign`
        FOREIGN KEY (`activityId`)
        REFERENCES `activities` (`id`)
        ON DELETE CASCADE,

    CONSTRAINT `activity_entity_entityid_foreign`
        FOREIGN KEY (`entityId`)
        REFERENCES `entities` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `incubators` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,

    `categoryId` BIGINT NOT NULL,
    `name` VARCHAR(255) NOT NULL UNIQUE,
    `nameAr` VARCHAR(255) NULL,
    `slug` VARCHAR(20) NOT NULL UNIQUE,
    `status` TINYINT NOT NULL DEFAULT 1,

    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`),

    CONSTRAINT `incubators_categoryid_foreign`
        FOREIGN KEY (`categoryId`)
        REFERENCES `categories` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `nationalities` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,

    `name` VARCHAR(255) NOT NULL,
    `phonecode` VARCHAR(20) NULL,
    `iso2` VARCHAR(3) NULL,
    `flag` VARCHAR(3) NULL,

    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `form_fields` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,

    `nameEn` VARCHAR(255) NOT NULL,
    `nameAr` VARCHAR(255) NULL,
    `slug` VARCHAR(255) NOT NULL,
    `type` VARCHAR(255) NOT NULL,
    `meta` JSON NULL,
    `status` TINYINT NOT NULL DEFAULT 1,

    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `form_field_metas` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,

    `ffId` BIGINT NOT NULL,

    `key` VARCHAR(50) NOT NULL,
    `meta` JSON NOT NULL,
    `onshoreOffShore` VARCHAR(255) NOT NULL,
    `isRequired` TINYINT(1) NOT NULL,

    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`),

    CONSTRAINT `form_field_metas_ffid_foreign`
        FOREIGN KEY (`ffId`)
        REFERENCES `form_fields` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;