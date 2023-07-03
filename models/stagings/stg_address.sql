with
    address as (
        select
            addressid as address_id
            , city
            , stateprovinceid as stateprovince_id
        from {{ source("sap_adw", "address") }}
    )

select *
from address
order by address_id
