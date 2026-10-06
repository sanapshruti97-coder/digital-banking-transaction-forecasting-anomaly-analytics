"""Reusable feature engineering helpers for Project 2."""
import pandas as pd

def aggregate_daily(df: pd.DataFrame) -> pd.DataFrame:
    data = df.copy()
    data["transaction_timestamp"] = pd.to_datetime(data["transaction_timestamp"])
    data["transaction_date"] = data["transaction_timestamp"].dt.floor("D")
    daily = data.groupby("transaction_date").agg(
        transaction_count=("transaction_id", "count"),
        total_transaction_value_inr=("transaction_amount_inr", "sum"),
        avg_transaction_value_inr=("transaction_amount_inr", "mean"),
        failed_transactions=("status", lambda s: (s == "Failed").sum()),
        unique_customers=("customer_id", "nunique"),
    ).reset_index()
    daily["failure_rate_pct"] = 100 * daily["failed_transactions"] / daily["transaction_count"]
    return daily

def make_forecast_features(daily: pd.DataFrame) -> pd.DataFrame:
    f = daily[["transaction_date", "total_transaction_value_inr"]].copy()
    f["day_of_week"] = f["transaction_date"].dt.dayofweek
    f["month"] = f["transaction_date"].dt.month
    f["day_of_month"] = f["transaction_date"].dt.day
    for lag in [1, 7, 14, 28]:
        f[f"lag_{lag}"] = f["total_transaction_value_inr"].shift(lag)
    f["rolling_mean_7"] = f["total_transaction_value_inr"].shift(1).rolling(7).mean()
    f["rolling_mean_28"] = f["total_transaction_value_inr"].shift(1).rolling(28).mean()
    f["rolling_std_28"] = f["total_transaction_value_inr"].shift(1).rolling(28).std()
    return f.dropna().reset_index(drop=True)
