with
    src_orders as (
        select * from {{ source("sql_server_dbo", "ORDERS") }}  -- referencia al source que vamos a utilizar
    ),

    renamed_casted as (
        select
            order_id,
            case 
                when shipping_service = '' then 'unknown'
                else shipping_service
            end as shipping_service,
            shipping_cost,
            address_id,
            created_at,
            case 
            when promo_id = '' then md5('sin promocion') 
            else md5(promo_id) end as promo_id,
            estimated_delivery_at,
            order_cost,
            user_id,
            order_total,
            delivered_at,
            tracking_id,
            status,
            coalesce(_fivetran_deleted,false) as date_deleted,
            convert_timezone('UTC',_fivetran_synced) as date_load
        from src_orders
    )
-- estamos creando un modelo de staging
select *
from renamed_casted
