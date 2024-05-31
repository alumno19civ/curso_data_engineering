--creamos un fichero base ya que vamos a normalizar esta tabla.
-- además se usará para users y así no dependerá de source_orders 
with
    src_orders as (
        select * from {{ source("sql_server_dbo", "ORDERS") }}  -- referencia al source que vamos a utilizar
    ),

    renamed_casted as (
        select
            order_id,
            user_id,
            shipping_service,
            shipping_cost,
            address_id,
            created_at,
            promo_id,
            estimated_delivery_at,
            order_cost,
            order_total,
            delivered_at,
            tracking_id,
            status,
            _fivetran_deleted,
           _fivetran_synced
        from src_orders
    )

select *
from renamed_casted
