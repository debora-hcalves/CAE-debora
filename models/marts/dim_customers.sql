with customers as (
    select *
    from {{ ref('int_customer') }}
)

select 
    *
from customers