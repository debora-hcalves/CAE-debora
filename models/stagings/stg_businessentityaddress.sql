with raw_personaddress as (
    select
        businessentityid as businessentity_id
        , addressid as address_id
        , cast(modifieddate as timestamp) as modified_date
    from {{source('sap_adw','businessentityaddress')}}
)

, cte_date as (
    select 
        businessentity_id
        , address_id
        , extract(date from modified_date) as date_only
    from raw_personaddress
)

select *
from cte_date