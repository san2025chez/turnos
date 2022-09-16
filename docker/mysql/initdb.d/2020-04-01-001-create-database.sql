CREATE DATABASE development;
CREATE USER 'dbuser'@'%' IDENTIFIED WITH mysql_native_password BY 'dbpass';
GRANT ALL PRIVILEGES ON development.* TO 'dbuser'@'%';
FLUSH PRIVILEGES;
USE development;

-- Table structure for table `categoriaDeProducto`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `id` char(36) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `latitude` varchar(100) NOT NULL,
  `longitude` varchar(100) NOT NULL,
  `proyects` varchar(100) NOT NULL,
  `meta` varchar(100) NOT NULL
  PRIMARY KEY (`id`)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoriaDeProducto`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `categoriaDeProducto` DISABLE KEYS */;
/*!40000 ALTER TABLE `categoriaDeProducto` ENABLE KEYS */;
UNLOCK TABLES;