     
{{
  config(
    materialized='view' 
  )
}}
--Estamos indicando que este modelo se materializará en nuestro DW como una vista.
--No es obligatorio definir la materialización en cada modelo (.sql) sino que se puede definir para conjuntos de modelos en el fichero dbt_project.yml

WITH src_events AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'EVENTS') }} --referencia al source que vamos a utilizar
    ),

renamed_casted AS (
    SELECT
          EVENT_ID
        , PAGE_URL
        , EVENT_TYPE
        , USER_ID
        , PRODUCT_ID
        , SESSION_ID
        , CREATED_AT
        , ORDER_ID
        , _FIVETRAN_DELETED AS date_deleted
        , _FIVETRAN_SYNCED AS date_load
    FROM src_events
    )
--estamos creando un modelo de staging
SELECT * FROM renamed_casted