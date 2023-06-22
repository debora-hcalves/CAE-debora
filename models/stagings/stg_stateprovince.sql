select
    stateprovinceid as stateprovince_id,
    territoryid as territory_id,
    countryregioncode as countryregion_code,
    name as name_state
from {{source('sap_adw','stateprovince')}}
