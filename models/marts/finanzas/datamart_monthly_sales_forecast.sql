with
    stg_products as (
        select * from {{ ref("stg_sql_server_dbo__products") }}
    ),

    int_order_item_price as (
        select distinct
            product_id
            , price
            , created_at
            , sum(quantity) over (partition by product_id order by month(created_at) and year(created_at)) as actual_quantity
            , round(sum(total_price_xproduct) over (partition by product_id order by month(created_at) and year(created_at)),2) as actual_gains
            , 
        from {{ ref("int_order_item_price") }}
    ),

    stg_budget as (
        select * from {{ ref("stg_google_sheets__budget") }}
    ),

    fct_forecast as (
        select
            a.product_id
            , year(b.created_at) as year
            , month(c.month) as month
            , c.quantity as budgeted_quantity
            , {{ calculate_forecast_values('b.created_at', 'c.month', 'b.actual_quantity') }} AS actual_quantity
            , round(c.quantity * b.price,2) as budgeted_gains
            , {{ calculate_forecast_values('b.created_at', 'c.month', 'b.actual_gains') }} AS actual_gains
            , round({{ calculate_forecast_difference('b.created_at', 'c.month', 'b.actual_quantity', 'c.quantity') }},2) AS quantity_difference
            , round({{ calculate_forecast_difference('b.created_at', 'c.month', 'b.actual_gains', 'c.quantity * b.price') }},2) AS gains_difference
    
        from stg_products as a
        inner join int_order_item_price as b
            on a.product_id = b.product_id
        inner join stg_budget as c
            on a.product_id = c.product_id
    )

select distinct *
from fct_forecast
order by year, month