# 🏦 Bank Fraud Detection Analysis Project

## 📌 Project Overview

This project focuses on analyzing banking transactions to identify fraudulent activities and understand customer transaction behavior.

The objective is to analyze transaction patterns, detect fraud trends, identify high-risk customers, and create an interactive dashboard to support fraud monitoring and decision-making.

---

# 🎯 Business Problem

Banks process millions of transactions every day. Detecting fraudulent transactions quickly is important to reduce financial losses and improve customer security.

This project answers key business questions:

* How many fraudulent transactions occurred?
* What is the total fraud amount?
* Which customers are involved in fraudulent activities?
* Which transaction types have higher fraud risk?
* What are the monthly fraud trends?
* Which locations generate more fraudulent transactions?

---

# 🛠️ Tools & Technologies Used

| Tool     | Purpose                                             |
| -------- | --------------------------------------------------- |
| SQL      | Data analysis, fraud investigation, KPI calculation |
| Python   | Data cleaning and exploratory analysis              |
| Pandas   | Data manipulation                                   |
| Power BI | Interactive dashboard creation                      |
| Excel    | preprocessing                   |

---

# 📂 Project Structure

```
Bank-Fraud-Detection
│
├── Dataset
│   └── fraud_sample.csv
│
├── SQL
│   └── fraud_queries.sql
│
├── Dashboard
│   └── Dashboard Screenshots
│
├── Report
│   └── Project_Report.pdf
│
└── README.md
```

---

# 📊 Dataset Description

The dataset contains banking transaction details including:

| Column             | Description                             |
| ------------------ | --------------------------------------- |
| transaction_id     | Unique transaction identifier           |
| customer_id        | Customer identification                 |
| transaction_date   | Date of transaction                     |
| transaction_amount | Transaction value                       |
| transaction_type   | Type of transaction                     |
| location           | Transaction location                    |
| is_fraud           | Fraud indicator (1 = Fraud, 0 = Normal) |

---

# 🔍 Data Analysis Process

## 1. Data Cleaning

Performed data preprocessing:

* Removed duplicate records
* Handled missing values
* Checked incorrect data types
* Validated transaction amounts
* Prepared clean dataset for analysis

## 2. SQL Analysis

Created SQL queries to analyze:

### Fraud Transaction Count

```sql
SELECT 
COUNT(*) AS total_fraud_transactions
FROM bank_transactions
WHERE is_fraud = 1;
```

### Total Fraud Amount

```sql
SELECT
SUM(transaction_amount) AS fraud_amount
FROM bank_transactions
WHERE is_fraud = 1;
```

### Customer Fraud Analysis

```sql
SELECT
customer_id,
COUNT(transaction_id) AS fraud_transactions,
SUM(transaction_amount) AS fraud_amount
FROM bank_transactions
WHERE is_fraud = 1
GROUP BY customer_id;
```

---

# 📈 Power BI Dashboard

The dashboard provides:

### Key Performance Indicators (KPIs)

* Total Transactions
* Fraud Transactions
* Fraud Amount
* Fraud Percentage

### Visualizations

* Fraud Trend Analysis
* Fraud Amount by Category
* High-Risk Customers
* Location-wise Fraud Analysis
* Transaction Pattern Analysis

## Dashboard Preview

(Add your dashboard screenshots here)

Example:

```
Dashboard
│
├── fraud_dashboard.png
└── fraud_analysis.png
```

---

# 📌 Key Insights

From the analysis:

* Identified fraudulent transaction patterns
* Found high-risk customers based on transaction behavior
* Analyzed fraud trends over time
* Identified transaction categories contributing to fraud
* Created monitoring dashboard for fraud investigation

---

# 🚀 Project Workflow

```
Raw Transaction Data

        ↓

Data Cleaning

        ↓

SQL Analysis

        ↓

Python Exploration

        ↓

Power BI Dashboard

        ↓

Business Insights
```

---

# 💡 Skills Demonstrated

✅ SQL Query Writing
✅ Data Cleaning
✅ Exploratory Data Analysis
✅ Business Intelligence Dashboard Development
✅ Fraud Pattern Analysis
✅ Data Visualization
✅ Problem Solving

---

# 👨‍💻 Author

KEERTHIVASAN S

Data Analyst | SQL | Python | Power BI | Pandas

---

# ⭐ Project Status

Completed ✅
