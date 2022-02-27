-- --------------------------------------------------------
-- Sunucu:                       127.0.0.1
-- Sunucu sürümü:                5.7.31-log - MySQL Community Server (GPL)
-- Sunucu İşletim Sistemi:       Win64
-- HeidiSQL Sürüm:               11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- tablo yapısı dökülüyor essentialmode.m3_inv_customstashs
CREATE TABLE IF NOT EXISTS `m3_inv_customstashs` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `stashname` varchar(50) NOT NULL,
  `data` longtext,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- Veri çıktısı seçilmemişti

-- tablo yapısı dökülüyor essentialmode.m3_inv_gloveboxs
CREATE TABLE IF NOT EXISTS `m3_inv_gloveboxs` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `plate` varchar(50) NOT NULL,
  `data` longtext,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- Veri çıktısı seçilmemişti

-- tablo yapısı dökülüyor essentialmode.m3_inv_stashs
CREATE TABLE IF NOT EXISTS `m3_inv_stashs` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `stashname` varchar(50) NOT NULL,
  `owner` varchar(50) NOT NULL,
  `data` longtext,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

-- Veri çıktısı seçilmemişti

-- tablo yapısı dökülüyor essentialmode.m3_inv_trunks
CREATE TABLE IF NOT EXISTS `m3_inv_trunks` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `plate` varchar(50) NOT NULL,
  `data` longtext,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- Veri çıktısı seçilmemişti

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
