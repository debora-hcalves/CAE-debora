with
    salesorder as (
        select *
        from {{ ref('stg_salesorderheadersalesreason') }}
    )

    , salesreason as (
    select *
    from {{ ref('stg_salesreason') }}
    )

    , join_order_reason as (
        select
            so.salesorder_id
            , so.salesreason_id
            , sr.name_reason
            , sr.type_id
            , sr.reason_type
        from salesorder as so
        left join salesreason as sr on so.salesreason_id = sr.salesreason_id
    )

 , rn_sales_reason as (
        select
            salesorder_id
            , salesreason_id
            , type_id
            , row_number () over (partition by salesorder_id order by type_id) as rn_reason
            , name_reason
            , reason_type
        from join_order_reason

    )

    , cte as (
        select 
        salesorder_id
        , count(distinct(type_id)) as qnt_type
        from rn_sales_reason
    group by salesorder_id
    order by salesorder_id
    )

select *
from cte
order by qnt_type DESC  



/*
    , agg_sales_reason as (
        select 
            salesorder_id
            , string_agg(name_reason,'&') as name
            , type_id
            , reason_type
    )




/*
select 
    so.salesorder_id
    , so.salesreason_id
    , sr.name_reason
    , sr.reason_type
    , sr.type_id
from salesorder as so
inner join salesreason as sr on so.salesreason_id = sr.salesreason_id
order by salesorder_id