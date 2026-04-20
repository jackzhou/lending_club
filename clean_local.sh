#! /bin/bash
root_dir=~/work/lending_club
project_dir=$root_dir/banking
rm -rf $project_dir/target
rm -rf $project_dir/logs
rm -rf $project_dir/dbt_packages
rm -rf $project_dir/account_summary.csv
rm -rf $project_dir/__pycache__
mv -f $project_dir/lending.duckdb $root_dir/lending.duckdb
