DROP DATABASE IF EXISTS sessions;
CREATE DATABASE  sessions;
\c sessions;


--
-- Table structure for table `movies`
--
DROP TABLE IF EXISTS movies;
CREATE TABLE movies (
  id serial,
  movie varchar(70) NOT NULL,
  theater varchar(50) NOT NULL,
  zip int NOT NULL,
  PRIMARY KEY (id)
);

--
-- Dumping data for table `movies`
--

INSERT INTO movies (movie, theater, zip) VALUES ('Valentine''s Day', 'Regal Fredericksburg 15', 22401);
INSERT INTO movies (movie, theater, zip) VALUES ('Dear John', 'Regal Fredericksburg 15', 22401);
INSERT INTO movies (movie, theater, zip) VALUES ('The Wolfman', 'Regal Fredericksburg 15', 22401);
INSERT INTO movies (movie, theater, zip) VALUES ('From Paris with Love', 'Marquee Cinemas Southpoint 9', 22401);
INSERT INTO movies (movie, theater, zip) VALUES ('The Book of Eli', 'Allen Cinema 4 Mesilla Valley', 88005);
INSERT INTO movies (movie, theater, zip) VALUES ('The Wolfman', 'Allen Cinema 4 Mesilla Valley', 88005);
INSERT INTO movies (movie, theater, zip) VALUES ('Avatar3D', 'Allen Cinema 4 Mesilla Valley', 88005);

-- --------------------------------------------------------

--
-- Table structure for table `stores`
--


DROP TABLE IF EXISTS stores;
CREATE TABLE stores(
  id serial,
  name varchar(25) NOT NULL,
  type varchar(25) NOT NULL,
  address varchar(30) NOT NULL,
  city varchar(25) NOT NULL,
  zip int NOT NULL,
  PRIMARY KEY (id)
);

--
-- Dumping data for table `stores`
--


INSERT INTO stores (name, type, address, city, zip) VALUES ('Starbucks', 'coffee', '2511 Lohman Ave', 'Las Cruces', 88005);
INSERT INTO stores (name, type, address, city, zip) VALUES ('Milagro Coffee Y Espresso', 'coffee', '1733 E. University Ave', 'Las Cruces', 88005);
INSERT INTO stores (name, type, address, city, zip) VALUES ('Starbucks', 'coffee', '1500 South Valley',  'Las Cruces', 88005);
INSERT INTO stores (name, type, address, city, zip) VALUES ('Bean', 'coffee', '2011 Avenida De Mesilla',  'Las Cruces', 88005);
INSERT INTO stores (name, type, address, city, zip) VALUES ('Hyperion Espresso', 'coffee', '301 William St.',  'Fredericksburg', 22401);
INSERT INTO stores (name, type, address, city, zip) VALUES ('Starbucks', 'coffee', '2001 Plank Road', 'Fredericksburg', 22401);
INSERT INTO stores (name, type, address, city, zip) VALUES ('Caribou Coffee', 'coffee', '1251 Carl D Silver Parkway', 'Fredericksburg',  22401);
INSERT INTO stores (name, type, address, city, zip) VALUES ('Pancho Villa Mexican Rest', 'Mexican restaurant', '10500 Spotsylvania Ave', 'Fredericksburg', 22401);
INSERT INTO stores (name, type, address, city, zip) VALUES ('Chipotle', 'Mexican restaurant', '5955 Kingstowne', 'Fredericksburg', 22401);
INSERT INTO stores (name, type, address, city, zip) VALUES ('El Comedor', 'Mexican restaurant', '2190 Avenida De  Mesilla', 'Las Cruces', 88005);
INSERT INTO stores (name, type, address, city, zip) VALUES ('Los Compas', 'Mexican restaurant', '603 S Nevarez St.',  'Las Cruces', 88005);
INSERT INTO stores (name, type, address, city, zip) VALUES ('La Fuente', 'Mexican restaurant', '1710 S Espina',  'Las Cruces', 88005);
INSERT INTO stores (name, type, address, city, zip) VALUES ('Peet''s', 'coffee', '2260 Locust',  'Las Cruces', 88005);

-- --------------------------------------------------------


--
-- Table structure for table `users`
--


DROP TABLE IF EXISTS users;
CREATE TABLE users(
  id serial,
  username varchar(12) NOT NULL,
  password text NOT NULL,
  zipcode int NOT NULL,
  PRIMARY KEY (id)
);

--
-- Dumping data for table `users`
--


INSERT INTO users (username, password, zipcode) VALUES ('raz', 'p00d13', 88005);
INSERT INTO users (username, password, zipcode) VALUES ('ann', 'changeme', 22401);
INSERT INTO users (username, password, zipcode) VALUES ('lazy', 'qwerty', 22401);