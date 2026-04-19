-- File: tests/stg_accounts/test_account_id.sql
-- Purpose: test AccountID transformation

with mock as (

    select ' abc ' as AccountID, '1' as CustomerID, '1' as Balance, 'x' as AccountType
    union all
    select '' , '2', '2', 'y'
    union all
    select null, '3', '3', 'z'

),

expected as (

    select 'ABC' as account_id, 1 as customer_id, 1.0 as balance, 'x' as account_type

),

actual as ( 
    {{ transform_accounts('mock') }}
)

-- validate
{{ assert_equal('actual', 'expected') }}