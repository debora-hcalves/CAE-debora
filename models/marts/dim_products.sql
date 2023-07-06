with 
    products as (

        -- adding all columns from product intermediate
        select *

        from {{ ref('int_product') }}
    )

select
   *
from products

