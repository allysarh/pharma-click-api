-- MySQL dump 10.13  Distrib 8.0.26, for Linux (x86_64)
--
-- Host: localhost    Database: db_pharmaclick
-- ------------------------------------------------------
-- Server version	8.0.26-0ubuntu0.20.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tag` varchar(45) NOT NULL,
  `recipient` varchar(45) NOT NULL,
  `iduser` int NOT NULL,
  `id_city_origin` int NOT NULL,
  `address` varchar(500) NOT NULL,
  `postal_code` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `set_default` int DEFAULT '2',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (6,'Upin House','Upin ',4,42,'Komplek perumahan blok 19 no 51',40511,'2021-07-22 00:56:10','2021-07-27 12:18:43',2),(20,'Raze House','Raze Mulo',20,151,'Komplek perumahan satchel blok 19 no 5',40521,'2021-07-22 06:58:56','2021-07-27 12:18:43',2),(25,'Rumah','Allysa',22,107,'Komplek Nusa Cisangkan Permai',40526,'2021-07-25 09:38:59','2021-07-27 12:18:43',2),(31,'Rumah Ucup','Ucup sanusi',24,151,'Komplek pegangsaan timur no 118',40413,'2021-08-02 12:30:12','2021-08-08 12:34:04',1),(48,'Rakha House','Rakha',16,22,'Komplek Ujung berung indah blok 16 no 2',40611,'2021-08-04 10:08:22','2021-08-04 17:08:22',1),(51,'Rumah','Allysa',21,107,'Komp ncp',40526,'2021-08-04 11:55:36','2021-08-04 19:04:50',2),(52,'Komplek Nusa Cisangkan Permai Blok H no 23','Kaka',21,107,'Komplek Nusa Cisangkan Permai Blok H no 23',40526,'2021-08-04 12:04:07','2021-08-04 19:04:50',1);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `iduser` int NOT NULL,
  `idproduct` int NOT NULL,
  `qty` int NOT NULL,
  `total_netto` float DEFAULT NULL,
  `price` decimal(12,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_cart_iduser_idx` (`iduser`),
  KEY `fk_cart_idproduct_idx` (`idproduct`),
  CONSTRAINT `fk_cart_idproduct` FOREIGN KEY (`idproduct`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cart_iduser` FOREIGN KEY (`iduser`) REFERENCES `user` (`iduser`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'covid'),(2,'mata'),(3,'flu dan batuk'),(4,'vitamin dan suplemen'),(5,'demam'),(6,'pencernaan'),(7,'hipertensi'),(8,'otot, tulang dan sendi'),(9,'kulit'),(10,'p3k');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (1,'Aceh Barat'),(2,'Aceh Barat Daya'),(3,'Aceh Besar'),(4,'Aceh Jaya'),(5,'Aceh Selatan'),(6,'Aceh Singkil'),(7,'Aceh Tamiang'),(8,'Aceh Tengah'),(9,'Aceh Tenggara'),(10,'Aceh Timur'),(11,'Aceh Utara'),(12,'Agam'),(13,'Alor'),(14,'Ambon'),(15,'Asahan'),(16,'Asmat'),(17,'Badung'),(18,'Balangan'),(19,'Balikpapan'),(20,'Banda Aceh'),(21,'Bandar Lampung'),(22,'Bandung'),(23,'Bandung'),(24,'Bandung Barat'),(25,'Banggai'),(26,'Banggai Kepulauan'),(27,'Bangka'),(28,'Bangka Barat'),(29,'Bangka Selatan'),(30,'Bangka Tengah'),(31,'Bangkalan'),(32,'Bangli'),(33,'Banjar'),(34,'Banjar'),(35,'Banjarbaru'),(36,'Banjarmasin'),(37,'Banjarnegara'),(38,'Bantaeng'),(39,'Bantul'),(40,'Banyuasin'),(41,'Banyumas'),(42,'Banyuwangi'),(43,'Barito Kuala'),(44,'Barito Selatan'),(45,'Barito Timur'),(46,'Barito Utara'),(47,'Barru'),(48,'Batam'),(49,'Batang'),(50,'Batang Hari'),(51,'Batu'),(52,'Batu Bara'),(53,'Bau-Bau'),(54,'Bekasi'),(55,'Bekasi'),(56,'Belitung'),(57,'Belitung Timur'),(58,'Belu'),(59,'Bener Meriah'),(60,'Bengkalis'),(61,'Bengkayang'),(62,'Bengkulu'),(63,'Bengkulu Selatan'),(64,'Bengkulu Tengah'),(65,'Bengkulu Utara'),(66,'Berau'),(67,'Biak Numfor'),(68,'Bima'),(69,'Bima'),(70,'Binjai'),(71,'Bintan'),(72,'Bireuen'),(73,'Bitung'),(74,'Blitar'),(75,'Blitar'),(76,'Blora'),(77,'Boalemo'),(78,'Bogor'),(79,'Bogor'),(80,'Bojonegoro'),(81,'Bolaang Mongondow (Bolmong)'),(82,'Bolaang Mongondow Selatan'),(83,'Bolaang Mongondow Timur'),(84,'Bolaang Mongondow Utara'),(85,'Bombana'),(86,'Bondowoso'),(87,'Bone'),(88,'Bone Bolango'),(89,'Bontang'),(90,'Boven Digoel'),(91,'Boyolali'),(92,'Brebes'),(93,'Bukittinggi'),(94,'Buleleng'),(95,'Bulukumba'),(96,'Bulungan (Bulongan)'),(97,'Bungo'),(98,'Buol'),(99,'Buru'),(100,'Buru Selatan'),(101,'Buton'),(102,'Buton Utara'),(103,'Ciamis'),(104,'Cianjur'),(105,'Cilacap'),(106,'Cilegon'),(107,'Cimahi'),(108,'Cirebon'),(109,'Cirebon'),(110,'Dairi'),(111,'Deiyai (Deliyai)'),(112,'Deli Serdang'),(113,'Demak'),(114,'Denpasar'),(115,'Depok'),(116,'Dharmasraya'),(117,'Dogiyai'),(118,'Dompu'),(119,'Donggala'),(120,'Dumai'),(121,'Empat Lawang'),(122,'Ende'),(123,'Enrekang'),(124,'Fakfak'),(125,'Flores Timur'),(126,'Garut'),(127,'Gayo Lues'),(128,'Gianyar'),(129,'Gorontalo'),(130,'Gorontalo'),(131,'Gorontalo Utara'),(132,'Gowa'),(133,'Gresik'),(134,'Grobogan'),(135,'Gunung Kidul'),(136,'Gunung Mas'),(137,'Gunungsitoli'),(138,'Halmahera Barat'),(139,'Halmahera Selatan'),(140,'Halmahera Tengah'),(141,'Halmahera Timur'),(142,'Halmahera Utara'),(143,'Hulu Sungai Selatan'),(144,'Hulu Sungai Tengah'),(145,'Hulu Sungai Utara'),(146,'Humbang Hasundutan'),(147,'Indragiri Hilir'),(148,'Indragiri Hulu'),(149,'Indramayu'),(150,'Intan Jaya'),(151,'Jakarta Barat'),(152,'Jakarta Pusat'),(153,'Jakarta Selatan'),(154,'Jakarta Timur'),(155,'Jakarta Utara'),(156,'Jambi'),(157,'Jayapura'),(158,'Jayapura'),(159,'Jayawijaya'),(160,'Jember'),(161,'Jembrana'),(162,'Jeneponto'),(163,'Jepara'),(164,'Jombang'),(165,'Kaimana'),(166,'Kampar'),(167,'Kapuas'),(168,'Kapuas Hulu'),(169,'Karanganyar'),(170,'Karangasem'),(171,'Karawang'),(172,'Karimun'),(173,'Karo'),(174,'Katingan'),(175,'Kaur'),(176,'Kayong Utara'),(177,'Kebumen'),(178,'Kediri'),(179,'Kediri'),(180,'Keerom'),(181,'Kendal'),(182,'Kendari'),(183,'Kepahiang'),(184,'Kepulauan Anambas'),(185,'Kepulauan Aru'),(186,'Kepulauan Mentawai'),(187,'Kepulauan Meranti'),(188,'Kepulauan Sangihe'),(189,'Kepulauan Seribu'),(190,'Kepulauan Siau Tagulandang Biaro (Sitaro)'),(191,'Kepulauan Sula'),(192,'Kepulauan Talaud'),(193,'Kepulauan Yapen (Yapen Waropen)'),(194,'Kerinci'),(195,'Ketapang'),(196,'Klaten'),(197,'Klungkung'),(198,'Kolaka'),(199,'Kolaka Utara'),(200,'Konawe'),(201,'Konawe Selatan'),(202,'Konawe Utara'),(203,'Kotabaru'),(204,'Kotamobagu'),(205,'Kotawaringin Barat'),(206,'Kotawaringin Timur'),(207,'Kuantan Singingi'),(208,'Kubu Raya'),(209,'Kudus'),(210,'Kulon Progo'),(211,'Kuningan'),(212,'Kupang'),(213,'Kupang'),(214,'Kutai Barat'),(215,'Kutai Kartanegara'),(216,'Kutai Timur'),(217,'Labuhan Batu'),(218,'Labuhan Batu Selatan'),(219,'Labuhan Batu Utara'),(220,'Lahat'),(221,'Lamandau'),(222,'Lamongan'),(223,'Lampung Barat'),(224,'Lampung Selatan'),(225,'Lampung Tengah'),(226,'Lampung Timur'),(227,'Lampung Utara'),(228,'Landak'),(229,'Langkat'),(230,'Langsa'),(231,'Lanny Jaya'),(232,'Lebak'),(233,'Lebong'),(234,'Lembata'),(235,'Lhokseumawe'),(236,'Lima Puluh Koto/Kota'),(237,'Lingga'),(238,'Lombok Barat'),(239,'Lombok Tengah'),(240,'Lombok Timur'),(241,'Lombok Utara'),(242,'Lubuk Linggau'),(243,'Lumajang'),(244,'Luwu'),(245,'Luwu Timur'),(246,'Luwu Utara'),(247,'Madiun'),(248,'Madiun'),(249,'Magelang'),(250,'Magelang'),(251,'Magetan'),(252,'Majalengka'),(253,'Majene'),(254,'Makassar'),(255,'Malang'),(256,'Malang'),(257,'Malinau'),(258,'Maluku Barat Daya'),(259,'Maluku Tengah'),(260,'Maluku Tenggara'),(261,'Maluku Tenggara Barat'),(262,'Mamasa'),(263,'Mamberamo Raya'),(264,'Mamberamo Tengah'),(265,'Mamuju'),(266,'Mamuju Utara'),(267,'Manado'),(268,'Mandailing Natal'),(269,'Manggarai'),(270,'Manggarai Barat'),(271,'Manggarai Timur'),(272,'Manokwari'),(273,'Manokwari Selatan'),(274,'Mappi'),(275,'Maros'),(276,'Mataram'),(277,'Maybrat'),(278,'Medan'),(279,'Melawi'),(280,'Merangin'),(281,'Merauke'),(282,'Mesuji'),(283,'Metro'),(284,'Mimika'),(285,'Minahasa'),(286,'Minahasa Selatan'),(287,'Minahasa Tenggara'),(288,'Minahasa Utara'),(289,'Mojokerto'),(290,'Mojokerto'),(291,'Morowali'),(292,'Muara Enim'),(293,'Muaro Jambi'),(294,'Muko Muko'),(295,'Muna'),(296,'Murung Raya'),(297,'Musi Banyuasin'),(298,'Musi Rawas'),(299,'Nabire'),(300,'Nagan Raya'),(301,'Nagekeo'),(302,'Natuna'),(303,'Nduga'),(304,'Ngada'),(305,'Nganjuk'),(306,'Ngawi'),(307,'Nias'),(308,'Nias Barat'),(309,'Nias Selatan'),(310,'Nias Utara'),(311,'Nunukan'),(312,'Ogan Ilir'),(313,'Ogan Komering Ilir'),(314,'Ogan Komering Ulu'),(315,'Ogan Komering Ulu Selatan'),(316,'Ogan Komering Ulu Timur'),(317,'Pacitan'),(318,'Padang'),(319,'Padang Lawas'),(320,'Padang Lawas Utara'),(321,'Padang Panjang'),(322,'Padang Pariaman'),(323,'Padang Sidempuan'),(324,'Pagar Alam'),(325,'Pakpak Bharat'),(326,'Palangka Raya'),(327,'Palembang'),(328,'Palopo'),(329,'Palu'),(330,'Pamekasan'),(331,'Pandeglang'),(332,'Pangandaran'),(333,'Pangkajene Kepulauan'),(334,'Pangkal Pinang'),(335,'Paniai'),(336,'Parepare'),(337,'Pariaman'),(338,'Parigi Moutong'),(339,'Pasaman'),(340,'Pasaman Barat'),(341,'Paser'),(342,'Pasuruan'),(343,'Pasuruan'),(344,'Pati'),(345,'Payakumbuh'),(346,'Pegunungan Arfak'),(347,'Pegunungan Bintang'),(348,'Pekalongan'),(349,'Pekalongan'),(350,'Pekanbaru'),(351,'Pelalawan'),(352,'Pemalang'),(353,'Pematang Siantar'),(354,'Penajam Paser Utara'),(355,'Pesawaran'),(356,'Pesisir Barat'),(357,'Pesisir Selatan'),(358,'Pidie'),(359,'Pidie Jaya'),(360,'Pinrang'),(361,'Pohuwato'),(362,'Polewali Mandar'),(363,'Ponorogo'),(364,'Pontianak'),(365,'Pontianak'),(366,'Poso'),(367,'Prabumulih'),(368,'Pringsewu'),(369,'Probolinggo'),(370,'Probolinggo'),(371,'Pulang Pisau'),(372,'Pulau Morotai'),(373,'Puncak'),(374,'Puncak Jaya'),(375,'Purbalingga'),(376,'Purwakarta'),(377,'Purworejo'),(378,'Raja Ampat'),(379,'Rejang Lebong'),(380,'Rembang'),(381,'Rokan Hilir'),(382,'Rokan Hulu'),(383,'Rote Ndao'),(384,'Sabang'),(385,'Sabu Raijua'),(386,'Salatiga'),(387,'Samarinda'),(388,'Sambas'),(389,'Samosir'),(390,'Sampang'),(391,'Sanggau'),(392,'Sarmi'),(393,'Sarolangun'),(394,'Sawah Lunto'),(395,'Sekadau'),(396,'Selayar (Kepulauan Selayar)'),(397,'Seluma'),(398,'Semarang'),(399,'Semarang'),(400,'Seram Bagian Barat');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `confirmation_payment`
--

DROP TABLE IF EXISTS `confirmation_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `confirmation_payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idtransaction` int NOT NULL,
  `id_transaction_status` int NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `confirmation_payment`
--

LOCK TABLES `confirmation_payment` WRITE;
/*!40000 ALTER TABLE `confirmation_payment` DISABLE KEYS */;
INSERT INTO `confirmation_payment` VALUES (10,68,5,'public\\transactions\\IMG1628401109654.jpg','2021-08-08 05:38:29','2021-08-08 12:38:29'),(11,69,5,'public\\transactions\\IMG1628403119434.jpg','2021-08-08 06:11:59','2021-08-08 13:11:59');
/*!40000 ALTER TABLE `confirmation_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expedition_status`
--

DROP TABLE IF EXISTS `expedition_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expedition_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expedition_status`
--

LOCK TABLES `expedition_status` WRITE;
/*!40000 ALTER TABLE `expedition_status` DISABLE KEYS */;
INSERT INTO `expedition_status` VALUES (1,'REG'),(2,'YES');
/*!40000 ALTER TABLE `expedition_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(200) NOT NULL,
  `brand` varchar(100) NOT NULL,
  `idcategory` int NOT NULL,
  `description` longtext,
  `effect` longtext,
  `usage` longtext,
  `dosage` longtext,
  `indication` longtext,
  `netto` float DEFAULT NULL,
  `pack_price` decimal(12,2) DEFAULT NULL,
  `unit` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Paracetamol MEF Kaplet 500 mg','Generic Manufacturer',5,'Paracetamol kaplet merupakan obat generik yang berfungsi untuk meringankan sakit kepala, sakit gigi, serta menurunkan demam. Paracetamol merupakan zat analgetik - antipiretik yang telah lama dipercaya dan digunakan sebagai pilihan utama dalam mengatasi nyeri dan demam. Paracetamol juga dapat dikonsumsi oleh anak - anak maupun orang dewasa dengan frekuensi penggunaan yang sesuai dengan kemasan atau anjuran dari dokter, apoteker, atau tenaga kesehatan lainnya.','kerusakan fungsi hati.+reaksi hipersensitivitas.','Dikonsumsi setelah makan.','Dewasa: 1-2 kaplet sebanyak 3-4 kali/hari dan Anak-anak 6-12 tahun: ½ kaplet sebanyak 3-4 kali/hari. ','Meringankan rasa sakit pada keadaan sakit kepala, sakit gigi dan menurunkan demam.',100,30000.00,'mg','2021-07-22 16:19:58','2021-08-03 11:47:42'),(2,'Sanmol Pereda Nyeri 4 Tablet','Sanbe Farma',5,'Sanmol Tablet diformulasikan khusus dengan parasetamol dan berkhasiat untuk meredakan demam yang disertai dengan nyeri seperti sakit kepala, nyeri di pundak, nyeri ringan pada persendian, sekaligus meredakan sakit gigi.','Mual.+Muntah.+Feses berwarna gelap.+ruam.+Nyeri perut bagian atasa.+Tubuh merasa kelelahan.','Dikonsumsi sebelum makan atau bersama dengan makanan.','Anak-anak usia 6 hingga 12 tahun: ½-1 tablet sebanyak 3 kali/hari, Dewasa atau anak diatas 12 tahun: 1 tablet sebanyak 3 kali/hari. ','Meredakan demam pada anak dan dewasa.+Meringankan nyeri sendi dan nyeri otot pada tubuh.+Meredakan sakit gigi dan sakit kepala.+Mengobati nyeri dan demam akibat flu.',4,20000.00,'tablet','2021-07-22 16:19:58','2021-07-26 13:21:25'),(3,'Sumagesic Tablet  4 Tablet','Darya Varia Laboratoria',5,'Sumagesic tablet merupakan obat dengan kandungan paracetamol 600 mg. Obat ini dapat digunakan untuk meringankan rasa sakit kepala, sakit gigi dan menurunkan demam.','Kerusaakan fungsi hati.+ Reaksi hipersensitifitas atau alergi.','Dikonsumsi setelah makan.','Anak-anak ¼ hingga ½ tablet sebanyak 3 kali sehari dan Dewasa: 1 tablet sebanyak 3 kali sehari.  ','Meredakan demam pada anak dan orang dewasa.+Meringankan nyeri sendi dan nyeri otot ringan pada tubuh.+Meredakan sakit gigi dan sakit kepala.',4,15000.00,'tablet','2021-07-22 16:19:58','2021-07-23 01:54:56'),(4,'Panadol Kaplet 500 mg','Sterling',5,'Panadol merupakan obat dengan kandungan Paracetamol 500 mg. obat ini dapat digunakan untuk meredakan sakit kepala, sakit gigi, sakit pada otot, nyeri yang mengganggu dan menurunkan demam yang menyertai flu/influensa dan demam.','Kerusakan hati.+Reaksi hipersensitifitas atau alergi.+Gangguan pernafasan.+Bengkak pada bibir. ','Dikonsumsi sebelum atau sesudah makan.','Anak-anak 6 hingga 11 tahun: ½-1 kaplet sebanyak 3 kali/hari, Dewasa dan anak diatas 11 tahun: 1-2 kaplet sebanyak 3 kali/hari.','Meredakan demam pada anak dan dewasa.+Meringankan nyeri sendi dan nyeri otot ringan pada tubuh.+Meredakan sakit gigi dan sakit kepala.+Mengobati nyeri dan demam pasca imunisasi.',500,31000.00,'mg','2021-07-22 16:19:58','2021-07-23 00:34:08'),(5,'Praxion Sirup Anak 60 ml','Pharos',5,'Praxion sirup merupakan obat yang mengandung paracetamol yang befungsi sebagai analgesik dan antipiretik. Paracetamol bekerja sebagai antipiretik pada pusat pengaturan suhu di otak dan analgetika dengan meningkatkan ambang rasa sakit.','Kerusakan hati.+Reaksi hipersensitifitas atau alergi.','Dapat dikonsumsi sebelum atau sesudah makan.','0 hingga 1 tahun 2,5 mL sebanyak 3 kali/hari,1 hingga 2 tahun 5 mL sebanyak 3 kali/hari,2 hingga 6 tahun 5-10 mL sebanyak 3 kali/hari,6 hingga 9 tahun 10-15 mL sebanyak 3 kali/hari dan 9 hingga 12 tahun 10-20 mL sebanyak 3 kali/hari.','Menurunkan panas pada anak.+Meredakan sakit kepala dan sakit gigi.+Meredakan nyeri ringan hingga sedang di tubuh.',60,27000.00,'ml','2021-07-22 16:19:58','2021-07-23 13:24:51'),(6,'Ailin Tetes Mata 10 ml','Erela',2,'Ailin tetes mata merupakan obat tetes mata yang mengandung zat aktif Tetrahidzolin HCL. Obat ini digunakan untuk mengatasi mata merah karena iritasi ringan yang disebabkan oleh debu, asap, cuaca dingin, pemakaian lensa kontak, terlalu lama bekerja dengan komputer atau iritasi saat berenang.','Tidak ditemukan','Teteskan pada mata kanan dan kiri atau pada mata yang sakit.','Teteskan 1-2 tetes pada masing-masing mata. Obat diteteskan 3-4 kali sehari, kecuali bila ada petunjuk dokter.','Meredakan mata merah karena iritasi ringan.',10,34000.00,'ml','2021-07-22 16:19:58','2021-07-23 00:34:08'),(7,'Chloramphenicol 1% Salep Mata 3.5 g','Generic Manufacturer',2,'Chloramphenicol 1% Salep Mata mengandung zak aktif Chloramfenicol yang merupakan antibiotik dengan spektrum luas, memiliki aktivitas bakteriostatik yang efektif terhadap berbagai organisme gram positif dan gram negatif.','Perih+Iritasi.+Oftalmik.+Neuritis Optik.','Oleskan 3 kali sehari pada bagian dalam kantong mata.','Oleskan setiap 3 jam.','Mengatasi infeksi mata akibat bakteri yang rentan terhadap kloramfenikol.',3,15000.00,'g','2021-07-22 16:19:58','2021-07-23 00:34:08'),(8,'Polidemisin Salep Mata 3.5 g','Sanbe Farma',2,'Polidemisin salep mata digunakan untuk mengatasi peradangan mata yang responsif terhadap steroid dan infeksi bakteri pada mata. Salep ini merupakan obat keras yang harus menggunakan resep dokter. Polidemisin salep mata mengandung zat aktif polimiksin B sulfat, neomisin sulfat, dan deksametason.','Reaksi Alergi.+Peningkatan tekanan intraokular.+Penglihatan kabur+Gatal pada mata.','Ambil sedikit salep dan oleskan ke dalam sakus kelopak mata bagian dalam (konjungtiva).','Gunakan 3-4 kali/hari.','Peradangan pada mata yang responsif terhadap steroid seperti pada konjungtiva bulbar, palpebra, kornea dan segmen anterior bola mata.+Infeksi bakteri pada mata.',3,25000.00,'g','2021-07-22 16:19:58','2021-07-23 00:34:08'),(9,'Cendo Tobroson Salep Mata 3.5 g','Cendo Pharmceutical',2,'Cendo Tobrodon merupakan obat keras yang memerlukan resep dokter. Cendo Tobrodon mengandung tobramycin dan dexamethasone sodium phospate setara dexamethasone untuk mengobati infeksi luar pada mata sehingga terjadi peradangan yang disebabkan oleh bakteri.','Rasa pedih.+Rasa gatal dan merah-merah pada konjungtiva.','Oleskan pada bagian yang sakit.','Oleskan 2-3 kali/hari.','Mengobati infeksi luar pada mata sehingga terjadi peradangan yang disebabkan oleh bakteri.',3,28000.00,'g','2021-07-22 16:19:58','2021-07-23 00:34:08'),(10,'Cendo Pithalmic Gel Mata 5 g','Cendo Pharmceutical',2,'Cendo Pithalmic merupakan obat keras yang memerlukan resep dokter. Cendo Pithalmic mengandung vitamin A palmitat untuk mengatasi infeksi yang disebabkan terutama oleh bakteri gram positif, melembabkan kondisi mata kering akibat peradangan selaput konjungtiva (keratokonjungtivitis sicca) dan tidak stabilnya lapisan air mata serta kornea kurang lembab.','Iritasi.+mata merah.+mata berair.','Teteskan pada kantung konjungtiva.','1 tetes sebanyak 3-4 kali/hari.','Mengatasi infeksi yang disebabkan terutama oleh bakteri gram positif, melembabkan kondisi mata kering akibat peradangan selaput konjungtiva (keratokonjungtivitis sicca) dan tidak stabilnya lapisan air mata serta kornea kurang lembab.',5,47000.00,'g','2021-07-22 16:19:58','2021-07-23 00:34:08'),(11,'Bodrexin Flu dan Batuk Sirup Rasa Jeruk 56 mL','Pharmaton',3,'Bodrexin Flu Dan Batuk Sirup Rasa Jeruk 56 mL, merupakan obat dengan kandungan Phenyleprhine, Paracetamol, Guaifenesin, Bromhexine HCl dan CTM. Berkhasiat untuk membantu meringankan gejala flu seperti demam, sakit kepala, bersin dan hidung tersumbat yang disertai batuk berdahak. Dengan rasa jeruk yang disukai anak.','Mengantuk.+Gangguan saluran cerna+gelisah.+Tremor.+','Dikonsumsi setelah makan.','Anak usia 2-5 tahun : sesuai petunjuk dokter. Anak usia 6-12 tahun : 3 x sehari 2 sendok takar.','Membantu meringankan gejala flu seperti demam, sakit kepala, bersin dan hidung tersumbat yang disertai batuk berdahak.',56,23500.00,'ml','2021-07-22 16:19:58','2021-07-23 00:34:08'),(12,'Paramex Flu Dan Batuk 4 Tablet','Konimex',3,'Paramex Flu dan Batuk berkhasiat untuk meringankan gejala flu disertai batuk tidak berdahak. Paramex Flu dan Batuk memiliki kandungan aktif parasetamol dan propifenazon yang dikenal efektif sebagai penurun panas tubuh, pereda nyeri, serta membantu mencegah peradangan.','Mengantuk.+Jantung berdebar-debar, gangguan pada detak jantung, gelisah, halusinasi.+Gemetar di beberapa bagian tubuh.+Mulut kering.','Dikonsumsi setelah makan.','Anak-anak usia 6 hingga 12 tahun: ½ tablet sebanyak 3 kali/hari dan Dewasa atau anak diatas 12 tahun: 1 tablet sebanyak 3 kali/hari ','Meredakan gejala flu seperti demam, sakit kepala, pilek, dan hidung tersumbat.+Meredakan batuk tidak berdahak.+Meredakan rasa perih di tenggorokan.',4,28500.00,'tablet','2021-07-22 16:19:58','2021-07-23 00:34:08'),(13,'Transpulmin Balsam 20 g','Transfarma Medica Indah',3,'Transpulmin Balsam berkhasiat untuk meredakan gejala flu dan batuk pada orang dewasa. Transpulmin balsam mengandung bahan aktif minyak ekaliptus dan champora yang telah terbukti efektif untuk meredakan nyeri pada persendian atau otot.','Kulit kemerahan.','Oleskan 1 hingga 4 cm balsem ke bagian dada, punggung, dan leher beberapa kali/hari.','Oleskan 1 hingga 4 cm balsem ke bagian dada, punggung, dan leher beberapa kali/hari.','Meredakan pusing, sakit kepala, dan sakit gigi.+Meredakan flu dan batuk.+Meredakan peradangan pada saluran pernapasan.+Menghangatkan tubuh dan melegakkan pernapasan.',20,40000.00,'g','2021-07-22 16:19:58','2021-07-23 00:34:08'),(14,'Imudator Kaplet 6 Tablet','Pyridam',3,'Imudator Kaplet adalah suplemen makanan yang berfungsi untuk menstimulasi kekebalan tubuh agar lebih efektif menangkal berbagai virus penyakit.Suplemen ini juga dapat digunakan sebagai terapi penunjang pada pasien yang mengalami flu, sekaligus membantu proses pemulihan kondisi pasien setelah sakit.','Mual dan muntah.+Timbul kemerahan atau iritasi di kulit.+Nyeri di ulu hati.+Kram perut.','Diminum setelah makan.','1 kaplet sebanyak 3 kali/hari.','Meningkatkan daya tahan tubuh.+Mempercepat pemulihan kondisi setelah sakit.+Mencegah flu dan infeksi di saluran pernapasan atas.Membantu penyembuhan pilek dan batuk.',6,31000.00,'tablet','2021-07-22 16:19:58','2021-07-23 00:34:08'),(15,'Blackmores 60 Tablet','Kalbe Blackmores Nutrition',3,'Blackmors merupakan suplemen yang mengandung kombinasi kalsium, magnesium dan vitamin D3 membantu menjaga kesehatan tulang dan osteoporosis.','Tidak ditemukan','Dikonsumsi setelah makan atau sesuai petunjuk dokter.','Dewasa 1 tablet sebanyak 3 kali/hari dan Anak-anak 2-12 tahun: sesuai petunjuk dokter. ','Membantu mengurangi keparahan dan durasi gejala flu.+Membantu mengurangi gejala flu termasuk sakit tenggorokan dan batuk.Mengurangi gejala bronkitis dan infeksi saluran pernapasan atas (ISPA) termasuk flu dan batuk.Mengurangi gejala bronkitis dan infeksi saluran pernapasan atas (ISPA) termasuk flu dan batuk.Mengurangi gejala bronkitis dan infeksi saluran pernapasan atas (ISPA) termasuk flu dan batuk.Mengurangi gejala bronkitis dan infeksi saluran pernapasan atas (ISPA) termasuk flu dan batuk.',20,23000.00,'tablet','2021-07-22 16:19:58','2021-07-23 00:34:08'),(16,'Cardiomin 4  Kapsul','Medifarma',4,'Cardiomin Kapsul bermanfaat dalam memenuhi kebutuhan vitamin. Kandungan dalam Cardiomin Kapsul telah disertai dengan vitamin B6, vitamin B12, asam folat, vitamin E alamiah untuk mengatasi defisiensi atau kekurangan vitamin. Kekurangan vitamin B6 dapat menyebabkan anemia dan gangguan kulit serta rentan terhadap infeksi.','Tidak ditemukan','Dikonsumsi bersama makanan.','1 kapsul sebanyak 1 kali/hari','Suplemen untuk membantu memenuhi kebutuhan vitamin pada kondisi defisiensi vitamin B6, B12, asam folat dan vitamin E.',4,27500.00,'kapsul','2021-07-22 16:19:58','2021-07-23 00:34:08'),(17,'Ultravita Cap 4 Tablet','Caprifarmindo',4,'Ultravita kaplet merupakan suplemen vitamin dan mineral. Suplemen ini merupakan produk konsumen yang dapat dibeli secara bebas. Ultravita mengandung vitamin A, vitamin B, vitamin D, asam folat, lycophene, nicotinamide, asam pantothenic dan mineral.','Feses berwarna hitam.','Dapat dikonsumsi dengan atau tanpa makanan. Dapat dikonsumsi dengan makanan agar diabsorpsi lebih baik atau jika timbul rasa tidak nyaman pada saluran pencernaan.','Dosis umum 1 kaplet/hari dan Pasien dengan gangguan saluran pencernaan: ½ kaplet/hari.','Suplemen untuk membantu memenuhi kebutuhan vitamin dan mineral.',4,13000.00,'tablet','2021-07-22 16:19:58','2021-07-23 00:34:08'),(18,'Caltrax Tablet Effervescent 10 Tablet','Pyridam',4,'Caltrax Tablet Effervescent merupakan suplemen untuk memenuhi kebutuhan kalsium, Vitamin C, D dan B6, serta membantu memelihara kesehatan tulang.','Tidak ditemukan','Larutkan 1 tablet effervescent dalam segelas air dan dikonsumsi setelah makan.','1 tablet/hari.','Suplemen untuk memenuhi kebutuhan kalsium, Vitamin C, D dan B6.+Membantu memelihara kesehatan tulang.',10,18000.00,'tablet','2021-07-22 16:19:58','2021-07-23 00:34:08'),(19,'Nutrafor Gold 40 Kapsul','Novell Pharmaceutical Laboratories',4,'Nutrafor gold adalah obat suplemen lengkap yang membantu memenuhi kebutuhan vitamin dan mineral utuk memelihara stamina dan kesehatan. Nutrafor gold merupakan produk konsumen yang dijual secara bebas.','Tidak ditemukan','Dapat dikonsumsi setelah makan.','1 softgel sebanyak 2 kali/hari','Suplemen lengkap yang membantu memenuhi kebutuhan vitamin dan mineral utuk memelihara stamina dan kesehatan.',40,145000.00,'kapsul','2021-07-22 16:19:58','2021-07-23 00:34:08'),(20,'Emineton Tablet 10 Tablet','Dankos Farma',4,'Emineton Tablet merupakan suplemen yang berfungsi untuk mencegah anemia akibat kekurangan zat besi dan membantu proses pemulihan pasien anemia.Anemia merupakan kondisi kurangnya sel darah merah di dalam tubuh.','Feses berwarna agak gelap karena zat besi.+Mual dan muntah.+Nyeri di ulu hati.','Diminum bersama makanan atau setelah makan.','Dosis dewasa untuk pencegahan 1 tablet sebanyak 1 kali/hari,Dosis dewasa untuk terapi 1 tablet sebanyak 2-3 kali/hari dan Dosis anak-anak 1 tablet sebanyak 1 kali/hari','Sebagai suplemen untuk menambah darah.+Memenuhi kebutuhan vitamin dan mineral dalam tubuh.+Membantu penyembuhan pasien anemia kekurangan zat besi.+Membantu masa pertumbuhan.',10,20000.00,'tablet','2021-07-22 16:19:58','2021-07-23 00:34:08'),(29,'Interlac Drops 5 ml','Interbat',6,'Interlac drops merupakan suplemen makanan yang mengandung probiotik Lactibacillus reuteri. Suplemen ini digunakan untuk memelihara kesehatan fungsi pencernan pada bayi, anak serta dewasa','Muntah. +Mengurangi kadar lipoprotein plasma & absorpsi tenaga','Dapat diberikan bersama atau tanpa makanan.','5 tetes, diminum per hari','Memelihara kesehatan fungsi pencernaan pd neonatur, bayi prematur, anak, & dws; membantu mengurangi & mencegah diare, regurgitasi, kolik, konstipasi, efek samping yg berhubungan dg antibiotik; meningkatkan fungsi sistem imun.',5,250000.00,'ml','2021-07-22 16:19:58','2021-07-23 00:34:08'),(30,'Lansoprazole 30 mg 10 Kapsul','Generic Manufacturer',6,'PENGGUNAAN OBAT INI HARUS SESUAI DENGAN PETUNJUK DOKTER. Ulkus duodenum : 1 kali sehari 30 mg selama 4 minggu. Benigna ulkus gaster : 1 kali sehari 30 mg selama 8 minggu. Refluks esofagitis : 1 kali sehari 30 mg selama 4 minggu. Dispepsia : Dosis usia dewasa diberikan 15 sampai 30 mg satu kali selama 2 sampai 4 minggu dan usia anak 1 sampai 11 tahun berat badan kurang dari 30 kg diberikan 15 mg satu kali sehari selama 12 minggu jika berat badan lebih besar dari 30 kg diberikan 30 mg satu kali sehari.','Sakit kepala. +Diare. +Nyeri abdomen. +Dispepsi. +Mual. +Muntah. +Mulut kering. +Sembelit. +Kembung. +Pusing. +Lelah. +Ruam kulit. +Urtikaria. +Pruritus. +Peningkatan sementara nilai tes fungsi hati. +Artralgia. +Edema perifer. +Depresi.','Pagi hari sebelum makan','PENGGUNAAN OBAT INI HARUS SESUAI DENGAN PETUNJUK DOKTER. Ulkus duodenum : 1 kali sehari 30 mg selama 4 minggu. Benigna ulkus gaster : 1 kali sehari 30 mg selama 8 minggu. Refluks esofagitis : 1 kali sehari 30 mg selama 4 minggu. Dispepsia : Dosis usia dewasa diberikan 15 sampai 30 mg satu kali selama 2 sampai 4 minggu dan usia anak 1 sampai 11 tahun berat badan kurang dari 30 kg diberikan 15 mg satu kali sehari selama 12 minggu jika berat badan lebih besar dari 30 kg diberikan 30 mg satu kali sehari.','INFORMASI OBAT INI HANYA UNTUK KALANGAN MEDIS. Pengobatan ulkus duodenum, tukak lambung, dan refluks esofagitis, serta tukak yang berkaitan dengan penggunaan anti inflamasi non steroid (AINS)',300,30000.00,'mg','2021-07-22 16:19:58','2021-07-23 00:34:09'),(31,'Omeprazole 20 mg 10 Kapsul','Generic Manufacturer',6,'Omeprazole merupakan obat golongan proton pump inhibitor yang dgunakan untuk menurunkan produksi asam berlebih pada lambung. Obat ini sering digunakan untuk mengatasi tukak pada lambung dan usus, serta reflux esofagitis. Dalam penggunaan obat ini harus SESUAI DENGAN PETUNJUK DOKTER.','Gangguan gastritis. +Sakit kepala. +Ruam Kulit.','Dikonsumsi sebelum makan','PENGGUNAAN OBAT INI HARUS SESUAI DENGAN PETUNJUK DOKTER. Dewasa : 1 kali sehari 1 tablet (20 - 40 mg per hari selama 2-4 minggu).','INFORMASI OBAT INI HANYA UNTUK KALANGAN MEDIS. Pengobatan jangka pendek untuk tukak duodenal, tukak lambung, refluks esofagitis, sindrom Zollinger-Ellison',10,20000.00,'kapsul','2021-07-22 16:19:58','2021-07-23 00:34:09'),(32,'Zinc 20 mg 10 Tablet','Generic Manufacturer',6,'Zinc tablet merupakan salah satu mikromineral esensial yang berperan penting dalam fungsi imunitas, tumbuh kembang anak, anti-oksidan, fungsi reproduksi, dan fungsi sensori. Zinc dapat digunakan sebagai terapi tambahan pada kasus diare, sehingga membantu menurunkan episode diare, memperbaiki pervalensi dan resiko diare berkepanjangan serta menunjukkan penurunan insiden diare persisten.','Sakit perut. +Dispepsia. +Mual. +Muntah. +Diare. +Iritasi lambung. +Gastritis.','Sesudah makan','Pengobatan Diare Akut Dewasa: 10-20 mg, diminum satu kali per hari, lama pengobatan 10-14 hari meskipun diare sudah berhenti. Anak-anak usia 6 bulan-5 tahun: 20 mg, diminum satu kali per hari, lama pengobatan 10 hari meskipun diare sudah berhenti.','Obat ini digunakan untuk membantu memperkuat sistem kekebalan tubuh, dan mengatasi defisiensi zinc pada kasus diare.',100,18000.00,'mg','2021-07-22 16:19:58','2021-08-03 12:08:43'),(33,'Oralit 200 4g 1 Sachet','Generic Manufacturer',6,'Oralit sachet merupakan obat dengan kandungan Natrium klorida, Kalium klorida, Trisodium sitrat dihidrat, Glukosa anhidrat dalam bentuk serbuk. Obat ini digunakan untuk mencegah dan mengobati kurang cairan (dehidrasi) akibat diare dan muntah.','Perut kembung. +Nyeri perut. +Hipernatremia','Dilarutkan dengan air matang. Larutan ini tidak dapat digunakan apabila lebih dari 24 jam. Jika terjadi muntah hentikan sementara, 2 sampai 5 menit, berikan oralit dengan sendok sedikit demi sedikit.','Dibawah 1 tahun : 3 jam pertama 1.5 gelas, selanjutnya 1/2 gelas tiap kali mencret. Anak 1 - 5 tahun: 3 jam pertama 3 gelas, selanjutnya 1 gelas tiap kali mencret. Anak 5 - 12 tahun : 3 jam pertama 6 gelas, selanjutnya 1.5 gelas tiap kali mencret. Anak lebih dari 12 tahun : 3 jam pertama 12 gelas, selanjutnya 2 gelas tiap kali mencret.','Obat ini digunakan untuk mencegah dan mengobati dehidrasi akibat diare dan muntah.',4,4000.00,'g','2021-07-22 16:19:58','2021-07-23 00:34:09'),(34,'Inpepsa Sirup 100 ml','Fahrenheit',6,'Insepsa sirup merupakan obat dengan kandungan Sucralfate dalam bentuk sirup. Obat ini digunakan untuk pengobatan jangka pendek dan jangka panjang pada tukak lambung dan usus, gastritis kronik. Dalam penggunaan obat ini harus SESUAI DENGAN PETUNJUK DOKTER.','Mulut kering. +Konstipasi','Saat perut kosong : 1 jam sebelum makan atau 2 jam sesudah makan dan menjelang tidur malam','PENGGUNAAN OBAT INI HARUS SESUAI DENGAN PETUNJUK DOKTER. Dewasa : 4 x sehari 2 sendok takar (10 ml)','INFORMASI OBAT INI HANYA UNTUK KALANGAN MEDIS. Sakit maag, Tukak Usus halus, Tukak Lambung, Gastritis kronis',100,180000.00,'ml','2021-07-22 16:19:58','2021-07-23 00:34:09'),(35,'Lacidofil Sachet 1 Gram','Dexa Medica',6,'Lacidofil adalah suplemen makanan untuk membantu memelihara kesehatan fungsi pencernaan. Lacidofil mengandung zat aktif lactobacillus helveticus rosell-52, lactobacillus rhamnosus rosell-11.','Tidak ada efek samping','Sebaiknya diberikan bersama makanan, dan dapat dilarukan dengan 1 gelas air atau yogurt.','Dewasa: 1 kali sehari 1 sachet Konsutasikan dengan dokter sebelum memberikan Lacidofil pada anak-anak.','Untuk memelihara kesehatan fungsi pencernaan',1,8000.00,'g','2021-07-22 16:19:58','2021-07-23 00:34:09'),(36,'Spasimal 10 Tablet','Hexpharm Jaya',6,'Spasminal merupakan obat untuk mengobati nyeri yang timbul pada keadaan kolik. Spasminal mengandung Metampiron, Pavaperin dan Ekstrak Belladona. Metampiron bekerja sebagai obat analgetik yang berfungsi untuk menghilangkan nyeri, sedangkan Papaverin dan Ekstrak Belladona bekerja sebagai obat spasmolitik yang secara langsung merelaksasikan otot polos. Dalam penggunaan obat ini harus SESUAI DENGAN PETUNJUK DOKTER.','Reaksi kemarahan pada kulit. +Agranulositosis. +Gangguan saluran pencernaan','Sesudah/sebelum makan','PENGGUNAAN OBAT INI HARUS SESUAI DENGAN PETUNJUK DOKTER. 3 kali sehari satu tablet. Maksimal 4 tablet.','Kolik Abdomen (sakit kram perut yang kadang disebabkan bakteri, radang pada usus, radang pankreas, dan usus buntu)',10,16000.00,'tablet','2021-07-22 16:19:58','2021-07-23 00:34:09'),(37,'Lodia 2 mg 10 Tablet','Sanbe Farma',6,'Lodia 2 mg merupakan obat antidiare dengan kandungan Loperamid HCl 2 mg. Obat ini dapat digunakan untuk mengobati diare akut dan kronis. Dalam menggunakan obat ini HARUS SESUAI DENGAN PETUNJUK DOKTER.','Mulut kering. +Nyeri perut. +Lelah. +Ruam kulit. +Megakolon toksik. +Pusing.','Sebelum atau sesudah makan','Dewasa : awal 2 tablet kemudian 1 tablet setiap habis diare/mencret. Maksimal : 8 tablet/hari. Anak >8 tahun : Awal : 1 tablet kemudian sesuai kebutuhan. Maksimal : 4-6 tablet/hari.','Diare akut non spesifik & diare kronik',20,150000.00,'mg','2021-07-22 16:19:58','2021-07-23 00:34:09'),(38,'Polysilane Sirup 100 ml','Pharos',6,'Polysilane sirup merupakan obat maag dan anti kembung dengan kandungan Dimetilpolisiloksan, Aluminium hidroksida, dan Magnesium hidroksida dalam bentuk sirup. Obat ini digunakan untuk mengurangi gejala yang berhubungan dengan kelebihan asam lambung, gastritis, tukak lambung, tukak usus 12 jari, dengan gejala-gejala seperti mual, nyeri lambung, nyeri ulu hati, kembung dan perasaan penuh pada lambung. Kombinasi Aluminium hidroksida dan Magnesium hidroksida merupakan antasida yang bekerja menetralkan asam lambung dan menginaktifkan pepsin, sehingga nyeri ulu hati akibat iritasi oleh asam lambung dan pepsin berkurang. Disamping itu, efek laksatif dan Magnesium hidroksida akan mengurangi efek konstipasi dari Aluminium Hidroksida.','Sembelit. +Diare. +Mual.+ Muntah.','Dikonsumsi 1-2 jam setelah makan dan menjelang tidur.','Dewasa : 5 - 10 ml, diminum 3-4 kali per hari. Anak 6-12 tahun : 2.5 - 5 ml diminum 3-4 kali per hari.','Gangguan fungsi ginjal berat karena dapat menimbulkan hipermagnesia (kadar magnesium dalam darah meningkat).',100,42000.00,'ml','2021-07-22 16:19:58','2021-07-23 00:34:09'),(39,'Amlodipine 5 mg 10 Tablet','Generic Manufacturer',7,'Amlodipine merupakan obat antihipertensi golongan Calcium Channel Blockers (CCB). Obat ini bekerja dengan cara menghambat kalsium masuk ke dalam sel sehingga salah satu efeknya adalah menyebabkan vasodilatasi, memperlambat laju jantung, dan menurunkan kontraktilitas miokard sehingga menurunkan tekanan darah. Dalam penggunaan obat ini harus SESUAI DENGAN PETUNJUK DOKTER.','Pemakaian obat umumnya memiliki efek samping tertentu dan sesuai dengan masing-masing individu. Jika terjadi efek samping yang berlebih dan berbahaya, harap konsultasikan kepada tenaga medis. Efek samping yang mungkin terjadi dalam penggunaan obat adalah: Umum yang sering timbul: +Edema +Ssakit kepala.\r','Dikonsumsi sebelum atau sesudah makan.','Dosis awal 5 mg per hari. Maksimal 10 mg per hari. Titrasi dosis dilakukan tiap 7-14 hari.','Hipertensi, angina stabil kronik dan vasospastik.',50,20000.00,'mg','2021-07-22 16:19:58','2021-07-23 00:34:09'),(40,'Candesartan 8 mg 10 Tablet','Generic Manufacturer',7,'Canderstan tablet adalah obat antihipertensi golongan penghambat reseptor angiotensin / Angiotensin Reseptor Blocker (ARB) yang bermanfaat untuk menurunkan tekanan darah. Obat ini bekerja dengan cara menghambat pengikatan angiotensin II ke reseptor AT1 pada jaringan tubuh. Hal ini mengakibatkan pelebaran pembuluh darah sehingga aliran darah menjadi lancar dan tekanan darah akan menurun. Selain itu, obat ini juga berfungsi dalam pengobatan pada pasien dengan gagal jantung dan gangguan fungsi sistolik ventrikel kiri ketika obat penghambat ACE tidak ditoleransi. Dalam menggunakan obat ini HARUS SESUAI DENGAN PETUNJUK DOKTER.','Infeksi saluran pernafasan bagian atas. +Nyeri punggung. +Pusing.','Dikonsumsi sebelum atau sesudah makan.','Pasien hipertensi : Dosis awal 4 mg per hari dan dapat ditingkatkan hingga 16 mg, satu kali sehari.  Pasien gagal jantung : 4 mg per hari.','Hipertensi , pengobatan pada pasien dengan gagal jantung dan gangguan fungsi sistolik ventrikel kiri ketika obat penghambat ACE tidak ditoleransi.',80,180000.00,'mg','2021-07-22 16:19:58','2021-07-23 00:34:09'),(41,'Bisoprolol 5 mg 10 Tablet','Generic Manufacturer',7,'Bisoprolol 5 mg 10 Tablet adalah obat anti hipertensi golongan Beta-Blocker Kardioselektif. Bisoprolol merupakan golongan obat beta-blocker yang bekerja dengan cara menghambat kerja sistem saraf simpatis pada jantung dengan menghambat reseptor beta-adrenergik jantung. Obat penghambat beta-adrenergik seperti Bisoprolol menurunkan kecepatan denyut jantung dan bermanfaat dalam terapi irama jantung yang cepat secara tidak normal. Bisoprolol juga menurunkan kekuatan kontraksi dari jantung dan menurunkan tekanan darah. Dengan menurunkan kecepatan denyut jantung dan kekuatan kontraksi otot, obat penghambat beta-adrenergik akan menurunkan kebutuhan jantung terhadap oksigen. ','Kram abdomen. +Diare. +Pusing. Sakit kepala. +Mual. +Denyut jantung lambat. +Tekanan darah rendah. +Keadaan mati rasa. +Kesemutan. +Ekstremitas dingin. +Nyeri tenggorokan. +Sesak napas atau mengi +Kelelahan.','Sesudah makan.',' Hipertensi dan angina: 5 mg - 10 mg per hari.  Gagal jantung kronik stabil: 1.25 mg per hari pada minggu pertama. Dosis dapat ditingkatkan secara bertahap. - Pada penderita bronkospastik, gangguan hati (hepatitis atau sirosis) dan gangguan ginjal (bersihan kreatinin kurang dari 40 ml/menit): dosis awal 2.5 mg sekali sehari.','Hipertensi dan angina pektoris, gagal jantung kronik stabil sedang sampai berat dengan penurunan fungsi ventrikular sistolik sebagai tambahan terhadap ACE inhibitor, atau Diuretik, atau Glikosida jantung.',50,75000.00,'mg','2021-07-22 16:19:58','2021-07-23 00:34:09'),(42,'Norvask 5 mg 10 Tablet','Pfizer',7,'Norvask tablet merupakan obat antihipertensi Calcium Channel Blockers (CCB) atau antagonis kalsium golongan Dihdropyridine. Obat ini digunakan untuk mengatasi hipertensi atau tekanan darah tinggi dan membantu mencegah nyeri dada pada pasien angina pectoris. Amlodipine bekerja dengan menghalangi kalsium masuk ke dalam sel-sel otot halus pada dinding pembuluh darah jantung. Kalsium merupakan zat yang berperan dalam kontraksi otot. Dengan dihambatnya kalsium, maka jumlah kalsium yang masuk ke dalam sel-sel otot berkurang dan pembuluh darah menjadi lebih rileks dan melebar, sehingga meningkatkan pasokan darah dan oksigen ke jantung','Sakit kepala. +Edema. +Lelah. +Mual. +Flushing.  +Pusing-pusing.','Dapat dikonsumsi sebelum atau sesudah makan.','Dewasa: Baik untuk hipertensi maupun angina, dosis lazim adalah 5 mg, diberikan 1 kali sehari. Dosis dapat ditingkatkan sampai dosis maksimal 10 mg, tergantung pada respon pasien secara individual dan berat penyakit. Pasien yang lemah, atau usia lanjut dapat mulai dengan dosis 2.5 mg, diberikan 1 kali sehari dan dosis ini dapat digunakan ketika Amlodipine dikombinasikan dengan antihipertensi lain. Dosis yang dianjurkan untuk angina stabil yang kronik atau angina vasospastik adalah 5-10 mg, dan dosis yang lebih rendah untuk pasien usia lanjut dan pasien dengan insufisiensi hati. Anak-anak: Sampai saat ini, Penggunaan Amlodipine untuk anak-anak tidak pernah dilaporkan.','Amlodipine diindikasikan untuk terapi hipertensi dan dapat digunakan sebagai obat pengontrol tekanan darah, serta first-line terapi iskemia miokard, baik karena obstruksi tetap (angina stabil) dan/atau angina prinzmetal.',50,120000.00,'mg','2021-07-22 16:19:58','2021-07-23 00:34:09'),(43,'Captopril 25 mg 10 Tablet','Generic Manufacturer',7,'Captopril 25 mg 10 Tablet adalah obat antihipertensi yang termasuk golongan ACE inhibitor. Obat ini bekerja dengan menghambat perubahan angiotensin 1 menjadi angiotensin 2 sehingga terjadi vasodilatasi dan penurunan sekresi aldosteron. Vasodilatasi secara langsung akan menurunkan tekanan darah sedangkan berkurangnya aldosteron akan emnyebabkan ekskresi air dan natrium dan retensi kalium. Dalam menggunakan obat ini HARUS SESUAI DENGAN PETUNJUK DOKTER.','Pruritus. +Gangguan indera pengcapan. +Gangguan proteinuria. +Meningkatnya nilai nitrogen urea darah dan kreatinin. +Neutropenia.','Diminum saat perut kosong, 1 jam sebelum makan atau 2 jam setelah makan.',' Awal : 3 kali sehari 12.5 mg. Ditingkatkan menjadi 25-50 mg 2-3 hari. Hipertensi berat: s/d 450 mg/hari. kategori kehamilan: D','Hipertensi, Gagal jantung pasien dengan tekanan darah normal',25,7000.00,'mg','2021-07-22 16:19:58','2021-07-23 00:34:09'),(44,'Prove D3-1000 IU 10 Tablet','Kalbe Farma',8,'Prove D3-1000 IU 10 Tablet merupakan obat yang mengandung vitamin d berguna untuk menstimulasi absorpsi kalsium melalui usus, penggabungan kalsium ke dalam osteoid, dan pelepasan kalsium dari jaringan tulang.','Hiperkalsemia. +Hiperkalsiuria. +Pruritus. +Ruam. +Urtikaria. +Reaksi hipersensitivitas. +Mual. +Muntah','Setelah makan','Dewasa dan anak >12 tahun: 1 tablet, 1 kali sehari','Untuk meningkatkan kadar 25(OH)D dalam darah pada pasien dengan kekurangan vitamin D (kadar 25(OH)D serum <30 ng/mL).',10,50000.00,'tablet','2021-07-22 16:19:58','2021-07-23 00:34:09'),(45,'Eperisone 50 mg 10 Tablet','Generic Manufacturer',8,'Eperisone 50 mg 10 Tablet merupakan obat yang mengandung Eperisone HCl. Eperisone HCl bekerja sebagai relaksan otot atau melemaskan otot rangka dan otot polos vaskular, yang menghasilkan pengurangan myotonia, peningkatan sirkulasi, dan penekanan refleks rasa sakit. EPERISONE digunakan untuk pengobatan simtomatik terhadap kondisi yang terkait dengan spasme muskuloskeletal atau kejang otot. Penggunaan obat ini HARUS SESUAI DENGAN PETUNJUK DOKTER.','Lemah. +Pusing. +Insomnia. +Mengantuk. +Rasa kebas atau gemetar pada ekstremitas. +Gangguan fungsi hati dan ginjal. +Kelainan hematologi. +Ruam kulit. +Gangguan Gl +Gangguan pada saluran kemih','Sesudah makan','1 tablet, diminum 3 kali per hari','Untuk pengobatan simtomatik pada kondisi yang berhubungan dengan spasme muskuloskeletal',500,50000.00,'mg','2021-07-22 16:19:58','2021-07-23 00:34:09'),(46,'CDR Effervescent 15 Tablet','Bayer Indonesia',8,'CDR Effervescent 15 Tablet merupakan suplemen vitamin (meliputi: Vitamin C, D, dan B6) dan mineral agar tulang sehat pada orang dewasa serta membantu memenuhi kebutuhan kalsium pada ibu hamil dan menyusui. Juga diperlukan untuk masa pertumbuhan, masa penyembuhan, keadaan gizi yang buruk, serta gangguan penyerapan makanan. Selain itu, suplemen ini digunakan juga untuk membantu mengembalikan kondisi kesehatan setelah sakit, memenuhi kebutuhan vitamin dan mineral dalam masa pertumbuhan, pemulihan, serta membantu perkembangan tulang dan gigi.',NULL,'Larutkan tablet effervescent ke dalam segelas air untuk memperoleh minuman effervescent dengan rasa jeruk segar. Sebaiknya diminum segera setelah dilarutkan.','1 tablet effervescent per hari, atau sesuai dengan petunjuk dokter.','Suplementasi Kalsium, Vitamin C, D, B6 agar tulang sehat pada orang dewasa, serta membantu memenuhi kebutuhan kalsium pada ibu hamil dan menyusui. Juga diperlukan untuk masa pertumbuhan, masa penyembuhan, keadaan gizi yang buruk serta gangguan penyerapan makanan.',15,150000.00,'tablet','2021-07-22 16:19:58','2021-07-23 00:34:09'),(47,'Recolfar 0.5 mg 10 Tablet','Pratapa Nirmala',8,'Recolfar 0.5 mg 10 Tablet adalah obat yang mengandung Colchicine yang digunakan untuk mencegah dan mengatasi serangan gout (gejala asam urat). Terutama untuk gejala gout yang muncul mendadak dan menyebabkan rasa sakit yang intens yang biasanya hanya melibatkan satu atau beberapa sendi jari kaki, lutut atau pergelangan kaki. Cara kerja obat ini belum diketahui secara pasti, namun obat ini diangap dapat mengganggu siklus kristal monosodium urate pada jaringan sendi serta menghambat proses peradangan yang jadi penyebab serangan akut gout. Colchicine juga bekerja menghambat laju pembentukan sel darah putih disekitar area yang meradang sehingga memutus siklus radang serta menghambat deposisi kristal asam urat.','Neuritis perifer. +Kelelahan otot. +Mual. +Muntah. +Nyeri abdomen. +Diare. +Ertikaria. +Anemia aplastik. +Agranulositosis. +Dermatitis. +Purpura. +Alopesia','Sesudah makan','rtritis gout akut awal : 0.5 - 1.2 mg diikuti dengan 0.5 mg tiap 2 jam sampai nyeri mereda atau timbul mual, muntah atau diare. Dosis rata-rata : 4 - 8 mg. Profilaksis jangka pendek selama awal terapi dengan alopurinol dan obat urikosurik : 0.5 mg 1 kali seminggu atau samapai dengan 1 kali sehari','Arthritis Gout Akut, profilaksis jangka pendek selama terapi awal dengan Alopurinol dan obat2 Urikosurik',5,80000.00,'g','2021-07-22 16:19:58','2021-07-23 00:34:09'),(48,'Voltaren Emulgel 5 g','Novartis Indonesia',8,'Voltaren Emulgel 5 g merupakan sediaan topikal yang mengandung zat aktif Diclofenac dan digunakan untuk mengatasi peradangan akibat trauma tendon, ligamen, otot dan sendi. Obat ini juga digunakan untuk mengatasi reumatisme jaringan lunak dan penyakit reumatik.','Ruam atau hipersensitif','Oleskan ke tempat yang sakit','3-4 kali sehari','Terapi lokal inflamasi traumatik pada tendon, ligamen, otot & sendi. Reumatik jaringan lunak yang terlokalisir & penyakit reumatik.',5,50000.00,'g','2021-07-22 16:19:58','2021-07-23 00:34:09'),(49,'Gentasolon Cream 5 g','Ikapharmindo',9,'Gentasolon Cream 5 g adalah obat yang digunakan untuk mengobati penyakit kulit seperti manifestasi inflamasi yang disertai infeksi oleh bakteri tertentu. Gentasolon mengandung zat aktif gentamicin. Dalam penggunaan obat ini harus SESUAI DENGAN PETUNJUK DOKTER.','Kulit kering. +Pruritus. +Iritasi. +Rasa terbakar/perih. +Hiperkortisme (penggunaan jangka lama). +Gatal. +Folikulitis. +Hipertrikosis. +Hipopigmentasi. +Dermatitis perioral. +Erupsi seperti jerawat. +Dermatitis kontak dan alergi. +Kulit menjadi lunak dan tipis.','Krim dioleskan pada area kulit yang radang/sakit','Oleskan krim 2-3 x sehari','Terapi topikal Dermatosis yang responsif terhadap Kortikosteroid dimana terjadi/diduga terjadi infeksi bakteri sekunder',5,35000.00,'g','2021-07-22 16:19:58','2021-07-23 00:34:09'),(50,'Acyclovir 5% Cream 5 g','Generic Manufacturer',9,'Acyclovir 5% Cream 5 g merupakan obat generik yang mengandung zat aktif Acyclovir. Krim ini digunakan untuk mengatasi infeksi herpes simpleks pada kulit dan selaput lendir yang biasanya berupa luka melepuh yang terjadi disekitar bibir atau wajah. Selain itu, obat ini juga digunakan untuk mengobati herpes genital dan labial awal serta rekuren. Acyclovir 5% Cream 5 g bekerja dengan menurunkan kemampuan virus dalam menggandakan diri, yaitu melalui penghambatan DNA polymerase dan replikasi DNA virus, sehingga mencegah pembentukan DNA virus tanpa mempengaruhi sel normal (sel tubuh).','+Sensasi terbakar atau menyengat. +Ertitema atau kemerahan. +Kulit kering (ringan). +Peneglupasan kulit.','Dioleskan pada area infeksi/yang sakit setelah kulit dibersihkan dan dikeringkan.','Oleskan 5 kali per hari tiap 4 jam tanpa dosis malam. Lanjutkan pengobatan setidaknya selama 5 hari, dalam beberapa kasus pengobatan dilanjutkan hingga 10 hari.','Mengatasi infeksi herpes simpleks pada kulit dan selaput lendir, termasuk herpes genital dal labial awal serta rekuren.',5,15000.00,'g','2021-07-22 16:19:58','2021-07-23 00:34:09'),(51,'Benoson N Cream 5 g','Bernofarm',9,'Benoson N Cream 5 gadalah obat oles yang mengandung Betamethasone 0.1% dan Neomycin sulfate 0.5%. Obat ini digunakan untuk meredakan peradangan dan alergi kulit yang disertai dengan adanya infeksi. Obat ini digunakan dengan cara mengoleskan obat pada wilayah yang infeksi sebanyak 2-3 kali per hari. ','Penggunaan jangka panjang dapat menyebabkan perubahan atrofi lokal pada kulit. +Sensasi terbakar kulit lokal. +Pruritus. +Perubahan pigmentasi. +Dermatitis kontak alergi.','Oleskan pada bagian tubuh yang diinginkan','Oleskan tipis pada bagian yang sakit 2-3 kali sehari','nflamasi disertai infeksi sekunder yang disebabkan oleh organisme yang peka terhadap neomisin',5,40000.00,'g','2021-07-22 16:19:58','2021-07-23 00:34:09'),(52,'Mometasone Cream 10 g','Generic Manufacturer',9,'Mometasone Cream 10 g termasuk dalam kelompok obat yang di sebut kortikosteroid, mometasone memiliki kerja anti inflamasi, anti pruritus, dan vasokonstriksi.','+Rasa terbakar. +Rasa gatal. +Tersengat. +Tanda-tanda atropi kulit','Oleskan pada bagian yang sakit','Oleskan 1 x sehari','Meringakan manifestasi inflamasi dan pruritus dari dermatosis yang responsif terhadap kortikosteroid, psoriasis, dermatitisk atopik',5,45000.00,'g','2021-07-22 16:19:58','2021-07-23 00:34:09'),(53,'Gentamicin Salep Kulit 0.1% 5 g','Generic Manufacturer',9,'Gentamicin Salep Kulit 0.1% 5 g merupakan antibiotik berbentuk salep yang digunakan untuk mengobati infeksi pada kulit yang disebabkan oleh bakteri. Gentamisin merupakan antibiotik golongan aminoglikosida yang efektif menghambat pertumbuhan kuman-kuman penyebab infeksi kulit; baik infeksi primer maupun sekunder. Mekanisme kerja sebagai bakterisidal dengan cara menghambat sintesis protein pada bakteri yang rentan. Hal ini diperantarai oleh kemampuannya dalam mengikat subunit ribosom 30S dan 50S secara ireversibel.','Penggunaan topikal antibiotik gentamisin dapat menyebabkan iritasi yang bersifat sementara, biasanya ditandai dengan kulit kemerahan dan gatal. +Kemungkinan terjadinya fotosensitisasi pernah dilaporkan pada beberapa pasien. +Penggunaan antibiotik gentamisin topikal dalam jangka panjang dapat menyebabkan jamur atau bakteri yang kebal tumbuh berlebihan.','Dioleskan tipis tipis pada kulit yang bermasalah setelah kulit dibersihkan dan dikeringkan.','rim/Salep Gentamicin dioleskan tipis pada daerah yang sakit sebanyak 3-4 kali sehari sampai tercapai kesembuhan. Daerah yang sakit boleh ditutupi dengan perban (gauze dressing).','Untuk pengobatan topikal infeksi primer dan sekunder pada kulit yang disebabkan oleh bakteri yang peka terhadap gentamicin',5,15000.00,'g','2021-07-22 16:19:58','2021-07-23 00:34:10'),(54,'Kasa Steril Husada 16 X 16 cm 16 Lembar','Sari Husada Generasi Mahardika',10,'Kasa Steril Husada 16 X 16 cm 16 Lembar adalah kasa steril yang digunakan untuk operasi besar/kecil, khitan, penutup luka dan bebat pusar bayi. Produk ini aman digunakan karena disterilisasi dengan radiasi sinar gamma yang tidak meninggalkan residu bahan kimia pada produk.','Tidak terdapat informasi efek samping pada kemasan.','Gunakan untuk melindungi luka terbuka','Sesuai kebutuhan','Untuk menutup luka',16,30000.00,'lembar','2021-07-22 16:19:58','2021-07-23 00:34:10'),(55,'Betadine Solution 15 ml','Mundipharma Healthcare Indonesia',10,'Betadine Solution 15 m mengandung zat aktif Povidone Iodine 10%. Povidone iodine merupakan zat anti mikroba dengan spektrum paling luas yang mampu membunuh bakteri, virus, jamur, dan protozoa. Zat ini juga tidak menimbulkan resistensi kuman. Obat ini digunakan untuk mengobati panu, kurap, kutu air dan gatal karena jamur, untuk pertolongan pertama dan mencegah timbulnya infeksi pada luka-luka seoerti lecet, terkelupas, tergores, terpotong, terkoyak atau luka khitan, untuk perawatan tali pusar bayi, untuk melindungi luka-luka operasi terhadap timbulnya infeksi. Hanya untuk bagian luar badan.','Iritasi lokal','Teteskan pada kulit yang luka atau infeksi.','Dapat digunakan beberapa kali dalam sehari dengan konsentrasi penuh baik untuk mengoles maupun kompres.','Cairan antiseptik untuk membunuh kuman penyebab infeksi.',15,30000.00,'ml','2021-07-22 16:19:58','2021-07-23 00:34:10'),(56,'Nexcare Micropore Plester Roll 1 Inch','3M Indonesia Importama',10,'Nexcare Micropore Plester Roll 1 Inch merupakan plester rol yang ideal untuk kulit sensitif dan mudah dilepas. Hypoallergenic sehingga lembut di kulit dan tidak menyebabkan rasa sakit pada luka. Plester ini sangat ideal untuk menempel penutup luka.','Tidak terdapat informasi efek samping pada kemasan.','Rekatkan pada kulit yang luka dengan diaplikasi bersama kasa steril','Sesuai Kebutuhan','Plester luka',1,40000.00,'roll','2021-07-22 16:19:58','2021-07-23 00:34:10'),(57,'Rivanol Liquid 100 ml','Generic Manufacturer',10,'Rivanol Liquid 100 ml adalah cairan desinfektan yang di gunakan untuk membersihkan luka.','Reaksi alergi','Tuang rivanol pada kapas, kemudian usapkan pada luka. bisa untuk membasuh luka','Sesuai kebutuhan','Untuk membersihkan luka',100,35000.00,'ml','2021-07-22 16:19:58','2021-07-23 00:34:10'),(58,'Hansaplast Kain Elastis 10 Lembar','Beiersdorf Indonesia',10,'Hansaplast Kain Elastis 10 Lembar merupakan alat kesehatan yang mengandung silvercare, digunakan untuk menutup luka dan memberi bantalan bagi luka.','Tidak terdapat informasi efek samping pada kemasan.','Bersihkan dan keringkan kulit disekitar luka sebelum menempelkan plester. Tutup luka dengan plester tanpa direnggangkan. Gantilah plester secara teratur.','Sesuai kebutuhan','Melindungi luka dari kotoran dan bakteri.',10,10000.00,'lembar','2021-07-22 16:19:58','2021-07-23 00:34:10'),(59,'Biogesic Tablet 500 mg','Medifarma Laboratories',5,'Biogesic Tablet berkhasiat untuk meredakan demam dan nyeri ringan hingga sedang pada orang dewasa.Biogesic Tablet telah bersertifikat halal dan memiliki kandungan parasetamol yang merupakan obat golongan analgesik (meredakan nyeri) dan antipiretik (meredakan demam). Parasetamol telah lama dipercaya dan digunakan untuk menurunkan demam, sakit kepala, sakit gigi, hingga nyeri sendi.','Gangguan pada kulit seperti ruam atau kemerahan.+Penggunaan jangka panjang dengan dosis besar dapat menyebabkan kerusakan fungsi hati.','Dikonsumsi setelah makan.','1 hingga 2 tablet sebanyak 3 kali/hari.','Menurunkan demam pada orang dewasa.+Meredakan nyeri tubuh ringan hingga sedang.+Meringankan sakit gigi dan sakit kepala.+Mengatasi nyeri ketika menstruasi atau menjelang menstruasi (dismenore).',5,4000.00,'tablet','2021-07-22 16:19:58','2021-07-23 13:33:05'),(60,'Proris Forte Sirup 50 mL','Pharos',5,'Proris Forte sirup adalah obat yang digunakan untuk menurunkan demam (antipiretik) dan meredakan nyeri (analgesik) pada berbagai kondisi, misalnya kram menstruasi, nyeri otot, dan radang sendi atau arthritis.Obat Proris Forte mengandung zat aktif ibuprofen. Zat aktif ini juga dapat digunakan untuk mengatasi nyeri ringan akibat flu.','Sakit perut.+Diare.+Bersendawa.+Perut kembung.+Kulit gatal.','Harus dikonsumsi dengan makanan.','Anak usia 1-2 tahun 3-4 kali/hari sebanyak ¼ sendok takar (50 mg), Anak usia 3-7 tahun 3-4 kali/hari sebanyak ½ sendok takar (100 mg) dan Anak usia 8-12 tahun 3-4 kali/hari sebanyak 1 sendok takar (200 mg). ','Menurunkan demam pada anak-anak.+meringankan nyeri ringan sampai sedang, misalnya nyeri haid (dismenore primer), nyeri akibat penyakit gigi atau pencabutan gigi, dan sakit kepala.',50,29000.00,'ml','2021-07-22 16:19:58','2021-07-23 00:34:10'),(61,'Psidii Sirup 60 ml','Dexa Medica',5,'Psidii Sirup merupakan obat herbal yang berfungsi untuk meningkatkan jumlah keping darah (trombosit) pada tubuh. Keping darah berperan penting dalam proses pembekuan darah. Selain itu, keping darah juga menjadi pendeteksi dini apabila terjadi gangguan pada penggumpalan darah. Pada kasus demam berdarah (DBD), virus dengue masuk ke dalam pembuluh darah yang kemudian menyebabkan kematian sel trombosit. Hal tersebut menjadikan trombosit lebih cepat menggumpal dan lapisan pembuluh darah juga menjadi rusak.','Mual dan muntah.+Nyeri di ulu hati.+Sakit perut atau timbul rasa mulas.','Diminum setelah makan.','5 hingga 10 ml sebanyak 3 kali/hari.','Meningkatkan jumlah trombosit (keping darah).+Membantu pemulihan pasien demam berdarah.+Menghambat pertumbuhan virus demam demam berdarah.+Mencegah dehidrasi pada tubuh ketika DBD.',60,33000.00,'ml','2021-07-22 16:19:58','2021-07-23 00:34:10'),(62,'Nipe Sirup 100 ml','Menarini Indria Laboratories',5,'Nipe sirup adalah obat yang digunakan untuk meringankan gejala-gejala flu, seperti demam, sakit kepala, dan hidung tersumbat. Obat ini mengandung kombinasi zat aktif, yaitu acetaminophen, isothipendyl HCl, dan phenylephrine HCl.Paracetamol bekerja dengan cara mengurangi produksi zat penyebab peradangan. Isothipendyl HCl merupakan obat antihistamin generasi pertama yang digunakan untuk mengatasi alergi.','Sakit kepala.+Mual.+Gugup.+Sulit tidur (insomnia).+Iritasi lambung.+Kerusakan hati (jika digunakan dalam dosis tinggi).','Dikonsumsi sesudah makan.','Anak-anak berusia lebih dari 6 tahun 3-4 kali/hari sebanyak 2 sendok takar','Meredakan demam.+Meredakan sakit kepala.+Meredakan pilek.+Meredakan nyeri otot.+Meredakan hidung tersumbat.',100,41000.00,'ml','2021-07-22 16:19:58','2021-07-23 00:34:10'),(63,'Dapyrin Sirup 60 ml','Hexpharm Jaya',5,'Dapyrin sirup digunakan untuk meringankan rasa sakit seperti sakit kepala, sakit gigi dan menurunkan demam. Obat ini merupakan obat bebas yang tidak memerlukan resep dokter. Dapyrin sirup mengandung zat aktif paracetamol.','Pada pemakaian jangka panjang dan dosis besar dapat menyebabkan kerusakan hati.+Reaksi alergi.','Dikonsumsi sesuai petunjuk penggunaan.','0-1 tahun ½ sendok takar 5 ml (2,5 ml) sebanyak 3-4 kali/hari,1-2 tahun 1 sendok takar 5 ml sebanyak 3-4 kali/hari.2-6 tahun: 1-2 sendok takar 5 ml (5-10 ml) sebanyak 3-4 kali/hari.','Meringankan rasa sakit seperti sakit kepala.+Meringankan sakit gigi.+Menurunkan demam.',60,80000.00,'L','2021-07-22 16:19:58','2021-08-03 18:40:01'),(64,'test','kalbe',3,'sfsdf','sdfs','sdfsd','sdfsd','sdfdf',2,10000.00,'g','2021-07-23 06:37:10','2021-07-23 13:37:10'),(65,'sa','as',1,'dfsadf','sdfasdf','sfasd','sdfass','fsdf',2,100000.00,'g','2021-07-23 07:54:43','2021-07-23 14:54:43'),(66,'fsadf','sfdsa',4,'wer','ewrewr','werfer','erwfwr','ewrfwe',2,90000.00,'g','2021-07-23 08:01:43','2021-07-23 15:01:43'),(67,'dasd','dfasdf',3,'sdaf','sdaf','fsad','sfdasdf','sdfsd',1,1000.00,'ml','2021-07-23 08:39:25','2021-07-23 15:39:25'),(68,'sdfsd','sadfs',3,'asdfasdf','dfsdf','sdfsdf','dsfsd','sdfsdfsdfdsf',2,1000.00,'g','2021-07-23 08:40:16','2021-07-23 15:40:16'),(69,'ads','saD',6,'ASD','sdASad','asdsdgf','asdsd','sdAS',2,1000.00,'L','2021-07-23 09:01:17','2021-07-23 16:01:17'),(70,'Hansaplast Sensitif','g tw',3,'weat','dfasfdsdf','asdfsdf','sdfasdfsd','drdgsdhgstfd',1,10000.00,'lembar','2021-07-23 09:07:13','2021-07-23 16:07:13'),(71,'aefsdf','sdfasdf',5,'asdfsdf','sdfasdf','sdfasdf','sdfasd','fdfasdf',1,1000.00,'g','2021-07-23 09:08:15','2021-07-23 16:08:15'),(72,'Hansaplast elsatos','asd',10,'sfasdf','fasdf','asdfsd','sadfsdf','sadfsdf',1,1000.00,'lembar','2021-07-23 09:10:15','2021-07-23 16:10:15'),(73,'Handsanitizeru','kimia farma',2,'a','a','a','a','abc',1,10000.00,'L','2021-07-23 09:19:59','2021-08-03 18:36:34'),(74,'Hansaplast1','Hansaplast',10,'Hansaplast','Hansaplast','Hansaplast','Hansaplast','Hansaplast',1,1000.00,'lembar','2021-07-26 12:37:59','2021-07-26 19:39:15'),(75,'a','a',10,'a','a','a','a','a',1,1000.00,'lembar','2021-07-26 15:26:34','2021-07-26 22:26:34'),(76,'a','a',5,'a','a','a','a','a',1,500.00,'lembar','2021-07-26 15:37:55','2021-07-26 22:37:55'),(77,'a','a',4,'a','a','a','a','a',1,50.00,'mg','2021-07-27 04:35:47','2021-07-27 11:35:47'),(78,'a','a',4,'a','a','a','a','a',1,50.00,'mg','2021-07-27 04:36:01','2021-07-27 11:36:01'),(79,'a','a',3,'a','a','a','a','a',1,1000.00,'ml','2021-07-27 04:38:01','2021-07-27 11:38:01'),(80,'a','a',4,'a','a','a','a','a',1,50.00,'g','2021-07-27 04:39:29','2021-07-27 11:39:29'),(81,'a','a',4,'a','a','a','a','a',1,50.00,'g','2021-07-27 04:40:20','2021-07-27 11:40:20'),(82,'e','a',4,'a','a','a','a','a',1,50.00,'g','2021-07-27 04:40:49','2021-07-27 11:56:57'),(85,'test','test',4,'test','test','test','test','test',1,1000.00,'g','2021-08-04 13:06:16','2021-08-04 20:06:16'),(86,'test','test',4,'test','test','test','test','test',1,1000.00,'g','2021-08-04 13:06:20','2021-08-04 20:06:20'),(87,'test','test',3,'test','test','test','test','test',1,1000.00,'L','2021-08-04 13:07:23','2021-08-04 20:12:03'),(88,'test','test',1,'test','test','test','test','test',1,1000.00,'ml','2021-08-05 03:13:34','2021-08-05 10:13:34');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_image`
--

DROP TABLE IF EXISTS `product_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_image` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idproduct` int NOT NULL,
  `image_url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_productimage_idproduct_idx` (`idproduct`),
  CONSTRAINT `fk_productimage_idproduct` FOREIGN KEY (`idproduct`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_image`
--

LOCK TABLES `product_image` WRITE;
/*!40000 ALTER TABLE `product_image` DISABLE KEYS */;
INSERT INTO `product_image` VALUES (1,1,'https://images.k24klik.com/product/large/apotek_online_k24klik_2020102202003123085_Edit-Produk-13.jpg'),(2,2,'https://images.k24klik.com/product/large/apotek_online_k24klik_20200810090629359225_SANMOL-4-TAB.jpg'),(3,3,'https://d2qjkwm11akmwu.cloudfront.net/products/789758_31-3-2019_15-23-57.jpg'),(4,4,'https://d2qjkwm11akmwu.cloudfront.net/products/827019_2-7-2021_20-11-32.jpeg'),(5,5,'https://d2qjkwm11akmwu.cloudfront.net/products/images/1867.jpg'),(6,6,'http://erela.co.id/wp-content/uploads/2014/03/Ailin.jpg'),(7,7,'https://d2qjkwm11akmwu.cloudfront.net/products/images/6504.jpg'),(8,8,'https://d2qjkwm11akmwu.cloudfront.net/products/images/3364.jpg'),(9,9,'https://d2qjkwm11akmwu.cloudfront.net/products/images/15680.jpg'),(10,10,'https://d2qjkwm11akmwu.cloudfront.net/products/123137_27-7-2020_0-15-38.jpeg'),(11,11,'https://cf.shopee.co.id/file/5027d9033f3d9fed1d73df67f45ab483'),(12,12,'https://d2qjkwm11akmwu.cloudfront.net/products/images/9963.jpg'),(13,13,'https://d2qjkwm11akmwu.cloudfront.net/products/666978_2-6-2021_18-16-23.jpeg'),(14,14,'https://images.k24klik.com/product/large/apotek_online_k24klik_20201204100810359225_IMUDATOR.jpg'),(15,15,'https://d2qjkwm11akmwu.cloudfront.net/products/8349_16-8-2019_10-40-40.jpg'),(16,16,'https://d2qjkwm11akmwu.cloudfront.net/products/images/8764.jpg'),(17,17,'https://d2qjkwm11akmwu.cloudfront.net/products/images/8999.jpg'),(18,18,'https://d2qjkwm11akmwu.cloudfront.net/products/images/1272.jpg'),(19,19,'https://d2qjkwm11akmwu.cloudfront.net/products/images/9911.jpg'),(20,20,'https://d2qjkwm11akmwu.cloudfront.net/products/images/8784.jpg'),(21,29,'https://d2qjkwm11akmwu.cloudfront.net/products/152860_22-4-2021_10-37-6.webp'),(22,30,'https://d2qjkwm11akmwu.cloudfront.net/products/8bbf944b-4987-4712-9268-99094031978a_product_image_url.webp'),(23,31,'https://d2qjkwm11akmwu.cloudfront.net/products/c66fac23-16e8-465e-bc86-fe984b3850dc_product_image_url.webp'),(24,32,'https://d2qjkwm11akmwu.cloudfront.net/products/11279b2d-4c7e-4287-b429-ac24dac60e2c_product_image_url.webp'),(25,33,'https://d2qjkwm11akmwu.cloudfront.net/products/b7865021-3b01-4dcc-9f2b-cc9e1202bc7d_product_image_url.webp'),(26,34,'https://d2qjkwm11akmwu.cloudfront.net/products/7119eb00-939f-4956-b6d9-e6bf228e609d_product_image_url.webp'),(27,35,'https://d2qjkwm11akmwu.cloudfront.net/products/66794127-b624-4a6b-83bf-2093d7d3bac7_product_image_url.webp'),(28,36,'https://d2qjkwm11akmwu.cloudfront.net/products/b91c8b50-835e-47a6-9c2e-dfa3f3df40d0_product_image_url.webp'),(29,37,'https://d2qjkwm11akmwu.cloudfront.net/products/a487eea0-4f99-4cdf-a9d0-a03eaa4b0464_product_image_url.webp'),(30,38,'https://d2qjkwm11akmwu.cloudfront.net/products/b9b8f712-95a3-43eb-b511-e6ee9159c18c_product_image_url.webp'),(31,39,'https://d2qjkwm11akmwu.cloudfront.net/products/0798a96f-9c88-4bc0-b1a3-08551ac737d2_product_image_url.webp'),(32,40,'https://d2qjkwm11akmwu.cloudfront.net/products/783f57ce-9b52-4935-aa65-d4dfa1c5bc59_product_image_url.webp'),(33,41,'https://d2qjkwm11akmwu.cloudfront.net/products/c25639a6-78c5-4f6a-b9da-b3ee35b4ea49_product_image_url.webp'),(34,42,'https://d2qjkwm11akmwu.cloudfront.net/products/8470e56f-bb81-4d98-b30f-134e47a292ac_product_image_url.webp'),(35,43,'https://d2qjkwm11akmwu.cloudfront.net/products/2e42f9a1-89c1-4122-b2fb-8405edb22e1b_product_image_url.webp'),(36,44,'https://d2qjkwm11akmwu.cloudfront.net/products/23244688-e029-4ab5-b625-ffa026047c29_product_image_url.webp'),(37,45,'https://d2qjkwm11akmwu.cloudfront.net/products/fd822bfe-bb32-4527-954c-d88952a3013c_product_image_url.webp'),(38,46,'https://d2qjkwm11akmwu.cloudfront.net/products/725237_7-7-2021_11-55-47.webp'),(39,47,'https://d2qjkwm11akmwu.cloudfront.net/products/5d767cad-1c1f-46b6-ada9-ccc5536c6434_product_image_url.webp'),(40,48,'https://d2qjkwm11akmwu.cloudfront.net/products/b6a38874-b5c4-47aa-ab5b-e988acc9588f_product_image_url.webp'),(41,49,'https://d2qjkwm11akmwu.cloudfront.net/products/7d55e82e-ccf7-4994-a380-de4b6108c661_product_image_url.webp'),(42,50,'https://d2qjkwm11akmwu.cloudfront.net/products/99b5c214-4dfb-40fb-ba9c-569a1bac27cc_product_image_url.webp'),(43,51,'https://d2qjkwm11akmwu.cloudfront.net/products/4f796246-b86b-49f1-b0cf-75921782c650_product_image_url.webp'),(44,52,'https://d2qjkwm11akmwu.cloudfront.net/products/8ccce1ea-9f38-4db9-8581-2db386f19239_product_image_url.webp'),(45,53,'https://d2qjkwm11akmwu.cloudfront.net/products/77307ee1-6d7b-4026-bc2f-40f3910790b0_product_image_url.webp'),(46,54,'https://d2qjkwm11akmwu.cloudfront.net/products/0b4361fb-db35-4204-89ad-b435405d39ac_product_image_url.webp'),(47,55,'https://d2qjkwm11akmwu.cloudfront.net/products/0369e873-8556-4eaf-ac88-2b78a007ed9d_product_image_url.webp'),(48,56,'https://d2qjkwm11akmwu.cloudfront.net/products/4549672b-21f1-4022-a4e6-291729de9629_product_image_url.webp'),(49,57,'https://hdmall.id/system/image_attachments/images/000/017/806/medium/rivanol-molex-100-ml-1.jpg'),(50,58,'products/IMG1626978917460.png'),(51,59,'https://d2qjkwm11akmwu.cloudfront.net/products/images/9246.jpg'),(52,60,'products/IMG1626977663226.jpg'),(53,61,'products/IMG1626977811009.jpg'),(54,62,'https://d2qjkwm11akmwu.cloudfront.net/products/images/1861.jpg'),(55,63,'products/IMG1626922326044.jpg'),(56,70,'products/IMG1626923271364.jpg'),(57,71,'products/IMG1626923287064.jpg'),(58,72,'products/IMG1626923361546.jpg'),(59,75,'products/IMG1626924211458.jpg'),(60,76,'products/IMG1626924867838.jpg'),(61,79,'products/IMG1626925028383.jpg'),(62,80,'products/IMG1626925062929.jpg'),(63,81,'products/IMG1626925134130.jpg'),(64,64,'products/IMG1627022229892.jpg'),(65,65,'products/IMG1627026883458.jpg'),(66,66,'products/IMG1627027303963.png'),(67,67,'products/IMG1627029566020.jpg'),(68,68,'products/IMG1627029616505.jpg'),(69,69,'products/IMG1627030877345.jpg'),(70,70,'products/IMG1627031234003.png'),(71,71,'products/IMG1627031295173.png'),(72,70,'products/IMG1627031415352.png'),(73,73,'products/IMG1627031999831.jpg'),(74,74,'products/IMG1627303079344.png'),(75,75,'products/IMG1627313194583.png'),(76,76,'products/IMG1627313875444.webp'),(77,82,'products/IMG1627360850263.jpg'),(80,87,'products/IMG1628082443483.jpg'),(81,88,'products/IMG1628133215288.jpg');
/*!40000 ALTER TABLE `product_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_status`
--

DROP TABLE IF EXISTS `product_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_status`
--

LOCK TABLES `product_status` WRITE;
/*!40000 ALTER TABLE `product_status` DISABLE KEYS */;
INSERT INTO `product_status` VALUES (1,'available'),(2,'low'),(3,'unavailable');
/*!40000 ALTER TABLE `product_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `iduser` int NOT NULL,
  `idproduct` int NOT NULL,
  `rating` varchar(45) NOT NULL,
  `review` varchar(10000) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,4,1,'5','Obat ini baik sekali, karena saya bisa sembuh dengan cepat setelah mengkonsumsi obat ini.','2021-07-22 01:00:18','2021-07-22 08:00:18'),(2,5,1,'4','Obatnya baik untuk saya dan anak, cocok sekali karena anak saya dan saya langsung sembuh dengan cepat.','2021-07-22 01:00:18','2021-07-22 08:00:18'),(3,6,3,'5','Keren obatnya manjur sekali pada saat saya gunakan, karena menurunkan panas dengan sangat cepat dibandingkan obat lain.','2021-07-22 01:00:18','2021-07-28 21:14:01'),(4,22,1,'4','bagus banget','2021-08-04 07:08:50','2021-08-04 14:10:25'),(5,22,2,'4','bagus aja sih','2021-08-04 07:08:50','2021-08-04 14:10:25'),(6,21,1,'4','Bagus product ini','2021-08-04 07:35:49','2021-08-04 14:35:49'),(7,21,2,'2','Kurang bagus untuk sakit kepala','2021-08-04 07:35:49','2021-08-04 14:35:49'),(8,21,1,'4','Bagus banget','2021-08-04 07:36:43','2021-08-04 14:36:43'),(9,21,2,'2','Kurang bagus','2021-08-04 07:36:43','2021-08-04 14:36:43'),(10,21,7,'3','Salep matanya kurang ampuh','2021-08-04 07:45:28','2021-08-04 14:45:28'),(11,21,5,'5','Anak saya langsung sembuh setelah minum ini','2021-08-04 07:48:01','2021-08-04 14:48:01'),(14,21,1,'3','bagus banget','2021-08-04 12:55:29','2021-08-04 19:55:29'),(15,21,2,'5','sangat bagussdssds','2021-08-04 12:55:29','2021-08-04 19:55:29');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `idrole` int NOT NULL AUTO_INCREMENT,
  `role` varchar(45) NOT NULL,
  PRIMARY KEY (`idrole`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'admin'),(2,'user');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `idstatus` int NOT NULL AUTO_INCREMENT,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`idstatus`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'verified'),(2,'unverified'),(3,'available'),(4,'low'),(5,'unvailable'),(6,'onprogress'),(7,'done'),(8,'reject'),(11,'request');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idproduct` int NOT NULL,
  `idtype` int NOT NULL,
  `qty` int NOT NULL,
  `total_netto` float NOT NULL,
  `unit_price` int DEFAULT NULL,
  `idstatus` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_stock_idproduct_idx` (`idproduct`),
  CONSTRAINT `fk_stock_idproduct` FOREIGN KEY (`idproduct`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES (1,1,1,44,4400,NULL,1),(2,2,1,30,120,NULL,1),(3,3,1,70,280,NULL,1),(4,4,1,6,5500,NULL,1),(5,5,1,22,1320,NULL,1),(6,6,1,13,130,NULL,1),(7,7,1,0,0,NULL,1),(8,8,1,18,54,NULL,1),(9,9,1,21,63,NULL,1),(10,10,1,4,20,NULL,1),(11,11,1,11,616,NULL,1),(12,12,1,7,28,NULL,1),(13,13,1,13,260,NULL,1),(14,14,1,7,42,NULL,1),(15,15,1,18,1120,NULL,1),(16,16,1,20,80,NULL,1),(17,17,1,5,20,NULL,1),(18,18,1,14,140,NULL,1),(19,19,1,17,680,NULL,1),(20,20,1,5,50,NULL,1),(68,29,1,10,50,NULL,1),(69,30,1,10,3000,NULL,1),(70,30,2,10,3000,100,3),(74,31,1,20,200,NULL,1),(75,31,1,30,300,2000,1),(76,32,1,12,1200,NULL,1),(77,32,2,36,3550,90,1),(79,33,1,50,200,NULL,1),(80,33,1,60,240,1000,1),(81,34,1,20,2000,NULL,1),(82,34,2,19,1900,1800,1),(83,35,1,20,20,NULL,1),(84,35,2,20,20,8000,1),(85,36,1,10,100,NULL,1),(86,36,2,10,100,1600,1),(87,37,1,20,400,NULL,1),(88,37,2,20,400,7500,1),(89,38,1,20,2000,NULL,1),(90,38,2,20,2000,420,1),(91,39,1,20,100,NULL,1),(92,39,2,20,100,400,1),(93,40,1,30,240,NULL,1),(94,40,2,30,240,2250,1),(95,41,1,10,500,NULL,1),(96,41,2,10,500,1500,1),(97,42,1,10,500,NULL,1),(98,42,2,10,500,2400,1),(99,43,1,20,500,NULL,1),(100,43,2,20,500,280,1),(101,44,1,20,200,NULL,1),(102,44,2,20,200,5000,1),(103,45,1,20,10000,NULL,1),(104,45,2,20,10000,1000,1),(106,46,1,30,450,NULL,1),(107,46,2,30,450,10000,1),(108,47,1,20,100,NULL,1),(109,47,2,20,100,16000,1),(110,48,1,10,50,NULL,1),(111,48,2,10,50,10000,1),(112,49,1,30,150,NULL,1),(113,49,2,30,150,7000,1),(114,50,1,20,100,NULL,1),(115,50,2,20,100,3000,1),(116,51,1,20,100,NULL,1),(117,51,2,20,100,8000,1),(118,52,1,10,50,NULL,1),(119,52,2,10,50,9000,1),(120,53,1,20,100,NULL,1),(121,53,2,20,100,3000,1),(122,54,1,50,800,NULL,1),(123,55,1,30,450,NULL,1),(124,56,1,50,50,NULL,1),(125,57,1,15,1500,NULL,1),(128,58,1,20,200,NULL,3),(129,59,1,10,50,NULL,1),(130,60,1,10,500,NULL,1),(131,61,1,9,540,NULL,1),(132,62,1,20,2000,NULL,1),(133,63,1,10,600,NULL,1),(134,64,1,10,150,NULL,3),(135,65,1,10,100,NULL,3),(136,68,1,1,1,NULL,3),(137,70,1,10,1000,NULL,3),(138,71,1,10,1000,NULL,3),(139,72,1,3,3,NULL,3),(140,75,1,1,10,NULL,3),(141,76,1,10,60,NULL,3),(142,79,1,10,20,NULL,3),(143,80,1,14,28,NULL,2),(144,81,1,10,100,NULL,2),(145,64,1,9,18,NULL,3),(146,65,1,2,4,NULL,3),(147,66,1,2,4,NULL,3),(148,67,1,1,1,NULL,3),(149,68,1,1,2,NULL,3),(150,69,1,1,2,NULL,3),(151,70,1,1,1,NULL,3),(152,71,1,1,1,NULL,3),(153,72,1,1,1,NULL,3),(154,73,1,1,1,NULL,3),(155,74,1,8,8,NULL,3),(156,75,1,4,4,NULL,3),(157,76,1,1,1,NULL,3),(158,82,1,1,1,NULL,3),(161,87,1,1,1,NULL,3),(162,88,2,1,1,NULL,3);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `iduser` int NOT NULL,
  `id_transaction_status` int DEFAULT '4',
  `invoice` varchar(45) NOT NULL,
  `id_city_origin` int NOT NULL,
  `id_city_destination` int NOT NULL,
  `address` varchar(255) NOT NULL,
  `recipient` varchar(45) NOT NULL,
  `postal_code` int NOT NULL,
  `expedition` varchar(45) DEFAULT NULL,
  `service` varchar(45) DEFAULT NULL,
  `shipping_cost` decimal(12,2) NOT NULL,
  `total_price` decimal(12,2) NOT NULL,
  `note` varchar(45) NOT NULL,
  `idtype` int NOT NULL,
  `img_order_url` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_at` datetime DEFAULT NULL,
  `review` varchar(45) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_p_iduser_idx` (`iduser`),
  CONSTRAINT `fk_transaction_iduser` FOREIGN KEY (`iduser`) REFERENCES `user` (`iduser`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (61,16,6,'PRM#CLICK1628303150254',22,22,'Komplek Ujung berung indah blok 16 no 2','Rakha',40611,'JNE','1',10000.00,213500.00,'Cek perscription',2,'perscription/IMG1628303150293.jpg','2021-08-07 09:25:50',NULL,'0'),(67,16,4,'PRM#CLICK1628314777772',22,22,'Komplek Ujung berung indah blok 16 no 2','Rakha',40611,NULL,NULL,8000.00,93000.00,'Jangan ditindih, barang mudah remuk !!',1,NULL,'2021-08-07 12:39:39',NULL,'0'),(70,16,4,'PRM#CLICK1628404056952',22,22,'Komplek Ujung berung indah blok 16 no 2','Rakha',40611,'JNE','0',0.00,0.00,'cek transaksi',2,'perscription/IMG1628404056976.jpg','2021-08-08 13:27:36',NULL,'0'),(71,16,4,'PRM#CLICK1628413210878',22,22,'Komplek Ujung berung indah blok 16 no 2','Rakha',40611,NULL,NULL,10000.00,60000.00,'Jangan ditindih ntar remuk, tolong mas !!',1,NULL,'2021-08-08 16:00:10',NULL,'0'),(72,24,4,'PRM#CLICK1628461658833',151,22,'Komplek pegangsaan timur no 118','Ucup sanusi',40413,'JNE','1',0.00,0.00,'',2,'perscription/IMG1628461658860.jpg','2021-08-09 05:27:39',NULL,'0');
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_detail`
--

DROP TABLE IF EXISTS `transaction_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_detail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idproduct` int NOT NULL,
  `idtransaction` int NOT NULL,
  `qty_buy` int NOT NULL,
  `netto` float NOT NULL,
  `total_netto` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_detail`
--

LOCK TABLES `transaction_detail` WRITE;
/*!40000 ALTER TABLE `transaction_detail` DISABLE KEYS */;
INSERT INTO `transaction_detail` VALUES (60,32,61,2,100,150,'2021-08-07 02:46:40','2021-08-07 09:46:40'),(61,34,61,1,100,100,'2021-08-07 02:46:40','2021-08-07 09:46:40'),(70,2,67,2,4,8,'2021-08-07 05:39:39','2021-08-07 12:39:39'),(71,3,67,3,4,12,'2021-08-07 05:39:39','2021-08-07 12:39:39'),(72,2,71,1,4,4,'2021-08-08 09:00:10','2021-08-08 16:00:10'),(73,3,71,2,4,8,'2021-08-08 09:00:10','2021-08-08 16:00:10');
/*!40000 ALTER TABLE `transaction_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_status`
--

DROP TABLE IF EXISTS `transaction_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_status`
--

LOCK TABLES `transaction_status` WRITE;
/*!40000 ALTER TABLE `transaction_status` DISABLE KEYS */;
INSERT INTO `transaction_status` VALUES (1,'onprogress'),(2,'done'),(3,'reject'),(4,'request'),(5,'waiting'),(6,'accept');
/*!40000 ALTER TABLE `transaction_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type`
--

DROP TABLE IF EXISTS `type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type`
--

LOCK TABLES `type` WRITE;
/*!40000 ALTER TABLE `type` DISABLE KEYS */;
INSERT INTO `type` VALUES (1,'pack'),(2,'custom');
/*!40000 ALTER TABLE `type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `iduser` int NOT NULL AUTO_INCREMENT,
  `fullname` varchar(45) NOT NULL,
  `gender` varchar(45) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `username` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `idrole` int NOT NULL,
  `idstatus` int NOT NULL,
  `profile_image` varchar(45) DEFAULT NULL,
  `password` varchar(300) NOT NULL,
  `otp` varchar(45) NOT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`iduser`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (2,'Allysa Rahmagustiani',NULL,NULL,'allysarh1','allysa.rahmagzstiani@gmail.com',2,2,NULL,'8a0cbb7f3b076c2200ed815b36bd15a4dd7042e08d60ca7b6d6c468130f0c690','atdwni',NULL,'2021-07-21 23:07:38','2021-07-22 06:07:38'),(3,'Allysa Rahmagustiani',NULL,NULL,'allysarh2','allysa.rahagjhkustiani@gmail.com',2,1,NULL,'8a0cbb7f3b076c2200ed815b36bd15a4dd7042e08d60ca7b6d6c468130f0c690','ebk1m8',NULL,'2021-07-21 23:07:38','2021-07-22 06:07:38'),(4,'Upin Upin','Male',22,'upin123','upin@mail.com',2,2,NULL,'789c187b31288bcbe21c354a4d3ad2bdcaffd7ebab90a454957df2568813d911','mi1dxs','082134521','2021-07-21 23:07:38','2021-07-22 09:28:51'),(5,'Upin Upin',NULL,NULL,'upin123','upin@mail.com',2,2,NULL,'789c187b31288bcbe21c354a4d3ad2bdcaffd7ebab90a454957df2568813d911','bejifc',NULL,'2021-07-21 23:07:38','2021-07-22 06:07:38'),(6,'Upin',NULL,NULL,'upinkeren','upin@mail.com',2,1,NULL,'8a0cbb7f3b076c2200ed815b36bd15a4dd7042e08d60ca7b6d6c468130f0c690','lh3hlc',NULL,'2021-07-21 23:07:38','2021-07-23 10:55:09'),(7,'Ipin ganteng',NULL,NULL,'ipin123','ipin@mail.com',2,2,NULL,'789c187b31288bcbe21c354a4d3ad2bdcaffd7ebab90a454957df2568813d911','rwprmv',NULL,'2021-07-21 23:07:38','2021-07-22 06:07:38'),(8,'Ipin ganteng 2',NULL,NULL,'ipin123','ipin@mail.com',2,2,NULL,'789c187b31288bcbe21c354a4d3ad2bdcaffd7ebab90a454957df2568813d911','94ax3r',NULL,'2021-07-21 23:07:38','2021-07-22 06:07:38'),(9,'Kak ros',NULL,NULL,'kakros_cantik','kakrod@mail.com',2,2,NULL,'789c187b31288bcbe21c354a4d3ad2bdcaffd7ebab90a454957df2568813d911','t76ghm',NULL,'2021-07-21 23:07:38','2021-07-22 06:07:38'),(10,'Taeyong lee',NULL,NULL,'tytrack','ty@mail.com',2,2,NULL,'789c187b31288bcbe21c354a4d3ad2bdcaffd7ebab90a454957df2568813d911','18ty1x',NULL,'2021-07-21 23:07:38','2021-07-22 06:07:38'),(11,'Ten lee',NULL,NULL,'tenlee','ten@mail.com',2,2,NULL,'789c187b31288bcbe21c354a4d3ad2bdcaffd7ebab90a454957df2568813d911','bacy8g',NULL,'2021-07-21 23:07:38','2021-07-22 06:07:38'),(12,'jeno lee',NULL,NULL,'jenolee','jeno@mail.com',2,2,NULL,'789c187b31288bcbe21c354a4d3ad2bdcaffd7ebab90a454957df2568813d911','g4hfgj',NULL,'2021-07-21 23:07:38','2021-07-22 06:07:38'),(13,'Mark lee',NULL,NULL,'onyoum','mark@mail.com',2,2,NULL,'789c187b31288bcbe21c354a4d3ad2bdcaffd7ebab90a454957df2568813d911','51wb7w',NULL,'2021-07-21 23:07:38','2021-07-22 06:07:38'),(14,'allysa',NULL,NULL,'allysarh','allysa.rahmaguastiani@gmail.com',2,2,NULL,'8a0cbb7f3b076c2200ed815b36bd15a4dd7042e08d60ca7b6d6c468130f0c690','lcfife',NULL,'2021-07-21 23:07:38','2021-07-27 13:41:51'),(16,'Rakha Luthfi','Male',22,'mrakhalf','mochamadrakha@gmail.com',2,1,'profiles/IMGUSR16.jpeg','2e4439d6d195013ec8e91872e0f47dccc3377e4faa61d828df9351dcf86d38fb','kyd22s','08112264420','2021-07-21 23:07:38','2021-08-08 09:20:36'),(17,'Allysa Rahmagustiani',NULL,NULL,'allysarh','allysa.rahwagustiani@gmail.com',1,1,NULL,'37c83ec241c8ce48080768dea49a731a238a1b237edb464c8a5b631f8bc1ac49','3isc9u',NULL,'2021-07-21 23:07:38','2021-07-25 16:19:36'),(18,'Maman Abdul','',NULL,'mandul','mandul@apeloe.com',2,1,'','2e4439d6d195013ec8e91872e0f47dccc3377e4faa61d828df9351dcf86d38fb','ahmjjr','','2021-07-21 23:07:38','2021-07-22 15:21:33'),(19,'reyna','',22,'reynamain','reynamain@apeloe.com',2,1,'','2e4439d6d195013ec8e91872e0f47dccc3377e4faa61d828df9351dcf86d38fb','cu4xm1','08112264420','2021-07-22 02:42:06','2021-07-26 18:53:54'),(20,'raze mulo','Male',17,'razemulo','razemulo@mail.com',1,1,'','2e4439d6d195013ec8e91872e0f47dccc3377e4faa61d828df9351dcf86d38fb','kaovl2',NULL,'2021-07-22 04:21:43','2021-07-26 09:35:15'),(21,'Renjun Huang','Male',22,'renjunie','renjun@mail.com',2,1,'profiles/IMGUSR21.jpeg','8a0cbb7f3b076c2200ed815b36bd15a4dd7042e08d60ca7b6d6c468130f0c690','x1g3bw','08123132324','2021-07-23 08:33:37','2021-08-04 19:13:32'),(22,'Allysa','Female',22,'allysarah','allysa.rahagustiani@gmail.com',1,1,'','8a0cbb7f3b076c2200ed815b36bd15a4dd7042e08d60ca7b6d6c468130f0c690','vjh1l0','082214708468','2021-07-25 09:20:06','2021-07-26 09:29:18'),(24,'rakha luthfi','Male',23,'mrakahalf','mrakhalf@apeloe.com',2,1,'profiles/IMGUSR24.jpeg','2e4439d6d195013ec8e91872e0f47dccc3377e4faa61d828df9351dcf86d38fb','szufkv','08112264420','2021-08-02 12:02:37','2021-08-02 20:51:49');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_status`
--

DROP TABLE IF EXISTS `user_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_status`
--

LOCK TABLES `user_status` WRITE;
/*!40000 ALTER TABLE `user_status` DISABLE KEYS */;
INSERT INTO `user_status` VALUES (1,'verified'),(2,'unverified');
/*!40000 ALTER TABLE `user_status` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-08-09  5:51:16
