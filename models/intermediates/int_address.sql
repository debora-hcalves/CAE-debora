with address as (
    select
        address_id
        , city
        , stateprovince_id
    from {{ ref('stg_address') }}
)

, territory as (
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
    a.address_id
    , a.city
    , sp.name_state
    , cr.name_country
    , t.name_territory
from stateprovince as sp
inner join address as a on sp.stateprovince_id = a.stateprovince_id
inner join countryregion as cr on sp.countryregion_code = cr.countryregion_code
inner join territory as t on sp.territory_id = t.territory_id
order by a.address_id
