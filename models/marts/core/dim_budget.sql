WITH stg_budget AS (
    select * from {{ ref("stg_google_sheets__budget") }} --referencia al source que vamos a utilizar
    ),

renamed_casted AS (
    SELECT
          _row
        , product_id
        , quantity
        , month
    FROM stg_budget
    )
--estamos creando un modelo de staging
SELECT * FROM renamed_casted