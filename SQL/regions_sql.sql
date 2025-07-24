SELECT * FROM sale.mavenmarket_regions;

CREATE VIEW vw_distinct_sales_districts AS
SELECT DISTINCT sales_district
FROM MavenMarket_Regions;

SELECT * FROM vw_distinct_sales_districts;

CREATE VIEW vw_distinct_sales_regions AS
SELECT DISTINCT sales_region
FROM MavenMarket_Regions;

SELECT * FROM vw_distinct_sales_regions;

-- total sales by region
SELECT 
 r.sales_region,
    CAST(CEIL(SUM(t.quantity * p.product_retail_price)) AS UNSIGNED) AS total_sales
FROM MavenMarket_Transactions_1997 t
JOIN MavenMarket_Stores s ON t.store_id = s.store_id
JOIN MavenMarket_Regions r ON s.region_id = r.region_id
JOIN MavenMarket_Products p ON t.product_id = p.product_id
GROUP BY r.sales_region
ORDER BY total_sales DESC;

