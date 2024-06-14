with
    src_events as (
        select * from {{ ref("base_sql_server_dbo__events") }}  -- referencia al source que vamos a utilizar
    ),

    event_type as (
        select distinct
            {{dbt_utils.generate_surrogate_key(['event_type'])}} as event_type_id,
            event_type
        from src_events
    )
-- estamos creando un modelo de staging
select *
from event_type
