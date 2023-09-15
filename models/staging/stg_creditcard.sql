with 
    creditcard as (
        select

            -- primary key
            creditcardid as creditcard_id

            -- card information
            , cardtype as card_type

        from {{ source('sap_adw','creditcard') }}
    )

select * 
from creditcard
