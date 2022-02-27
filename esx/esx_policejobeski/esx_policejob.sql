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
	('police',0,'recruit','Açıktaki Memur',20,'{}','{}'),
	('police',1,'recruit','Akademi Öğrencisi',40,'{}','{}'),
	('police',2,'recruit','Stajyer Memur',60,'{}','{}'),
	('police',3,'officer','Memur',85,'{}','{}'),
	('police',4,'officer','Başpolis Memur',100,'{}','{}'),
	('police',5,'officer','Komiser Yardımcısı',100,'{}','{}')
	('police',6,'sergeant','Komiser',100,'{}','{}')
	('police',7,'lieutenant','Başkomiser',100,'{}','{}')
	('police',8,'lieutenant','Emniyet Amiri',100,'{}','{}')
	('police',9,'boss','Şef',100,'{}','{}')
;

--
-- Table structure for table `fine_types`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `fine_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fine_types`
--

INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES 
	(1,'Şehir İçi Hız Aşımı > 90kmh',320,0),
	(2,'Şehir İçi Hız Aşımı > 150kmh',480,0),
	(3,'Şehir Dışı Hız Aşımı > 150kmh',270,0),
	(4,'Şehir Dışı Hız Aşımı > 220kmh',420,0),
	(5,'Trafiğe Açık Alanda Drift',200,0),
	(6,'Trafiğe Açık Alanda Lastik Yakma',120,0),
	(7,'Çalıntı Araç Kullanımı',520,0),
	(8,'Dikkatsiz Sürüş',220,0),
	(9,'Dur İhtarına Uymama',360,0),
	(10,'Trafik Akışını Engelleme',520,0),
	(11,'Yasadışı Modifiye',220,0),
	(12,'Kamu Araçlarına Yol Üstünlüğü Sağlamama',420,0),
	(13,'Ehliyetsiz Araç Kullanma',450,0),
	(14,'Araçta Yüksek Sesle Müzik Dinleme',360,0),
	(15,'Sivile Hakaret',70,1),
	(16,'Görevli Kamu Personeline Hakaret',120,1),
	(17,'Sivile Sözlü Tehdit',220,1),
	(18,'Görevli Kamu Personeline Sözlü Tehdit',260,1),
	(19,'Irkçı Söylemlerde Bulunma',180,1),
	(20,'Hayvanlara Zarar Verme',420,1),
	(21,'Eşgal Gizleme',200,1),
	(22,'Devlet Malına Kasıtlı Zarar',260,1),
	(23,'Sözlü Taciz',120,1),
	(24,'Fiziksel Taciz',190,1),
	(25,'Gasp',400,2),
	(26,'Uyuşturucu Üretimi',720,2),
	(27,'Uyuşturucu Satışı',680,2),
	(28,'Uyuşturucu Bulundurma',420,2),
	(29,'Suç Mahallinden Kaçış',380,2),
	(30,'Görevli Kamu Personeline Direnme',350,2),
	(31,'Sivil Kaçırma',620,2),
	(32,'Ruhsatsız Silah Bulundurma',610,2),
	(33,'Suça Yardım ve Yataklık ',570,2),
	(34,'Market Soygunu',1200,3),
	(35,'Banka Soygunu',3000,3),
	(36,'Kuyumcu Soygunu',2000,3),
	(37,'Vatandaş Yaralama',920,3),
	(38,'Cinayet',1100,3),
	(39,'Çetecilik Faaliyetleri',670,3),
	(40,'Çalıntı Araç Parçalama',800,3),
	(41,'Yasadışı Ticaret',860,3);
