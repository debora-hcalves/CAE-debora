with 
    raw_salesheader as (
        select

            -- primary key
            salesorderid as salesorder_id

            -- timestamp
            , cast(orderdate as timestamp) as sales_date

            -- order status
            , status

            -- foreign keys
            , creditcardid as creditcard_id
            , customerid as customer_id
            , territoryid as territory_id
            , shiptoaddressid as address_id

            -- costs
            , subtotal
            , taxamt as taxes
            , freight
            , totaldue

        from {{ source('sap_adw','salesorderheader') }}
    )

    , orderdate as (
        select

            -- primary key
            salesorder_id

            -- extracting the date
            , extract(date from sales_date) as order_date

            -- order status
            , status

            -- foreign keys
            , creditcard_id
            , customer_id
            , territory_id
            , address_id

            --costs
            , subtotal
            , taxes
            , freight
            , totaldue

        from raw_salesheader
    )

    , ordersyear as (
        select

            -- primary key
            salesorder_id

            -- extracting date information
            , extract(year from order_date) as order_year
            , extract(month from order_date) as order_month
            , order_date

            -- order status
            , case
                when status = 1 then 'In process'
                when status = 2 then 'Approved'
                when status = 3 then 'Backordered'
                when status = 4 then 'Rejected'
                when status = 5 then 'Shipped'
                when status = 6 then 'Canceled'
            end as order_status

            -- foreign keys
            , creditcard_id
            , customer_id
            , territory_id
            , address_id

            -- costs
            , subtotal
            , taxes
            , freight
            , totaldue
            
        from orderdate
    )

select *
from ordersyear