with mock_accounts as (

    select 'A001' as account_id, 101 as customer_id, 10000.0::double as balance, 'savings' as account_type
    union all
    select 'A002', 102, 20000.0, 'checking'
    union all
    select 'A003', 103, 10000.0, 'savings'
    union all
    select 'A004', 104, null::double, 'savings'
    union all
    select 'A005', 105, 30000.0, 'checking'
    union all
    select 'A006', 105, 15000.0, 'savings'
    union all
    select 'A007', 106, 5000.0, 'savings'

),

 mock_customers as (
    select 101 as customer_id, 'alice smith' as name, true as has_loan
    union all
    select 102, 'bob jones', false
    union all
    select 103, 'charlie brown', true
    union all
    select 104, 'david lee', false
    union all
    select 105, 'eve adams', false
    union all
    select 106, 'frank o''connor', true

),

 expected as (
    select 101 as customer_id, 'A001' as account_id, 10000.0 as original_balance, 0.020 as interest_rate_applied, 200.0 as annual_interest_amount, 10200.0 as new_balance
    union all
    select 103, 'A003', 10000.0, 0.020, 200.0, 10200.0
    union all
    select 104, 'A004', null, 0.000, null, null
    union all
    select 105, 'A006', 15000.0, 0.015, 225.0, 15225.0
    union all
    select 106, 'A007', 5000.0, 0.015, 75.0, 5075.0

),

actual as (
    {{ summary('mock_accounts', 'mock_customers') }}
)

{{ assert_equal('actual', 'expected') }}