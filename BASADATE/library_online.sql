-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: library_online
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `year` int DEFAULT NULL,
  `genre` varchar(100) DEFAULT NULL,
  `description` text,
  `cover_url` varchar(512) DEFAULT NULL,
  `price` decimal(8,2) DEFAULT '0.00',
  `rating` float DEFAULT '0',
  `reviews_count` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'Четверте крило','Ребекка Яррос',2023,'Фентезі','Перша книга про школу драконів і боротьбу за виживання. Вайолет Сорренгейл вступає до воєнного коледжу, де кожен день може стати останнім.','https://covers.openlibrary.org/b/isbn/9781649374172-L.jpg',0.00,0,0),(2,'Залізні полум\'я','Ребекка Яррос',2024,'Фентезі','Продовження пригод Вайолет, ще більше інтриг, битв і драконів. Героїня стикається з новими загрозами та розкриттям таємниць.','https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1685980144i/61431986.jpg',0.00,0,0),(3,'Останнє бажання','Анджей Сапковський',1993,'Фентезі','Збірка оповідань про Ґеральта з Рівії - відьмака, який позбавляє світ від потвор за гроші.','https://covers.openlibrary.org/b/isbn/9788375780635-L.jpg',0.00,0,0),(4,'Меч призначення','Анджей Сапковський',1992,'Фентезі','Оповідання, які формують основу саги про Відьмака. Знайомство з Йеннефер та поява Цірі.','https://covers.openlibrary.org/b/isbn/9788375780642-L.jpg',0.00,0,0),(5,'Кров ельфів','Анджей Сапковський',1994,'Фентезі','Перша частина основної саги про Ґеральта і Цірі. Початок їхньої спільної подорожі.','https://covers.openlibrary.org/b/isbn/9788375780659-L.jpg',0.00,0,0),(6,'Час погорди','Анджей Сапковський',1995,'Фентезі','Світ Відьмака занурюється у війну. Цірі навчається магії під керівництвом Йеннефер.','https://covers.openlibrary.org/b/isbn/9788375780666-L.jpg',0.00,0,0),(7,'Хрещення вогнем','Анджей Сапковський',1996,'Фентезі','Ґеральт збирає нових союзників у пошуках Цірі. Політичні інтриги посилюються.','https://covers.openlibrary.org/b/isbn/9788375780673-L.jpg',0.00,0,0),(8,'Башта Ластівки','Анджей Сапковський',1997,'Фентезі','Цірі опиняється у смертельній небезпеці. Її здібності розкриваються повністю.','https://covers.openlibrary.org/b/isbn/9788375780680-L.jpg',0.00,0,0),(9,'Володарка Озера','Анджей Сапковський',1999,'Фентезі','Фінал саги про Відьмака. Всі сюжетні лінії сходяться до кульмінації.','https://covers.openlibrary.org/b/isbn/9788375780697-L.jpg',0.00,0,0),(10,'Метро 2033','Дмитро Глуховський',2005,'Постапокаліпсис','Людство виживає у московському метро після ядерної війни. Артем вирушає в небезпечну подорож, щоб врятувати свою станцію.','https://covers.openlibrary.org/b/isbn/9785676700254-L.jpg',0.00,0,0),(11,'Метро 2034','Дмитро Глуховський',2009,'Постапокаліпсис','Нова історія про виживання у підземці. Герої досліджують таємниці метро та стикаються з новими загрозами.','https://covers.openlibrary.org/b/isbn/9785676700261-L.jpg',0.00,0,0),(12,'Метро 2035','Дмитро Глуховський',2015,'Постапокаліпсис','Завершення трилогії. Артем дізнається шокуючу правду про світ за межами метро.','https://covers.openlibrary.org/b/isbn/9785676700278-L.jpg',0.00,0,0),(13,'Гаррі Поттер і філософський камінь','Дж. К. Ролінґ',1997,'Фентезі','Початок пригод Гаррі Поттера у школі чарів і чаклунства Хогвартс.','https://covers.openlibrary.org/b/isbn/9780747532699-L.jpg',0.00,0,0),(14,'Гаррі Поттер і таємна кімната','Дж. К. Ролінґ',1998,'Фентезі','Продовження історії юного чарівника. У школі відкривається таємна кімната.','https://covers.openlibrary.org/b/isbn/9780747538493-L.jpg',0.00,0,0),(15,'Гаррі Поттер і в\'язень Азкабану','Дж. К. Ролінґ',1999,'Фентезі','Таємниці минулого розкриваються. З в\'язниці Азкабан втікає небезпечний злочинець.','https://covers.openlibrary.org/b/isbn/9780747542155-L.jpg',0.00,0,0),(16,'Гаррі Поттер і келих вогню','Дж. К. Ролінґ',2000,'Фентезі','Турнір трьох чарівників. Хогвартс приймає міжшкільні змагання.','https://covers.openlibrary.org/b/isbn/9780747550990-L.jpg',0.00,0,0),(17,'Гаррі Поттер і Орден Фенікса','Дж. К. Ролінґ',2003,'Фентезі','Боротьба проти Волдеморта посилюється. Створюється Орден Фенікса.','https://covers.openlibrary.org/b/isbn/9780747551003-L.jpg',0.00,0,0),(18,'Гаррі Поттер і напівкровний принц','Дж. К. Ролінґ',2005,'Фентезі','Розкриття таємниць минулого Волдеморта. Гаррі знаходить старий підручник.','https://covers.openlibrary.org/b/isbn/9780747581086-L.jpg',0.00,0,0),(19,'Гаррі Поттер і смертельні реліквії','Дж. К. Ролінґ',2007,'Фентезі','Фінальна битва добра і зла. Полювання на горокракси.','https://covers.openlibrary.org/b/isbn/9780545010221-L.jpg',0.00,0,0),(20,'Гобіт, або Туди і Звідти','Дж. Р. Р. Толкін',1937,'Фентезі','Пригоди Більбо Беґінса у поході за скарбами дракона Смоґа.','https://covers.openlibrary.org/b/isbn/9780547928227-L.jpg',0.00,0,0),(21,'Володар перснів: Братство персня','Дж. Р. Р. Толкін',1954,'Фентезі','Перша частина епосу. Фродо вирушає у небезпечну подорож знищити Перстень.','https://covers.openlibrary.org/b/isbn/9780547928210-L.jpg',0.00,0,0),(22,'Володар перснів: Дві вежі','Дж. Р. Р. Толкін',1954,'Фентезі','Продовження історії Фродо. Братство розділяється, кожен йде своїм шляхом.','https://covers.openlibrary.org/b/isbn/9780547928203-L.jpg',0.00,0,0),(23,'Володар перснів: Повернення короля','Дж. Р. Р. Толкін',1955,'Фентезі','Фінал трилогії. Остання битва за Середзем\'я.','https://covers.openlibrary.org/b/isbn/9780547928197-L.jpg',0.00,0,0),(24,'1984','Джордж Орвелл',1949,'Антиутопія','Історія тоталітарного суспільства, де кожен крок контролюється Великим Братом.','https://covers.openlibrary.org/b/isbn/9780451524935-L.jpg',0.00,0,0),(25,'Майстер і Маргарита','Михайло Булгаков',1966,'Роман','Поєднання сатири, містики та філософії. Візит Сатани до Москви 1930-х років.','https://covers.openlibrary.org/b/isbn/9780141180144-L.jpg',0.00,0,0),(26,'Великий Гетсбі','Френсіс Скотт Фіцджеральд',1925,'Роман','Трагічна історія Джея Гетсбі та його кохання до Дейзі в епоху джазу.','https://covers.openlibrary.org/b/isbn/9780743273565-L.jpg',0.00,0,0),(27,'Убити пересмішника','Гарпер Лі',1960,'Роман','Боротьба проти расизму на Півдні США. Історія, розказана очима дитини.','https://covers.openlibrary.org/b/isbn/9780061120084-L.jpg',0.00,0,0),(28,'Гордість і упередження','Джейн Остін',1813,'Роман','Класична історія кохання Елізабет Беннет та містера Дарсі.','https://covers.openlibrary.org/b/isbn/9780141439518-L.jpg',0.00,0,0),(29,'Злочин і кара','Федір Достоєвський',1866,'Роман','Психологічна драма про злочинця Родіона Раскольникова та його муки сумління.','https://covers.openlibrary.org/b/isbn/9780143058144-L.jpg',0.00,0,0),(30,'Анна Кареніна','Лев Толстой',1877,'Роман','Трагедія кохання Анни та графа Вронського в царській Росії.','https://covers.openlibrary.org/b/isbn/9780143035008-L.jpg',0.00,0,0),(32,'Моби Дік','Герман Мелвілл',1851,'Пригоди','Епічна історія полювання на білого кита Моби Діка.','https://covers.openlibrary.org/b/isbn/9780142437247-L.jpg',0.00,0,0),(33,'Голодні ігри','Сюзанна Коллінз',2008,'Антиутопія','Підлітки змушені боротися на арені в телевізійному шоу.','https://covers.openlibrary.org/b/isbn/9780439023481-L.jpg',0.00,0,0),(34,'Ім\'я вітру','Патрік Ротфус',2007,'Фентезі','Історія Квоута, студента університету магії, що розповідає про своє життя.','https://covers.openlibrary.org/b/isbn/9780756404079-L.jpg',0.00,0,0),(35,'Пісня льоду та полум\'я: Гра престолів','Джордж Р. Р. Мартін',1996,'Фентезі','Перша книга епічної саги про боротьбу за Залізний трон Вестеросу.','https://covers.openlibrary.org/b/isbn/9780553103540-L.jpg',0.00,0,0),(36,'Ерагон','Крістофер Паоліні',2002,'Фентезі','Хлопчик знає яйце дракона і стає останнім Вершником Дракона.','https://covers.openlibrary.org/b/isbn/9780375826689-L.jpg',0.00,0,0),(37,'Аліса в Країні Чудес','Льюїс Керролл',1865,'Фентезі','Чарівна пригода дівчинки Аліси у світі дивних істот.','https://covers.openlibrary.org/b/isbn/9780194230196-L.jpg',0.00,0,0),(38,'Хроніки Нарнії: Лев, чаклунка та шафа','К. С. Льюїс',1950,'Фентезі','Діти потрапляють у чарівну країну Нарнію через шафу.','https://covers.openlibrary.org/b/isbn/9780060234812-L.jpg',0.00,0,0),(39,'Автостопом по Галактиці','Дуглас Адамс',1979,'Наукова фантастика','Комічні пригоди Артура Дента після знищення Землі.','https://covers.openlibrary.org/b/isbn/9780330258647-L.jpg',0.00,0,0),(40,'Дюна','Френк Герберт',1965,'Наукова фантастика','Епічна сага про Пол Атрідеса та боротьбу за контроль над планетою Арракіс.','https://covers.openlibrary.org/b/isbn/9780441172719-L.jpg',0.00,0,0),(41,'Фундація','Айзек Азімов',1951,'Наукова фантастика','Спроба врятувати галактичну цивілізацію від колапсу за допомогою психоісторії.','https://covers.openlibrary.org/b/isbn/9780553293357-L.jpg',0.00,0,0),(42,'451° за Фаренгейтом','Рей Бредбері',1953,'Антиутопія','Суспільство, де книги заборонені та підлягають спаленню.','https://covers.openlibrary.org/b/isbn/9780345342966-L.jpg',0.00,0,0),(43,'Шерлок Холмс: Етюд у багряних тонах','Артур Конан Дойл',1887,'Детектив','Перша спільна справа Шерлока Холмса та доктора Ватсона.','https://covers.openlibrary.org/b/isbn/9780199536950-L.jpg',0.00,0,0),(44,'Кобзар','Тарас Шевченко',1840,'Поезія','Найвідоміша збірка української поезії. Вірші про волю, любов до Батьківщини та людську гідність.','https://covers.openlibrary.org/b/id/15004591-L.jpg',0.00,0,0),(45,'Лісова пісня','Леся Українка',1911,'Драма','Поетична драма-феєрія про кохання, природу та вічну боротьбу добра і зла.','https://covers.openlibrary.org/b/id/15004592-L.jpg',0.00,0,0),(46,'Тигролови','Іван Багряний',1944,'Пригоди','Пригодницький роман про полювання на тигрів у далекосхідній тайзі.','https://covers.openlibrary.org/b/id/15004593-L.jpg',0.00,0,0),(47,'Захар Беркут','Іван Франко',1883,'Історичний','Історичний роман про боротьбу українських опришків проти монголо-татар.','https://covers.openlibrary.org/b/id/15004594-L.jpg',0.00,0,0),(48,'Камінний хрест','Василь Стефаник',1900,'Повість','Збірка новел про життя галицьких селян на початку XX століття.','https://covers.openlibrary.org/b/id/15004595-L.jpg',0.00,0,0);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `book_id` int DEFAULT NULL,
  `quantity` int DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `book_id` int DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `comment` text,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  CONSTRAINT `reviews_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'library_online'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-08 15:42:31
