with
    src_events as (
        select * from {{ source("sql_server_dbo", "EVENTS") }}  -- referencia al source que vamos a utilizar
    ),

    renamed_casted as (
        select
            event_id,
            page_url,
            event_type,
            user_id,
            nullif(product_id,'') as product_id,
            session_id,
            convert_timezone('UTC',created_at)::date as created_at,
            nullif(order_id,'') as order_id,
            coalesce(_fivetran_deleted,false) as date_deleted,
            convert_timezone('UTC',_fivetran_synced) as date_load
        from src_events
    )
-- estamos creando un modelo de staging
select *
from renamed_casted
