CREATE DATABASE vehicle_db;
USE vehicle_db;

CREATE TABLE manufacturer (
    manufacturer_id INT AUTO_INCREMENT PRIMARY KEY,
    manufacturer_name VARCHAR(255) NOT NULL,
    country VARCHAR(100)
);

CREATE TABLE car (
    car_id INT AUTO_INCREMENT PRIMARY KEY,
    manufacturer_id INT,
    car_model VARCHAR(255) NOT NULL,
    car_type VARCHAR(50),
    year_of_manufacture YEAR,
    price DECIMAL(10, 2),
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturer(manufacturer_id) ON DELETE CASCADE
);

CREATE TABLE bike (
    bike_id INT AUTO_INCREMENT PRIMARY KEY,
    manufacturer_id INT,
    bike_model VARCHAR(255) NOT NULL,
    bike_type VARCHAR(50),
    year_of_manufacture YEAR,
    price DECIMAL(10, 2),
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturer(manufacturer_id) ON DELETE CASCADE
);

CREATE TABLE dealership (
    dealership_id INT AUTO_INCREMENT PRIMARY KEY,
    dealership_name VARCHAR(255) NOT NULL,
    car_id INT,
    bike_id INT,
    location VARCHAR(255),
    FOREIGN KEY (car_id) REFERENCES car(car_id) ON DELETE SET NULL,
    FOREIGN KEY (bike_id) REFERENCES bike(bike_id) ON DELETE SET NULL
);

INSERT INTO manufacturer (manufacturer_name, country) 
VALUES
('Toyota', 'Japan'),
('Honda', 'Japan'),
('Ford', 'USA'),
('Harley-Davidson', 'USA'),
('BMW', 'Germany');

INSERT INTO car (manufacturer_id, car_model, car_type, year_of_manufacture, price) 
VALUES
(1, 'Camry', 'Sedan', 2023, 24000.00),
(1, 'Corolla', 'Sedan', 2022, 20000.00),
(2, 'Civic', 'Sedan', 2023, 22000.00),
(3, 'Mustang', 'Coupe', 2023, 27000.00),
(5, 'X5', 'SUV', 2022, 60000.00);

INSERT INTO bike (manufacturer_id, bike_model, bike_type, year_of_manufacture, price) 
VALUES
(2, 'CBR600RR', 'Sport', 2023, 12000.00),
(4, 'Sportster', 'Cruiser', 2023, 13000.00),
(4, 'Street Glide', 'Touring', 2022, 25000.00),
(5, 'S1000RR', 'Sport', 2023, 20000.00),
(1, 'MT-09', 'Naked', 2023, 10000.00);

INSERT INTO dealership (dealership_name, car_id, bike_id, location) 
VALUES
('AutoNation', 1, NULL, 'Los Angeles'),
('CarMax', 2, NULL, 'San Francisco'),
('Harley Davidson Dealer', NULL, 2, 'New York'),
('BMW Motorrad', NULL, 4, 'Miami'),
('Local Bike Shop', NULL, 1, 'Chicago');

select * from car;
select * from bike;
select * from dealership;
ALTER TABLE manufacturer
ADD COLUMN website VARCHAR(255);

select * from manufacturer;

-- Update the website for Toyota
UPDATE manufacturer
SET website = 'www.toyota.com'
WHERE manufacturer_name = 'Toyota';

-- Update the website for Honda
UPDATE manufacturer
SET website = 'www.honda.com'
WHERE manufacturer_name = 'Honda';

-- Update the website for Ford
UPDATE manufacturer
SET website = 'www.ford.com'
WHERE manufacturer_name = 'Ford';

-- Update the website for Harley-Davidson
UPDATE manufacturer
SET website = 'www.harley-davidson.com'
WHERE manufacturer_name = 'Harley-Davidson';

-- Update the website for BMW
UPDATE manufacturer
SET website = 'www.bmw.com'
WHERE manufacturer_name = 'BMW';

#change the price column in the car table
ALTER TABLE car
MODIFY price DECIMAL(15, 2);

#delete all cars from the car table that belong to the manufacturer named 'Toyota'
DELETE FROM car
WHERE manufacturer_id = (SELECT manufacturer_id FROM manufacturer WHERE manufacturer_name = 'Toyota');

#update the price of the car model 'Mustang' to 28000
UPDATE car
SET price = 28000.00 WHERE car_model = 'Mustang';

# update the website of all manufacturers located in Japan to 'www.japan-mfg.com'
UPDATE manufacturer
SET website = 'www.japan-mfg.com' WHERE country = 'Japan';

# find the total number of cars for each manufacturer in the car table
SELECT manufacturer_id, COUNT(*) AS num_cars FROM car GROUP BY manufacturer_id;

# calculate the average price of bikes for each bike type in the bike table
SELECT bike_type, AVG(price) AS average_price FROM bike GROUP BY bike_type;

# retrieve all car models from the car table where the car model name starts with the letter 'C'
SELECT car_model FROM car WHERE car_model LIKE 'C%';

# find all records from the manufacturer table where the manufacturer name contains the word 'Harley'
SELECT * FROM manufacturer WHERE manufacturer_name LIKE '%Harley%';

# retrieve the car model and manufacturer name for each car using a join between the car and manufacturer tables
SELECT car.car_model, manufacturer.manufacturer_name
FROM car
JOIN manufacturer ON car.manufacturer_id = manufacturer.manufacturer_id;

# retrieve the bike model and dealership name using a join between the bike and dealership tables
SELECT bike.bike_model, dealership.dealership_name
FROM bike
JOIN dealership ON bike.bike_id = dealership.bike_id;

# retrieve the bike model, dealership name, and location using a join between the bike and dealership tables
SELECT bike.bike_model, dealership.dealership_name, dealership.location
FROM bike
JOIN dealership ON bike.bike_id = dealership.bike_id;
