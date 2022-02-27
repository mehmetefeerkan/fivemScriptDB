USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('police','LSPD')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('police',0,'recruit','Stajyer Polis',300,'{}','{}'),
	('police',1,'officer','Polis Memuru',450,'{}','{}'),
	('police',2,'sergeant','Kidemli Polis',900,'{}','{}'),
	('police',3,'intendent','Komiser',1400,'{}','{}'),
	('police',4,'lieutenant','Baskomiser',2000,'{}','{}'),
	('police',5,'chef','Emniyet Amiri',2600,'{}','{}'),
	('police',6,'boss','Emniyet Muduru',4000,'{}','{}'),
	('police',7,'srecruit','Stajyer Şerif',300,'{}','{}'),
	('police',8,'sofficer','Şerif',400,'{}','{}'),
	('police',9,'ssergeant','Kidemli Şerif',850,'{}','{}'),
	('police',10,'sintendent','Komiser',1350,'{}','{}'),
	('police',11,'slieutenant','Baskomiser',1900,'{}','{}'),
	('police',12,'schef','Amir',2700,'{}','{}'),
	('police',13,'sboss','Serif',4000,'{}','{}')
;

CREATE TABLE `fine_types` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`label` varchar(255) DEFAULT NULL,
	`amount` int(11) DEFAULT NULL,
	`category` int(11) DEFAULT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `fine_types` (label, amount, category) VALUES
	('Dikkatsiz Sürüş',1000,0),
	('Hatali Sollama',1500,0),
	('Ters Yonde Arac Kullanma',2500,0),
	('Yetkisiz U Donusu',2500,0),
	('Arazide Arac Kullanma',1700,0),
	('Kazada Suclu Bulunma',3000,0),
	('Tehlikeli / Yasak Duruslar',1500,0),
	('Uygunsuz / Yasak Park Etme',700,0),
	('Kayitsiz Plakali Arac Kullanimi',700,0),
	('Oncelikli Araçlara Yol Vermeme',900,0),
	('Dur ihtarina Uymama',1050,0),
	('Kirmizi isiga Uymama',1300,0),
	('Cop Bait Uyarisi',1000,0),
	('Devlet Dairesine Ait Olan Arac',5000,0),
	('Calinti Arac Kullanimi',3000,0),
	('Vur Kac',800,0),
	('Hiz Yapma< 60 kmh',900,0),
	('Hiz Yapma < 80 kmh',1200,0),
	('Hiz Yapma < 120 kmh',1800,0),
	('Hiz Yapma < 130 ve ustu kmh',3000,0),
	('Trafik Akisini Engelleme',1100,1),
	('Trafik Kazasina Sebebiyet',900,1),
	('Hasarli Arac ile Seyahat',900,1),
	('Polis Operasyonunu Engelleme',2000,1),
	('Hakaret Etmek / Siviller',750,1),
	('Polis Memuruna Girisimde Bulunma',1100,1),
	('Sozlu Tehdit veya Fiziksel Girisim',900,1),
	('Bir Polis Memuruna Sozlu Tehdit Veya Fiziksel Girisim',1500,1),
	('Yasa Disi Protesto',2500,1),
	('Rusvet Teklif Etme',10000,1),
	('Silahi Kabzasi Disinda Bulundurma',1200,2),
	('Olumcul Silah Bulundurma',3000,2),
	('Ruhsatsiz Silah Bulundurma (Bulundurma Lisansı)',6000,2),
	('İllegal Silah Bulundurma',7000,2),
	('Maymuncuk Tasima',3000,2),
	('Arac Hirsizligi',1800,2),
	('Uyusturucu Satisi Yapma',3000,2),
	('Uyusturucu Trafigi Yapma',3500,2),
	('Uyusturucu Uretimi Yapma',6500,2),
	('Onaysiz  Sivil inis Gerceklestirme',1500,2),
	('Devlet Memurunu Rehin Alma',1000,2),
	('Soygun Girisiminde Bulunma',5000,2),
	('Magaza / Dukkan Soyma',10000,2),
	('Banka Soygunu ',50000,2),
	('Sivil Yaralama',5000,3),
	('Devlet Memurunu Yaralama',10000,3),
	('Sivil Oldurme Tesebbus',12500,3),
	('Devlet Memurunu Oldurmeye Tesebbus',25000,3),
	('Sivil Oldurme',25000,3),
	('Devlet Memuru Oldurme',50000,3),
	('Istemsiz Cinayet / Nevsi Mudafa',1800,3),
	('Is Hirsizligi / Vergi Kacirma',2000,2)
;
