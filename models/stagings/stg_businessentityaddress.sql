select
    businessentityid as businessentity_id,
    addressid as address_id
from {{source('sap_adw','businessentityaddress')}}