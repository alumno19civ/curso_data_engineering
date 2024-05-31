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
            product_id,
            session_id,
            created_at,
            order_id,
            _fivetran_deleted,
            _fivetran_synced
        from src_events
    )
-- estamos creando un modelo de staging
select *
from renamed_casted
