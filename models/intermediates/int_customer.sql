with 
    customer as (

        -- all columns from customer staging
        select *

        from {{ ref('stg_customer') }}
    )   

    , person as (
        select

            -- primary key
            person_id

            -- customer full name
            , full_name

        from {{ ref('stg_person') }}
    )

    , join_customer_person as (
        select

            -- column from customer
            c.customer_id

            -- adding customer information on null values on a column from person
            , coalesce(p.full_name, 'Unregistered Customer') as name_customer

        from customer as c
        left join person as p on c.person_id = p.person_id
    )

select *
from join_customer_person

