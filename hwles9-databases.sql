--/* create user table and insert one user into that table
Drop table if exists gebruiker
CREATE TABLE gebruiker (
	id SERIAL PRIMARY KEY,
	username VARCHAR(255) NOT NULL,
	password VARCHAR(255) CHECK(length(password) > 8),
	address VARCHAR(255),
	job VARCHAR(255),
	wages INT,
	holiday_days INT DEFAULT 25
);

INSERT INTO gebruiker (username, password, address, job, wages, holiday_days)
VALUES ('benmij@icloud.com','hello1234','spuistraat 123','storemanager',3500,28);

select * from gebruiker
--*/


--/*
--Create tabel voor alle producten
CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	brand VARCHAR(255) NOT NULL,
	type VARCHAR(255),
	price INT,
	current_stock INT,
	sold INT,
	date_sold DATE
);

--Create televisie tabel
CREATE TABLE television (
	id SERIAL PRIMARY KEY,
	height INT,
	width INT,
	screen_quality VARCHAR(255),
	screen_type VARCHAR(255),
	wifi BOOLEAN DEFAULT false,
	smartTV BOOLEAN DEFAULT false,
	voice_control BOOLEAN DEFAULT false,
	HDR BOOLEAN DEFAULT false,
	productId INT,
	FOREIGN KEY (productId) REFERENCES products(id)
);

--Create tabel afstandsbediening
Drop table if exists remoteController
CREATE TABLE remoteController (
	id SERIAL PRIMARY KEY,
	smart BOOLEAN,
	battery_type VARCHAR(255),
	productId INT,
	televisionId INT,
	FOREIGN KEY (productId) REFERENCES products(id),
	FOREIGN KEY (televisionId) REFERENCES television(id)
);

--Create tabel CiModule
Drop table if exists ciModule
CREATE TABLE ciModule (
	id SERIAL PRIMARY KEY,
	provider VARCHAR(255),
	encodingCiModule VARCHAR(255),
	productId INT,
	televisionId INT,
	FOREIGN KEY (productId) REFERENCES products(id),
	FOREIGN KEY (televisionId) REFERENCES television(id)
);

--Create tabel WallBracket
Drop table if exists wallBracket
CREATE TABLE wallBracket (
	id SERIAL PRIMARY KEY,
	adjustable BOOLEAN DEFAULT false,
	mountingMethod VARCHAR(255),
	height INT,
	width INT,
	productId INT,
	televisionId INT,
	FOREIGN KEY (productId) REFERENCES products(id),
	FOREIGN KEY (televisionId) REFERENCES television(id)
);
--*/

--Creating data

--INSERT INTO products (name, brand, type, price, current_stock, sold, date_sold)
--VALUES ('QN90A Neo Qled 4k', 'Samsung', 'Television', 899, 10, 5, '2024-04-11');
--VALUES ('C1 OLED 4K', 'LG', 'Television', 799, 11, 6, '2024-05-11');
--VALUES ('X90J LED 4K', 'Sony', 'Television', 999, 10, 5, '2024-06-11');
--VALUES ('6-series R635', 'TLC', 'Television', 499, 10, 5, '2024-07-11');
--VALUES ('P-series Quantumm X', 'Vizio', 'Television', 1899, 10, 5, '2024-01-11');
--VALUES ('U8G ULED 4K', 'Hisense', 'Television', 699, 10, 5, '2024-04-11');
--VALUES ('JZ2000 OLED 4K', 'Panasonic', 'Television', 1099, 10, 5, '2024-02-11');
--VALUES ('Solar Remote', 'Samsung', 'Remotes', 59,20,15, '2024-06-25');
--VALUES ('Module +', 'Ziggo', 'CiModules', 99, 2, 10, '2024-07-03');
--VALUES ('Multy bracket', 'BracketBrand', 'wallBrackets', 49, 150, 125, '2024-08-04');

select * from products

INSERT INTO television (height, width, screen_quality, screen_type, wifi, smartTV, voice_control, HDR, productId)
VALUES (1200, 600, '4k', 'QLED', true, true, false, true, (select id from products where brand = 'Samsung'))

select * from television

INSERT INTO remoteController (smart, battery_type, productId, televisionId)
VALUES (true, 'rechargeable', (select id from products where type = 'Remotes'), (select id from television where screen_quality = '4k' ));

select * from remoteController

INSERT INTO ciModule (provider, encodingCiModule, productId, televisionId)
VALUES ('Ziggo', 'C+', (select id from products where type = 'CiModules'), (select id from television where screen_quality = '4k' ));

select * from ciModule

INSERT INTO wallBracket (adjustable, mountingMethod, height, width, productId, televisionId)
VALUES (true, 'screws into wall', 100, 100, (select id from products where type = 'wallBrackets'), (select id from television where screen_quality = '4k' ) )

select * from wallBracket

--Joining all tables
select * from products t1
left join television t2
on t1.id = t2.productId
left join remoteController t3
on t2.id = t3.televisionId
left join ciModule t4
on t2.id = t4.televisionId
left join wallBracket t5
on t2.id = t5.televisionId

