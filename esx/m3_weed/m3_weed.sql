CREATE TABLE `m3_weedcoords` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`coord` varchar(100) DEFAULT NULL,
	`radius` float(10) DEFAULT NULL,
	`burned` tinyint(1) DEFAULT 0,

	PRIMARY KEY (`id`)
);