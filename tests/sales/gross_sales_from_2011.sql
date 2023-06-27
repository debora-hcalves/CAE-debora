with
    gross_sales_2011 as (
        select
            sum(totaldue) as gross_sales
        from {{ ref('fct_sales') }}
        where order_date between '2011-01-01' and '2011-12-31'
    )

select *
from gross_sales_2011
--where gross_sales_2011 = 151798212.91