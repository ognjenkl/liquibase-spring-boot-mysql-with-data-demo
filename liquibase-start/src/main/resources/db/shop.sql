CREATE DATABASE IF NOT EXISTS `shop`;
USE `shop`;

CREATE TABLE IF NOT EXISTS `purchase_order` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `shipping_address` varchar(45) DEFAULT NULL,
    PRIMARY KEY (`id`)
);

INSERT INTO `purchase_order` (`id`, `shipping_address`) VALUES
    (1, 'Street 1');

CREATE TABLE IF NOT EXISTS `order_item` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `product` varchar(50) DEFAULT NULL,
    `amount` int DEFAULT NULL,
    `purchase_order_id` bigint NOT NULL,
    PRIMARY KEY (`id`),
    KEY `purchase_order_id` (`purchase_order_id`),
    CONSTRAINT `order_item_ibfk_1` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_order` (`id`)
);

INSERT INTO `order_item` (`id`, `product`, `amount`, `purchase_order_id`) VALUES
  (1, 'Product 1', 5, 1),
  (2, 'Product 2', 10, 1);
