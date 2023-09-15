with 
    salesorderreason as (
        select

            -- primary key
            salesorderid as salesorder_id

            --- foreign key
            , salesreasonid as salesreason_id

        from {{ source('sap_adw','salesorderheadersalesreason') }}
    )

select *
from salesorderreason