select
    salesorderid as salesorder_id,
    orderdate as order_date,
    status,
    creditcardid as creditcard_id,
    customerid as customer_id,
    territoryid as territory_id,
    shiptoaddressid as address_id
from {{source('sap_adw','salesorderheader')}}
