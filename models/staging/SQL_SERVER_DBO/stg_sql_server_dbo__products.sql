
WITH src_products AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'PRODUCTS') }} --referencia al source que vamos a utilizar
    ),

renamed_casted AS (
    SELECT
          PRODUCT_ID
        , PRICE
        , NAME
        , INVENTORY
        , _FIVETRAN_DELETED AS date_deleted
        , _FIVETRAN_SYNCED AS date_load
    FROM src_products
    )
--estamos creando un modelo de staging
SELECT * FROM renamed_casted