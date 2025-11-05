-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server-Version:               9.4.0 - MySQL Community Server - GPL
-- Server-Betriebssystem:        Linux
-- HeidiSQL Version:             12.12.0.7122
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Exportiere Datenbank-Struktur für krautundrueben
CREATE DATABASE IF NOT EXISTS `krautundrueben` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `krautundrueben`;

-- Exportiere Struktur von Tabelle krautundrueben.ALLERGEN
CREATE TABLE IF NOT EXISTS `ALLERGEN` (
  `ALLERGEN_ID` int NOT NULL AUTO_INCREMENT,
  `NAME` varchar(50) NOT NULL,
  PRIMARY KEY (`ALLERGEN_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Exportiere Daten aus Tabelle krautundrueben.ALLERGEN: ~15 rows (ungefähr)
INSERT INTO `ALLERGEN` (`ALLERGEN_ID`, `NAME`) VALUES
	(0, 'Keine Allergene'),
	(1, 'Glutenhaltiges Getreide'),
	(2, 'Krebstiere'),
	(3, 'Eier'),
	(4, 'Fisch'),
	(5, 'Erdnüsse'),
	(6, 'Sojabohnen'),
	(7, 'Milch'),
	(8, 'Schalenfrüchte'),
	(9, 'Sellerie'),
	(10, 'Senf'),
	(11, 'Sesamsamen'),
	(12, 'Schwefeldioxid und Sulfite'),
	(13, 'Lupinen'),
	(14, 'Weichtiere');

-- Exportiere Struktur von Tabelle krautundrueben.BESTELLUNG
CREATE TABLE IF NOT EXISTS `BESTELLUNG` (
  `BESTELLNR` int NOT NULL AUTO_INCREMENT,
  `KUNDENNR` int DEFAULT NULL,
  `BESTELLDATUM` date DEFAULT NULL,
  `RECHNUNGSBETRAG` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`BESTELLNR`),
  KEY `KUNDENNR` (`KUNDENNR`),
  CONSTRAINT `BESTELLUNG_ibfk_1` FOREIGN KEY (`KUNDENNR`) REFERENCES `KUNDE` (`KUNDENNR`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Exportiere Daten aus Tabelle krautundrueben.BESTELLUNG: ~12 rows (ungefähr)
INSERT INTO `BESTELLUNG` (`BESTELLNR`, `KUNDENNR`, `BESTELLDATUM`, `RECHNUNGSBETRAG`) VALUES
	(1, 2001, '2020-07-01', 6.21),
	(2, 2002, '2020-07-08', 32.96),
	(3, 2003, '2020-08-01', 24.08),
	(4, 2004, '2020-08-02', 19.90),
	(5, 2005, '2020-08-02', 6.47),
	(6, 2006, '2020-08-10', 6.96),
	(7, 2007, '2020-08-10', 2.41),
	(8, 2008, '2020-08-10', 13.80),
	(9, 2009, '2020-08-10', 8.67),
	(10, 2007, '2020-08-15', 17.98),
	(11, 2005, '2020-08-12', 8.67),
	(12, 2003, '2020-08-13', 20.87);

-- Exportiere Struktur von Tabelle krautundrueben.BESTELLUNGZUTAT
CREATE TABLE IF NOT EXISTS `BESTELLUNGZUTAT` (
  `BESTELLNR` int NOT NULL,
  `ZUTATENNR` int NOT NULL,
  `MENGE` int DEFAULT NULL,
  PRIMARY KEY (`BESTELLNR`,`ZUTATENNR`),
  KEY `ZUTATENNR` (`ZUTATENNR`),
  CONSTRAINT `BESTELLUNGZUTAT_ibfk_1` FOREIGN KEY (`BESTELLNR`) REFERENCES `BESTELLUNG` (`BESTELLNR`),
  CONSTRAINT `BESTELLUNGZUTAT_ibfk_2` FOREIGN KEY (`ZUTATENNR`) REFERENCES `ZUTAT` (`ZUTATENNR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Exportiere Daten aus Tabelle krautundrueben.BESTELLUNGZUTAT: ~26 rows (ungefähr)
INSERT INTO `BESTELLUNGZUTAT` (`BESTELLNR`, `ZUTATENNR`, `MENGE`) VALUES
	(1, 1001, 5),
	(1, 1002, 3),
	(1, 1004, 3),
	(1, 1006, 2),
	(2, 1003, 4),
	(2, 1005, 5),
	(2, 6408, 5),
	(2, 9001, 10),
	(3, 3001, 5),
	(3, 6300, 15),
	(4, 3003, 2),
	(4, 5001, 7),
	(5, 1001, 5),
	(5, 1002, 4),
	(5, 1004, 5),
	(6, 1010, 5),
	(7, 1009, 9),
	(8, 1008, 7),
	(8, 1012, 5),
	(9, 1007, 4),
	(9, 1012, 5),
	(10, 1011, 7),
	(10, 4001, 7),
	(11, 1012, 5),
	(11, 5001, 2),
	(12, 1010, 15);

-- Exportiere Struktur von Tabelle krautundrueben.KUNDE
CREATE TABLE IF NOT EXISTS `KUNDE` (
  `KUNDENNR` int NOT NULL,
  `NACHNAME` varchar(50) DEFAULT NULL,
  `VORNAME` varchar(50) DEFAULT NULL,
  `GEBURTSDATUM` date DEFAULT NULL,
  `STRASSE` varchar(50) DEFAULT NULL,
  `HAUSNR` varchar(6) DEFAULT NULL,
  `PLZ` varchar(5) DEFAULT NULL,
  `ORT` varchar(50) DEFAULT NULL,
  `TELEFON` varchar(25) DEFAULT NULL,
  `EMAIL` varchar(50) DEFAULT NULL,
  `DATENSCHUTZ_ZUSTIMMUNG` tinyint(1) DEFAULT NULL,
  `LOESCH_DATUM` date DEFAULT NULL,
  PRIMARY KEY (`KUNDENNR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Exportiere Daten aus Tabelle krautundrueben.KUNDE: ~9 rows (ungefähr)
INSERT INTO `KUNDE` (`KUNDENNR`, `NACHNAME`, `VORNAME`, `GEBURTSDATUM`, `STRASSE`, `HAUSNR`, `PLZ`, `ORT`, `TELEFON`, `EMAIL`, `DATENSCHUTZ_ZUSTIMMUNG`, `LOESCH_DATUM`) VALUES
	(2001, 'Wellensteyn', 'Kira', '1990-05-05', 'Eppendorfer Landstrasse', '104', '20249', 'Hamburg', '040/443322', 'k.wellensteyn@yahoo.de', NULL, NULL),
	(2002, 'Foede', 'Dorothea', '2000-03-24', 'Ohmstraße', '23', '22765', 'Hamburg', '040/543822', 'd.foede@web.de', NULL, NULL),
	(2003, 'Leberer', 'Sigrid', '1989-09-21', 'Bilser Berg', '6', '20459', 'Hamburg', '0175/1234588', 'sigrid@leberer.de', NULL, NULL),
	(2004, 'Soerensen', 'Hanna', '1974-04-03', 'Alter Teichweg', '95', '22049', 'Hamburg', '040/634578', 'h.soerensen@yahoo.de', NULL, NULL),
	(2005, 'Schnitter', 'Marten', '1964-04-17', 'Stübels', '10', '22835', 'Barsbüttel', '0176/447587', 'schni_mart@gmail.com', NULL, NULL),
	(2006, 'Maurer', 'Belinda', '1978-09-09', 'Grotelertwiete', '4a', '21075', 'Hamburg', '040/332189', 'belinda1978@yahoo.de', NULL, NULL),
	(2007, 'Gessert', 'Armin', '1978-01-29', 'Küstersweg', '3', '21079', 'Hamburg', '040/67890', 'armin@gessert.de', NULL, NULL),
	(2008, 'Haessig', 'Jean-Marc', '1982-08-30', 'Neugrabener Bahnhofstraße', '30', '21149', 'Hamburg', '0178-67013390', 'jm@haessig.de', NULL, NULL),
	(2009, 'Urocki', 'Eric', '1999-12-04', 'Elbchaussee', '228', '22605', 'Hamburg', '0152-96701390', 'urocki@outlook.de', NULL, NULL);

-- Exportiere Struktur von Tabelle krautundrueben.LIEFERANT
CREATE TABLE IF NOT EXISTS `LIEFERANT` (
  `LIEFERANTENNR` int NOT NULL,
  `LIEFERANTENNAME` varchar(50) DEFAULT NULL,
  `STRASSE` varchar(50) DEFAULT NULL,
  `HAUSNR` varchar(6) DEFAULT NULL,
  `PLZ` varchar(5) DEFAULT NULL,
  `ORT` varchar(50) DEFAULT NULL,
  `TELEFON` varchar(25) DEFAULT NULL,
  `EMAIL` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`LIEFERANTENNR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Exportiere Daten aus Tabelle krautundrueben.LIEFERANT: ~3 rows (ungefähr)
INSERT INTO `LIEFERANT` (`LIEFERANTENNR`, `LIEFERANTENNAME`, `STRASSE`, `HAUSNR`, `PLZ`, `ORT`, `TELEFON`, `EMAIL`) VALUES
	(101, 'Bio-Hof Müller', 'Dorfstraße', '74', '24354', 'Weseby', '04354-9080', 'mueller@biohof.de'),
	(102, 'Obst-Hof Altes Land', 'Westerjork 74', '76', '21635', 'Jork', '04162-4523', 'info@biohof-altesland.de'),
	(103, 'Molkerei Henning', 'Molkereiwegkundekunde', '13', '19217', 'Dechow', '038873-8976', 'info@molkerei-henning.de');

-- Exportiere Struktur von Tabelle krautundrueben.NAEHRWERTE
CREATE TABLE IF NOT EXISTS `NAEHRWERTE` (
  `ZUTATENNR` int NOT NULL,
  `KALORIEN_KJ` int DEFAULT NULL,
  `KALORIEN_KCAL` int DEFAULT NULL,
  `PROTEIN` decimal(10,2) DEFAULT NULL,
  `KOHLENHYDRATE` decimal(10,2) DEFAULT NULL,
  `ZUCKER` decimal(10,2) DEFAULT NULL,
  `FETT` decimal(10,2) DEFAULT NULL,
  `GES_FETT` decimal(10,2) DEFAULT NULL,
  `BALLASTSTOFFE` decimal(10,2) DEFAULT NULL,
  `NATRIUM` decimal(10,2) DEFAULT NULL,
  `EIWEIß` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`ZUTATENNR`),
  CONSTRAINT `NAEHRWERTE_ibfk_1` FOREIGN KEY (`ZUTATENNR`) REFERENCES `ZUTAT` (`ZUTATENNR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Exportiere Daten aus Tabelle krautundrueben.NAEHRWERTE: ~22 rows (ungefähr)
INSERT INTO `NAEHRWERTE` (`ZUTATENNR`, `KALORIEN_KJ`, `KALORIEN_KCAL`, `PROTEIN`, `KOHLENHYDRATE`, `ZUCKER`, `FETT`, `GES_FETT`, `BALLASTSTOFFE`, `NATRIUM`, `EIWEIß`) VALUES
	(1001, 80, 19, 2.10, 2.00, 2.00, 0.29, 0.07, 1.00, 0.00, 2.00),
	(1002, 116, 28, 1.20, 5.00, 4.00, 0.25, 0.08, 1.00, 0.00, 1.00),
	(1003, 73, 17, 0.80, 3.00, 3.00, 0.21, 0.04, 1.00, 0.00, 1.00),
	(1004, 92, 22, 1.50, 3.00, 3.00, 0.20, 0.05, 2.00, 0.01, 2.00),
	(1005, 137, 33, 0.90, 7.00, 6.00, 0.18, 0.04, 3.00, 0.02, 1.00),
	(1006, 307, 73, 2.00, 16.00, 1.00, 0.01, 0.00, 1.00, 0.00, 2.00),
	(1007, 105, 26, 2.60, 2.00, 2.00, 1.00, 0.21, 2.00, 0.03, 2.00),
	(1008, 174, 42, 0.90, 9.00, 7.00, 0.30, 0.07, 3.00, 0.01, 1.00),
	(1009, 593, 142, 6.10, 28.00, 2.00, 0.12, 0.03, 2.00, 0.02, 6.00),
	(1010, 172, 41, 3.10, 5.00, 5.00, 1.00, 0.15, 3.00, 0.01, 3.00),
	(1011, 466, 111, 1.70, 24.00, 5.00, 1.00, 0.24, 3.00, 0.00, 2.00),
	(1012, 114, 27, 3.40, 2.00, 2.00, 1.00, 0.09, 6.00, 0.00, 4.00),
	(2001, 255, 61, 0.40, 14.00, 13.00, 0.05, 0.02, 2.00, 0.00, 0.34),
	(3001, 272, 65, 3.90, 5.00, 5.00, 4.00, 2.21, 0.00, 0.05, 3.00),
	(3002, 1210, 290, 20.40, 2.00, 0.00, 23.00, 15.69, 0.00, 0.21, 19.00),
	(3003, 3101, 741, 0.70, 1.00, 1.00, 83.00, 53.81, 0.00, 0.01, 1.00),
	(4001, 646, 154, 12.80, 1.00, 1.00, 11.00, 3.33, 0.00, 0.14, 13.00),
	(5001, 1240, 296, 14.90, 0.28, 0.27, 26.00, 9.52, 0.10, 0.83, 15.00),
	(6300, 522, 125, 7.80, 17.00, 1.00, 3.00, 0.48, 4.00, 0.24, 7.00),
	(6408, 1429, 341, 12.00, 69.00, 1.00, 2.00, 0.25, 6.00, 0.01, 12.00),
	(7043, 94, 22, 0.50, 1.00, 1.00, 2.00, 0.99, 1.00, 0.18, 1.00),
	(9001, 956, 228, 27.80, 8.50, 1.60, 13.70, 2.00, 2.30, 0.64, 27.10);

-- Exportiere Struktur von Tabelle krautundrueben.REZEPT
CREATE TABLE IF NOT EXISTS `REZEPT` (
  `Name` text,
  `ZUTAT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IST_VEGAN` tinyint(1) DEFAULT NULL,
  `IST_VEGETARISCH` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Exportiere Daten aus Tabelle krautundrueben.REZEPT: ~0 rows (ungefähr)

-- Exportiere Struktur von Tabelle krautundrueben.ZUTAT
CREATE TABLE IF NOT EXISTS `ZUTAT` (
  `ZUTATENNR` int NOT NULL,
  `BEZEICHNUNG` varchar(50) DEFAULT NULL,
  `EINHEIT` varchar(25) DEFAULT NULL,
  `NETTOPREIS` decimal(10,2) DEFAULT NULL,
  `BESTAND` int DEFAULT NULL,
  `LIEFERANT` int DEFAULT NULL,
  `KALORIEN` int DEFAULT NULL,
  `KOHLENHYDRATE` decimal(10,2) DEFAULT NULL,
  `PROTEIN` decimal(10,2) DEFAULT NULL,
  `IST_VEGAN` tinyint(1) DEFAULT NULL,
  `IST_VEGETARISCH` tinyint(1) DEFAULT NULL,
  `IST_FLEISCHHALTIG` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ZUTATENNR`),
  KEY `LIEFERANT` (`LIEFERANT`),
  CONSTRAINT `ZUTAT_ibfk_1` FOREIGN KEY (`LIEFERANT`) REFERENCES `LIEFERANT` (`LIEFERANTENNR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Exportiere Daten aus Tabelle krautundrueben.ZUTAT: ~22 rows (ungefähr)
INSERT INTO `ZUTAT` (`ZUTATENNR`, `BEZEICHNUNG`, `EINHEIT`, `NETTOPREIS`, `BESTAND`, `LIEFERANT`, `KALORIEN`, `KOHLENHYDRATE`, `PROTEIN`, `IST_VEGAN`, `IST_VEGETARISCH`, `IST_FLEISCHHALTIG`) VALUES
	(1001, 'Zucchini', 'Stück', 0.89, 100, 101, 19, 2.00, 1.60, 1, 1, 0),
	(1002, 'Zwiebel', 'Stück', 0.15, 50, 101, 28, 4.90, 1.20, 1, 1, 0),
	(1003, 'Tomate', 'Stück', 0.45, 50, 101, 18, 2.60, 1.00, 1, 1, 0),
	(1004, 'Schalotte', 'Stück', 0.20, 500, 101, 25, 3.30, 1.50, 1, 1, 0),
	(1005, 'Karotte', 'Stück', 0.30, 500, 101, 41, 10.00, 0.90, 1, 1, 0),
	(1006, 'Kartoffel', 'Stück', 0.15, 1500, 101, 71, 14.60, 2.00, 1, 1, 0),
	(1007, 'Rucola', 'Bund', 0.90, 10, 101, 27, 2.10, 2.60, 1, 1, 0),
	(1008, 'Lauch', 'Stück', 1.20, 35, 101, 29, 3.30, 2.10, 1, 1, 0),
	(1009, 'Knoblauch', 'Stück', 0.25, 250, 101, 141, 28.40, 6.10, 1, 1, 0),
	(1010, 'Basilikum', 'Bund', 1.30, 10, 101, 41, 5.10, 3.10, 1, 1, 0),
	(1011, 'Süßkartoffel', 'Stück', 2.00, 200, 101, 86, 20.00, 1.60, 1, 1, 0),
	(1012, 'Schnittlauch', 'Bund', 0.90, 10, 101, 28, 1.00, 3.00, 1, 1, 0),
	(2001, 'Apfel', 'Stück', 1.20, 750, 102, 54, 14.40, 0.30, 1, 1, 0),
	(3001, 'Vollmilch. 3.5%', 'Liter', 1.50, 50, 103, 65, 4.70, 3.40, 0, 1, 0),
	(3002, 'Mozzarella', 'Packung', 3.50, 20, 103, 241, 1.00, 18.10, 0, 1, 0),
	(3003, 'Butter', 'Stück', 3.00, 50, 103, 741, 0.60, 0.70, 0, 1, 0),
	(4001, 'Ei', 'Stück', 0.40, 300, 102, 137, 1.50, 11.90, 0, 1, 0),
	(5001, 'Wiener Würstchen', 'Paar', 1.80, 40, 101, 331, 1.20, 9.90, 0, 0, 1),
	(6300, 'Kichererbsen', 'Dose', 1.00, 400, 103, 150, 21.20, 9.00, 1, 1, 0),
	(6408, 'Couscous', 'Packung', 1.90, 15, 102, 351, 67.00, 12.00, 1, 1, 0),
	(7043, 'Gemüsebrühe', 'Würfel', 0.20, 4000, 101, 1, 0.50, 0.50, 1, 1, 0),
	(9001, 'Tofu-Würstchen', 'Stück', 1.80, 20, 103, 252, 7.00, 17.00, 1, 1, 0);

-- Exportiere Struktur von Tabelle krautundrueben.ZUTAT_ALLERGEN
CREATE TABLE IF NOT EXISTS `ZUTAT_ALLERGEN` (
  `ZUTATENNR` int DEFAULT NULL,
  `ALLERGEN_ID` int DEFAULT NULL,
  KEY `ZUTAT` (`ZUTATENNR`) USING BTREE,
  KEY `ALLERGENID` (`ALLERGEN_ID`),
  CONSTRAINT `ALLERGENID` FOREIGN KEY (`ALLERGEN_ID`) REFERENCES `ALLERGEN` (`ALLERGEN_ID`),
  CONSTRAINT `ZUTAT` FOREIGN KEY (`ZUTATENNR`) REFERENCES `ZUTAT` (`ZUTATENNR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Exportiere Daten aus Tabelle krautundrueben.ZUTAT_ALLERGEN: ~29 rows (ungefähr)
INSERT INTO `ZUTAT_ALLERGEN` (`ZUTATENNR`, `ALLERGEN_ID`) VALUES
	(1001, 0),
	(1002, 0),
	(1003, 0),
	(1004, 0),
	(1005, 0),
	(1006, 0),
	(1007, 0),
	(1008, 0),
	(1009, 0),
	(1010, 0),
	(1011, 0),
	(1012, 0),
	(2001, 0),
	(3003, 7),
	(3001, 7),
	(3002, 7),
	(4001, 3),
	(5001, 7),
	(5001, 10),
	(5001, 9),
	(5001, 6),
	(5001, 1),
	(6300, 0),
	(6408, 1),
	(7043, 9),
	(7043, 1),
	(7043, 6),
	(7043, 7),
	(9001, 6),
	(9001, 1),
	(9001, 10),
	(9001, 9),
	(9001, 7);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
