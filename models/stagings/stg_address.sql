with
    address as (
        select

            -- primary key
            addressid as address_id

            -- city name
            , city

            -- foreign key
            , stateprovinceid as stateprovince_id

        from {{ source("sap_adw", "address") }}
)

select *
from address
