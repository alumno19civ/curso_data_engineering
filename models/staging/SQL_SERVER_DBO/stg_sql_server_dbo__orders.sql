
WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'ORDERS') }} --referencia al source que vamos a utilizar
    ),

renamed_casted AS (
    SELECT
          ORDER_ID
        , SHIPPING_SERVICE
        , SHIPPING_COST
        , ADDRESS_ID
        , CREATED_AT
        , PROMO_ID
        , ESTIMATED_DELIVERY_AT
        , ORDER_COST
        , USER_ID
        , ORDER_TOTAL
        , DELIVERED_AT
        , TRACKING_ID
        , STATUS
        , _FIVETRAN_DELETED AS date_deleted
        , _FIVETRAN_SYNCED AS date_load
    FROM src_orders
    )
--estamos creando un modelo de staging
SELECT * FROM renamed_casted