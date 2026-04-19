import duckdb


conn = duckdb.connect("/app/lending.duckdb")
conn.execute("INSTALL httpfs;")
conn.execute("LOAD httpfs;")
conn.execute("""
        CREATE OR REPLACE TABLE accounts_raw AS
        SELECT *
        FROM read_csv(
            'https://lendingclub-assignment.s3.us-west-2.amazonaws.com/accounts.csv',
            columns = {
                'AccountID': 'VARCHAR',
                'CustomerID': 'VARCHAR',
                'Balance': 'VARCHAR',
                'AccountType': 'VARCHAR'
            },
            header = true
        )
    """)