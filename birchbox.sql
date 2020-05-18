/* Author : Jerome CHARDIN */
/* mail : jerome.chardin@live.fr */
/* test BirchBox */


CREATE DATABASE IF NOT EXISTS `birchbox`;
USE `birchbox`;

-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `Baskets` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idItem` INT NOT NULL,
  `quantity` INT NOT NULL,
  `idOrder` INT NOT NULL,
  PRIMARY KEY (`id`)
);


INSERT INTO `Baskets` (`id`, `idItem`, `quantity`, `idOrder`) VALUES
(1, 2, 4, 1),
(2, 3, 1, 1),
(3, 2, 34, 2),
(4, 1, 42, 3),
(5, 2, 84, 3),
(6, 3, 5, 4),
(7, 2, 22, 4),
(8, 1, 3, 1);


-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `Clients` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `firstName` text NOT NULL,
  `lastName` text NOT NULL,
  `mail` text NOT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `Clients` (`id`, `firstName`, `lastName`, `mail`) VALUES
(1, 'Jean', 'Dupond', 'jean.dupond@live.fr'),
(2, 'Alexander', 'Legrand', 'alexander.legrand@live.fr');


-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `Items` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `price` decimal(10,0) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `Items` (`id`, `name`, `price`, `description`) VALUES
(1, 'PRODUCT_1', '20', 'Super produit 1.'),
(2, 'PRODUCT_2', '34', 'Description product 2'),
(3, 'PRODUCT_3', '33', 'PRODUCT_3 description.');


-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `Orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idClient` INT NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `Orders` (`id`, `idClient`, `date`) VALUES
(1, 1, '2020-05-17'),
(2, 2, '2020-05-17'),
(3, 2, '2020-04-06'),
(4, 1, '2020-05-13');



/* CREATE TABLE `birchbox`.`Clients` ( `id` INT NOT NULL AUTO_INCREMENT , `firstName` TEXT NOT NULL , `lastName` TEXT NOT NULL , `mail` TEXT NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB; */

/* CREATE TABLE `birchbox`.`Orders` ( `id` INT NOT NULL AUTO_INCREMENT , `idClient` INT NOT NULL , `date` DATE NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB; */

/* CREATE TABLE `birchbox`.`Baskets` ( `id` INT NOT NULL AUTO_INCREMENT , `idItem` INT NOT NULL , `quantity` INT NOT NULL , `idOrder` INT NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB; */

/* CREATE TABLE `birchbox`.`Items` ( `id` INT NOT NULL AUTO_INCREMENT , `name` TEXT NOT NULL , `price` DECIMAL NOT NULL , `description` TEXT NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB; */


/* INSERT INTO `Items` (`id`, `name`, `price`, `description`) VALUES (NULL, 'PRODUCT_1', '19.99', 'Super produit 1.'); */

/* INSERT INTO `Items` (`id`, `name`, `price`, `description`) VALUES (NULL, 'PRODUCT_2', '34', 'Description product 2'), (NULL, 'PRODUCT_3', '33', 'PRODUCT_3 description.'); */


/* INSERT INTO `Clients` (`id`, `firstName`, `lastName`, `mail`) VALUES (NULL, 'Jean', 'Dupond', 'jean.dupond@live.fr'), (NULL, 'Alexander', 'Legrand', 'alexander.legrand@live.fr') */


/* INSERT INTO `Baskets` (`id`, `idItem`, `quantity`, `idOrder`) VALUES (NULL, '2', '4', '1'), (NULL, '3', '1', '1'), (NULL, '2', '34', '2'), (NULL, '1', '42', '3'), (NULL, '2', '84', '3'), (NULL, '3', '5', '4'), (NULL, '2', '22', '4') */

/* INSERT INTO `Orders` (`id`, `idClient`, `date`) VALUES (NULL, '1', '2020-05-17'), (NULL, '2', '2020-05-17'), (NULL, '2', '2020-04-06'), (NULL, '1', '2020-05-13') */


SELECT `firstname`, `mail` FROM `Clients` INNER JOIN `Orders` ON `Clients`.`id` = `Orders`.`idClient` INNER JOIN `Baskets`ON `Orders`.`id`= `Baskets`.`idOrder` INNER JOIN `Items` ON `Items`.`id` = `Baskets`.`idItem` WHERE `Items`.`name` = 'PRODUCT_1';

SELECT SUM(`Baskets`.`quantity`), `Items`.`name` FROM `Baskets` INNER JOIN `Items` ON `Baskets`.`idItem` = `Items`.`id` INNER JOIN `Orders` ON `Baskets`.`idOrder` = `Orders`.`id` WHERE `Orders`.`date` between date_sub(now(),INTERVAL 1 WEEK) and now() GROUP BY `Items`.`id`;
