with customer as (
    select *
    from {{ ref('stg_customer') }}
)

, personal_data as (
    select *
    from {{ ref('stg_salesterritory') }}
)

select 
    c.customer_id
    , c.person_id
    , c.territory_id
    , pd.name_territory
from customer as c
left join personal_data as pd on c.territory_id = pd.territory_id
order by c.customer_id