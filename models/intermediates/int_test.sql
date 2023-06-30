with 
     orders_detail as (
        select
            orderdetail_id
            , salesorder_id
            , order_qty
            , product_id
            , unit_price
            , unit_discount
        from {{ ref('stg_salesorderdetail') }}
    )

        , products as (
            select *
            from {{ ref('stg_product') }}
        )

        , details_products as (
            select 
                od.*
                , p.name_product
            from orders_detail as od
            inner join products as p on od.product_id = p.product_id

        )

      , products_orders as (
        select
            product_id
            , count(salesorder_id) as qnt_pedidos
            , sum(order_qty) as qnt_itens
       from details_products
       group by product_id
    )

  --      , final as (
   --         select
   --         product_id
   --         , name_product
    --        , count(salesorder_id) as qnt_pedidos
   --         , sum(order_qty) as qnt_itens_vendidos
   --     from partition_details_by_orders
   --     group by product_id
   --     order by product_id
   --     )

select *
from products_orders
order by product_id


--    , sales_orders as (
--        select 
--            salesorder_id
--           , count(row_order_details) as qnt_products
--            , sum(gross_subtotal) as gross_subtotal_by_order
--            , sum(order_qty) as qnt_itens
--        from partition_details_by_orders
--        group by salesorder_id
--   )

--    , sales as (
--        select
--            o.salesorder_id
--           , o.order_date
--            , o.order_year
--            , so.qnt_products
--            , so.qnt_itens
--            , so.gross_subtotal_by_order
--            , o.status
--            , coalesce(cc.card_type, 'Not a Creditcard Purchase') as card_type
--            , o.customer_id
--            , o.address_id
--          , o.subtotal
--            , o.totaldue
--            , coalesce(sr.reason_type, 'No Sales Reason Associated') as reason_type
--        from orders as o
--        left join sales_orders as so on o.salesorder_id = so.salesorder_id
--        left join creditcard as cc on o.creditcard_id = cc.creditcard_id
--        left join salesreason as sr on o.salesorder_id = sr.salesorder_id
--        order by o.salesorder_id
--    )


