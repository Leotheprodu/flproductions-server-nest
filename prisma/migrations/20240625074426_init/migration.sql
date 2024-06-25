/*
  Warnings:

  - You are about to drop the `song_genres` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `song_genres` DROP FOREIGN KEY `Song_genres_genreId_fkey`;

-- DropForeignKey
ALTER TABLE `song_genres` DROP FOREIGN KEY `Song_genres_songId_fkey`;

-- DropTable
DROP TABLE `song_genres`;

-- CreateTable
CREATE TABLE `_Song_genres` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_Song_genres_AB_unique`(`A`, `B`),
    INDEX `_Song_genres_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `_Song_genres` ADD CONSTRAINT `_Song_genres_A_fkey` FOREIGN KEY (`A`) REFERENCES `Genres`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_Song_genres` ADD CONSTRAINT `_Song_genres_B_fkey` FOREIGN KEY (`B`) REFERENCES `Songs`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
