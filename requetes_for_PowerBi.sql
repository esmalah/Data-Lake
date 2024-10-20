//vente par client
SELECT 
    c.firstname, c.lastname, SUM(f.quantity) as total_achats from
    fait_orders f
JOIN 
    dim_customers c ON f.customer_id = c.customerkey
    GROUP BY 
    c.firstname, c.lastname;

//ventes par produit 
SELECT b.model, SUM(f.quantity) as total_ventes
FROM fait_orders f
JOIN dim_bikes b ON f.product_id = b.bikeid
GROUP BY b.model;
//ventes total_ventes
SELECT SUM(o.quantity) as total_ventes
FROM orders o;

//ventes par date 
SELECT 
    TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(f.order_date, 'd/M/yyyy'))) as order_date,
    SUM(f.quantity) as total_ventes
FROM fait_orders f
GROUP BY TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(f.order_date, 'd/M/yyyy')));

//valeur_vie_client
SELECT 
    c.FirstName, 
    c.LastName, 
    SUM(f.quantity * b.price) as valeur_vie_client
FROM 
    fait_orders f
JOIN 
    dim_customers c ON f.customer_id = c.CustomerKey
JOIN 
    dim_bikes b ON f.product_id = b.bike_id
GROUP BY 
    c.FirstName, c.LastName;

//taux_retention clients actifs et client perdus
WITH orders_before_2013 AS (
    SELECT customer_id
    FROM fait_orders
    WHERE TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(order_date, 'd/M/yyyy'))) < '2013-01-01'
),
orders_after_2013 AS (
    SELECT customer_id
    FROM fait_orders
    WHERE TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(order_date, 'd/M/yyyy'))) >= '2013-01-01'
)

INSERT OVERWRITE DIRECTORY '/user/cloudera/data/taux_retention'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
SELECT 
    COUNT(DISTINCT c.CustomerKey) as total_clients,
    COUNT(DISTINCT CASE 
        WHEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(f.order_date, 'd/M/yyyy'))) >= '2015-01-01' 
        THEN c.CustomerKey END) as clients_actifs,
    COUNT(DISTINCT CASE 
        WHEN o.customer_id IS NOT NULL AND oa.customer_id IS NULL 
        THEN o.customer_id END) as clients_perdus
FROM 
    orders_before_2013 o
LEFT JOIN orders_after_2013 oa ON o.customer_id = oa.customer_id
JOIN dim_customers c ON o.customer_id = c.CustomerKey
LEFT JOIN fait_orders f ON f.customer_id = o.customer_id;


