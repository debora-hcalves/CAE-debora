with 
    customer as (
        select *
        from {{ ref('stg_customer') }}
    )   

    , person as (
        select
            person_id
            , full_name
        from {{ ref('stg_person') }}
    )

select
   c.customer_id
    , coalesce(p.full_name, 'unregistered customer') as name_customer
from customer as c
left join person as p on c.person_id = p.person_id
order by c.customer_id
