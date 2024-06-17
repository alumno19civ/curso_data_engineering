with
    stg_event_type  as (
        select * from {{ ref("stg_sql_server_dbo__event_type") }}  -- referencia al source que vamos a utilizar
    ),

    event_type as (
        select distinct
            event_type_id,
            event_type
        from stg_event_type
    )
    select *
    from event_type
