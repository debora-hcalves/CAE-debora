with
    customer as (
        select 
            customerid as customer_id,
            personid as person_id,
            territoryid as territory_id
        from {{source('sap_adw','customer')}}
    )

select 
    customer_id
    , person_id
from customer
order by customer_id

