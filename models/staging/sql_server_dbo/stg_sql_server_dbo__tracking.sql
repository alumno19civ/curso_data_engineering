with
    src_orders as (
        select * from {{ ref("base_sql_server_dbo__orders") }}  -- referencia al source que vamos a utilizar
    ),

    renamed_casted as (
        select
            tracking_id,
            md5(shipping_service) as shipping_service_id,
            estimated_delivery_at,
            delivered_at
        from src_orders
        where tracking_id!=''
    )
-- estamos creando un modelo de staging
select *
from renamed_casted
