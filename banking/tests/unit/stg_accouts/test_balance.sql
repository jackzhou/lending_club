-- File: tests/stg_accounts/test_balance.sql
-- Purpose: test Balance casting including NULL handling

with mock as (

    select 'a' as AccountID, '1' as CustomerID, '100.5' as Balance, 'x' as AccountType
    union all
    select 'b', '2', ' 200 ', 'y'
    union all
    select 'c', '3', 'abc', 'z'
    union all
    select 'd', '4', null, 'w'   -- NULL case

),

expected as (

    select 'A', 1, 100.5, 'x'
    union all
    select 'B', 2, 200.0, 'y'
    union all
    select 'C', 3, null, 'z'
    union all
    select 'D', 4, null, 'w'   -- expect NULL preserved

),

actual as (   
     {{ transform_accounts('mock') }}
)

-- validate
{{ assert_equal('actual', 'expected') }}