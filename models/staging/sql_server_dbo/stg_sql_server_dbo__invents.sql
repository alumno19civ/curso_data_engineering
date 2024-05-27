WITH src_invents AS (
    select *
    from {{ref('stg_sql_server_dbo__events')}}
),

users as (
    select * 
    from {{ref('stg_sql_server_dbo__users')}}
),

final as (
    select users.USER_ID
    , EVENT_TYPE   
    , EVENT_ID 
    from src_invents
    join users
    on users.user_id = src_invents.user_id
)

SELECT *
FROM final