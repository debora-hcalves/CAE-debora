with address as (
    select
        address_id
        , city
        , stateprovince_id
    from {{ ref('stg_address') }}
)

, shippedto as (
    select
        salesorder_id
        , address_id
        , territory_id
    from {{ ref('stg_salesorderheader') }}
)

, stateprovince as (
    select
        stateprovince_id
        , name_state
        , territory_id
        , countryregion_code
    from {{ ref('stg_stateprovince') }}
)

, countryregion as (
    select
        countryregion_code
        , name_country
    from {{ ref('stg_countryregion') }}
)

, territory as (
    select
        territory_id
        , name_territory
        , countryregion_code
    from {{ ref('stg_salesterritory') }}
)

, join_shipped_address as (
    select
        st.address_id
        , st.salesorder_id
        , row_number () over (partition by st. address_id order by st.salesorder_id) as row_address_id
        , a.city
        , a.stateprovince_id
    from shippedto as st
    left join address as a on st.address_id = a.address_id
)

, join_address_state as (
    select
        jsa.address_id
        , jsa.row_address_id
        , jsa.city
        , sp. name_state
        , sp.countryregion_code
        , sp.territory_id
    from join_shipped_address as jsa
    inner join stateprovince as sp on jsa.stateprovince_id = sp.stateprovince_id
    where jsa.row_address_id = 1
)

, join_country_territory as (
    select
        jas.address_id
        , jas.city
        , jas.name_state
        , cr.name_country
        , t.name_territory
    from join_address_state as jas
    inner join countryregion as cr on jas.countryregion_code = cr.countryregion_code
    inner join territory as t on jas.territory_id = t.territory_id
)

select *
from join_country_territory
order by address_id

