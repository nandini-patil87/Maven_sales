SELECT * FROM sale.mavenmarket_transactions_1998;

SELECT * FROM MavenMarket_Transactions_1997 LIMIT 100;

-- Count Total Transactions
SELECT COUNT(*) AS total_transactions FROM MavenMarket_Transactions_1998;

-- Date Range of Transactions
SELECT 
  MIN(transaction_date) AS earliest_date, 
  MAX(transaction_date) AS latest_date
FROM MavenMarket_Transactions_1998;

-- Daily Sales Volume
SELECT 
    customer_id, SUM(quantity) AS total_purchased
FROM
    sale.mavenmarket_transactions_1998
GROUP BY customer_id
ORDER BY total_purchased DESC
LIMIT 5;

-- Distribution of Quantity Sold
SELECT quantity, COUNT(*) AS frequency
FROM MavenMarket_Transactions_1998
GROUP BY quantity
ORDER BY quantity;

-- Most Active Days (High Transaction Count)
SELECT transaction_date, COUNT(*) AS num_transactions
FROM MavenMarket_Transactions_1998
GROUP BY transaction_date
ORDER BY num_transactions DESC
LIMIT 10;

-- Transactions with High Quantities
SELECT * 
FROM MavenMarket_Transactions_1998
WHERE quantity > 10
ORDER BY quantity DESC;

-- Year-over-Year Sales Comparison (1997 vs 1998)
SELECT '1997' AS year, product_id, SUM(quantity) AS total_quantity
FROM MavenMarket_Transactions_1997
GROUP BY product_id

UNION ALL

SELECT '1998' AS year, product_id, SUM(quantity) AS total_quantity
FROM MavenMarket_Transactions_1998
GROUP BY product_id;


