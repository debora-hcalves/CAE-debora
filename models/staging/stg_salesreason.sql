with   
    salesreason as (
        select

            -- primary key
            salesreasonid as salesreason_id

            -- sales reason informations
            , name as name_reason
            , reasontype as reason_type

        from {{ source('sap_adw','salesreason') }}
    )

select *
from salesreason