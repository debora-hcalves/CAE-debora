with salesordersalesreason as (
    select
        salesorder_id
        , salesreason_id
    from {{ ref('stg_salesorderheadersalesreason') }}
),

salesreason as (
    select
        salesreason_id
        , name_reason
    from {{ ref('stg_salesreason') }}
)

select
    sosr.salesorder_id, sr.name_reason
from salesordersalesreason as sosr
left join salesreason as sr on sosr.salesreason_id = sr.salesreason_id
order by sosr.salesorder_id
