INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_taco','Tacos & Burritos',1),
	('taco','Tacos & Burritos',1),
	('taco_black_money','Black Money',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_taco', 'Tacos & Burritos', 1),
	('taco','Tacos & Burritos',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_taco','Tacos & Burritos',1),
	('taco','Tacos & Burritos',1),
	('ttray','Tacos Tray', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('taco','Tacos & Burritos'),
	('offtaco','Tacos & Burritos')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('taco',0,'staff','Cook',10,'{}','{}'),
	('taco',1,'agent','Chief Cook',25,'{}','{}'),
	('taco',2,'manager','Manager',40,'{}','{}'),
	('taco',3,'boss','Owner',0,'{}','{}'),

	('offtaco',0,'staff','Off-Duty',0,'{}','{}'),
	('offtaco',1,'agent','Off-Duty',0,'{}','{}'),
	('offtaco',2,'manager','Off-Duty',0,'{}','{}'),
	('offtaco',3,'boss','Off-Duty',0,'{}','{}')
;

INSERT INTO `items` (`name`, `label`) VALUES
('taco', 'Taco'),
('tacowrap', 'Taco Wrap'),
('burritos', 'Burritos'),
('bunsdog', 'Hotdog on Buns'),
('groundmeat', 'Ground Meat')
;