# LendingClub dbt Pipeline Assignment

## Overview

This project implements a data pipeline for a banking system using:

- dbt (data transformation)
- DuckDB (analytical database)
- Docker (reproducibility)

The pipeline processes customer and account data, applies data cleaning, and calculates interest for savings accounts.

---

## Pipeline Architecture

CSV (seeds)
  ↓
Staging (data cleaning & normalization)
  ↓
Mart (business logic: interest calculation)

---

## Key Features

- Data cleaning:
  - Trim whitespace
  - Normalize casing
  - Handle malformed values using `TRY_CAST`
- Data validation:
  - Filter invalid AccountID and CustomerID
- Business logic:
  - Tiered interest rates
  - Bonus rate for customers with loans
- Reusable macro:
  - `interest_rate_calc`

---

## Interest Rules

- Balance < 10,000 → 1%
- 10,000 ≤ Balance < 20,000 → 1.5%
- Balance ≥ 20,000 → 2%
- Bonus: +0.5% if customer has a loan

---

## Handling Bad Data

- Malformed or missing balance → treated as NULL
- Interest rate defaults to 0 for NULL balance
- Derived values remain NULL to preserve correctness

---

## How to Run

### Build Docker image

```bash
docker build -t lending-dbt .
```

### Run pipeline

```bash
docker run --rm -v $(pwd):/app lending-dbt dbt test
docker run --rm -v $(pwd):/app lending-dbt dbt run
```

---

## Output

Final table:

fct_account_summary

Fields:

- customer_id
- account_id
- original_balance
- interest_rate_applied
- annual_interest_amount
- new_balance

---

## Notes

- DuckDB stores data in a single file (`lending.duckdb`)
- dbt seeds are used as the raw data layer
- Staging models enforce data quality
- Mart model applies business logic

---

## Author

Jinyuan Zhou