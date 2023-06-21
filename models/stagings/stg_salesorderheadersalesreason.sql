select
    salesorderid as salesorder_id,
    salesreasonid as salesreason_id
from {{source('sap_adw','salesorderheadersalesreason')}}