with
    salesreason as (

            -- adding all columns from salesreason intermediate
            select *

            from {{ ref('int_salesreason') }}
    )

select 
    *
from salesreason