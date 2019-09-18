// question 1
SELECT *
FROM invoice i JOIN invoice_line il ON il.invoice_id = i.invoice_id
WHERE il.unit_price > 0.99;

// QUESTION 2 
SELECT i.invoice_date, c.first_name, c.last_name, i.total
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id

// QUESTION 3 

SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e ON  c.support_rep_id = e.employee_id

// QUESTION 4
SELECT al.title, ar.name
FROM album al
join artist ar ON al.artist_id = ar.artist_id

// QUESTION 5
SELECT pt.track_id
FROM playlist_track pt
JOIN playlist p ON p.playlist_id = pt.playlist_id
WHERE p.name = 'music';

// question 6
SELECT t.name
FROM track t
JOIN playlist_track pt ON pt.track_id = t.track_id 
WHERE pt.playlist_id = 5;

// question 7
SELECT t.name, p.name
FROM track t
JOIN playlist_track ON t.track_id = pt.track_id
JOIN playlist p ON pt.playlist_id = p.playlist_id

// QUESTION 8
SELECT t.name, a.title
FROM track t
JOIN album a ON t.album_id = a.album_id
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & punk'


// =========================NESTED QUERIES=========================

// QUESTION 1
SELECT * FROM invoice
WHERE invoice_id IN (SELECT invoice_id 
FROM invoice_line
WHERE unit_price > 0.99)

// QUESTION 2
SELECT * FROM playlist_track
WHERE playlist_id IN
(SELECT playlist_id FROM playlist
 WHERE name = 'Music');

//  QUESTION 3
SELECT name 
FROM track 
WHERE track_id IN (SELECT track_id FROM
playlist_track WHERE 
playlist_id =5)

// QUESTION 4
SELECT * FROM track
WHERE genre_id IN (SELECT genre_id FROM genre WHERE name ='Comedy');

// QUESTION 5
SELECT * FROM track
WHERE album_id IN (SELECT album_id FROM album WHERE name ='Fireball');

// question 6
SELECT * FROM track
WHERE album_id IN (
SELECT album_id FROM album WHERE 
 artist_id IN (SELECT artist_id FROM artist WHERE name='Queen')
  );

//   =============================UPDATING  ROWS============================

// QUESTION 1
UPDATE customer 
SET fax = null
WHERE fax IS NOT null

// QUESTION 2
UPDATE customer 
SET company ="self"
WHERE company IS null

// QUESTION 3
UPDATE customer
SET last_name ="Thompson"
WHERE last_name ="Julia" AND last_name = "Barnett"

// QUESTION 4
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl'

// QUESTION 5
UPDATE track
SET composer = "The darkness around us"
WHERE genre_id =(Select genre_id FROM genre WHERE name = 'Metal')
AND composer IS null


// ====================== GROUP BY======================

// QUESTION 1
SELECT COUNT (*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;

// QUESTION 2
SELECT COUNT (*), g.name
FROM track t 
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = "Pop" OR g.name = "Rock"
GROUP BY g.name

// question 3
SELECT ar.name, COUNT(*)
FROM album al
JOIN artist ar ON ar.artist_id = al.artist_id
GROUP BY ar.name

// ========================USE DISTINCT==================================

// Question 1
SELECT DISTINCT composer
FROM track

//QUESTION 2
SELECT DISTINCT billing_postal_customer
FROM invoice

// QUESTION 3
SELECT DISTINCT company
FROM customer


=========================DELETE ROWS====================================
// QUESTION 1
DELETE FROM practice_delete
WHERE type = 'bronze'

//QUESTION 2
DELETE FROM practice_delete
WHERE type = 'silver'

//QUESTION 3
DELETE FROM practice_delete
WHERE value = 150;


==========================ECOMM WEBSTIE THING=========================
//1
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  name VARCHAR(250) NOT NULL,
  email VARCHAR(250) NOT NULL
  );
  CREATE TABLE products (
  product_id SERIAL PRIMARY KEY,
  name VARCHAR(250) NOT NULL,
  price NUMERIC 
  );
CREATE TABLE orders(
  order_id SERIAL PRIAMRY KEY
  product_id int,
  FORIEGN KEY (product_id) REFERENCE product_id(product_id)
)
INSERT INTO users
(email, name)
VALUES
('Madelyn', 'madelyn.arsenault@gmail.com'),
('Kevin', 'KevinIsAFratBoi@gmail.com'),
('trey', 'sk8boarderTreyFlip@gmail.com');

INSERT INTO products (price,name)
VALUES (0.99,'paper');
INSERT INTO products (price,name)
VALUES (1000,'T.V');
INSERT INTO products (price,name)
VALUES (1200,'Phone');

INSERT INTO orders (product_id)
VALUES
(1),
(2),
(3)

SELECT * product_id
FROM orders
WHERE product_id = 1;

SELECT * FROM orders

SELECT sum(price)
FROM products p
JOIN orders o ON o.product_id = p.product_id

ALTER TABLE users
ADD column order_id int REFERENCES orders(order_id);

UPDATE orders
SET order_id = user_id

SELECT * FROM users
WHERE order_id = 3

SELECT COUNT(*) FROM users
WHERE order_id = 3