select
    countryregioncode as countryregion_code,
    name as name_country
from {{source('sap_adw','countryregion')}}