INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_bshot','Burger Shot',1),
	('bshot','Burger Shot',1),
	('bshot_black_money','Black Money',1)

;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_bshot', 'Burger Shot', 1),
	('bshot','Burger Shot',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_bshot','Burger Shot',1),
	('bshot','Burger Shot',1),
	('bstray','BShot Order',1)
;

INSERT INTO `jobs` (name, label) VALUES
	('bshot','Burger Shot'),
	('offbshot','Burger Shot')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('bshot',0,'staff','Cook',10,'{}','{}'),
	('bshot',1,'agent','Chief Cook',25,'{}','{}'),
	('bshot',2,'manager','Manager',40,'{}','{}'),
	('bshot',3,'boss','Owner',0,'{}','{}'),

	('offbshot',0,'staff','Off-Duty',0,'{}','{}'),
	('offbshot',1,'agent','Off-Duty',0,'{}','{}'),
	('offbshot',2,'manager','Off-Duty',0,'{}','{}'),
	('offbshot',3,'boss','Off-Duty',0,'{}','{}')
;

INSERT INTO `items` (`name`, `label`) VALUES
('sprunk', 'Sprunk'),
('bleeder', 'The Bleeder'),
('stopper', 'Heart Stopper'),
('chilysauce', 'Chillie Sauce'),
('c_patty', 'Patty'),
('cheese', 'Cheese'),
('buns', 'Buns'),
('vegetables', 'Vegetables'),
('fresh_vegetables', 'Fresh Vegetables'),
('fresh_meat', 'Fresh Meat')
;