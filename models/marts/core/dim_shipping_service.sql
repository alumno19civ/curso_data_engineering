with
    stc_orders as (
        select * from {{ ref("stg_sql_server_dbo__shipping_service") }}  -- referencia al source que vamos a utilizar
    ),

    shipping_service as (
        select
            shipping_service_id,
            shipping_service
        from stc_orders
    )
-- estamos creando un modelo de staging
select *
from shipping_service