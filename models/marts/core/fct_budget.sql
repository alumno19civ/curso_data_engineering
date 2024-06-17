{{ config(
    materialized='incremental',
    unique_key = '_row'
    ) 
}}

WITH stg_budget AS (
    select * from {{ ref("stg_google_sheets__budget") }} --referencia al source que vamos a utilizar
    ),

renamed_casted AS (
    SELECT
          _row
        , product_id
        , quantity
        , month
        , date_load
    FROM stg_budget
    )
--estamos creando un modelo de staging
SELECT * FROM renamed_casted


{% if is_incremental() %}

  where date_load > (select max(date_load) from {{ this }})

{% endif %}