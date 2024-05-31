with
    src_promos as (
        select * from {{ ref("base_sql_server_dbo__promos") }}  -- referencia al source que vamos a utilizar
    ),

    status as (
        select distinct
        case 
            when status like 'active' then 1
            when status like 'inactive' then 0 
        end as status_id
        , status as description
        from src_promos
    )

    select *
    from status