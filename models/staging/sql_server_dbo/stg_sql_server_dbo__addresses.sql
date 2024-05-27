{{ config(materialized="view") }}
-- Estamos indicando que este modelo se materializará en nuestro DW como una vista.
-- No es obligatorio definir la materialización en cada modelo (.sql) sino que se
-- puede definir para conjuntos de modelos en el fichero dbt_project.yml
with
    src_addresses as (
        select * from {{ source("sql_server_dbo", "ADDRESSES") }}  -- referencia al source que vamos a utilizar
    ),

    renamed_casted as (
        select
            address_id,
            zipcode,
            country,
            address,
            state,
            _fivetran_deleted as date_deleted,
            _fivetran_synced as date_load
        from src_addresses
    )
-- estamos creando un modelo de staging
select *
from renamed_casted
