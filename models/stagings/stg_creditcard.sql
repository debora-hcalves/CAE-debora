select
    creditcardid as creditcard_id,
    cardtype as card_type
from {{source('sap_adw','creditcard')}}