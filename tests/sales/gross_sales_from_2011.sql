with
    gross_sales_2011 as (
        select

            -- summing gross subtototal per order on 2011. [rounded number]
            round(sum(gross_subtotal_by_order)) as grosssales_2011

        from {{ ref('fct_sales') }}
        where order_year = 2011
    )

-- testing gross sales on 2011
select 
    *
from gross_sales_2011
where grosssales_2011 != 12646112