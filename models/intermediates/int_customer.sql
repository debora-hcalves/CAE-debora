with customer as (
    select
        customer_id
        , person_id
    from {{ ref('stg_customer') }}
)

, 