with
    territory as (
        select

            -- primary key
            territoryid as territory_id

            -- territory name
            , name as name_territory

            -- foreign key
            , countryregioncode as countryregion_code

        from {{ source('sap_adw','salesterritory') }}
    )

select *
from territory 