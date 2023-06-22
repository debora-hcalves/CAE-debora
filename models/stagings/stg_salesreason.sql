select
    salesreasonid as salesreason_id,
    name as name_reason
from {{source('sap_adw','salesreason')}}