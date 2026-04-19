
#!/bin/bash
#docker command
# Check if the file exists

# echo "HOST: $DATABRICKS_HOST"
python export_summary.py

if [ $? -ne 0 ]; then
    echo "Error: Failed to generate account_summary.csv"
    exit 1
fi

if [ ! -f "account_summary.csv" ]; then
    echo "Error: account_summary.csv file not found"
    exit 1
fi

# Upload the file to the Databricks workspace
databricks fs cp --overwrite account_summary.csv dbfs:/Volumes/main/default/lending_club/output

# Check if the upload was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to upload account_summary.csv to Databricks"
    exit 1
fi

databricks fs ls  dbfs:/Volumes/main/default/lending_club/output
echo "account_summary.csv uploaded successfully to Databricks"
