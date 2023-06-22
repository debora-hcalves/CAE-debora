with raw_businessentityaddress as (
    select
    businessentityid as businessentity_id
    , addressid as address_id
    , cast(modifieddate as timestamp) as date_modified
from {{source('sap_adw','businessentityaddress')}}
)

select 
    businessentity_id
    , address_id
    , extract(date from date_modified) as date_only
from raw_businessentityaddress;