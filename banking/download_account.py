import os

import duckdb

ACCOUNTS_CSV_URL = os.environ.get("ACCOUNTS_CSV_URL")
if ACCOUNTS_CSV_URL is None:
    raise ValueError("ACCOUNTS_CSV_URL is not set")

conn = duckdb.connect("/app/lending.duckdb")
conn.execute("INSTALL httpfs;")
conn.execute("LOAD httpfs;")
conn.execute(
    f"""
        CREATE OR REPLACE TABLE accounts_raw AS
        SELECT *
        FROM read_csv(
            '{ACCOUNTS_CSV_URL}',
            columns = {{
                'AccountID': 'VARCHAR',
                'CustomerID': 'VARCHAR',
                'Balance': 'VARCHAR',
                'AccountType': 'VARCHAR'
            }},
            header = true
        )
    """
)
