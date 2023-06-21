select 
    customerid as customer_id,
    personid as person_id,
    territoryid as territory_id
from {{source('sap_adw','customer')}}


