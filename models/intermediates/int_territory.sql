with territory as (
    select
        territory_id
        , name_territory
        , countryregion_code
    from {{ ref('stg_salesterritory') }}
)

, coutryregion as (
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
    sp.stateprovince_id
    , sp.name_state
    , sp.territory_id
    , t.name_territory
    , sp.countryregion_code
    , cr.name_country
from stateprovince as sp 
join territory as t on sp.territory_id = t.territory_id
join coutryregion as cr on sp.countryregion_code = cr.countryregion_code
order by sp.stateprovince_id;
