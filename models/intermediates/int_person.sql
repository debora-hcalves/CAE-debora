with person as (
    select *
    from {{ ref('stg_person') }}
)

, address_code as (
    select *
    from {{ ref('stg_businessentityaddress') }}
)

, city as (
    select *
    from {{ ref('stg_address') }}
)

, stateprovince as (
    select *
    from {{ ref('stg_stateprovince') }}
)

, countryregion as (
    select *
    from {{ ref('stg_countryregion') }}
)

, territory as (
    select *
    from {{ ref('stg_salesterritory') }}
)

select 
    p.person_id
    , p.first_name
    , p. last_name
    , a.address_id
    , c.city
    , sp.name_state
    , cr.name_country
    , t.name_territory
from person as p
left join address_code as a on p.person_id = a.businessentity_id
left join city as c on a.address_id = c.address_id
left join stateprovince as sp on c.stateprovince_id = sp.stateprovince_id
left join countryregion as cr on sp.countryregion_code = cr.countryregion_code
left join territory as t on sp.territory_id = t.territory_id
order by p.person_id