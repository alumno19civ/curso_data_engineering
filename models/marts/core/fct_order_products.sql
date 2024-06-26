{{ config(
    materialized='incremental',
    unique_key = 'order_item_id'
    ) 
}}
    
   
with 
    stg_orders as (
        select * from {{ ref("stg_sql_server_dbo__orders") }}  -- referencia al base que vamos a utilizar
    ),

    int_order_item_price as (
        select * from {{ ref("int_order_item_price") }}  -- referencia al base que vamos a utilizar
    ),

    stg_tracking as (
        select * from {{ ref("stg_sql_server_dbo__tracking") }}  -- referencia al base que vamos a utilizar
    ),

    fct_order_products as (
        select
            b.order_item_id
            , a.order_id
            , b.product_id
            , a.user_id
            , a.address_id
            , a.promo_id
            , a.tracking_status_id
            , c.shipping_service_id
            , b.quantity
            , b.total_price_xproduct
            , a.order_cost
            , b.shipping_cost_xproduct
            , a.shipping_cost            
            , a.order_total
            , round(a.order_total - (a.order_cost + a.shipping_cost)) as total_discount
            , b.created_at as date_of_order
            , c.delivered_at
            , b.date_load
        from stg_orders a
        left join int_order_item_price b
            on a.order_id = b.order_id
        left join stg_tracking c
            on a.tracking_id = c.tracking_id
        order by order_id
    )

select * 
from fct_order_products


{% if is_incremental() %}

  where date_load > (select max(date_load) from {{ this }})

{% endif %}