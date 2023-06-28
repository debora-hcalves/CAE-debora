with orders as (
    select *
    from {{ ref('int_orders') }}
)

select
    *
from orders