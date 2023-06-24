with 
    creditcard as (
        select
            creditcardid as creditcard_id
            , cardtype as card_type
        from {{source('sap_adw','creditcard')}}
    )

select * 
from creditcard
order by creditcard_id