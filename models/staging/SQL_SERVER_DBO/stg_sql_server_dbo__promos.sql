
WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'PROMOS') }} --referencia al source que vamos a utilizar
    ),

renamed_casted AS (
    SELECT
          PROMO_ID
        , DISCOUNT
        , STATUS
        , _FIVETRAN_DELETED AS date_deleted
        , _FIVETRAN_SYNCED AS date_load
    FROM src_promos
    )
--estamos creando un modelo de staging
SELECT * FROM renamed_casted