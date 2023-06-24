with
    person as(
        select *
        from {{ ref('stg_person') }}
    )
    , creditcard as (
        select *
        from {{ ref('stg_creditcard') }}
    )

select count(creditcard_id) as qnt
from creditcard 
--left join creditcard as cc on p.person_id = cc.creditcard_id