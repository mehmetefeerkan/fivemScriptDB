USE `essentialmode`;

ALTER TABLE `owned_vehicles`
	ADD `color` varchar(5) NOT NULL DEFAULT 'NOT',
;