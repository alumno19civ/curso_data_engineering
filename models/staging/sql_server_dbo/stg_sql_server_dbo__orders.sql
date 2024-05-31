with
    base_orders as (
        select * from {{ ref("base_sql_server_dbo__orders") }}  -- referencia al source que vamos a utilizar
    ),

    renamed_casted as (
        select
            order_id,
            user_id,
            address_id,
            convert_timezone('UTC',created_at)::date as created_at,
            case 
                when promo_id = '' then md5('sin promocion') 
            else md5(promo_id) end as promo_id,
            order_cost,
            order_total,
            nullif(tracking_id,'') as tracking_id,
            case 
                when status like 'preparing' then 0
                when status like 'shipped' then 1
                when status like 'delivered' then 2
            end as tracking_status_id,
            coalesce(_fivetran_deleted,false) as date_deleted,
            convert_timezone('UTC',_fivetran_synced) as date_load
        from base_orders
    )
-- estamos creando un modelo de staging
select *
from renamed_casted
