with
    src_promos as (
        select * from {{ source("sql_server_dbo", "PROMOS") }}  -- referencia al source que vamos a utilizar
    ),

    renamed_casted as (
        select
            promo_id
            , discount as discount_dollars  --el descuento es el descuento total en dolares, no un porcentaje
            , status
            , coalesce(_fivetran_deleted,false) as date_deleted
            , convert_timezone('UTC',_fivetran_synced) as date_load
        from src_promos
    )

select *
from renamed_casted