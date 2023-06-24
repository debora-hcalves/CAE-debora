with   
    salesreason as (
        select
            salesreasonid as salesreason_id
            , name as name_reason
            , reasontype as reason_type
        from {{source('sap_adw','salesreason')}}
    )

select *
from salesreason