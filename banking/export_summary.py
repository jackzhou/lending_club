#! /user/bin/env python3
import duckdb

con = duckdb.connect("/app/lending.duckdb", read_only=True)
con.execute(
    """
    COPY (SELECT * FROM main.fct_account_summary)
    TO '/app/account_summary.csv' (HEADER true, DELIMITER ',')
    """
)
con.close()
