CREATE TABLE bank_transactions
(
    transaction_id VARCHAR(50),
    customer_id VARCHAR(50),
    transaction_date DATE,
    transaction_time TIME,
    hour_of_day INT,
    is_weekend INT,
    is_night_transaction INT,
    country VARCHAR(50),
    city VARCHAR(50),
    merchant_category VARCHAR(50),
    payment_method VARCHAR(50),
    device_type VARCHAR(50),
    customer_age INT,
    credit_score INT,
    account_age_years FLOAT,
    account_balance FLOAT,
    transaction_amount FLOAT,
    num_prev_transactions INT,
    transaction_freq_monthly INT,
    distance_from_home_km FLOAT,
    time_since_last_txn_hrs FLOAT,
    is_international INT,
    failed_attempts INT,
    pin_changed_recently INT,
    is_fraud INT,
    fraud_type VARCHAR(50),

    PRIMARY KEY (transaction_id, customer_id)
);


SELECT * FROM bank_transactions
LIMIT 5;

-- Check NULL Values
	
SELECT
COUNT(*) AS total_rows,
SUM(CASE WHEN transaction_id IS NULL THEN 1 ELSE 0 END) transaction_null,
SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) customer_null,
SUM(CASE WHEN transaction_amount IS NULL THEN 1 ELSE 0 END) amount_null,
SUM(CASE WHEN payment_method IS NULL THEN 1 ELSE 0 END) payment_null
FROM bank_transactions;


SELECT
transaction_id,
COUNT(*) AS duplicate_count
FROM bank_transactions
GROUP BY transaction_id
HAVING COUNT(*) > 1;


-- Total Transactions

SELECT
COUNT(*) AS total_transactions
FROM bank_transactions;


-- Total Fraud Transactions

SELECT
COUNT(*) AS fraud_transactions
FROM bank_transactions
WHERE is_fraud = 1;


SELECT

CASE
WHEN is_fraud=1 THEN 'Fraud'
ELSE 'Normal'
END AS transaction_status,

COUNT(*) total_transactions

FROM bank_transactions

GROUP BY is_fraud;


-- Fraud Amount by Category
SELECT

fraud_type,

COUNT(transaction_id) fraud_transactions,

SUM(transaction_amount) fraud_amount

FROM bank_transactions

WHERE is_fraud=1

GROUP BY fraud_type

ORDER BY fraud_amount DESC;


-- Payment Method

SELECT

payment_method,

COUNT(*) total_transactions,

SUM(CASE WHEN is_fraud=1 THEN 1 ELSE 0 END)
AS fraud_count,

SUM(
CASE WHEN is_fraud=1
THEN transaction_amount
ELSE 0
END
)
AS fraud_amount


FROM bank_transactions

GROUP BY payment_method

ORDER BY fraud_amount DESC;

-- High Risk Payment Methods


SELECT

payment_method,

ROUND(
SUM(CASE WHEN is_fraud=1 THEN 1 ELSE 0 END)
*100.0/
COUNT(*),
2
)
AS fraud_percentage


FROM bank_transactions

GROUP BY payment_method

HAVING
COUNT(*) > 100

ORDER BY fraud_percentage DESC;

-- Monthly Fraud Trend

SELECT

DATE_TRUNC('month',transaction_date)
AS month_trend,

COUNT(*) total_transactions,

SUM(
CASE WHEN is_fraud=1
THEN 1 ELSE 0 END
)
AS fraud_transactions


FROM bank_transactions

GROUP BY month_trend

ORDER BY month_trend;

-- Monthly Fraud Amount Trend

SELECT

DATE_TRUNC('month',transaction_date)
AS month,

SUM(transaction_amount)
AS fraud_amount


FROM bank_transactions

WHERE is_fraud=1

GROUP BY month

ORDER BY month;

-- Top Fraud Cities

SELECT

city,

COUNT(*) fraud_count,

SUM(transaction_amount)
fraud_amount


FROM bank_transactions

WHERE is_fraud=1


GROUP BY city


ORDER BY fraud_amount DESC

LIMIT 10;


-- Customer Fraud Ranking

SELECT

customer_id,

COUNT(*) fraud_transactions,

SUM(transaction_amount) fraud_amount,


RANK() OVER
(
ORDER BY SUM(transaction_amount) DESC
)
AS fraud_rank


FROM bank_transactions


WHERE is_fraud=1


GROUP BY customer_id;


-- Customer Transaction Behavior

SELECT

customer_id,

COUNT(transaction_id)
total_transactions,

AVG(transaction_amount)
average_transaction,


MAX(transaction_amount)
maximum_transaction


FROM bank_transactions


GROUP BY customer_id;


-- Detect Suspicious Large Transactions

SELECT *

FROM bank_transactions

WHERE transaction_amount >

(
SELECT AVG(transaction_amount)
FROM bank_transactions
)

ORDER BY transaction_amount DESC;

-- Running Fraud Amount

SELECT

transaction_date,

transaction_amount,


SUM(transaction_amount)
OVER
(
ORDER BY transaction_date
)
AS running_amount


FROM bank_transactions


WHERE is_fraud=1;


-- MOM Fraud Growth


WITH monthly AS
(
SELECT

DATE_TRUNC('month',transaction_date) MOM,

SUM(transaction_amount) fraud_amount


FROM bank_transactions


WHERE is_fraud=1


GROUP BY MOM
)

SELECT

MOM,

fraud_amount,


LAG(fraud_amount)
OVER
(
ORDER BY MOM
)
previous_month,


fraud_amount -
LAG(fraud_amount)
OVER
(
ORDER BY MOM
)
growth

FROM monthly;
