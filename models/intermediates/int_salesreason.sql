with
    salesorder as (

        -- adding all columns from salesorderheaderreason staging
        select *

        from {{ ref('stg_salesorderheadersalesreason') }}
    )
    , salesreason as (

        -- adding all columns from salesreason staging
        select *

        from {{ ref('stg_salesreason') }}
    )

    , salesheader as (

        -- adding all columns from salesorderheader stagings
        select *

        from {{ ref('stg_salesorderheader') }}
    )

    , join_order_reason as (
        select 

            -- columns from salesorder
            so.salesorder_id
            , so.salesreason_id

            -- columns from salesreason
            , sr.name_reason
            , sr.reason_type

        from salesorder as so
        inner join salesreason as sr on so.salesreason_id = sr.salesreason_id
        order by salesorder_id
    )

    , join_header_reason as (
        select

            -- column from salesheader
            sh.salesorder_id

            -- columns from join_order_reason
            , jor.salesreason_id 
            , jor.name_reason 
            , jor.reason_type

        from salesheader as sh
        left join join_order_reason as jor on sh.salesorder_id = jor.salesorder_id
    )

    , coalececolumns as (
        select 

            -- primary key
            salesorder_id

            -- adding information on null values
            , coalesce(salesreason_id, 0) as salesreason_id
            , coalesce(name_reason, 'No Sales Reason') as name_reason
            , coalesce(reason_type, 'No Reason Type') as reason_type

        from join_header_reason
    )

select *
from coalececolumns