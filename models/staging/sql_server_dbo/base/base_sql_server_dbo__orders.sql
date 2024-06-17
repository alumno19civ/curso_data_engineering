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
            convert_timezone('UTC',created_at)::date as created_at,
            promo_id,
            estimated_delivery_at::date as estimated_delivery_at,
            order_cost,
            order_total,
            delivered_at::date as delivered_at,
            nullif(tracking_id,'') as tracking_id,
            status,
            coalesce(_fivetran_deleted,false) as date_deleted,
            convert_timezone('UTC',_fivetran_synced) as date_load
        from src_orders
    )

select *
from renamed_casted
