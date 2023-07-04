with 
    raw_salesheader as (
        select
            salesorderid as salesorder_id
            , cast(orderdate as timestamp) as sales_date
            , status
            , creditcardid as creditcard_id
            , customerid as customer_id
            , territoryid as territory_id
            , shiptoaddressid as address_id
            , subtotal
            , taxamt as taxes
            , freight
            , totaldue
        from {{source('sap_adw','salesorderheader')}}
    )

    , orderdate as (
        select
            salesorder_id
            , extract(date from sales_date) as order_date
            , status
            , creditcard_id
            , customer_id
            , territory_id
            , address_id
            , subtotal
            , taxes
            , freight
            , totaldue
        from raw_salesheader
    )

    , ordersyear as (
        select
            salesorder_id
            , extract(year from order_date) as order_year
            , order_date
            , case
                when status = 1 then 'In process'
                when status = 2 then 'Approved'
                when status = 3 then 'Backordered'
                when status = 4 then 'Rejected'
                when status = 5 then 'Shipped'
                when status = 6 then 'Canceled'
            end as order_status
            , creditcard_id
            , customer_id
            , territory_id
            , address_id
            , subtotal
            , taxes
            , freight
            , totaldue
        from orderdate
    )



select count(salesorder_id) as qtd
from ordersyear