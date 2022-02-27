-- --------------------------------------------------------
-- Sunucu:                       127.0.0.1
-- Sunucu sürümü:                5.7.15-log - MySQL Community Server (GPL)
-- Sunucu İşletim Sistemi:       Win32
-- HeidiSQL Sürüm:               11.1.0.6116
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- extendedmode için veritabanı yapısı dökülüyor
CREATE DATABASE IF NOT EXISTS `extendedmode` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `extendedmode`;

-- tablo yapısı dökülüyor extendedmode.bz_bandana
CREATE TABLE IF NOT EXISTS `bz_bandana` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mavi` int(11) NOT NULL DEFAULT '0',
  `mor` int(11) NOT NULL DEFAULT '0',
  `kirmizi` int(11) NOT NULL DEFAULT '0',
  `yesil` int(11) NOT NULL DEFAULT '0',
  `sari` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=UTF8MB4;

-- extendedmode.bz_bandana: ~1 rows (yaklaşık) tablosu için veriler indiriliyor
/*!40000 ALTER TABLE `bz_bandana` DISABLE KEYS */;
INSERT INTO `bz_bandana` (`id`, `mavi`, `mor`, `kirmizi`, `yesil`, `sari`) VALUES
	(1, 0, 0, 0, 0, 0);
/*!40000 ALTER TABLE `bz_bandana` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
