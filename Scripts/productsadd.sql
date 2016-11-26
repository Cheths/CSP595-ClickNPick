use db_clicknpick;

delete from product;
drop table product;

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(255),
  `gender` varchar(10),
  `category` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL,
  `price` double NOT NULL,
  `manufacturer` varchar(45) DEFAULT NULL,
  `discount` int(11) DEFAULT NULL,
  `condition` varchar(45) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (6,'Alba','female','tops','0',25,'Alba',4,'0','Alba.jpg','Maroon T-shirt');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (7,'Sera','female','tops','0',26,'Sera',4,'0','Sera.jpg','Black T-shirt');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (8,'Taurus','female','tops','0',29,'Taurus',4,'0','Taurus.jpg','Peach colour Top');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (9,'Roadster','female','tops','0',30,'Roadster',4,'0','Roadster.jpg','Pink Top');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (10,'popnetic','female','tops','0',35,'popnetic',4,'0','popnetic.jpg','Black Top');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (11,'Ether','female','tops','0',20,'Ether',4,'0','Ether.jpg','Pink Boxy Top');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (12,'Devis','female','jeans','0',35,'Devis',4,'0','Devis.jpg','Navy Slim-Fit');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (13,'Forever21','female','jeans','0',31,'Forever21',4,'0','Forever21.jpg','Navy Mid-Rise');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (14,'Levis','female','jeans','0',38,'Levis',4,'0','Levis.jpg','Skinny Jeans');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (15,'Mango','female','jeans','0',40,'Mango',4,'0','Mango.jpg','White Low-Rise Jeans');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (16,'Roadster','female','jeans','0',39,'Roadster',4,'0','Roadsterjeans.jpg','Blue Slim-Fit Jeans');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (17,'Vero MOda','female','jeans','0',35,'Vero Moda',4,'0','Veromoda.jpg','Blue Slim-Fit Jeans');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (18,'Mast N Harbour','female','sweaters','0',19,'Mast N Harbour',4,'0','MastnHarbor.jpg','MaroonSolid Sweater');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (19,'Renka','female','sweaters','0',23,'Renka',4,'0','Renka.jpg','Black Sweater');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (20,'Ether','female','sweaters','0',26,'Ether',4,'0','WEthersweater.jpg','Teal Blue Sweater');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (21,'Foerver21','female','sweaters','0',25,'Forever21',4,'0','WForever21Sweater.jpg','Beige Patterned Sweater');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (22,'Roadster','female','sweaters','0',29,'Roadster',4,'0','WRoadstersweater.jpg','Black and Grey Sweater');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (23,'Roadster','female','sweaters','0',33,'Roadster',4,'0','WRoadstersweater2.jpg','Beige Ribbed Sweater');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (24,'Dress Berry','female','jackets','0',40,'Dress Berry',4,'0','Dressberry.jpg','Brown Biker Jacket');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (25,'Purys','female','jackets','0',40,'Purys',4,'0','Purys.jpg','Black quilted Jacket');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (26,'Vanca','female','jackets','0',42,'Vanca',4,'0','Vanca.jpg','Red Slim-Fit Jacket');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (27,'Mast N Harbour','female','jackets','0',45,'Mast N Harbour',4,'0','WMastnharbourjacket.jpg','Tan Brown Biker Jacket');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (28,'Roadster','female','jackets','0',43,'Roadster',4,'0','WRoadsterjacket.jpg','Tan Brown Biker Jacket');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (29,'Vero Moda','female','jackets','0',48,'Vero Moda',4,'0','WVeromodaJacket.jpg','Mustard Yellow Jacket');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (30,'Allen Solly','female','blazers','0',50,'Allen Solly',4,'0','AllenSolly.jpg','Grey Formal Blazer');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (31,'Fort Collins','female','blazers','0',52,'Fort Collins',4,'0','Fortcollins.jpg','Olive Brown Blazer');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (32,'NewLook','female','blazers','0',55,'NewLook',4,'0','Newlook.jpg','Red Blazer');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (33,'ONLY','female','blazers','0',51,'ONLY',4,'0','Only.jpg','Blue Blazer');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (34,'Park Avenue','female','blazers','0',54,'Park Avenue',4,'0','Parkavenue.jpg','Charcoal Grey Blazer');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (35,'Vero Moda','female','blazers','0',56,'Vero Moda',4,'0','WVeromodablazer.jpg','Grey Casual Blazer');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (36,'Avoir Envie','male','tshirt','0',16,'Avoir Envie',4,'0','Avoirenvie.jpg','Blue N grey T-Shirt');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (37,'Adidas','male','tshirt','0',20,'Adidas',4,'0','MAdidastshirt.jpg','Blue Round neck T-shirt');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (38,'Ether','male','tshirt','0',23,'Ether',4,'0','MEthertshirt.jpg','Grey Melange & Maroon T-shirt');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (39,'Moda Rapido','male','tshirt','0',28,'Moda Rapido',4,'0','Moda Rapido.jpg','Navy Printed T-shirt');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (40,'Roadster','male','tshirt','0',24,'Roadster',4,'0','MRoadstertshirt.jpg','Black printed T-shirt');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (41,'UCB','male','tshirt','0',30,'UCB',4,'0','UCB.jpg','White V-neck T-shirt');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (42,'LP Sport','male','casual','0',27,'LP SPort',4,'0','LPSport.jpg','White Casual shirt');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (43,'Roadster','male','casual','0',29,'Roadster',4,'0','MRoadstercasualt.jpg','Blue Casual shirt');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (44,'Wrangler','male','casual','0',31,'Wrangler',4,'0','Wranglercasualt.jpg','Beige and Navy Casual shirt');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (45,'GANT','male','casual','0',30,'GANT',4,'0','GANT.jpg','Navy blue Casual Trouser');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (46,'Hubberholme','male','casual','0',32,'Hubberholme',4,'0','Hubberholme.jpg','White Strechable Casual Trouser');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (47,'High Lander','male','casual','0',34,'High Lander',4,'0','MHighlandercasual.jpg','Brown Slim-Fit Casual Trouser');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (48,'Arrow','male','formal','0',32,'Arrow',4,'0','Arrow.jpg','Purple Formal Shirt');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (49,'Hancock','male','formal','0',34,'Hancock',4,'0','Hancock.jpg','Blue Slim Formal Shirt');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (50,'John Players','male','formal','0',35,'John Players',4,'0','John player.jpg','White Formal Shirt');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (51,'Arrow NewYork','male','formal','0',40,'ArrowNewYork',4,'0','Arrownewyork.jpg','Charcoal grey Formal Trouser');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (52,'Invictus','male','formal','0',42,'Invictus',4,'0','Invictus.jpg','Blue Formal Trouser');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (53,'Tommy Hilfiger','male','formal','0',38,'Tommy Hilfiger',4,'0','Tommyhilfiger.jpg','Charcoal grey Formal Trouser');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (54,'High Lander','male','jeans','0',44,'High Lander',4,'0','MHighlanderjeans.jpg','Black slim-fit jeans');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (55,'John Players','male','jeans','0',42,'John Players',4,'0','MJohnplayersjeans.jpg','Navy Mid-rise jeans');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (56,'Levis','male','jeans','0',46,'Levis',4,'0','MLevisjeans.jpg','Blue Low-Rise jeans');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (57,'UCB','male','jeans','0',41,'UCB',4,'0','MUcbjeans.jpg','Black slim-fit jeans');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (58,'Replay','male','jeans','0',45,'Replay',4,'0','Replay.jpg','Blue fit jeans');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (59,'WROGN','male','jeans','0',49,'WROGN',4,'0','WROGN.jpg','Black Mid-Rise jeans');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (60,'Ether','male','sweater','0',55,'Ether',4,'0','MEthersweater.jpg','Black Solid Sweater');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (61,'SPYKER','male','sweater','0',58,'SPYKER',4,'0','MSpykersweater.jpg','Grey Sweater');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (62,'Pepe Jeans','male','sweater','0',59,'Pepe Jeans',4,'0','Pepe Jeans.jpg','Black Sweater');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (63,'Santa Monica','male','sweater','0',48,'Santa Monica',4,'0','Santa Monica.jpg','Charcoal Grey Sweater');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (64,'SPYKER','male','sweater','0',49,'SPYKER',4,'0','SPYKER.jpg','Red Sweater');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (65,'Tokyo Laundry','male','sweater','0',58,'Tokyo Laundry',4,'0','Tokyo Laundry.jpg','Grey Patterned Sweater');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (66,'Fila','male','jacket','0',60,'Fila',4,'0','Fila.jpg','Blue Colourblocked Jacket');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (67,'Harvard','male','jacket','0',65,'Harvard',4,'0','Harvard.jpg','Black Quilted Bomber Jacket');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (68,'Fort Collins','male','jacket','0',60,'Fort Collins',4,'0','MFortCollinsjacket.jpg','Black Leather Jacket');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (69,'Roadster','male','jacket','0',63,'Roadster',4,'0','MRoadsterjacket.jpg','Brown Biker Jacket');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (70,'Puma','male','jacket','0',67,'Puma',4,'0','Puma.jpg','Black Jacket');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (71,'Wildcraft','male','jacket','0',69,'Wildcraft',4,'0','Wildcraft.jpg','Black Hooded Jacket');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (72,'Baby League','kids','clothingsets','0',30,'Baby League',4,'0','Baby League.jpg','White and yellow Clothing set');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (73,'Marks N Spencer','kids','clothingsets','0',25,'Marks N Spencer',4,'0','Marks Spencer.jpg','White Clothing Set');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (74,'Mother Care','kids','clothingsets','0',22,'Mother Care',4,'0','Mothercare.jpg','White and Red Clothing Set');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (75,'Nauti Nato','kids','clothingsets','0',28,'Nauti Nato',4,'0','Nauti Nato.jpg','White  and yellow Clothing Set');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (76,'Pantaloons','kids','clothingsets','0',31,'Pantaloons',4,'0','Pantaloons.jpg','Black and Pink Clothing Set');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (77,'Pepito','kids','clothingsets','0',29,'Pepito',4,'0','Pepito.jpg','Black Clothing Set');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (78,'612 League','kids','boys','0',20,'612 League',4,'0','612 League.jpg','Green boys T-Shirt');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (79,'Nauti Nati','kids','boys','0',25,'Nauti Nati',4,'0','BNautinati.jpg','MultiColour Boys T-Shirt');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (80,'Gini and Jony','kids','boys','0',22,'Giny and Jony',4,'0','Gini n Jony.jpg','Grey boys T-Shirt');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (81,'Juniors','kids','boys','0',18,'Juniors',4,'0','Juniors.jpg','White and Blue boys T-Shirt');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (82,'Palm Tree','kids','boys','0',26,'Palm Tree',4,'0','Palmtree.jpg','Blue boys T-Shirt');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (83,'Scullers','kids','boys','0',15,'Scullers',4,'0','Scullers.jpg','White and Orange boys T-Shirt');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (84,'Autograph','kids','girls','0',22,'Autograph',4,'0','Autograph.jpg','Brown girls Top');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (85,'Beebay','kids','girls','0',25,'Beebay',4,'0','Beebay.jpg','Pink girls Top');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (86,'Biba','kids','girls','0',27,'Biba',4,'0','Biba.jpg','Blue girls Top');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (87,'Gini and Jony','kids','girls','0',26,'Gini and Jony',4,'0','GGini n Jony.jpg','Navy girls Top');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (88,'Scullers','kids','girls','0',21,'Scullers',4,'0','GScullers.jpg','Orange girls Top');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (89,'UFO','kids','girls','0',28,'UFO',4,'0','Ufo.jpg','Pink girls Top');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (90,'Cute Cumber','kids','dresses','0',35,'CUTE CUMBER',4,'0','CUTECUMBER.jpg','Pink and Black girls Dress');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (91,'Lil Orchids','kids','dresses','0',31,'Lil Orchids',4,'0','Lil Orchids.jpg','Blue and white girls Dress');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (92,'Naughty Ninos','kids','dresses','0',33,'Naughty Ninos',4,'0','naughty ninos.jpg','White and Blue girls Dress');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (93,'Peppermint','kids','dresses','0',38,'Peppermint',4,'0','Peppermint.jpg','Blue girls Dress');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (94,'Style Stone','kids','dresses','0',32,'Style Stone',4,'0','StyleStone.jpg','Blue and pink girls Dress');
INSERT INTO `product` (`id`,`name`,`gender`,`category`,`type`,`price`,`manufacturer`,`discount`,`condition`,`image`,`description`) VALUES (95,'Toy Balloon','kids','dresses','0',40,'Toy Balloon',4,'0','Toy Balloon.jpg','Pink girls Dress');
