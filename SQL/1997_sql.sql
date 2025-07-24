SELECT * FROM sale.mavenmarket_transactions_1997;

SELECT * FROM MavenMarket_Transactions_1997 LIMIT 100;

-- Count Total Transactions
SELECT COUNT(*) AS total_transactions FROM MavenMarket_Transactions_1997;

-- Date Range of Transactions
SELECT 
  MIN(transaction_date) AS earliest_date, 
  MAX(transaction_date) AS latest_date
FROM MavenMarket_Transactions_1997;

-- Daily Sales Volume
SELECT 
    customer_id, SUM(quantity) AS total_purchased
FROM
    sale.mavenmarket_transactions_1997
GROUP BY customer_id
ORDER BY total_purchased DESC
LIMIT 5;

-- Distribution of Quantity Sold
SELECT quantity, COUNT(*) AS frequency
FROM MavenMarket_Transactions_1997
GROUP BY quantity
ORDER BY quantity;

-- Most Active Days (High Transaction Count)
SELECT transaction_date, COUNT(*) AS num_transactions
FROM MavenMarket_Transactions_1997
GROUP BY transaction_date
ORDER BY num_transactions DESC
LIMIT 10;

-- Transactions with High Quantities
SELECT * 
FROM MavenMarket_Transactions_1997
WHERE quantity > 10
ORDER BY quantity DESC;

-- Top-Selling Products (1997 + 1998) by Quantity

SELECT 
    p.product_name,
    SUM(t.quantity) AS total_quantity_sold
FROM MavenMarket_Products p
JOIN (
    SELECT * FROM MavenMarket_Transactions_1997
    UNION ALL
    SELECT * FROM MavenMarket_Transactions_1998
) t ON p.product_id = t.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 10;

-- Total Sales by Product Name (1997)
SELECT 
    p.product_name,
    SUM(t.quantity) AS total_quantity_sold
FROM MavenMarket_Transactions_1997 t
JOIN MavenMarket_Products p ON t.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC;

-- Customer Demographics vs Purchase
SELECT 
    c.gender,
    SUM(t.quantity) AS total_quantity
FROM MavenMarket_Transactions_1997 t
JOIN MavenMarket_Customers c ON t.customer_id = c.customer_id
GROUP BY c.gender
ORDER BY total_quantity DESC;







