with
    customer as (
        select

            -- primary key 
            customerid as customer_id,

            -- foreign keys
            personid as person_id,
            territoryid as territory_id

        from {{ source('sap_adw','customer') }}
    )

select *
from customer


