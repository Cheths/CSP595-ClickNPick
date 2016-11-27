/*
-- Query: SELECT * FROM db_clicknpick.product
LIMIT 0, 1000

-- Date: 2016-11-15 12:33
*/
INSERT INTO `product` (`id`,`name`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (1,'Round Neck','Shirt','0',10,'Wrangler',1,'0',"themes/images/products/shirts5.jpg",NULL);
INSERT INTO `product` (`id`,`name`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (2,'V Neck','Shirt','0',12,'Wrangler',2,'0',"themes/images/products/shirts6.jpg",NULL);
INSERT INTO `product` (`id`,`name`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (3,'Slim Fit','Jeans','0',28,'Wrangler',2,'0',NULL,NULL);
INSERT INTO `product` (`id`,`name`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (4,'Low Waist','Jeans','0',35,'Denim',2,'0',NULL,NULL);
INSERT INTO `product` (`id`,`name`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (5,'Pull Over','Sweaters','0',22,'Addidas',3,'0',NULL,NULL);

select * from `product` 
where donation = `yes`