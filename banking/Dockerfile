# Use slim Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies (optional but good)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install dbt-duckdb
RUN pip install --no-cache-dir \
    dbt-duckdb==1.7.0\
    dagster \
    dagster-webserver \
    "protobuf<5"




RUN curl -fSL https://raw.githubusercontent.com/databricks/setup-cli/main/install.sh -o install.sh 
RUN sh install.sh
RUN databricks --version

# Copy project files
COPY . /app

# Create profiles directory
RUN mkdir -p /root/.dbt

# Copy profiles.yml into correct location
COPY profiles.yml /root/.dbt/profiles.yml

CMD ["dagster", "dev", "-h", "0.0.0.0", "-p", "3000", "-f", "pipeline.py"]

