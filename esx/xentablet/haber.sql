CREATE TABLE IF NOT EXISTS `tab_newsaccounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `tab_newpaper` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `htitle` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kmessage` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `umessage` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_tab_newpaper_tab_newsaccounts` (`authorId`),
  CONSTRAINT `FK_tab_newpaper_tab_newsaccounts` FOREIGN KEY (`authorId`) REFERENCES `tab_newsaccounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
