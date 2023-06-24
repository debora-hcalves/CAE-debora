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

    , personaddress as (
        select
            businessentity_id
            , address_id
        from {{ ref('stg_businessentityaddress') }}
    )

select
    c.customer_id
    , coalesce(p.full_name, 'unregistered customer') as name_customer
    , coalesce(pa.address_id, 0) as address_id
from customer as c
left join person as p on c.person_id = p.person_id
left join personaddress as pa on p.person_id = pa.businessentity_id
order by c.customer_id