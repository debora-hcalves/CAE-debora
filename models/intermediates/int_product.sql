with order_detail as (
    select *
    from {{ ref('stg_salesorderdetail') }}
)

, product as (
    select *
    from {{ ref('stg_product') }}
)

select
    od.orderdetail_id
    , od.salesorder_id
    , od.product_id
    , p.name_product
    , od.order_qty
    , od.unit_price
    , od.unit_discount
from order_detail as od
left join product as p on od.product_id = p.product_id
order by orderdetail_id