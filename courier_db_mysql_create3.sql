CREATE TABLE `users` (
	`id` int NOT NULL,
	`login` varchar(255) NOT NULL UNIQUE,
	`password` varchar(32) NOT NULL UNIQUE,
	`description` TEXT NOT NULL,
	`name` varchar(255) NOT NULL,
	`company_id` int(255) NOT NULL,
	`session_hash` varchar(32) NOT NULL,
	`courier_status` tinyint NOT NULL,
	`phone` varchar(255) NOT NULL,
	`courier_transport_id` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `orders` (
	`id` int NOT NULL UNIQUE,
	`name` varchar(255) NOT NULL,
	`courier_id` int NOT NULL,
	`date_create` TIMESTAMP NOT NULL,
	`date_delivery` DATETIME NOT NULL,
	`status_id` int NOT NULL,
	`customer_id` int NOT NULL,
	`payment_id` smallint NOT NULL,
	`sender_id` int NOT NULL UNIQUE,
	`cargo_id` int NOT NULL,
	`cargo_weight` FLOAT NOT NULL,
	`cargo_length` FLOAT NOT NULL,
	`cargo_width` FLOAT NOT NULL,
	`cargo_height` FLOAT NOT NULL,
	`cargo_comment` TEXT NOT NULL,
	`recipient_id` int NOT NULL,
	`price` FLOAT NOT NULL,
	`address_name` varchar(255) NOT NULL,
	`address_latitude` FLOAT NOT NULL,
	`address_longitude` FLOAT NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `transport` (
	`id` int NOT NULL UNIQUE,
	`type_name` varchar(255) NOT NULL UNIQUE,
	`parent_id` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `role` (
	`id` int NOT NULL UNIQUE,
	`name` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `priv` (
	`id` int NOT NULL UNIQUE,
	`name` varchar(255) NOT NULL UNIQUE,
	PRIMARY KEY (`id`)
);

CREATE TABLE `role_priv` (
	`role_id` int NOT NULL UNIQUE,
	`priv_id` int NOT NULL UNIQUE
);

CREATE TABLE `sender` (
	`id` int NOT NULL UNIQUE,
	`name` varchar(255) NOT NULL,
	`phone` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `recipient` (
	`id` int NOT NULL UNIQUE,
	`name` varchar(255) NOT NULL,
	`phone` varchar(255) NOT NULL,
	`comment` TEXT NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `statuses` (
	`id` int NOT NULL,
	`name` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `payment_methods` (
	`id` smallint NOT NULL,
	`name` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `cargo_types` (
	`id` int NOT NULL,
	`name` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `company` (
	`id` int NOT NULL,
	`name` varchar(255) NOT NULL,
	`address` varchar(255) NOT NULL,
	`address_latitude` FLOAT NOT NULL,
	`address_longitude` FLOAT NOT NULL,
	`inn` char(10) NOT NULL,
	`kpp` char(9) NOT NULL,
	`rs` char(20) NOT NULL,
	`ks` char(20) NOT NULL,
	`bik` char(9) NOT NULL,
	`okpo` char(8) NOT NULL,
	`ogrn` char(13) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `user_role` (
	`user_id` int NOT NULL UNIQUE,
	`role_id` int NOT NULL UNIQUE
);

ALTER TABLE `users` ADD CONSTRAINT `users_fk0` FOREIGN KEY (`company_id`) REFERENCES `company`(`id`);

ALTER TABLE `users` ADD CONSTRAINT `users_fk1` FOREIGN KEY (`courier_transport_id`) REFERENCES `transport`(`id`);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk0` FOREIGN KEY (`courier_id`) REFERENCES `users`(`id`);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk1` FOREIGN KEY (`status_id`) REFERENCES `statuses`(`id`);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk2` FOREIGN KEY (`customer_id`) REFERENCES `users`(`id`);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk3` FOREIGN KEY (`payment_id`) REFERENCES `payment_methods`(`id`);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk4` FOREIGN KEY (`sender_id`) REFERENCES `sender`(`id`);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk5` FOREIGN KEY (`cargo_id`) REFERENCES `cargo_types`(`id`);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk6` FOREIGN KEY (`recipient_id`) REFERENCES `recipient`(`id`);

ALTER TABLE `role_priv` ADD CONSTRAINT `role_priv_fk0` FOREIGN KEY (`role_id`) REFERENCES `role`(`id`);

ALTER TABLE `role_priv` ADD CONSTRAINT `role_priv_fk1` FOREIGN KEY (`priv_id`) REFERENCES `priv`(`id`);

ALTER TABLE `user_role` ADD CONSTRAINT `user_role_fk0` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`);

ALTER TABLE `user_role` ADD CONSTRAINT `user_role_fk1` FOREIGN KEY (`role_id`) REFERENCES `role`(`id`);

