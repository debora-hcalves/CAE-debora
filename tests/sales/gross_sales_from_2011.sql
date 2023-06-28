with
    gross_sales_2011 as (
        select
            round(sum(gross_subtotal_by_order)) as grosssales_2011
        from {{ ref('fct_sales') }}
        where order_year = 2011
    )

select 
    *
from gross_sales_2011
where grosssales_2011 != 12646112