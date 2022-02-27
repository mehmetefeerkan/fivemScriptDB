CREATE TABLE `Brn_stashouse` (
	`identity` VARCHAR(150) NOT NULL COLLATE 'utf8mb4_turkish_ci',
	`houseid` VARCHAR(150) NOT NULL COLLATE 'utf8mb4_turkish_ci',
	`price` VARCHAR(150) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_bin'
)
COLLATE='utf8mb4_turkish_ci'
ENGINE=InnoDB
;