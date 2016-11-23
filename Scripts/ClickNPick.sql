/*create database db_clicknpick;*/

use db_clicknpick;

drop table user;
drop table product;
drop table orders;


CREATE TABLE `orders` (
  `id` VARCHAR(30) NOT NULL,
  `fk_product_ids` varchar(45) NOT NULL,
  `fk_user_name` VARCHAR(45) DEFAULT NULL,
  `shipping_address_1` varchar(100) DEFAULT NULL,
  `shipping_address_2` varchar(100) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `zip` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `expected_delivery_date` datetime DEFAULT NULL,
  `card_number` varchar(45) DEFAULT NULL,
  `card_expiry_date` varchar(45) DEFAULT NULL,
  `CVV` varchar(45) DEFAULT NULL,
  `name_on_card` varchar(45) DEFAULT NULL,
  `order_amount` double DEFAULT NULL,
  `flag_donated` varchar(1) DEFAULT `0`,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(255),
  `category` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL,
  `price` double NOT NULL,
  `manufacturer` varchar(45) DEFAULT NULL,
  `discount` int(11) DEFAULT NULL,
  `condition` varchar(45) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user` (
  `username` varchar(45) NOT NULL,
  `title` varchar(5) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `email_id` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `address_1` varchar(100) NOT NULL,
  `address_2` varchar(100) DEFAULT NULL,
  `city` varchar(45) NOT NULL,
  `state` varchar(45) NOT NULL,
  `zip` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `role` varchar(45) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Sample Product Data*/
INSERT INTO `product` (`id`,`name`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (1,'Round Neck','Shirt','0',10,'Wrangler',1,'0',NULL,NULL);
INSERT INTO `product` (`id`,`name`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (2,'V Neck','Shirt','0',12,'Wrangler',2,'0',NULL,NULL);
INSERT INTO `product` (`id`,`name`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (3,'Slim Fit','Jeans','0',28,'Wrangler',2,'0',NULL,NULL);
INSERT INTO `product` (`id`,`name`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (4,'Low Waist','Jeans','0',35,'Denim',2,'0',NULL,NULL);
INSERT INTO `product` (`id`,`name`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (5,'Pull Over','Sweaters','0',22,'Addidas',3,'0',NULL,NULL);
