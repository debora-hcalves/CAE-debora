with salesorder as (
    select *
    from {{ ref('stg_salesorderheader') }}
)

, credicard as (
    select *
    from {{ ref('stg_creditcard') }}
)

, salesordersalesreason as (
    select
        *
    from {{ ref('stg_salesorderheadersalesreason') }}
),

salesreason as (
    select
        *
    from {{ ref('stg_salesreason') }}
)

select
    so.salesorder_id
    , so.order_date
    , so.status
    , sr.name_reason
    , c.card_type
    , so.customer_id
    , so.territory_id
from salesorder as so
left join salesordersalesreason as sosr on so.salesorder_id = sosr.salesorder_id
left join salesreason as sr on sosr.salesreason_id = sr.salesreason_id
left join credicard as c on so.creditcard_id = c.creditcard_id
order by so.salesorder_id