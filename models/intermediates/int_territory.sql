with territory as (
    select
        territory_id
        , name_territory
        , countryregion_code
    from {{ ref('stg_salesterritory') }}
)

, countryregion as (
    select
        countryregion_code
        , name_country
    from {{ ref('stg_countryregion') }}
)

, stateprovince as (
    select
        stateprovince_id
        , name_state
        , territory_id
        , countryregion_code
    from {{ ref('stg_stateprovince') }}
)

select
    t.territory_id
    , t.name_territory
    , cr.name_country
    , sp.stateprovince_id
    , sp.name_state
from territory as t 
join countryregion as cr on t.countryregion_code = cr.countryregion_code
join stateprovince as sp on t.territory_id = sp.territory_id
order by t.territory_id
