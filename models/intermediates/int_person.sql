with person_address as (
    select
        businessentity_id
        , address_id
        , MAX(date_only) as last_date_modified
    from {{ ref('stg_businessentityaddress') }}
    where address_id is not null
    group by businessentity_id
)

select *
from person_address