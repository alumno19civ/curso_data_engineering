with
    base_orders as (
        select * from {{ ref("base_sql_server_dbo__orders") }}  -- referencia al source que vamos a utilizar
    ),

    renamed_casted as (
        select distinct
            order_id,
            user_id,
            address_id,
            created_at,
            case 
                when promo_id = '' then md5('sin promocion') 
            else {{dbt_utils.generate_surrogate_key(['promo_id'])}} end as promo_id,
            order_cost,
            order_total,
            shipping_cost,
            tracking_id,
            case 
                when status like 'preparing' then 0
                when status like 'shipped' then 1
                when status like 'delivered' then 2
            end as tracking_status_id,
            date_deleted,
            date_load
        from base_orders
    )
-- estamos creando un modelo de staging
select *
from renamed_casted
