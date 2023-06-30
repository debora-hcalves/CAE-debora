with
    salesorder as (
        select *
        from {{ ref('stg_salesorderheadersalesreason') }}
    )
    , salesreason as (
    select *
    from {{ ref('stg_salesreason') }}
    )


select 
    so.salesorder_id
    , sr.name_reason
    , sr.reason_type
from salesorder as so
left join salesreason as sr on so.salesreason_id = sr.salesreason_id
order by salesorder_id