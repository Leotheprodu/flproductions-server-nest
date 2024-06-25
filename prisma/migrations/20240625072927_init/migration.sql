/*
  Warnings:

  - You are about to drop the `appmessages` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `artistas` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `songgenres` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `temporaltokenpool` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `userroles` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `artistas` DROP FOREIGN KEY `Artistas_userId_fkey`;

-- DropForeignKey
ALTER TABLE `songgenres` DROP FOREIGN KEY `SongGenres_genreId_fkey`;

-- DropForeignKey
ALTER TABLE `songgenres` DROP FOREIGN KEY `SongGenres_songId_fkey`;

-- DropForeignKey
ALTER TABLE `songs` DROP FOREIGN KEY `Songs_artistId_fkey`;

-- DropForeignKey
ALTER TABLE `temporaltokenpool` DROP FOREIGN KEY `TemporalTokenPool_userEmail_fkey`;

-- DropForeignKey
ALTER TABLE `userroles` DROP FOREIGN KEY `UserRoles_rolId_fkey`;

-- DropForeignKey
ALTER TABLE `userroles` DROP FOREIGN KEY `UserRoles_userId_fkey`;

-- DropTable
DROP TABLE `appmessages`;

-- DropTable
DROP TABLE `artistas`;

-- DropTable
DROP TABLE `songgenres`;

-- DropTable
DROP TABLE `temporaltokenpool`;

-- DropTable
DROP TABLE `userroles`;

-- CreateTable
CREATE TABLE `Artists` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `artist_name` VARCHAR(191) NOT NULL,
    `instagram` VARCHAR(191) NULL,
    `spotify` VARCHAR(191) NULL,
    `imagen` VARCHAR(191) NULL,
    `info` VARCHAR(191) NULL,
    `tipo` VARCHAR(191) NOT NULL,
    `userId` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Artists_userId_key`(`userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `User_roles` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `rolId` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Temporal_token_pool` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `token` VARCHAR(191) NOT NULL,
    `userEmail` VARCHAR(191) NOT NULL,
    `type` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Temporal_token_pool_token_key`(`token`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `App_messages` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `message` VARCHAR(191) NOT NULL,
    `type` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Song_genres` (
    `songId` INTEGER NOT NULL,
    `genreId` INTEGER NOT NULL,

    PRIMARY KEY (`songId`, `genreId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Artists` ADD CONSTRAINT `Artists_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `User_roles` ADD CONSTRAINT `User_roles_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `User_roles` ADD CONSTRAINT `User_roles_rolId_fkey` FOREIGN KEY (`rolId`) REFERENCES `Roles`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Temporal_token_pool` ADD CONSTRAINT `Temporal_token_pool_userEmail_fkey` FOREIGN KEY (`userEmail`) REFERENCES `User`(`email`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Songs` ADD CONSTRAINT `Songs_artistId_fkey` FOREIGN KEY (`artistId`) REFERENCES `Artists`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Song_genres` ADD CONSTRAINT `Song_genres_songId_fkey` FOREIGN KEY (`songId`) REFERENCES `Songs`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Song_genres` ADD CONSTRAINT `Song_genres_genreId_fkey` FOREIGN KEY (`genreId`) REFERENCES `Genres`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
