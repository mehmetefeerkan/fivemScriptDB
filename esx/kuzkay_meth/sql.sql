/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for aveirodb
CREATE DATABASE IF NOT EXISTS `aveirodb` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `aveirodb`;

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('acetone', 'Acetone', -1, 0, 1),
	('methlab', 'Meth Lab', -1, 0, 1),
	('meth', 'Meth', -1, 0, 1),
	('lithium', 'Lityum Batarya', -1, 0, 1);
/*!40000 ALTER TABLE `addon_inventory_items` ENABLE KEYS */;