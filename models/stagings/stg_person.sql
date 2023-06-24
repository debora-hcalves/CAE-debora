with
    person as (
        select
            businessentityid as person_id
            , firstname || ' ' || lastname as full_name
        from {{source('sap_adw','person')}}
    )


select *
from person
order by person_id