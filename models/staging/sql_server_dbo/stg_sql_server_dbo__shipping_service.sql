with
    src_orders as (
        select * from {{ ref("base_sql_server_dbo__orders") }}  -- referencia al source que vamos a utilizar
    ),

    shipping_service as (
        select distinct
            {{dbt_utils.generate_surrogate_key(['shipping_service'])}} as shipping_service_id,
            shipping_service
            from src_orders
            where shipping_service != ''
    )
-- estamos creando un modelo de staging
select *
from shipping_service
