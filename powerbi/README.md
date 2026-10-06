# Power BI Build Guide

A genuine `.pbix` must be created in Power BI Desktop. This folder intentionally contains the build guide rather than a fake `.pbix`.

## Load these files
1. `../data/processed/daily_transaction_metrics.csv`
2. `../data/processed/forecast_test_results.csv`
3. `../data/raw/digital_banking_transactions.csv` for channel/type/city visuals

## Recommended pages
### 1. Executive Overview
KPI cards: Total Transaction Value, Transactions, Unique Customers, Average Transaction Value, Failure Rate. Add a daily value line chart and channel/type breakdowns.

### 2. Forecast Performance
Line chart with Actual vs Predicted Total Transaction Value. Cards for MAE, RMSE, and R² can be taken from `model_comparison.csv` or recreated as measures. Add forecast error by date.

### 3. Anomaly Monitoring
Filter `anomaly_flag = 1`. Show date, anomaly score, transaction count, total value, average value, and failure rate. Add a daily trend with anomaly markers.

### 4. Transaction Mix
Use the raw transaction file for Channel, Transaction Type, City, Status, and date slicers.

## Suggested DAX
```DAX
Total Transaction Value = SUM(digital_banking_transactions[transaction_amount_inr])
Total Transactions = COUNTROWS(digital_banking_transactions)
Unique Customers = DISTINCTCOUNT(digital_banking_transactions[customer_id])
Average Transaction Value = AVERAGE(digital_banking_transactions[transaction_amount_inr])
Failed Transactions = CALCULATE([Total Transactions], digital_banking_transactions[status] = "Failed")
Failure Rate = DIVIDE([Failed Transactions], [Total Transactions], 0)
Anomaly Days = SUM(daily_transaction_metrics[anomaly_flag])
```

When completed, save the real report here as `Digital_Banking_Transaction_Forecasting_Anomaly_Analytics.pbix` and add dashboard screenshots under `reports/figures/`.
