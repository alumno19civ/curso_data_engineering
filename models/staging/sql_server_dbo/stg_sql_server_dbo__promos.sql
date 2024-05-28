with
    src_promos as (
        select * from {{ source("sql_server_dbo", "PROMOS") }}  -- referencia al source que vamos a utilizar
    ),

    renamed_casted as (
        select
            md5(promo_id) as promo_id
            , promo_id as description
            , discount as discount_dollars --el descuento es el descuento total en dolares, no un porcentaje
            ,  case 
                 when status like 'active' then 1
                 when status like 'inactive' then 0 
            end as status_id
            , coalesce(_fivetran_deleted,false) as date_deleted
            , convert_timezone('UTC',_fivetran_synced) as date_load
        from src_promos
    ),

    no_discount as(
        select 
        md5('sin promocion') as promo_id
        , 'sin promocion' as description
        , 0 as discount_dollars
        , 1 as status_id
        , false as date_deleted
        , null as date_load
    )
-- estamos creando un modelo de staging
select *
from renamed_casted
union all
select *
from no_discount
