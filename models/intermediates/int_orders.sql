with 
    orders as (
        select *
        from {{ ref('stg_salesorderheader') }}
    )

    , orders_detail as (
        select
            orderdetail_id
            , salesorder_id
            , order_qty
            , product_id
            , unit_price
            , unit_discount
        from {{ ref('stg_salesorderdetail') }}
    )

    , creditcard as (
        select *
        from {{ ref('stg_creditcard') }}
    )

    , partition_details_by_orders as (
        select
            o.salesorder_id
            , row_number () over (partition by o.salesorder_id order by od.orderdetail_id) as row_order_details
            , unit_price*order_qty as gross_subtotal
            , order_qty
        from orders as o
        inner join orders_detail as od on o.salesorder_id = od.salesorder_id
    )

    , sales_orders as (
        select 
            salesorder_id
            , count(row_order_details) as qnt_products
            , sum(gross_subtotal) as gross_subtotal_by_order
            , sum(order_qty) as qnt_itens
        from partition_details_by_orders
        group by salesorder_id
    )

    , sales as (
        select
            o.salesorder_id
            , o.order_date
            , o.order_month
            , o.order_year
            , so.qnt_products
            , so.qnt_itens
            , so.gross_subtotal_by_order
            , coalesce(o.order_status, 'No Status') as order_status
            , coalesce(cc.card_type, 'Not a Creditcard Purchase') as card_type
            , o.customer_id
            , o.address_id
            , o.subtotal
            , o.totaldue
        from orders as o
        left join sales_orders as so on o.salesorder_id = so.salesorder_id
        left join creditcard as cc on o.creditcard_id = cc.creditcard_id
        order by o.salesorder_id
    )

select *
from sales
order by salesorder_id

