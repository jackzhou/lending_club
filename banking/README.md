# LendingClub dbt Pipeline Assignment

## Overview

This project implements a data pipeline for interest calculation in a banking system, built on:

- **DuckDB** — analytical database
- **dbt** — transformations and tests
- **Dagster** — orchestration

The pipeline processes customer and account data, applies data cleaning, and calculates interest for savings accounts.

For assumptions, trade-offs, and design decisions, see **REVIEWER_NOTES.md**.

---

## Prerequisites

- **Docker** — Install [Docker Desktop](https://docs.docker.com/get-docker/) (or Docker Engine on Linux).
- **Python 3.11** — The `lending-dbt` image is based on `python:3.11-slim`; use 3.11 for any host-side tooling if needed.
- **Environment file** — Copy `env` to `.env` (`cp env .env`), then fill in values:
  - **Download (S3 / HTTP):** set `ACCOUNTS_CSV_URL` to the public HTTPS URL for `accounts.csv` (the sample `env` includes the assignment URL).
  - **Upload to Databricks:** set `DATABRICKS_HOST`, `DATABRICKS_TOKEN`, and `DBFS_PATH` so the summary can be copied to a DBFS path in your workspace (see comments in `env`).

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
or for a clean build:
```bash
docker build --no-cache -t lending-dbt .
```

### Run pipeline

```bash
docker run --rm -p 3000:3000 -v "$(pwd)":/app --env-file .env lending-dbt
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

