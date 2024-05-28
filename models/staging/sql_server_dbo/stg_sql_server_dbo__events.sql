{{ config(materialized="view") }}
-- Estamos indicando que este modelo se materializará en nuestro DW como una vista.
-- No es obligatorio definir la materialización en cada modelo (.sql) sino que se
-- puede definir para conjuntos de modelos en el fichero dbt_project.yml
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
            coalesce(_fivetran_deleted,false) as date_deleted,
            convert_timezone('UTC',_fivetran_synced) as date_load
        from src_events
    )
-- estamos creando un modelo de staging
select *
from renamed_casted
