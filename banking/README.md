# LendingClub dbt Pipeline Assignment

## Overview

This project implements a data pipeline for a inerest calcuation banking system built on:

- **DuckDB** — analytical database
- **dbt** — transformations and tests
- **Dagster** — orchestration


The pipeline processes customer and account data, applies data cleaning, and calculates interest for savings accounts.

For assumptions, trade-offs, and design decisions, see **REVIEWER_NOTES.md**.

---

## Pipeline Architecture

1. Load raw data
  ↓
2. Clean up and standardize the data
  ↓
3. **Calculate interest**
  ↓
4. Export data





## How to Run

### Build Docker image

```bash
docker build -t lending-dbt .
```

### Run pipeline

```bash
docker run --rm -p 3000:3000 -e DATABRICKS_HOST -e DATABRICKS_TOKEN  -v $(pwd):/app lending-dbt # dagster piple run 
```

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