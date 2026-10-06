# Digital Banking Transaction Forecasting & Anomaly Analytics

## Overview
An end-to-end data science project that analyzes **synthetic digital-banking transaction events**, forecasts daily transaction value, and identifies unusual transaction days for investigation. The project combines Python, SQL, time-series feature engineering, machine learning, anomaly detection, and Power BI-ready datasets.

> **Data note:** The raw dataset in this repository is fully synthetic and contains no real customer or bank information. It was generated for portfolio and learning purposes.

## Business Problem
Digital banking teams need to anticipate transaction demand and quickly identify unusual activity. This project addresses two questions:
1. Can historical transaction patterns be used to forecast daily transaction value?
2. Which days show unusual combinations of transaction volume, value, average ticket size, or failure rate?

## Dataset
- Period: **2024-01-01 to 2025-12-31**
- Raw transaction rows: **247,617**
- Daily observations: **731**
- Fields: transaction/customer IDs, timestamp, amount, city, channel, transaction type, and status
- Raw file: `data/raw/digital_banking_transactions.csv`

See `DATA_DICTIONARY.md` for field definitions.

## Project Structure
```text
digital-banking-transaction-forecasting-anomaly-analytics/
├── README.md
├── DATA_DICTIONARY.md
├── requirements.txt
├── .gitignore
├── data/
│   ├── raw/digital_banking_transactions.csv
│   └── processed/
│       ├── daily_transaction_metrics.csv
│       ├── forecast_test_results.csv
│       ├── model_comparison.csv
│       └── anomaly_days.csv
├── notebooks/digital_banking_transaction_forecasting_anomaly.ipynb
├── sql/analysis_queries.sql
├── powerbi/README.md
├── reports/figures/README.md
└── src/README.md
```

## Workflow
1. Validate and preprocess transaction-level data.
2. Aggregate daily transaction KPIs.
3. Explore trend, weekday effects, and transaction behavior.
4. Engineer **lag 1/7/14/28** and shifted rolling 7/28-day features.
5. Use a **chronological 80/20 split** to avoid random time-series leakage.
6. Compare a seasonal-naive baseline, Random Forest, and Gradient Boosting using MAE, RMSE, and R².
7. Apply **Isolation Forest** to daily KPIs for unsupervised anomaly detection.
8. Export forecast/anomaly/KPI tables for Power BI reporting.

## Forecasting Results
The generated dataset produced the following test-set comparison:

| model                  |    MAE |   RMSE |    R2 |
|:-----------------------|-------:|-------:|------:|
| Random Forest          | 223835 | 447681 | -0.25 |
| Seasonal Naive (Lag 7) | 189482 | 490438 | -0.49 |
| Gradient Boosting      | 254908 | 519351 | -0.68 |

Best RMSE in this generated run: **Random Forest**. These metrics describe this synthetic dataset only and should not be generalized to real banking behavior.

## Anomaly Analytics
Isolation Forest evaluates daily:
- transaction count
- total transaction value
- average transaction value
- transaction failure rate

The model flagged **19 of 731 days** as investigation candidates. An anomaly flag is **not a fraud label**; it indicates statistically unusual daily behavior that may warrant root-cause analysis.

## Power BI Dashboard Plan
Recommended pages:
- **Executive Overview:** total value, transactions, unique customers, failure rate, daily trend
- **Forecast Performance:** actual vs predicted value, MAE/RMSE/R², forecast errors
- **Anomaly Monitoring:** flagged days, anomaly score, value/volume/failure-rate context
- **Transaction Mix:** channel, transaction type, and city breakdowns

Use `daily_transaction_metrics.csv`, `forecast_test_results.csv`, and the raw/session-level transaction file as appropriate. See `powerbi/README.md`.

## Tech Stack
Python, Pandas, NumPy, Matplotlib, Scikit-learn, SQL, Power BI, Jupyter Notebook

## Skills Demonstrated
Time-series forecasting, lag/rolling feature engineering, chronological validation, regression model evaluation, anomaly detection, EDA, KPI development, SQL aggregation/window functions, and BI reporting.

## How to Run
```bash
pip install -r requirements.txt
```
Open `notebooks/digital_banking_transaction_forecasting_anomaly.ipynb` and run cells in order. Paths are relative to the notebook folder.

## Limitations
- Synthetic data is designed to demonstrate workflow and does not represent real bank customers.
- The forecasting horizon is one day ahead using historical daily features.
- Isolation Forest detects unusual patterns but cannot determine fraud or root cause.
- Real production forecasting would require stronger backtesting, external drivers, drift monitoring, and operational validation.

## Resume-Ready Description
**Digital Banking Transaction Forecasting & Anomaly Analytics** — Built an end-to-end analytics workflow on synthetic banking transactions using Python and SQL; engineered leakage-safe lag and rolling features, compared baseline and ensemble regression models using MAE/RMSE/R², applied Isolation Forest for anomaly detection, and prepared KPI/forecast datasets for Power BI reporting.
