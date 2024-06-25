/*
  Warnings:

  - You are about to drop the `_song_genres` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `_song_genres` DROP FOREIGN KEY `_Song_genres_A_fkey`;

-- DropForeignKey
ALTER TABLE `_song_genres` DROP FOREIGN KEY `_Song_genres_B_fkey`;

-- DropTable
DROP TABLE `_song_genres`;

-- CreateTable
CREATE TABLE `_GenresToSongs` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_GenresToSongs_AB_unique`(`A`, `B`),
    INDEX `_GenresToSongs_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `_GenresToSongs` ADD CONSTRAINT `_GenresToSongs_A_fkey` FOREIGN KEY (`A`) REFERENCES `Genres`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_GenresToSongs` ADD CONSTRAINT `_GenresToSongs_B_fkey` FOREIGN KEY (`B`) REFERENCES `Songs`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
