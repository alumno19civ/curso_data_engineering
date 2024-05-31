with
    src_users as (
        select * from {{ source("sql_server_dbo", "USERS") }}  -- referencia al source que vamos a utilizar
    ),

    src_orders as (
        select * from {{ ref("base_sql_server_dbo__orders") }}  -- referencia al source que vamos a utilizar
    ),

    renamed_casted as (
        select distinct
            a.user_id,
            a.first_name,
            a.last_name,
            a.email,
            a.address_id,
            convert_timezone('UTC',a.created_at)::date as created_at,
            convert_timezone('UTC',a.updated_at)::date as updated_at,
            a.phone_number,
            COUNT(b.order_id) OVER (PARTITION BY b.user_id) as total_orders,
            coalesce(a._fivetran_deleted,false) as date_deleted,
            convert_timezone('UTC',a._fivetran_synced) as date_load
        from src_users a
        left join src_orders b
            on a.user_id = b.user_id
    )
-- estamos creando un modelo de staging
select *
from renamed_casted
