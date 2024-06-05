with
    stg_tracking_status as (
        select * from {{ ref("stg_sql_server_dbo__tracking_status") }}  -- referencia al base que vamos a utilizar
    ),

    tracking_status as (
        select 
        tracking_status_id
        , description
        from stg_tracking_status
    )

    select *
    from tracking_status
    order by tracking_status_id
