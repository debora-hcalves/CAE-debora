with
    salesorderdetail as (
        select 

            -- primary key
            salesorderdetailid as orderdetail_id

            -- foreign keys
            , salesorderid as salesorder_id
            , productid as product_id

            -- order informations
            , orderqty as order_qty
            , unitprice as unit_price
            , unitpricediscount as unit_discount

       from {{ source('sap_adw','salesorderdetail') }}
    )

select *
from salesorderdetail
