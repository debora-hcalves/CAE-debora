with   
    salesreason as (
        select
            salesreasonid as salesreason_id
            , name as name_reason
            , reasontype as reason_type
        from {{source('sap_adw','salesreason')}}
    )

, reason_type_id as (
    select
        salesreason_id
        , name_reason
        , case
            when salesreason_id = 1 then 1
            when salesreason_id = 5 then 1
            when salesreason_id = 6 then 1
            when salesreason_id = 9 then 1
            when salesreason_id = 10 then 1
            when salesreason_id = 3 then 2
            when salesreason_id = 4 then 2
            when salesreason_id = 7 then 2
            when salesreason_id = 8 then 2
            when salesreason_id = 2 then 3
        end as type_id
        , reason_type
    from salesreason
    )

select *
from reason_type_id