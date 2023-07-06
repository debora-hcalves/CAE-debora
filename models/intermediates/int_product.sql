with 
    order_detail as (

        -- adding all columns from salesorderdetail staging
        select *

        from {{ ref('stg_salesorderdetail') }}
    )

    , product as (

        -- adding all columns from product staging
        select *

        from {{ ref('stg_product') }}
    )

    , join_orderdetail_product as (
        select

            -- columns from order_detail
            od.orderdetail_id
            , od.salesorder_id
            , od.product_id
            , od.order_qty
            , od.unit_price
            , od.unit_discount

            -- calculing total per item from order_detail
            , od.order_qty*(od.unit_price - od.unit_discount) as total_per_item

            -- column from product
            , p.name_product

        from order_detail as od
        left join product as p on od.product_id = p.product_id
        order by orderdetail_id
    )

select *
from join_orderdetail_product


