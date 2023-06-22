select
    businessentityid as businessentity_id,
    personid as person_id
from {{source('sap_adw','businessentitycontact')}}