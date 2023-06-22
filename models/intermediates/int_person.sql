with person_address as (
    select
        businessentity_id
        , address_id
        , date_only
    from {{ ref('stg_businessentityaddress') }}
)

, drop_duplicate as (
    select
        *
        , row_number() over (
            partition by
                businessentity_id
            order by
                date_only
        ) as rn
    from person_address
    order by date_only desc
)

, last_person_address as (
    select *
    from drop_duplicate
    where rn = 1
    order by businessentity_id
)

, person_name as (
    select *
    from {{ ref('stg_person') }}
)

, businesscontact as (
    select 
        businessentity_id
        , person_id
        , last_date_update
    from {{ ref('stg_businessentitycontact') }}
)

, drop_contact_duplicate as (
    select
        *
        , row_number() over (
            partition by
                businessentity_id
            order by
                last_date_update
        ) as num_date
    from businesscontact
    order by last_date_update desc
)

, person_last_contact as (
    select *
    from drop_contact_duplicate
    where num_date = 1
    order by businessentity_id
)

select 
    p.*
    , lpa.address_id
from person_name as p 
left join last_person_address as lpa on p.businessentity_id = lpa.businessentity_id
order by p.businessentity_id

