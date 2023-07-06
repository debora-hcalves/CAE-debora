with 
    orders as (

        -- adding all columns from sales order header staging
        select *

        from {{ ref('stg_salesorderheader') }}
    )

    , orders_detail as (
        select

            -- primary key
            orderdetail_id

            -- foreign keys
            , salesorder_id
            , product_id

            -- order informations
            , order_qty
            , unit_price
            , unit_discount

        from {{ ref('stg_salesorderdetail') }}
    )

    , creditcard as (

        -- adding all columns from creditcard staging
        select *

        from {{ ref('stg_creditcard') }}
    )

    , partition_details_by_orders as (
        select

            -- column from orders
            o.salesorder_id

            -- partition of salesorder id from orders by orderdetail id from order_details
            , row_number () over (partition by o.salesorder_id order by od.orderdetail_id) as row_order_details
            
            -- calculing gross subtotal from order_details
            , od.unit_price*od.order_qty as gross_subtotal

            -- column from order_details
            , od.order_qty

        from orders as o
        inner join orders_detail as od on o.salesorder_id = od.salesorder_id
    )

    , sales_orders as (
        select

            -- primary key
            salesorder_id

            -- counting products quantity by order
            , count(row_order_details) as qnt_products

            -- summing gross subtotal by order
            , sum(gross_subtotal) as gross_subtotal_by_order

            -- summing item quantity by order
            , sum(order_qty) as qnt_itens

        from partition_details_by_orders
        group by salesorder_id
    )

    , sales as (
        select

            -- columns from orders
            o.salesorder_id
            , o.order_date
            , o.order_month
            , o.order_year
            , o.customer_id
            , o.address_id
            , o.subtotal
            , o.totaldue

            -- adding order status information on null values on a column from orders
            , coalesce(o.order_status, 'No Status') as order_status

            -- columns from sales order
            , so.qnt_products
            , so.qnt_itens
            , so.gross_subtotal_by_order

            -- adding credit card information on null values on a column from credit card
            , coalesce(cc.card_type, 'Not a Creditcard Purchase') as card_type

        from orders as o
        left join sales_orders as so on o.salesorder_id = so.salesorder_id
        left join creditcard as cc on o.creditcard_id = cc.creditcard_id
        order by o.salesorder_id
    )

select *
from sales


