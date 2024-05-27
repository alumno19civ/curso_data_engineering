
WITH src_order_items AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'ORDER_ITEMS') }} --referencia al source que vamos a utilizar
    ),

renamed_casted AS (
    SELECT
          ORDER_ID
        , PRODUCT_ID
        , QUANTITY
        , _FIVETRAN_DELETED AS date_deleted
        , _FIVETRAN_SYNCED AS date_load
    FROM src_order_items
    )
--estamos creando un modelo de staging
SELECT * FROM renamed_casted