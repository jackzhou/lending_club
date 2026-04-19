-- File: tests/stg_customers/test_name.sql

with mock as (
    select '1' as CustomerID, ' Alice ' as Name, 'YES' as HasLoan
    union all
    select '2', 'Bob', 'no'
    union all
    select '3', 'Charlie', 'None'
),

actual as (
    {{ transform_customers('mock') }}
),

expected as (
    select 1, 'alice', 'true'
    union all
    select 2, 'bob', 'false'
    union all
    select 3, 'charlie', 'false'
)

{{ assert_equal('actual', 'expected') }}