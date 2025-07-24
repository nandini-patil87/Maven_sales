SELECT * FROM sale.mavenmarket_products;

describe mavenmarket_products;

UPDATE MavenMarket_Products
SET recyclable = CASE
    WHEN recyclable = '1' THEN 'Yes'
    ELSE 'No'
END,
low_fat = CASE
    WHEN low_fat = '1' THEN 'Yes'
    ELSE 'No'
END;

ALTER TABLE MavenMarket_Products
CHANGE COLUMN product_sku product_code VARCHAR(255);

SELECT 
    product_id,
    product_name,
    product_retail_price
FROM MavenMarket_Products
ORDER BY product_retail_price DESC
LIMIT 10;

SELECT 
    product_name,
    product_brand,
    product_retail_price,
    RANK() OVER (PARTITION BY product_brand ORDER BY product_retail_price DESC) AS price_rank
FROM MavenMarket_Products;


CREATE VIEW prod_info as
select
    product_id,
    product_name,
    product_retail_price,
    product_cost,
    ceil((product_retail_price - product_cost)) AS profit
FROM MavenMarket_Products;

select * from prod_info;

SELECT COUNT(*) AS recyclable_count
FROM MavenMarket_Products
WHERE recyclable = 'Yes';

SELECT COUNT(*) AS low_fat_count
FROM MavenMarket_Products
WHERE low_fat = 'Yes';

SELECT 
    product_brand,
    COUNT(*) AS product_count
FROM MavenMarket_Products
GROUP BY product_brand
ORDER BY product_count DESC;



