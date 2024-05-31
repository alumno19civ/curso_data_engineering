with
    src_orders as (
        select * from {{ ref("base_sql_server_dbo__orders") }}  -- referencia al source que vamos a utilizar
    ),

    renamed_casted as (
        select
            tracking_id,
            md5(shipping_service) as shipping_service_id,
            shipping_cost,
            convert_timezone('UTC',estimated_delivery_at) as estimated_delivery_at,
            convert_timezone('UTC',delivered_at) as delivered_at
        from src_orders
        where tracking_id!=''
    )
-- estamos creando un modelo de staging
select *
from renamed_casted
