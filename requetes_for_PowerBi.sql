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

//CA Total
SELECT SUM(o.quantity) as total_ventes
FROM orders o;

//CA par year
SELECT  
YEAR(TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(f.order_date, 'M/d/yyyy')))) as year,  
SUM(f.quantity * b.price) as total_CA 
FROM  
fait_orders f 
JOIN  
dim_bikes b ON f.product_id = b.bikeid 
GROUP BY  
YEAR(TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(f.order_date, 'M/d/yyyy')))) 
ORDER BY  
year 

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
//New Clients
SELECT  
c.customerkey,  
c.firstname,  
c.lastname,  
MAX(f.order_date) as last_order_date 
FROM  
fait_orders f 
JOIN  
dim_customers c ON f.customer_id = c.customerkey 
GROUP BY  
c.customerkey, c.firstname, c.lastname 
HAVING  
TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(MAX(f.order_date), 'M/d/yyyy'))) > '2015-01-01'

//Lost Clients
SELECT  
c.customerkey,  
c.firstname,  
c.lastname,  
MAX(f.order_date) as last_order_date 
FROM  
fait_orders f 
JOIN  
dim_customers c ON f.customer_id = c.customerkey 
GROUP BY  
c.customerkey, c.firstname, c.lastname 
HAVING  
TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(MAX(f.order_date), 'M/d/yyyy'))) > '2015-01-01'
