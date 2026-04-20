# LendingClub dbt Pipeline Assignment

## Overview

This project implements a data pipeline for interest calculation in a banking system, built on:

- **DuckDB** — analytical database
- **dbt** — transformations and tests
- **Dagster** — orchestration

The pipeline processes customer and account data, applies data cleaning, and calculates interest for savings accounts.

For assumptions, trade-offs, and design decisions, see **REVIEWER_NOTES.md**.

The result file account_summary.csv is include

There is a also a ppt file : Account Summary .ppt

---

## Prerequisites

- **Docker** — Install [Docker Desktop](https://docs.docker.com/get-docker/) (or Docker Engine on Linux).
- **Python 3.11** — The `lending-dbt` image is based on `python:3.11-slim`; use 3.11 for any host-side tooling if needed.
  - do this in the banking folder: python3.11 -m venv .venv
- **Environment file** — Copy `env` to `.env`, then fill in values:
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

From the `banking/` directory (same folder as the `Dockerfile`). The container starts **Dagster dev** on port **3000** (see image `CMD`).

**Without a bind mount** — runs the project files that were **copied into the image at build time**:

```bash
docker run --rm -p 3000:3000 --env-file .env lending-dbt
```

**With a bind mount** — mounts your **current directory** to `/app` so local edits to SQL, Python, and `lending.duckdb` show up without rebuilding (useful while debugging):

```bash
docker run --rm -p 3000:3000 -v "$(pwd):/app" --env-file .env lending-dbt
```

Then open **[http://localhost:3000](http://localhost:3000)** in a browser.

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

