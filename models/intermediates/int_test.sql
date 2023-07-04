with
    salesreason as (
        select *
        from {{ ref('stg_salesorderheadersalesreason') }}
    )

, salesheader as (
    select *
    from {{ ref('stg_salesorderheader') }}

)

select count(salesorder_id) as qtd
from salesheader

/*, join_header_reason as (
    select
        sh.salesorder_id as headerid
        , sr.salesorder_id as headerreasonid
    from salesheader as sh
    left join salesreason as sr on sh.salesorder_id = sr.salesorder_id
)

select count(headerid) as qtd
from join_header_reason
--order by headerid