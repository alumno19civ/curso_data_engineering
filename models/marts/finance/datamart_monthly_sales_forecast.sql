with
    dim_products as (
        select * from {{ ref('dim_products') }}
    ),

    fct_op as (
        select distinct
            product_id,
            date_of_order,
            sum(quantity) over (partition by product_id order by month(date_of_order) and year(date_of_order)) as actual_quantity,
            round(sum(total_price_xproduct) over (partition by product_id order by month(date_of_order) and year(date_of_order)), 2) as actual_gains
        from {{ ref('fct_order_products') }}
    ),

    stg_budget as (
        select * from {{ ref('fct_budget') }}
    ),

    dtm_forecast as (
        select
            a.product_id
            , year(b.date_of_order) as year
            , month(c.month) as month
            , c.quantity as budgeted_quantity
            , {{calculate_forecast_values('b.date_of_order', 'c.month', 'b.actual_quantity')}} AS actual_quantity
            , round(c.quantity * a.price,2) as budgeted_gains
            , {{calculate_forecast_values('b.date_of_order', 'c.month', 'b.actual_gains')}} AS actual_gains
            , round({{calculate_forecast_difference('b.date_of_order', 'c.month', 'b.actual_quantity', 'c.quantity')}},2) AS quantity_difference
            , round({{calculate_forecast_difference('b.date_of_order', 'c.month', 'b.actual_gains', 'c.quantity * a.price')}},2) AS gains_difference

        from dim_products as a
        inner join fct_op as b
            on a.product_id = b.product_id
        inner join stg_budget as c
            on a.product_id = c.product_id
    )

select distinct *
from dtm_forecast
order by year, month
