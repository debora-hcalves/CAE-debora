with 
    customers as (
        
        -- adding all columns from customer intermediate
        select *

        from {{ ref('int_customer') }}
    )

select 
    *
from customers