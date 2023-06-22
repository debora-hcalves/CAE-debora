with raw_businessentitycontact as (
    select
        businessentityid as businessentity_id
        , personid as person_id
        , cast(modifieddate as timestamp) as date_modified
    from {{source('sap_adw','businessentitycontact')}}
)

, cte_date_only as (
    select
        businessentity_id
        , person_id
        , extract(date from date_modified) as last_date_update
    from raw_businessentitycontact
)

select *
from cte_date_only