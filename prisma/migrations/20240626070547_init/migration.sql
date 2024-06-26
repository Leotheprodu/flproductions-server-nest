/*
  Warnings:

  - You are about to drop the column `artist_name` on the `artists` table. All the data in the column will be lost.
  - You are about to drop the column `info` on the `artists` table. All the data in the column will be lost.
  - You are about to drop the column `tipo` on the `artists` table. All the data in the column will be lost.
  - You are about to drop the `_genrestosongs` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `songs` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `artistName` to the `Artists` table without a default value. This is not possible if the table is not empty.
  - Added the required column `typeId` to the `Artists` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `_genrestosongs` DROP FOREIGN KEY `_GenresToSongs_A_fkey`;

-- DropForeignKey
ALTER TABLE `_genrestosongs` DROP FOREIGN KEY `_GenresToSongs_B_fkey`;

-- DropForeignKey
ALTER TABLE `songs` DROP FOREIGN KEY `Songs_artistId_fkey`;

-- AlterTable
ALTER TABLE `artists` DROP COLUMN `artist_name`,
    DROP COLUMN `info`,
    DROP COLUMN `tipo`,
    ADD COLUMN `artistName` VARCHAR(191) NOT NULL,
    ADD COLUMN `description` VARCHAR(191) NULL,
    ADD COLUMN `typeId` INTEGER NOT NULL;

-- DropTable
DROP TABLE `_genrestosongs`;

-- DropTable
DROP TABLE `songs`;

-- CreateTable
CREATE TABLE `Type_of_artists` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `typeName` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Projects` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `songName` VARCHAR(191) NOT NULL,
    `userId` INTEGER NOT NULL,
    `description` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Project_media` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `projectId` INTEGER NOT NULL,
    `fileUrl` VARCHAR(191) NOT NULL,
    `clientUrl` VARCHAR(191) NOT NULL,
    `fileTypeId` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `File_types` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `typeName` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Status_names` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `statusName` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Projects_status` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `projectId` INTEGER NOT NULL,
    `statusId` INTEGER NOT NULL,
    `projectMediaId` INTEGER NOT NULL,
    `description` VARCHAR(191) NOT NULL,
    `startDate` DATETIME(3) NOT NULL,
    `endDate` DATETIME(3) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Projects_artists` (
    `artistId` INTEGER NOT NULL,
    `projectId` INTEGER NOT NULL,
    `isFT` BOOLEAN NOT NULL DEFAULT false,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`artistId`, `projectId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_GenresToProjects` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_GenresToProjects_AB_unique`(`A`, `B`),
    INDEX `_GenresToProjects_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Artists` ADD CONSTRAINT `Artists_typeId_fkey` FOREIGN KEY (`typeId`) REFERENCES `Type_of_artists`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Projects` ADD CONSTRAINT `Projects_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `Users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Project_media` ADD CONSTRAINT `Project_media_projectId_fkey` FOREIGN KEY (`projectId`) REFERENCES `Projects`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Project_media` ADD CONSTRAINT `Project_media_fileTypeId_fkey` FOREIGN KEY (`fileTypeId`) REFERENCES `File_types`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Projects_status` ADD CONSTRAINT `Projects_status_statusId_fkey` FOREIGN KEY (`statusId`) REFERENCES `Status_names`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Projects_status` ADD CONSTRAINT `Projects_status_projectId_fkey` FOREIGN KEY (`projectId`) REFERENCES `Projects`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Projects_status` ADD CONSTRAINT `Projects_status_projectMediaId_fkey` FOREIGN KEY (`projectMediaId`) REFERENCES `Project_media`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Projects_artists` ADD CONSTRAINT `Projects_artists_artistId_fkey` FOREIGN KEY (`artistId`) REFERENCES `Artists`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Projects_artists` ADD CONSTRAINT `Projects_artists_projectId_fkey` FOREIGN KEY (`projectId`) REFERENCES `Projects`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_GenresToProjects` ADD CONSTRAINT `_GenresToProjects_A_fkey` FOREIGN KEY (`A`) REFERENCES `Genres`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_GenresToProjects` ADD CONSTRAINT `_GenresToProjects_B_fkey` FOREIGN KEY (`B`) REFERENCES `Projects`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
