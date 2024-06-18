with 

src_prov as (

    select * from {{ source('sql_server_dbo', 'PROVEEDORES') }}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['proveedores_id']) }} as proveedores_id,
        proveedores_id as _row,
        first_name,
        last_name,
        email,
        address,
        data_load

    from src_prov

)

select * from renamed
