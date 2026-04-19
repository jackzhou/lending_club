with test_cases as (

    select 9999.1 as balance, false as has_loan, 0.01 as expected
    union all
    select 10000, false, 0.015
    union all
    select 20000, false, 0.02
    union all
    select 9999.1, true, 0.015
    union all
    select 10000, true, 0.02
    union all
    select 20000, true, 0.025

),

actual as (

    select
        balance,
        has_loan,
        expected,
        {{ interest_rate_calc('balance', 'has_loan') }} as actual
    from test_cases

)

select *
from actual
where abs(actual - expected) > 0.000001