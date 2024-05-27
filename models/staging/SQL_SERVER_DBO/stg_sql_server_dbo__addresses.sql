     
{{
  config(
    materialized='view' 
  )
}}
--Estamos indicando que este modelo se materializará en nuestro DW como una vista.
--No es obligatorio definir la materialización en cada modelo (.sql) sino que se puede definir para conjuntos de modelos en el fichero dbt_project.yml

WITH src_addresses AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'ADDRESSES') }} --referencia al source que vamos a utilizar
    ),

renamed_casted AS (
    SELECT
          ADDRESS_ID
        , ZIPCODE
        , COUNTRY
        , ADDRESS
        , STATE
        , _fivetran_deleted AS date_deleted
        , _fivetran_synced AS date_load
    FROM src_addresses
    )
--estamos creando un modelo de staging
SELECT * FROM renamed_casted