with
    src_order_items as (
        select * from {{ source("sql_server_dbo", "ORDER_ITEMS") }}  -- referencia al source que vamos a utilizar
    ),

    renamed_casted as (
        select distinct
            {{dbt_utils.generate_surrogate_key(['order_id','product_id'])}} as order_item_id,            
            order_id,
            product_id,
            quantity,
            coalesce(_fivetran_deleted,false) as date_deleted,
            convert_timezone('UTC',_fivetran_synced)::date as date_load
        from src_order_items
        
    )
-- estamos creando un modelo de staging
select *
from renamed_casted
