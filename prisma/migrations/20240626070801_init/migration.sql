/*
  Warnings:

  - You are about to drop the `file_types` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `project_media` DROP FOREIGN KEY `Project_media_fileTypeId_fkey`;

-- DropTable
DROP TABLE `file_types`;

-- CreateTable
CREATE TABLE `Media_types` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `typeName` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Project_media` ADD CONSTRAINT `Project_media_fileTypeId_fkey` FOREIGN KEY (`fileTypeId`) REFERENCES `Media_types`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
