with products as (
    select *
    from {{ ref('int_product') }}
)

select
    *
from products