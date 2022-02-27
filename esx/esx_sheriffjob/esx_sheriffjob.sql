USE `extendedmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_sheriff', 'sheriff', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_sheriff', 'sheriff', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_sheriff', 'sheriff', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('sheriff','LSSD')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('sheriff',0,'cadet','Cadet',300,'{}','{}'),
	('sheriff',1,'officer','Officer',450,'{}','{}'),
	('sheriff',2,'officer2','Officer II',900,'{}','{}'),
	('sheriff',3,'officer3','Officer III',1400,'{}','{}'),
	('sheriff',4,'officer4','Officer III + I',2000,'{}','{}'),
	('sheriff',5,'sergeant','Sergent',2600,'{}','{}'),
	('sheriff',6,'sergeant2','Sergent II',3000,'{}','{}'),
	('sheriff',7,'lieutenant1','Lieutenant',3500,'{}','{}'),
	('sheriff',8,'lieutenant2','Lieutenant II',4000,'{}','{}'),
	('sheriff',9,'captain','Captain',4000,'{}','{}'),
	('sheriff',10,'captain2','Captain II',4000,'{}','{}'),
	('sheriff',11,'commander','Commander',4000,'{}','{}'),
	('sheriff',12,'undersheriff','Under sheriff',4000,'{}','{}'),
	('sheriff',13,'boss','sheriff',4000,'{}','{}')
;