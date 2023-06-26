with orders as (
    select *
    from {{ ref('int_salesorder') }}
)

select
    *
from orders