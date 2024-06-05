with
    stg_addresses as (
        select * from {{ ref("stg_sql_server_dbo__addresses") }}  -- referencia al source que vamos a utilizar
    ),

    renamed_casted as (
        select
            address_id,
            address,
            zipcode,
            state,
            country            
        from stg_addresses
    )
-- estamos creando un modelo de staging
select *
from renamed_casted
