-- Digital Banking Transaction Forecasting & Anomaly Analytics
-- SQL examples assume a table named digital_banking_transactions.

-- 1) Daily KPIs
SELECT CAST(transaction_timestamp AS DATE) AS transaction_date,
       COUNT(*) AS transaction_count,
       SUM(transaction_amount_inr) AS total_transaction_value_inr,
       AVG(transaction_amount_inr) AS avg_transaction_value_inr,
       COUNT(DISTINCT customer_id) AS unique_customers,
       100.0 * SUM(CASE WHEN status = 'Failed' THEN 1 ELSE 0 END) / COUNT(*) AS failure_rate_pct
FROM digital_banking_transactions
GROUP BY CAST(transaction_timestamp AS DATE)
ORDER BY transaction_date;

-- 2) Channel performance
SELECT channel, COUNT(*) AS transactions, SUM(transaction_amount_inr) AS total_value_inr,
       AVG(transaction_amount_inr) AS avg_value_inr,
       100.0 * SUM(CASE WHEN status='Failed' THEN 1 ELSE 0 END) / COUNT(*) AS failure_rate_pct
FROM digital_banking_transactions
GROUP BY channel ORDER BY total_value_inr DESC;

-- 3) 7-day rolling transaction value (PostgreSQL/DuckDB-style)
WITH daily AS (
  SELECT CAST(transaction_timestamp AS DATE) AS transaction_date,
         SUM(transaction_amount_inr) AS total_value_inr
  FROM digital_banking_transactions
  GROUP BY 1
)
SELECT transaction_date, total_value_inr,
       AVG(total_value_inr) OVER (ORDER BY transaction_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS rolling_7d_avg
FROM daily ORDER BY transaction_date;

-- 4) City-level monitoring
SELECT city, COUNT(*) AS transactions, SUM(transaction_amount_inr) AS total_value_inr,
       COUNT(DISTINCT customer_id) AS unique_customers
FROM digital_banking_transactions
GROUP BY city ORDER BY total_value_inr DESC;
