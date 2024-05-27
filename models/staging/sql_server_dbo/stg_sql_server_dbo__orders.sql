with
    src_orders as (
        select * from {{ source("sql_server_dbo", "ORDERS") }}  -- referencia al source que vamos a utilizar
    ),

    renamed_casted as (
        select
            order_id,
            shipping_service,
            shipping_cost,
            address_id,
            created_at,
            promo_id,
            estimated_delivery_at,
            order_cost,
            user_id,
            order_total,
            delivered_at,
            tracking_id,
            status,
            _fivetran_deleted as date_deleted,
            _fivetran_synced as date_load
        from src_orders
    )
-- estamos creando un modelo de staging
select *
from renamed_casted
