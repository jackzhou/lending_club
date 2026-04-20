"""Same shell sequence as pipeline.py, expressed as a single Dagster op + job."""

from time import sleep

from dagster import get_dagster_logger, in_process_executor, job, op
import subprocess

logger = get_dagster_logger()


def run(cmd: str) -> None:
    logger.info(f"RUNNING: {cmd}\n")

    result = subprocess.run(
        cmd,
        shell=True,
        cwd="/app",
    )

    logger.info(f"{cmd} : EXIT CODE: {result.returncode}\n")
    sleep(2)

    if result.returncode != 0:
        raise RuntimeError(f"FAILED: {cmd}")


@op
def full_pipeline() -> None:
    logger.info("Loading data into DuckDB...")
    run("python /app/download_account.py")
    logger.info("Accounts loaded")
    sleep(2)
    run("dbt seed")

    run("dbt test --select path:tests/unit")

    run("dbt run")

    run("dbt test --exclude path:tests/unit")

    run("sh /app/upload_summary.sh")


@job(executor_def=in_process_executor)
def banking_pipeline_one_step():
    full_pipeline()
