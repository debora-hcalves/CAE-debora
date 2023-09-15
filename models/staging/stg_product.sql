with 
    product as (
        select

            -- primary key
            productid as product_id

            -- product name
            , name as name_product
            
        from {{ source('sap_adw','product') }}
    )

select
    *
from product