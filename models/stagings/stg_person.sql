select
    businessentityid as businessentity_id,
    firstname as first_name,
    lastname as last_name
from {{source('sap_adw','person')}}