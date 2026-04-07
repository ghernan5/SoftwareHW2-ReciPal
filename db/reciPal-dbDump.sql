-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: recipal_db
-- ------------------------------------------------------
-- Server version	8.4.8

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
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `info` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredients`
--

LOCK TABLES `ingredients` WRITE;
/*!40000 ALTER TABLE `ingredients` DISABLE KEYS */;
INSERT INTO `ingredients` VALUES (1,'Skirt Steak','Cooking Tip: For the best Carne Asada, sear quickly over high heat and always slice against the grain for tenderness.'),(2,'Guajillo Chile','Origin: Mexico. These are dried mirasol chiles. They provide a deep red color and a sweet, mild heat!'),(3,'Queso Fresco','This is a \"fresh cheese.\" Because of its high moisture, it should be kept refrigerated and used quickly after opening.'),(4,'Corn Tortilla','Fact: Traditional tortillas are made through nixtamalization, a process that makes corn more nutritious and easier to digest.'),(5,'Jalapeño','When chopping, avoid touching your eyes! The capsaicin is concentrated in the seeds and white ribs.'),(6,'Cilantro','Origin: Mediterranean. While essential to Mexican food today, it was actually introduced by Spanish settlers.'),(7,'Roma Tomato','Fact: Roma tomatoes are preferred for salsas and sauces because they have thicker walls and fewer seeds than other varieties.'),(8,'Vanilla Extract','Vanilla has a unique, woody flavor that is essential for authentic Flan.'),(9,'Firm Tofu','Cooking Tip: Press tofu for 20 minutes before marinating to help it absorb bold Mexican spices like cumin and chili powder.');
/*!40000 ALTER TABLE `ingredients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_ingredients`
--

DROP TABLE IF EXISTS `recipe_ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_ingredients` (
  `recipe_id` int NOT NULL,
  `ingredient_id` int NOT NULL,
  PRIMARY KEY (`recipe_id`,`ingredient_id`),
  KEY `ingredient_id` (`ingredient_id`),
  CONSTRAINT `recipe_ingredients_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `recipe_ingredients_ibfk_2` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_ingredients`
--

LOCK TABLES `recipe_ingredients` WRITE;
/*!40000 ALTER TABLE `recipe_ingredients` DISABLE KEYS */;
INSERT INTO `recipe_ingredients` VALUES (2,1),(1,2),(2,3),(2,4),(1,5),(2,6),(4,6),(1,7),(2,7),(4,7),(5,8),(4,9);
/*!40000 ALTER TABLE `recipe_ingredients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipes`
--

DROP TABLE IF EXISTS `recipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `protein_type` enum('Chicken','Beef','Tofu','Grains') NOT NULL,
  `instructions` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipes`
--

LOCK TABLES `recipes` WRITE;
/*!40000 ALTER TABLE `recipes` DISABLE KEYS */;
INSERT INTO `recipes` VALUES (1,'Chicken Tinga','Chicken','1. Rehydrate guajillo chiles and blend with tomatoes and jalapeños. 2. Saute onions and add shredded chicken. 3. Simmer in the sauce for 20 mins.'),(2,'Carne Asada Tacos','Beef','1. Marinate steak with lemon and garlic.(Add any spices as well) 2. Grill until charred. 3. Serve on corn tortillas with cilantro, diced tomato, and queso fresco.'),(3,'Tex-Mex Beef Enchiladas','Beef','1. Fill tortillas with seasoned ground beef and cheese. 2. Roll and place in a dish. 3. Cover with red chili sauce and bake until bubbly.'),(4,'Tofu \"Al Pastor\" Sopes','Tofu','1. Marinate cubed tofu in achiote and pineapple. 2. Sear until crispy. 3. Serve on thick masa sopes with fresh cilantro and lime.'),(5,'Traditional Mexican Flan','Grains','1. Melt sugar into caramel and coat the bottom of the mold. 2. Blend eggs, condensed milk, and vanilla. 3. Bake in a water bath until set. 4. Chill and flip.');
/*!40000 ALTER TABLE `recipes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'recipal_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-06 21:07:49
