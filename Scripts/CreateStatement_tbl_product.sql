CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `category` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL,
  `price` double NOT NULL,
  `manufacturer` varchar(45) DEFAULT NULL,
  `discount` int(11) DEFAULT NULL,
  `condition` varchar(45) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
