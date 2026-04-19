{% macro transform_customers(source_cte='mock') %}
-- copied from models/staging/stg_customers.sql

select
    cast(trim(CustomerID) as int) as customer_id,
    lower(trim(Name)) as name,
    case
        when lower(trim(coalesce(HasLoan, ''))) = 'yes' then true else false
    end as has_loan
from {{ source_cte }}
where trim(coalesce(CustomerID, '')) != ''

{% endmacro %}

{% macro transform_accounts(source_cte='mock') %}
 -- copied from models/staging/stg_accounts.sql
select
    upper(trim(AccountID)) as account_id,
    try_cast(trim(CustomerID) as int) as customer_id,
    try_cast(trim(Balance) as double) as balance,
    lower(trim(AccountType)) as account_type
from {{ source_cte }}
where trim(coalesce(AccountID, '')) != ''


{% endmacro %}