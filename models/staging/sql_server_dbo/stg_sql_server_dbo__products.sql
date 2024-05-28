with
    src_products as (
        select * from {{ source("sql_server_dbo", "PRODUCTS") }}  -- referencia al source que vamos a utilizar
    ),

    renamed_casted as (
        select
            product_id,
            price,
            name,
            inventory,
            coalesce(_fivetran_deleted,false) as date_deleted,
            convert_timezone('UTC',_fivetran_synced) as date_load -- hacemos el cambio de zona horaria porque no era el correcto; ahora en la tabla sale '20-....00+00:00'
        from src_products
    )
-- estamos creando un modelo de staging
select *
from renamed_casted
