-- File: tests/stg_customers/test_customer_id.sql
-- Purpose: test CustomerID cast + filtering

with mock as (

    select '123' as CustomerID, 'Alice' as Name, 'yes' as HasLoan
    union all
    select ' 456 ', 'Bob', 'no'
    union all
    select '', 'Bad', 'yes'      -- filtered out
    union all
    select null, 'Bad2', 'no'    -- filtered out

),

actual as (

    {{ transform_customers('mock') }}

),

expected as (

    select 123, 'alice', true
    union all
    select 456, 'bob', false

)

 {{ assert_equal('actual', 'expected') }}