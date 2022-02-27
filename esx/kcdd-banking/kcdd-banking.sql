-- --------------------------------------------------------
-- Sunucu:                       127.0.0.1
-- Sunucu sürümü:                10.4.11-MariaDB - mariadb.org binary distribution
-- Sunucu İşletim Sistemi:       Win64
-- HeidiSQL Sürüm:               11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- essentialmode için veritabanı yapısı dökülüyor
CREATE DATABASE IF NOT EXISTS `essentialmode` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `essentialmode`;

-- tablo yapısı dökülüyor essentialmode.bankhistory
CREATE TABLE IF NOT EXISTS `bankhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `header` varchar(999) DEFAULT NULL,
  `amount` int(50) DEFAULT 0,
  `msg` varchar(999) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- essentialmode.bankhistory: ~0 rows (yaklaşık) tablosu için veriler indiriliyor
/*!40000 ALTER TABLE `bankhistory` DISABLE KEYS */;
INSERT INTO `bankhistory` (`id`, `identifier`, `header`, `amount`, `msg`, `type`) VALUES
	(6, '1cc7d24b9f560fc7a72019dec468a9db666b529f', 'Withdrawal process', 555, 'daasd', 'withdraw'),
	(7, '1cc7d24b9f560fc7a72019dec468a9db666b529f', 'Withdrawal process', 5000, 'canım istedi', 'withdraw'),
	(8, '1cc7d24b9f560fc7a72019dec468a9db666b529f', 'Deposit process', 31, '', 'deposit'),
	(9, '1cc7d24b9f560fc7a72019dec468a9db666b529f', 'Deposit process', 1, '', 'deposit');
/*!40000 ALTER TABLE `bankhistory` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
