with person as (
    select *
    from {{ ref('stg_person') }}
)

, address as (
    select *
    from {{ ref('stg_businessentityaddress') }}
)

, city as (
    select *
    from {{ ref('stg_address') }}
)

select 
    p.person_id
    , p.first_name
    , p. last_name
    , a.address_id
    , c.city
from person as p
left join address as a on p.person_id = a.businessentity_id
left join city as c on a.address_id = c.address_id
order by p.person_id