with salesorder as (
    select *
    from {{ ref('stg_salesorderheader') }}
)

, credicard as (
    select *
    from {{ ref('stg_creditcard') }}
)


select
    so.salesorder_id
    , so.order_date
    , so.totaldue
    , so.status
    , coalesce(cc.card_type, 'not a creditcard purchase') as card_type
    , so.customer_id
    , so.address_id
from salesorder as so
left join credicard as cc on so.creditcard_id = cc.creditcard_id
order by salesorder_id
