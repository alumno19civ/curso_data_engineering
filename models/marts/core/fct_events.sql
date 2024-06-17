{{ config(
    materialized='incremental',
    unique_key = 'event_id'
    ) 
}}

with 
    stg_events AS (
        select * from {{ ref('stg_sql_server_dbo__events') }}
),

fct_events AS (
    SELECT
        event_id,
        event_type_id,
        user_id,
        session_id,
        page_url,
        product_id,
        order_id,
        created_at,
        date_load
    FROM stg_events
)

SELECT * FROM fct_events

{% if is_incremental() %}

  where date_load > (select max(date_load) from {{ this }})

{% endif %}