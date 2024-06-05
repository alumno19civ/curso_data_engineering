with 
    stg_orders as (
        select * from {{ ref("stg_sql_server_dbo__orders") }}  -- referencia al base que vamos a utilizar
    ),

    stg_order_items as (
        select * from {{ ref("stg_sql_server_dbo__order_items") }}  -- referencia al base que vamos a utilizar
    ),

    stg_products as (
        select * from {{ ref("stg_sql_server_dbo__products") }}  -- referencia al base que vamos a utilizar
    ),

    fct_order_products as (
        select
            a.order_id
            , b.product_id
            , b.quantity
            , c.price
            , b.quantity * c.price as total_price_xproduct
            , round(a.shipping_cost*(b.quantity * c.price / a.order_cost),2) as shipping_cost_xproduct
        from stg_orders a
        left join stg_order_items b
            on a.order_id = b.order_id
        left join stg_products c
            on b.product_id = c.product_id
        order by order_id
    )

select * 
from fct_order_products