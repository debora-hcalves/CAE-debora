select
    businessentityid as businessentity_id,
    personid as person_id,
    cast(modifieddate as timestamp) as date_modified
from {{source('sap_adw','businessentitycontact')}}