with sales_order as (
    select *
    from {{ ref('stg_salesorderheader') }}
)

, order_detail as (
    select *
    from {{ ref('stg_salesorderdetail') }}
)

select * from sales_order