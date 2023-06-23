with sales as (
    select *
    from {{ ref('int_salesorder') }}
)

select
    *
from sales