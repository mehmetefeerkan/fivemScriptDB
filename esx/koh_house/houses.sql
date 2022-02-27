

CREATE TABLE IF NOT EXISTS `houses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `houseid` varchar(50) DEFAULT NULL,
  `owner` varchar(50) DEFAULT '''''',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

INSERT INTO `houses` (`id`, `houseid`, `owner`) VALUES
	(1, '1', ''),
	(2, '2', ''),
	(3, '3', ''),
	(4, '4', ''),
	(5, '5', ''),
	(6, '6', ''),
	(7, '7', ''),
	(8, '8', ''),
	(9, '9', ''),
	(10, '10', '')
	

