with
    stg_status  as (
        select * from {{ ref("stg_sql_server_dbo__status") }}  -- referencia al source que vamos a utilizar
    ),

    status as (
        select 
        status_id
        ,  description
        from stg_status
    )

    select *
    from status