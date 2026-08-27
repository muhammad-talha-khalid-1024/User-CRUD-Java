CREATE TABLE IF NOT EXISTS `stages` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,

    `name` VARCHAR(50) NOT NULL,
    `nameAr` VARCHAR(50) NULL,
    `slug` VARCHAR(50) NOT NULL,
    `description` TEXT NULL,
    `order` INT NOT NULL,
    `status` TINYINT NOT NULL DEFAULT 1,

    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `stages_statuses` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,

    `stageId` BIGINT NOT NULL,

    `name` VARCHAR(50) NOT NULL,
    `nameAr` VARCHAR(50) NULL,
    `slug` VARCHAR(50) NOT NULL,
    `status` TINYINT NOT NULL DEFAULT 1,

    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`),

    CONSTRAINT `stages_statuses_stageid_foreign`
        FOREIGN KEY (`stageId`)
        REFERENCES `stages` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `request_stages` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,

    `reqId` BIGINT NOT NULL,

    `stageSlug` VARCHAR(50) NOT NULL,
    `startDate` DATE NOT NULL,
    `endDate` DATE NULL,
    `order` INT NOT NULL,
    `status` TINYINT NOT NULL DEFAULT 0,

    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`),

    CONSTRAINT `request_stages_reqid_foreign`
        FOREIGN KEY (`reqId`)
        REFERENCES `requests` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `request_statuses` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,

    `userId` BIGINT NOT NULL,
    `reqStageId` BIGINT NOT NULL,

    `stageStatusSlug` VARCHAR(50) NOT NULL,
    `startDate` DATE NOT NULL,
    `endDate` DATE NULL,
    `meta` JSON NULL,
    `status` TINYINT NOT NULL DEFAULT 0,

    `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `deletedAt` TIMESTAMP NULL,

    PRIMARY KEY (`id`),

    CONSTRAINT `request_statuses_userid_foreign`
        FOREIGN KEY (`userId`)
        REFERENCES `users` (`id`)
        ON DELETE CASCADE,

    CONSTRAINT `request_statuses_reqstageid_foreign`
        FOREIGN KEY (`reqStageId`)
        REFERENCES `request_stages` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;