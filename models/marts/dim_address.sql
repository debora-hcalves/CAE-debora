with address as (
    select *
    from {{ ref('int_address') }}
)

select 
    *
from address