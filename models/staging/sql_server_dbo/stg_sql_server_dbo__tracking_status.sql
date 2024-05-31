with
    base_orders as (
        select * from {{ ref("base_sql_server_dbo__orders") }}  -- referencia al base que vamos a utilizar
    ),

    tracking_status as (
        select distinct
        case 
            when status like 'preparing' then 0
            when status like 'shipped' then 1
            when status like 'delivered' then 2
        end as tracking_status_id
        , status as description
        from base_orders
    )

    select *
    from tracking_status
    order by tracking_status_id
