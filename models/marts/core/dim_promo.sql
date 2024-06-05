with
    stg_promos as (
        select * from {{ ref("stg_sql_server_dbo__promos") }}  -- referencia al source que vamos a utilizar
    ),

    renamed_casted as (
        select
            promo_id
            , description
            , discount_dollars --el descuento es el descuento total en dolares, no un porcentaje
            , status_id as status
        from stg_promos
    )
-- estamos creando un modelo de staging
select *
from renamed_casted