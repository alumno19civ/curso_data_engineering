with
    src_users as (
        select * from {{ source("sql_server_dbo", "USERS") }}  -- referencia al source que vamos a utilizar
    ),

    renamed_casted as (
        select
            user_id,
            updated_at,
            address_id,
            last_name,
            created_at,
            phone_number,
            total_orders,
            first_name,
            email,
            _fivetran_deleted as date_deleted,
            _fivetran_synced as date_load
        from src_users
    )
-- estamos creando un modelo de staging
select *
from renamed_casted
