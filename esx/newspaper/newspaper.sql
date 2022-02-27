CREATE TABLE `newspaper` (
	`ID` INT(11) NOT NULL DEFAULT '1',
	`reporter` TEXT NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`articleTitle1` TEXT(65535) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`articleTitle2` TEXT(65535) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`articleDesc1` TEXT(65535) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`articleDesc2` TEXT(65535) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`arrest1` TEXT(65535) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`arrest2` TEXT(65535) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`arrest3` TEXT(65535) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	PRIMARY KEY (`ID`) USING BTREE,
	UNIQUE INDEX `ID` (`ID`) USING BTREE
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

INSERT INTO `newspaper` (`ID`, `reporter`)
 VALUES
  (1, NULL)
;