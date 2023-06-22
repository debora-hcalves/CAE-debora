with order_detail as (
    select *
    from {{ ref('stg_salesorderdetail') }}
)

, product as (
    select *
    from {{ ref('stg_product') }}
)

select
    od.*
    ,  p.name_product
from order_detail as od
left join product as p on od.product_id = p.product_id
order by orderdetail_id