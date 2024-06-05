with
        stg_users as (
        select * from {{ ref("stg_sql_server_dbo__users") }}  -- referencia al source que vamos a utilizar
    ),

    renamed_casted as (
        select distinct
            user_id,
            first_name,
            last_name,
            email,
            phone_number,
            total_orders
        from stg_users
    )
-- estamos creando un modelo de staging
select *
from renamed_casted
