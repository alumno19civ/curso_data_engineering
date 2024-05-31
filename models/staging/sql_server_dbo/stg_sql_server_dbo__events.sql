{{ config(materialized="view") }}
-- Estamos indicando que este modelo se materializará en nuestro DW como una vista.
-- No es obligatorio definir la materialización en cada modelo (.sql) sino que se
-- puede definir para conjuntos de modelos en el fichero dbt_project.yml
with
    base_events as (
        select * from {{ ref("base_sql_server_dbo__events") }}  -- referencia al source que vamos a utilizar
    ),

    renamed_casted as (
        select
            event_id,
            page_url,
            md5(event_type) as event_type_id,
            user_id,
            nullif(product_id,'') as product_id,
            session_id,
            convert_timezone('UTC',created_at)::date as created_at,
            nullif(order_id,'') as order_id,
            coalesce(_fivetran_deleted,false) as date_deleted,
            convert_timezone('UTC',_fivetran_synced) as date_load
        from base_events
    )
-- estamos creando un modelo de staging
select *
from renamed_casted