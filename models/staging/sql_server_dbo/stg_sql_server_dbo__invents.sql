with
    src_invents as (select * from {{ ref("stg_sql_server_dbo__events") }}),

    users as (select * from {{ ref("stg_sql_server_dbo__users") }}),

    final as (
        select users.user_id, event_type, event_id
        from src_invents
        join users on users.user_id = src_invents.user_id
    )

select *
from final
