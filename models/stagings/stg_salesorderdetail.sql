with
    salesorderdetail as (
        select 
            salesorderdetailid as orderdetail_id
            , salesorderid as salesorder_id
            , orderqty as order_qty
            , productid as product_id
            , unitprice as unit_price
            , unitpricediscount as unit_discount
       from {{source('sap_adw','salesorderdetail')}}
    )

select *
from salesorderdetail
order by orderdetail_id