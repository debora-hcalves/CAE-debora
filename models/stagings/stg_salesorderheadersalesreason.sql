with 
    salesorderreason as (
        select
            salesorderid as salesorder_id
            , salesreasonid as salesreason_id
        from {{source('sap_adw','salesorderheadersalesreason')}}
    )

select *
from salesorderreason
order by salesorder_id