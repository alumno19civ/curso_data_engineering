
{{
  config(
    materialized='view' 
  )
}}
--Estamos indicando que este modelo se materializará en nuestro DW como una vista.
--No es obligatorio definir la materialización en cada modelo (.sql) sino que se puede definir para conjuntos de modelos en el fichero dbt_project.yml

WITH src_budget AS (
    SELECT * 
    FROM {{ source('google_sheets', 'budget') }} --referencia al source que vamos a utilizar
    ),

renamed_casted AS (
    SELECT
          _row
        , product_id
        , quantity
        , month
        , convert_timezone('UTC',_fivetran_synced)::date as date_load
    FROM src_budget
    )
--estamos creando un modelo de staging
SELECT * FROM renamed_casted