from dagster import op, job, In, Nothing, in_process_executor, get_dagster_logger
import subprocess
from time import sleep

logger = get_dagster_logger()

def run(cmd):
    logger.info(f"RUNNING: {cmd}\n")

    result = subprocess.run(
        cmd,
        shell=True,
        cwd="/app"
    )

    logger.info(f"{cmd} : EXIT CODE: {result.returncode}\n")
    sleep(2)

    if result.returncode != 0:
        raise Exception(f"FAILED: {cmd}")
#0. Download data
@op
def prepare_data():

    logger.info("Loading data into DuckDB...")
    run("python /app/download_account.py")
    logger.info("Accounts loaded")
    sleep(2)
    run("dbt seed")

# 1. Unit tests
@op(ins={"start": In(Nothing)})
def unit_tests():
    run("dbt test --select path:tests/unit")


# 2. Seed + transformations
@op(ins={"start": In(Nothing)})
def dbt_run():
    run("dbt run")


# 3. Data quality checks
@op(ins={"start": In(Nothing)})
def data_checks():
    run("dbt test --exclude path:tests/unit")


# 4. Upload
@op(ins={"start": In(Nothing)})
def upload_summary():
    run("sh /app/upload_summary.sh")


# Pipeline wiring
@job(executor_def=in_process_executor)
def banking_pipeline():
    upload_summary(
        data_checks(
            dbt_run(
                unit_tests(
                    prepare_data()
                )
            )
        )
    )