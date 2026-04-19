-- File: tests/stg_customers/test_hasloan.sql
-- Purpose: test CASE logic for HasLoan

with mock as (
    select '1' as CustomerID, 'Alice' as Name, 'YES' as HasLoan
    union all
    select '2', 'Bob', ' yes '
    union all
    select '3', 'Carl', 'no'
    union all
    select '4', 'Dan', null
    union all
    select '5', 'Eve', 'random'
),

actual as (
    {{ transform_customers('mock') }}
),

expected as (
    select 1, 'alice', true
    union all
    select 2, 'bob', true
    union all
    select 3, 'carl', false
    union all
    select 4, 'dan', false
    union all
    select 5, 'eve', false
)

{{ assert_equal('actual', 'expected') }}