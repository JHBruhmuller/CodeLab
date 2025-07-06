-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: codelabdb
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `administrador`
--

DROP TABLE IF EXISTS `administrador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `administrador` (
  `id_adm` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `data_criacao` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id_adm`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrador`
--

LOCK TABLES `administrador` WRITE;
/*!40000 ALTER TABLE `administrador` DISABLE KEYS */;
/*!40000 ALTER TABLE `administrador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comentario`
--

DROP TABLE IF EXISTS `comentario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comentario` (
  `id_comentario` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_desafio` int(11) NOT NULL,
  `texto` text NOT NULL,
  `data_comentario` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id_comentario`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_desafio` (`id_desafio`),
  CONSTRAINT `comentario_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE,
  CONSTRAINT `comentario_ibfk_2` FOREIGN KEY (`id_desafio`) REFERENCES `desafio` (`id_desafio`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comentario`
--

LOCK TABLES `comentario` WRITE;
/*!40000 ALTER TABLE `comentario` DISABLE KEYS */;
INSERT INTO `comentario` VALUES (14,26,10002,'Desafio divertido!','2025-07-05 23:35:26'),(15,27,10003,'Muito ?til para iniciantes.','2025-07-05 23:35:26'),(16,28,10004,'Gosto de trabalhar com strings.','2025-07-05 23:35:26'),(17,29,10005,'Precisa de aten??o ? sintaxe.','2025-07-05 23:35:26'),(18,30,10006,'Mais complexo do que parece.','2025-07-05 23:35:26'),(19,31,10004,'Excelente para treinar l?gica.','2025-07-05 23:35:26'),(20,32,10006,'Gostei do desafio!','2025-07-05 23:35:26'),(21,33,10003,'Muito bom para revisar.','2025-07-05 23:35:26'),(22,33,10002,'R?pido e objetivo.','2025-07-05 23:35:26');
/*!40000 ALTER TABLE `comentario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `desafio`
--

DROP TABLE IF EXISTS `desafio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `desafio` (
  `id_desafio` int(11) NOT NULL AUTO_INCREMENT,
  `id_linguagem` int(11) DEFAULT NULL,
  `titulo` varchar(100) NOT NULL,
  `descricao` text NOT NULL,
  `estrelas` int(11) DEFAULT 0,
  `bits` int(11) DEFAULT 0,
  `data_criacao` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id_desafio`),
  KEY `id_linguagem` (`id_linguagem`),
  CONSTRAINT `desafio_ibfk_1` FOREIGN KEY (`id_linguagem`) REFERENCES `linguagem` (`id_linguagem`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=10021 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `desafio`
--

LOCK TABLES `desafio` WRITE;
/*!40000 ALTER TABLE `desafio` DISABLE KEYS */;
INSERT INTO `desafio` VALUES (1,1,'Validador de Senhas','Desafio de cria??o de um validador de senhas.',1,9,'2025-05-22 21:45:00'),(2,1,'Calculadora Simples','Desafio de cria??o de uma calculadora simples.',3,9,'2025-05-22 21:45:00'),(10002,1,'FizzBuzz JS','Implemente FizzBuzz em JavaScript',2,50,'2025-07-05 23:28:31'),(10003,2,'Soma de N?meros','Escreva uma fun??o que soma dois n?meros',1,30,'2025-07-05 23:28:31'),(10004,2,'Pal?ndromo','Verifique se uma palavra ? um pal?ndromo',3,80,'2025-07-05 23:28:31'),(10005,3,'Ordena??o C++','Ordene uma lista de inteiros',4,100,'2025-07-05 23:28:31'),(10006,4,'Valida??o CPF','Valide um n?mero de CPF em Java',3,90,'2025-07-05 23:28:31'),(10007,1,'FizzBuzz JS','Implemente FizzBuzz em JavaScript',2,50,'2025-07-05 23:30:21'),(10008,2,'Soma de N?meros','Escreva uma fun??o que soma dois n?meros',1,30,'2025-07-05 23:30:21'),(10009,2,'Pal?ndromo','Verifique se uma palavra ? um pal?ndromo',3,80,'2025-07-05 23:30:21'),(10010,3,'Ordena??o C++','Ordene uma lista de inteiros',4,100,'2025-07-05 23:30:21'),(10011,4,'Valida??o CPF','Valide um n?mero de CPF em Java',3,90,'2025-07-05 23:30:21'),(10012,1,'FizzBuzz JS','Desafio b?sico',2,50,'2025-07-05 23:32:34'),(10013,2,'Soma Simples','Soma dois n?meros',1,30,'2025-07-05 23:32:34'),(10014,3,'Ordena??o C++','Ordena inteiros',3,80,'2025-07-05 23:32:34'),(10015,4,'Validador CPF','Valida um CPF',4,100,'2025-07-05 23:32:34'),(10016,1,'FizzBuzz JS','Desafio cl?ssico de l?gica em JS',2,50,'2025-07-05 23:33:59'),(10017,2,'Soma Simples','Soma dois n?meros inteiros',1,30,'2025-07-05 23:33:59'),(10018,2,'Pal?ndromo','Verifica se uma string ? um pal?ndromo',3,80,'2025-07-05 23:33:59'),(10019,3,'Ordena??o','Ordena lista de inteiros em C++',4,100,'2025-07-05 23:33:59'),(10020,4,'Validador CPF','Valida um CPF em Java',3,90,'2025-07-05 23:33:59');
/*!40000 ALTER TABLE `desafio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `desafio_em_destaque`
--

DROP TABLE IF EXISTS `desafio_em_destaque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `desafio_em_destaque` (
  `id_usuario` int(11) NOT NULL,
  `id_desafio` int(11) NOT NULL,
  `data_destaque` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id_usuario`,`id_desafio`),
  KEY `id_desafio` (`id_desafio`),
  CONSTRAINT `desafio_em_destaque_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE,
  CONSTRAINT `desafio_em_destaque_ibfk_2` FOREIGN KEY (`id_desafio`) REFERENCES `desafio` (`id_desafio`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `desafio_em_destaque`
--

LOCK TABLES `desafio_em_destaque` WRITE;
/*!40000 ALTER TABLE `desafio_em_destaque` DISABLE KEYS */;
/*!40000 ALTER TABLE `desafio_em_destaque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorito`
--

DROP TABLE IF EXISTS `favorito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favorito` (
  `id_usuario` int(11) NOT NULL,
  `id_desafio` int(11) NOT NULL,
  `data_favorito` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id_usuario`,`id_desafio`),
  KEY `id_desafio` (`id_desafio`),
  CONSTRAINT `favorito_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE,
  CONSTRAINT `favorito_ibfk_2` FOREIGN KEY (`id_desafio`) REFERENCES `desafio` (`id_desafio`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorito`
--

LOCK TABLES `favorito` WRITE;
/*!40000 ALTER TABLE `favorito` DISABLE KEYS */;
INSERT INTO `favorito` VALUES (26,10004,'2025-07-05 23:35:22'),(27,10002,'2025-07-05 23:35:22'),(28,10005,'2025-07-05 23:35:22'),(29,10003,'2025-07-05 23:35:22'),(30,10006,'2025-07-05 23:35:22'),(31,10004,'2025-07-05 23:35:22'),(32,10006,'2025-07-05 23:35:22'),(33,10002,'2025-07-05 23:35:22'),(33,10003,'2025-07-05 23:35:22');
/*!40000 ALTER TABLE `favorito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `linguagem`
--

DROP TABLE IF EXISTS `linguagem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `linguagem` (
  `id_linguagem` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  PRIMARY KEY (`id_linguagem`)
) ENGINE=InnoDB AUTO_INCREMENT=1002 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `linguagem`
--

LOCK TABLES `linguagem` WRITE;
/*!40000 ALTER TABLE `linguagem` DISABLE KEYS */;
INSERT INTO `linguagem` VALUES (1,'Java'),(2,'Python'),(3,'Html'),(4,'Sql'),(5,'Golang'),(6,'Css'),(7,'JavaScript'),(8,'Php'),(9,'C'),(10,'TypeScript');
/*!40000 ALTER TABLE `linguagem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submissao`
--

DROP TABLE IF EXISTS `submissao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submissao` (
  `id_submissao` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_desafio` int(11) NOT NULL,
  `id_linguagem` int(11) NOT NULL,
  `codigo_fonte` text NOT NULL,
  `status` varchar(50) NOT NULL,
  `tempo_execucao` float DEFAULT NULL,
  `data_envio` datetime DEFAULT current_timestamp(),
  `status_conclusao` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id_submissao`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_desafio` (`id_desafio`),
  KEY `id_linguagem` (`id_linguagem`),
  CONSTRAINT `submissao_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE,
  CONSTRAINT `submissao_ibfk_2` FOREIGN KEY (`id_desafio`) REFERENCES `desafio` (`id_desafio`) ON DELETE CASCADE,
  CONSTRAINT `submissao_ibfk_3` FOREIGN KEY (`id_linguagem`) REFERENCES `linguagem` (`id_linguagem`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submissao`
--

LOCK TABLES `submissao` WRITE;
/*!40000 ALTER TABLE `submissao` DISABLE KEYS */;
INSERT INTO `submissao` VALUES (25,26,10002,1,'console.log(\"FizzBuzz\")','Aceito',0.12,'2025-07-05 23:35:18',1),(26,27,10003,2,'print(a + b)','Aceito',0.09,'2025-07-05 23:35:18',1),(27,28,10004,2,'palindromo(s)','Aceito',0.18,'2025-07-05 23:35:18',1),(28,29,10005,3,'sort(v.begin(), v.end())','Aceito',0.22,'2025-07-05 23:35:18',1),(29,30,10006,4,'validaCPF(cpf)','Aceito',0.3,'2025-07-05 23:35:18',1),(30,31,10004,2,'isPalindromo(s)','Aceito',0.17,'2025-07-05 23:35:18',1),(31,32,10002,1,'console.log(\"FizzBuzz\")','Aceito',0.1,'2025-07-05 23:35:18',1),(32,33,10003,2,'print(a + b)','Aceito',0.11,'2025-07-05 23:35:18',1),(35,31,1,1,'print(\"Calculadora\")','Aprovado',0.123,'2025-07-05 23:47:12',1),(36,31,1,1,'print(\"Calculadora\")','Aprovado',0.123,'2025-07-05 23:48:38',1),(37,26,1,1,'print(\"Calculadora\")','Aprovado',0.123,'2025-07-05 23:48:51',1);
/*!40000 ALTER TABLE `submissao` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_incrementar_resolvidos
AFTER INSERT ON Submissao
FOR EACH ROW
BEGIN
    IF NEW.status_conclusao = TRUE THEN
        UPDATE Usuario
        SET desafios_resolvidos = desafios_resolvidos + 1
        WHERE id_usuario = NEW.id_usuario;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `data_registro` datetime DEFAULT current_timestamp(),
  `titulo` varchar(50) DEFAULT NULL,
  `bits` int(11) DEFAULT 0,
  `desafios_resolvidos` int(11) DEFAULT 0,
  `id_desafio_em_destaque` int(11) DEFAULT NULL,
  `foto_perfil` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email` (`email`),
  KEY `id_desafio_em_destaque` (`id_desafio_em_destaque`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_desafio_em_destaque`) REFERENCES `desafio` (`id_desafio`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (26,'Usuário Login','login@teste.com','$2b$10$5ZhyDMTn3lS3tm9ZZRLT2ul6QlLzzdAD8p.Ug8yAFUP1BRT8XCsM.','2025-05-26 22:01:54',NULL,0,2,NULL,NULL),(27,'José','josehenrique.bruhmuller@gmail.com','$2b$10$GOi9.XJyt0TSq6IhqoFRXOFAg0VDLLrAJKwo3HQdPiXqwQMVdqG3.','2025-05-28 19:32:48',NULL,0,1,NULL,NULL),(28,'Teste API','teste@postman.com','$2b$10$dn9uGkINoL1H6opGEvMcUeK9zBf1UiqiZSIK992NUQPGD.eGo6xb.','2025-06-30 18:10:37',NULL,0,1,NULL,NULL),(29,'José','jose.bruhmuller@gmail.com','$2b$10$0Z9lr1Zofzwi9JlBFUKO7OKW9A5uVREYXp5FhQEZeq4NWrTUPT2bi','2025-06-30 18:49:33',NULL,0,1,NULL,NULL),(30,'José','jose@gmail.com','$2b$10$vqgz4wK2M7UfP47P/sEYZeZJMOJPGWzxoiBaGgxP1quhKpZEEcui2','2025-06-30 18:53:48',NULL,0,1,NULL,NULL),(31,'Alice','alice@email.com','1234','2025-07-05 23:28:35','Iniciante',100,5,NULL,NULL),(32,'Bob','bob@email.com','1234','2025-07-05 23:28:35','Intermedi?rio',200,4,NULL,NULL),(33,'Carlos','carlos@email.com','1234','2025-07-05 23:28:35','Avan?ado',300,6,NULL,NULL);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `vw_ranking_usuarios`
--

DROP TABLE IF EXISTS `vw_ranking_usuarios`;
/*!50001 DROP VIEW IF EXISTS `vw_ranking_usuarios`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_ranking_usuarios` AS SELECT
 1 AS `id_usuario`,
  1 AS `nome`,
  1 AS `titulo`,
  1 AS `bits`,
  1 AS `foto_perfil` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_submissoes_detalhadas`
--

DROP TABLE IF EXISTS `vw_submissoes_detalhadas`;
/*!50001 DROP VIEW IF EXISTS `vw_submissoes_detalhadas`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_submissoes_detalhadas` AS SELECT
 1 AS `id_submissao`,
  1 AS `usuario`,
  1 AS `desafio`,
  1 AS `linguagem`,
  1 AS `status`,
  1 AS `status_conclusao`,
  1 AS `tempo_execucao`,
  1 AS `data_envio` */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_ranking_usuarios`
--

/*!50001 DROP VIEW IF EXISTS `vw_ranking_usuarios`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_ranking_usuarios` AS select `usuario`.`id_usuario` AS `id_usuario`,`usuario`.`nome` AS `nome`,`usuario`.`titulo` AS `titulo`,`usuario`.`bits` AS `bits`,`usuario`.`foto_perfil` AS `foto_perfil` from `usuario` order by `usuario`.`bits` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_submissoes_detalhadas`
--

/*!50001 DROP VIEW IF EXISTS `vw_submissoes_detalhadas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_submissoes_detalhadas` AS select `s`.`id_submissao` AS `id_submissao`,`u`.`nome` AS `usuario`,`d`.`titulo` AS `desafio`,`l`.`nome` AS `linguagem`,`s`.`status` AS `status`,`s`.`status_conclusao` AS `status_conclusao`,`s`.`tempo_execucao` AS `tempo_execucao`,`s`.`data_envio` AS `data_envio` from (((`submissao` `s` join `usuario` `u` on(`s`.`id_usuario` = `u`.`id_usuario`)) join `desafio` `d` on(`s`.`id_desafio` = `d`.`id_desafio`)) join `linguagem` `l` on(`s`.`id_linguagem` = `l`.`id_linguagem`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-06 19:58:36
