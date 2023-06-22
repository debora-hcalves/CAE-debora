with raw_salesheader as (
    select
        salesorderid as salesorder_id,
        cast(orderdate as timestamp) as sales_date,
        status,
        creditcardid as creditcard_id,
        customerid as customer_id,
        territoryid as territory_id,
        shiptoaddressid as address_id
    from {{source('sap_adw','salesorderheader')}}
)

, cte_date as (
    select
        salesorder_id
        , extract(date from sales_date) as order_date
        , status
        , creditcard_id
        , customer_id
        , territory_id
        , address_id
    from raw_salesheader
)

select * from cte_date