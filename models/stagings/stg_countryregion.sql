with
    countryregion as (
        select

            -- primary key
            countryregioncode as countryregion_code

            -- country information
            , name as name_country

        from {{ source('sap_adw','countryregion') }}
    )

select *
from countryregion