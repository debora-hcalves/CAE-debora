select
    territoryid as territory_id,
    name as name_territory,
    countryregioncode as countryregion_code
from {{source('sap_adw','salesterritory')}}