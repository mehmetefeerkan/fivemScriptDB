-- --------------------------------------------------------
-- Sunucu:                       127.0.0.1
-- Sunucu sürümü:                10.4.14-MariaDB - mariadb.org binary distribution
-- Sunucu İşletim Sistemi:       Win64
-- HeidiSQL Sürüm:               11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- extendedmode için veritabanı yapısı dökülüyor
CREATE DATABASE IF NOT EXISTS `extendedmode` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `extendedmode`;

-- tablo yapısı dökülüyor extendedmode.criminal_kimlik
CREATE TABLE IF NOT EXISTS `criminal_kimlik` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reason` varchar(50) NOT NULL DEFAULT 'Bilinmiyor',
  `fine` varchar(50) NOT NULL DEFAULT 'Bilinmiyor',
  `resmi` varchar(50) NOT NULL DEFAULT 'Yok',
  `user_id` varchar(50) NOT NULL DEFAULT 'Yok',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- extendedmode.criminal_kimlik: ~0 rows (yaklaşık) tablosu için veriler indiriliyor
/*!40000 ALTER TABLE `criminal_kimlik` DISABLE KEYS */;
/*!40000 ALTER TABLE `criminal_kimlik` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
