with customer as (
    select
        customer_id
        , person_id
    from {{ ref('stg_customer') }}
)

, person as (
    select
        businessentity_id
    from {{ ref('stg_person') }}
)

select
    c.customer_id
    , p.businessentity_id
from person as p
left join customer as c on p.businessentity_id = c.person_id
order by c.customer_id