select
    cast(trim(CustomerID) as int) as customer_id,
    lower(trim(Name)) as name,
    case
        when lower(trim(coalesce(HasLoan, ''))) = 'yes' then true else false
    end as has_loan
from {{ ref('customers') }}
where trim(coalesce(CustomerID, '')) != '' -- scope is to find summary , fitere ut useless bad data. 

