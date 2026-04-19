import duckdb

def run_shell(db_path=":memory:"):
    conn = duckdb.connect(database=db_path)
    print("DuckDB Python Shell (type 'exit' to quit)")

    # conn.execute("INSTALL httpfs;")
    # conn.execute("LOAD httpfs;")

    # conn.execute("""
    #     CREATE OR REPLACE TABLE accounts_raw AS
    #     SELECT *
    #     FROM read_csv(
    #         'https://lendingclub-assignment.s3.us-west-2.amazonaws.com/accounts.csv',
    #         columns = {
    #             'AccountID': 'VARCHAR',
    #             'CustomerID': 'VARCHAR',
    #             'Balance': 'VARCHAR',
    #             'AccountType': 'VARCHAR'
    #         },
    #         header = true
    #     )
    # """)

    while True:
        try:
            query = input("duckdb> ").strip()

            if query.lower() in ("exit", "quit"):
                print("Bye!")
                break

            if not query:
                continue
            
            result = conn.execute(query)

            # Fetch results if it's a SELECT
            try:
                rows = result.fetchall()
                columns = [desc[0] for desc in result.description]

                # Print header
                print("\t".join(columns))

                # Print rows
                for row in rows:
                    print("\t".join(map(str, row)))

            except:
                # For non-SELECT (CREATE, INSERT, etc.)
                print("Query OK")

        except Exception as e:
            print(f"Error: {e}")

if __name__ == "__main__":
    run_shell("/Users/jinyuanzhou/work/lending_club/banking/lending.duckdb")  # or ":memory:"
