select
    businessentityid as person_id
    , firstname as first_name
    , middlename as middle_name
    , lastname as last_name
from {{source('sap_adw','person')}}