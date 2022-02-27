USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_mecano1', 'Grove', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_mecano1', 'Grove', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('mecano1', 'Grove')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('mecano1',0,'recrue','Recruit',12,'{}','{}'),
	('mecano1',1,'novice','Novice',24,'{}','{}'),
	('mecano1',2,'experimente','Experienced',36,'{}','{}'),
	('mecano1',3,'chief','Leader',48,'{}','{}'),
	('mecano1',4,'boss','Boss',0,'{}','{}')
;
