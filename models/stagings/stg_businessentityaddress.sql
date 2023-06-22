select
    businessentityid as businessentity_id,
    addressid as address_id,
    cast(modifieddate as timestamp) as date_modified
from {{source('sap_adw','businessentityaddress')}}