
#!/bin/bash
#docker command
# Check if the file exists

python export_summary.py

if [ $? -ne 0 ]; then
    echo "Error: Failed to generate account_summary.csv"
    exit 1
fi


# Upload the file to the Databricks workspace
databricks fs cp --overwrite account_summary.csv $DBFS_PATH

# Check if the upload was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to upload account_summary.csv to Databricks"
    exit 1
fi

databricks fs ls  $DBFS_PATH
echo "account_summary.csv uploaded successfully to Databricks"
