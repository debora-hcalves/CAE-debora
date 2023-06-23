with customer as (
    select *
    from {{ ref('stg_customer') }}
)

, person as (
    select
        person_id
        , first_name
        , middle_name
        , last_name
    from {{ ref('stg_person') }}
)

, personaddress as (
    select
        businessentity_id
        , address_id
    from {{ ref('stg_businessentityaddress') }}
)

select
    c.customer_id
    , p.first_name
    , p.middle_name
    , p.last_name
    , pa.address_id    
from customer as c
left join person as p on c.person_id = p.person_id
left join personaddress as pa on p.person_id = pa.businessentity_id
order by c.customer_id