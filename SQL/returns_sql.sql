SELECT * FROM sale.`mavenmarket_returns_1997-1998`;

SELECT store_id, SUM(quantity) AS total_returns
FROM `mavenmarket_returns_1997-1998`
GROUP BY store_id
ORDER BY total_returns DESC;

SELECT product_id, SUM(quantity) AS total_returned
FROM `mavenmarket_returns_1997-1998`
GROUP BY product_id
ORDER BY total_returned DESC
LIMIT 1;

SELECT 
    p.product_name,
    COUNT(*) AS return_count
FROM MavenMarket_Returns_1997_1998 r
JOIN MavenMarket_Products p ON p.product_id = p.product_id
GROUP BY p.product_name
ORDER BY return_count DESC;

-- Customer Return Rate
SELECT 
    c.customer_id,
    c.full_name,
    COUNT(DISTINCT CONCAT(r.product_id, r.store_id, r.return_date)) AS returns_made,
    COUNT(*) AS total_transactions,
    ROUND(COUNT(DISTINCT CONCAT(r.product_id, r.store_id, r.return_date)) / COUNT(*), 2) AS return_rate
FROM MavenMarket_Customers c
JOIN MavenMarket_Transactions_1997 t ON c.customer_id = t.customer_id
LEFT JOIN `MavenMarket_Returns_1997-1998` r 
    ON t.product_id = r.product_id 
    AND t.store_id = r.store_id
    AND t.transaction_date = r.return_date
GROUP BY c.customer_id, c.full_name
ORDER BY return_rate DESC;



