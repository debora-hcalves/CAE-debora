with 
    orders as (

        -- adding all columns from orders intermediate
        select *

        from {{ ref('int_orders') }}
    )

select
    *
from orders