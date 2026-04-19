select *

from {{ ref('stg_accounts') }}

where balance < 0