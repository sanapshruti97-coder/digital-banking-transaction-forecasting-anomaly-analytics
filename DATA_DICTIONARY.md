# Data Dictionary

## Raw dataset — `digital_banking_transactions.csv`
| Column | Type | Description |
|---|---|---|
| transaction_id | string | Synthetic unique transaction identifier |
| customer_id | string | Synthetic customer identifier |
| transaction_timestamp | datetime | Date and time of transaction |
| transaction_amount_inr | decimal | Transaction amount in INR |
| city | string | Synthetic customer/transaction city |
| channel | string | Mobile App, Internet Banking, UPI, or ATM |
| transaction_type | string | Transfer, Bill Payment, Merchant Payment, Recharge, or Loan/EMI Payment |
| status | string | Success or Failed |

## Processed daily metrics
`daily_transaction_metrics.csv` contains transaction count, total/average value, failed transactions, unique customers, failure rate, Isolation Forest anomaly flag, and anomaly score by date.

## Forecast results
`forecast_test_results.csv` contains actual daily value, predicted daily value from the best test-set model, and absolute forecast error for the chronological test period.

## Model comparison
`model_comparison.csv` contains MAE, RMSE, and R² for the seasonal-naive baseline, Random Forest, and Gradient Boosting models.

## Anomaly days
`anomaly_days.csv` is the subset of daily metrics flagged by Isolation Forest. A flag indicates unusual behavior, not confirmed fraud.
