SELECT * FROM sale.mavenmarket_stores;
ALTER TABLE MavenMarket_Stores
DROP COLUMN store_phone,
DROP COLUMN store_state,
DROP COLUMN store_street_address,
DROP COLUMN last_remodel_date,
DROP COLUMN total_sqft,
DROP COLUMN grocery_sqft,
DROP COLUMN store_name;

DESCRIBE MavenMarket_Stores;

SELECT store_city, COUNT(*) AS total_stores
FROM MavenMarket_Stores
GROUP BY store_city
ORDER BY total_stores DESC;

SELECT store_type, COUNT(*) AS total
FROM MavenMarket_Stores
GROUP BY store_type;

SELECT *
FROM MavenMarket_Stores
ORDER BY first_opened_date ASC
LIMIT 1;

SELECT *
FROM MavenMarket_Stores
ORDER BY first_opened_date DESC
LIMIT 1;

SELECT 
  SUM(CASE WHEN store_id IS NULL THEN 1 ELSE 0 END) AS null_store_id,
  SUM(CASE WHEN region_id IS NULL THEN 1 ELSE 0 END) AS null_region_id,
  SUM(CASE WHEN store_type IS NULL THEN 1 ELSE 0 END) AS null_store_type,
  SUM(CASE WHEN store_city IS NULL THEN 1 ELSE 0 END) AS null_store_city,
  SUM(CASE WHEN store_country IS NULL THEN 1 ELSE 0 END) AS null_store_country,
  SUM(CASE WHEN first_opened_date IS NULL THEN 1 ELSE 0 END) AS null_first_opened_date
FROM MavenMarket_Stores;

SELECT store_id, region_id, store_type, store_city, store_country, first_opened_date, COUNT(*) AS count
FROM MavenMarket_Stores
GROUP BY store_id, region_id, store_type, store_city, store_country, first_opened_date
HAVING COUNT(*) > 1;

-- product performane by store
 SELECT 
    s.store_id,
    p.product_name,
    SUM(t.quantity) AS total_quantity_sold
FROM MavenMarket_Transactions_1998 t
JOIN MavenMarket_Stores s ON t.store_id = s.store_id
JOIN MavenMarket_Products p ON t.product_id = p.product_id
GROUP BY s.store_id, p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 15;

-- Total Sales by Store Location
SELECT 
    s.store_id,
    s.store_city,
    SUM(t.quantity) AS total_quantity
FROM MavenMarket_Transactions_1997 t
JOIN MavenMarket_Stores s ON t.store_id = s.store_id
GROUP BY s.store_id, s.store_city
ORDER BY total_quantity DESC;

