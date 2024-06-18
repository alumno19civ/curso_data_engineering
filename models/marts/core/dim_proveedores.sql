with
    stg_proveedores as (
        select * from {{ ref("stg_sql_server_dbo__proveedores") }}  -- referencia al source que vamos a utilizar
    ),

    renamed_casted as (
        select *
        from stg_proveedores
    )
-- estamos creando un modelo de staging
select *
from renamed_casted