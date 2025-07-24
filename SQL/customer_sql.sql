SELECT * FROM sale.mavenmarket_customers;

ALTER TABLE MavenMarket_Customers
DROP COLUMN customer_state_province,
DROP COLUMN customer_postal_code,
DROP COLUMN yearly_income,
DROP COLUMN num_children_at_home,
DROP COLUMN homeowner,
DROP COLUMN education,
DROP COLUMN acct_open_date,
DROP COLUMN occupation;

ALTER TABLE MavenMarket_Customers
DROP COLUMN full_name;

ALTER TABLE MavenMarket_Customers
ADD COLUMN full_name VARCHAR(100) AFTER last_name;

UPDATE MavenMarket_Customers
SET full_name = CONCAT(first_name, ' ', last_name);

ALTER TABLE MavenMarket_Customers
ADD COLUMN age INT AFTER birthdate;

SELECT 
  customer_id,
  full_name,
  birthdate,
  TIMESTAMPDIFF(
      YEAR,
      STR_TO_DATE(birthdate, '%m/%d/%Y'),
      CURDATE()
  ) AS age
FROM MavenMarket_Customers;

UPDATE MavenMarket_Customers
SET age = TIMESTAMPDIFF(
    YEAR,
    STR_TO_DATE(birthdate, '%m/%d/%Y'),
    CURDATE()
);

UPDATE MavenMarket_Customers
SET marital_status = CASE 
    WHEN marital_status = 'M' THEN 'Married'
    WHEN marital_status = 'S' THEN 'Single'
    ELSE marital_status
END;

UPDATE MavenMarket_Customers
SET gender = CASE 
    WHEN gender = 'M' THEN 'Male'
    WHEN gender = 'F' THEN 'Female'
    ELSE gender
END;

describe mavenmarket_customers;

ALTER TABLE MavenMarket_Customers
ADD COLUMN birthdate_converted DATE;

UPDATE MavenMarket_Customers
SET birthdate_converted = STR_TO_DATE(birthdate, '%m/%d/%Y');

ALTER TABLE MavenMarket_Customers
DROP COLUMN birthdate;

ALTER TABLE MavenMarket_Customers
CHANGE COLUMN birthdate_converted birthdate DATE;

ALTER TABLE MavenMarket_Customers
CHANGE COLUMN customer_acct_num account_number bigint;

SELECT 
  full_name,  account_number,
  COUNT(*) AS count
FROM MavenMarket_Customers
GROUP BY full_name, account_number
HAVING COUNT(*) > 1;

SELECT
  SUM(customer_id IS NULL) AS null_customer_id,
  SUM(account_number IS NULL) AS null_account_number,
  SUM(first_name IS NULL) AS null_first_name,
  SUM(last_name IS NULL) AS null_last_name,
  SUM(customer_address IS NULL) AS null_address,
  SUM(customer_city IS NULL) AS null_city,
  SUM(customer_country IS NULL) AS null_country,
  SUM(birthdate IS NULL) AS null_birthdate,
  SUM(marital_status IS NULL) AS null_marital_status,
  SUM(gender IS NULL) AS null_gender,
  SUM(total_children IS NULL) AS null_total_children,
  SUM(member_card IS NULL) AS null_member_card
FROM MavenMarket_Customers;

-- DATA EXPLORATION AND FILTERING
SELECT DISTINCT gender FROM MavenMarket_Customers;
SELECT DISTINCT marital_status FROM MavenMarket_Customers;
SELECT DISTINCT member_card FROM MavenMarket_Customers;

SELECT customer_city, COUNT(*) AS customer_count
FROM MavenMarket_Customers
GROUP BY customer_city
ORDER BY customer_count DESC
LIMIT 5;

SELECT 
  member_card, 
  CAST(AVG(age) AS UNSIGNED) AS avg_age
FROM MavenMarket_Customers
GROUP BY member_card
HAVING CAST(AVG(age) AS UNSIGNED) > 45;

SELECT *
FROM MavenMarket_Customers
WHERE age > (SELECT AVG(age) FROM MavenMarket_Customers);




