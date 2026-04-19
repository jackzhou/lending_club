#! /bin/bash
set +
root_dir=~/work/lending_club
project_dir=$root_dir/banking
rm -rf $project_dir/target
rm -rf $project_dir/logs
rm -rf $project_dir/dbt_packages
rm -rf $project_dir/account_summary.csv
mv -f $project_dir/lending.duckdb $root_dir/lending.duckdb
