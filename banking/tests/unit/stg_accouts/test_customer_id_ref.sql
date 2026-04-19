-- File: tests/stg_accounts/test_customer_id.sql
-- Purpose: test CustomerID casting

with mock as (

    select 'a' as AccountID, '123' as CustomerID, '1' as Balance, 'x' as AccountType
    union all
    select 'b', ' 456 ', '2', 'y'
    union all
    select 'c', 'abc', '3', 'z'

),


expected as (

    select 'A', 123, 1.0, 'x'
    union all
    select 'B', 456, 2.0, 'y'
    union all
    select 'C', null, 3.0, 'z'

),

actual as (   
     {{ transform_accounts('mock') }}
)

-- validate
{{ assert_equal('actual', 'expected') }}