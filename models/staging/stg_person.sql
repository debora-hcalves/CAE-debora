with
    person as (
        select
            
            -- primary key
            businessentityid as person_id

            -- concatenating first and last name
            , firstname || ' ' || lastname as full_name

        from {{ source('sap_adw','person') }}
    )


select *
from person