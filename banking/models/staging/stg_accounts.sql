select
    upper(trim(AccountID)) as account_id,
    try_cast(trim(CustomerID) as int) as customer_id,
    try_cast(trim(Balance) as double) as balance,
    lower(trim(AccountType)) as account_type
from {{ ref('accounts') }}
where trim(coalesce(AccountID, '')) != ''
