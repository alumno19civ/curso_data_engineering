with
    src_promos as (
        select * from {{ source("sql_server_dbo", "PROMOS") }}  -- referencia al source que vamos a utilizar
    ),

    renamed_casted as (
        select
            promo_id
            , discount  --el descuento es el descuento total en dolares, no un porcentaje
            , status
            , _fivetran_deleted
            , _fivetran_synced
        from src_promos
    )

select *
from renamed_casted