-- Nettoyage de la table orders
CREATE TABLE fait_orders AS
SELECT DISTINCT * 
FROM orders
WHERE order_id IS NOT NULL 
  AND customer_id IS NOT NULL
  AND product_id IS NOT NULL
  AND quantity > 0
  AND TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(order_date, 'd/M/yyyy'))) IS NOT NULL;

-- Nettoyage de la table customers
CREATE TABLE customers AS
SELECT DISTINCT * 
FROM customers
WHERE CustomerKey IS NOT NULL 
  AND FirstName IS NOT NULL 
  AND LastName IS NOT NULL;

-- Nettoyage de la table bikes
CREATE TABLE dim_bikes AS
SELECT DISTINCT * 
FROM bikes
WHERE bike_id IS NOT NULL 
  AND price > 0;

-- Nettoyage de la table dim_bikeshops
CREATE TABLE dim_bikeshops AS
SELECT DISTINCT * 
FROM bikeshops
WHERE bikeshop_id IS NOT NULL 
  AND bikeshop.name IS NOT NULL
  AND bikeshop.city IS NOT NULL;
