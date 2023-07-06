with
    stateprovince as (
        select

            -- primary key
            stateprovinceid as stateprovince_id

            -- foreign keys
            , territoryid as territory_id
            , countryregioncode as countryregion_code

            -- state name
            , name as name_state

        from {{ source('sap_adw','stateprovince') }}
    )

select *
from stateprovince
