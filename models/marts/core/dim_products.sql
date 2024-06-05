with
    stg_products as (
        select * from {{ ref("stg_sql_server_dbo__products") }}  -- referencia al source que vamos a utilizar
    ),

    renamed_casted as (
        select
            product_id,
            name,
            price,
            inventory
        from stg_products
    )
-- estamos creando un modelo de staging
select *
from renamed_casted
