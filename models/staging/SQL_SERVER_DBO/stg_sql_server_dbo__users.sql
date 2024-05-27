
WITH src_users AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'USERS') }} --referencia al source que vamos a utilizar
    ),

renamed_casted AS (
    SELECT
          USER_ID
        , UPDATED_AT
        , ADDRESS_ID
        , LAST_NAME
        , CREATED_AT
        , PHONE_NUMBER
        , TOTAL_ORDERS
        , FIRST_NAME
        , EMAIL
        , _FIVETRAN_DELETED AS date_deleted
        , _FIVETRAN_SYNCED AS date_load
    FROM src_users
    )
--estamos creando un modelo de staging
SELECT * FROM renamed_casted