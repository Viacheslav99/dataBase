-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               5.7.29 - MySQL Community Server (GPL)
-- Операционная система:         Win64
-- HeidiSQL Версия:              11.0.0.5958
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Дамп структуры базы данных homework
CREATE DATABASE IF NOT EXISTS `homework` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `homework`;

-- Дамп структуры для таблица homework.accounts
CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `balance` int(11) DEFAULT NULL,
  `currency_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_currency_id` (`user_id`,`currency_id`),
  KEY `user_id` (`user_id`),
  KEY `FK_accounts_currencies` (`currency_id`),
  CONSTRAINT `FK_accounts_currencies` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`),
  CONSTRAINT `FK_accounts_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Рахунки користувача (Баланс. Валюта)';

-- Дамп данных таблицы homework.accounts: ~6 rows (приблизительно)
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` (`id`, `user_id`, `balance`, `currency_id`) VALUES
	(1, 1, 2000, 1),
	(2, 2, 10000, 1),
	(3, 3, 7000, 3),
	(4, 8, 3000, 2),
	(5, 4, 15000, 3),
	(6, 1, 200, 2);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;

-- Дамп структуры для таблица homework.amounts
CREATE TABLE IF NOT EXISTS `amounts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cashbox_id` int(11) unsigned NOT NULL,
  `value` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_amounts_cashboxes` (`cashbox_id`),
  CONSTRAINT `FK_amounts_cashboxes` FOREIGN KEY (`cashbox_id`) REFERENCES `cashboxes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Номінали банкнот (термінал. номінал. кількість)';

-- Дамп данных таблицы homework.amounts: ~2 rows (приблизительно)
/*!40000 ALTER TABLE `amounts` DISABLE KEYS */;
INSERT INTO `amounts` (`id`, `cashbox_id`, `value`, `quantity`) VALUES
	(1, 1, 2000, 10),
	(2, 2, 5000, 20);
/*!40000 ALTER TABLE `amounts` ENABLE KEYS */;

-- Дамп структуры для таблица homework.cashboxes
CREATE TABLE IF NOT EXISTS `cashboxes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `city` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `model_currency_id` (`model`,`currency_id`),
  KEY `FK_cashboxes_currencies` (`currency_id`),
  CONSTRAINT `FK_cashboxes_currencies` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Термінал (місто, валюта, модель)';

-- Дамп данных таблицы homework.cashboxes: ~6 rows (приблизительно)
/*!40000 ALTER TABLE `cashboxes` DISABLE KEYS */;
INSERT INTO `cashboxes` (`id`, `city`, `model`, `currency_id`) VALUES
	(1, 'Poltava', 'Bkm13', 2),
	(2, 'Praga', 'Cashbox1', 3),
	(3, 'Kyiv', 'KK20', 3),
	(4, 'Paris', 'Cashbox1', 1),
	(5, 'Berlin', 'Cashbox1', 2),
	(6, 'Lviv', 'Bkm13', 1);
/*!40000 ALTER TABLE `cashboxes` ENABLE KEYS */;

-- Дамп структуры для таблица homework.currencies
CREATE TABLE IF NOT EXISTS `currencies` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sign` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sign` (`sign`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Валюти система (символ назва)';

-- Дамп данных таблицы homework.currencies: ~3 rows (приблизительно)
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
INSERT INTO `currencies` (`id`, `sign`, `name`) VALUES
	(1, '$', 'dolar'),
	(2, 'Є', 'euro'),
	(3, '₴', 'gryvnya');
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;

-- Дамп структуры для таблица homework.logs
CREATE TABLE IF NOT EXISTS `logs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `cashbox_id` int(11) unsigned NOT NULL,
  `acount_id` int(11) unsigned NOT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_logs_cashboxes` (`cashbox_id`),
  KEY `FK_logs_accounts` (`acount_id`),
  CONSTRAINT `FK_logs_accounts` FOREIGN KEY (`acount_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `FK_logs_cashboxes` FOREIGN KEY (`cashbox_id`) REFERENCES `cashboxes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Журнал транзакцій';

-- Дамп данных таблицы homework.logs: ~12 rows (приблизительно)
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` (`id`, `date`, `cashbox_id`, `acount_id`, `amount`) VALUES
	(1, '2021-08-12 14:52:47', 1, 1, 2000),
	(2, '2021-08-12 15:28:06', 2, 2, 5500),
	(3, '2021-08-12 17:03:20', 3, 2, 345),
	(4, '2021-08-12 17:03:46', 4, 3, 4678),
	(5, '2021-07-12 17:04:39', 3, 4, 999),
	(6, '2021-08-12 17:04:59', 3, 5, 888),
	(7, '2021-08-12 17:05:12', 5, 6, 9999),
	(8, '2021-08-12 17:05:34', 5, 1, 4444),
	(9, '2021-08-12 17:06:00', 1, 4, 6789),
	(10, '2021-08-12 17:06:14', 3, 3, 10241),
	(11, '2021-08-12 17:06:31', 2, 6, 9000),
	(12, '2021-08-12 17:06:54', 5, 2, 8989);
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;

-- Дамп структуры для таблица homework.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Коричтувачі системи';

-- Дамп данных таблицы homework.users: ~8 rows (приблизительно)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `age`) VALUES
	(1, 'Petro', 45),
	(2, 'Ivan', 23),
	(3, 'Stepan', 24),
	(4, 'Viktor', 83),
	(5, 'Igor', 19),
	(6, 'Anna', 19),
	(7, 'Oleg', 31),
	(8, 'Svitlana', 29);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
