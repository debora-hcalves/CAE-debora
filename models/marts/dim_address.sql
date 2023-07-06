with 
    address as (

        -- adding all columns from address intermediate
        select *
        
        from {{ ref('int_address') }}
    )

select 
    *
from address
order by address_id