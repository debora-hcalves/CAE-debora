select
    productid as product_id,
    name as name_product
from {{source('sap_adw','product')}}