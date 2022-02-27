INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_usaf', 'usaf', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_usaf', 'usaf', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_usaf', 'usaf', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('usaf','usaf')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('usaf',0,'recruit','Private',300,'{}','{}'),
	('usaf',1,'officer','Private First Class',450,'{}','{}'),
	('usaf',2,'sergeant','Corporal',900,'{}','{}'),
	('usaf',3,'intendent','Sergeant',1400,'{}','{}'),
	('usaf',4,'lieutenant','Staff Sergeant',2000,'{}','{}'),
	('usaf',5,'chef','Sergeant First Class',2600,'{}','{}'),
	('usaf',6,'boss','First Sergeant',4000,'{}','{}'),
	('usaf',7,'srecruit','Sergeant Major',300,'{}','{}'),
	('usaf',8,'sofficer','Second lieutenant',400,'{}','{}'),
	('usaf',9,'ssergeant','First Lieutenant',850,'{}','{}'),
	('usaf',10,'sintendent','Captain',1350,'{}','{}'),
	('usaf',11,'slieutenant','Major',1900,'{}','{}'),
	('usaf',12,'schef','Lieutenant Colonel',2700,'{}','{}'),
	('usaf',13,'sboss','Senior Colonel',4000,'{}','{}')
;