-- copied from models/marts/fct_account_summary.sql for unit testing
{% macro summary(stg_accounts='mock_accounts', stg_customers='mock_customers') %}

with base as (
    select
        a.customer_id,
        a.account_id,
        a.balance,
        c.has_loan
    from {{ stg_accounts}} a
    join {{ stg_customers }} c
        on a.customer_id = c.customer_id
    where a.account_type = 'savings'
),

calc as (
    select
        customer_id,
        account_id,
        balance as original_balance,

        case
            when balance is null then 0
            else {{ interest_rate_calc('balance', 'has_loan') }}
        end as interest_rate_applied

    from base
)

select
    customer_id,
    account_id,
    original_balance,
    interest_rate_applied,

    case
        when original_balance is null then null
        else original_balance * interest_rate_applied
    end as annual_interest_amount,

    case
        when original_balance is null then null
        else original_balance + (original_balance * interest_rate_applied)
    end as new_balance

from calc

{% endmacro %}