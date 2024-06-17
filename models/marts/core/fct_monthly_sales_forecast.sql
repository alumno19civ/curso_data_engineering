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
  --          , case
  --              when
  --                  month(b.created_at) = month(c.month)
  --                  and year(b.created_at) = year(c.month)
  --                  then b.actual_quantity
  --            end as actual_quantity
            , {{ calculate_forecast_values('b.created_at', 'c.month', 'b.actual_quantity') }} AS actual_quantity
            , round(c.quantity * b.price,2) as budgeted_gains
  --          , case 
  --              when month(b.created_at) = month(c.month) and year(b.created_at) = year(c.month) then b.actual_gains
  --              else null
  --            end as actual_gains
            , {{ calculate_forecast_values('b.created_at', 'c.month', 'b.actual_gains') }} AS actual_gains
  --          , case
  --              when month(b.created_at) = month(c.month) and year(b.created_at) = year(c.month) 
  --                  and actual_quantity - budgeted_quantity > 0 
  --                  then actual_quantity - budgeted_quantity
  --              when month(b.created_at) = month(c.month) and year(b.created_at) = year(c.month) 
  --                  and actual_quantity - budgeted_quantity <= 0 
  --                  then (actual_quantity - budgeted_quantity) - 2*(actual_quantity - budgeted_quantity)
  --              else null
  --            end as quantity_difference
            , {{ calculate_forecast_difference('b.created_at', 'c.month', 'b.actual_quantity', 'c.quantity') }} AS quantity_difference
  --          , case
  --              when month(b.created_at) = month(c.month) and year(b.created_at) = year(c.month) 
  --                  and actual_gains - budgeted_gains > 0 
  --                  then round(actual_gains - budgeted_gains,2)
  --              when month(b.created_at) = month(c.month) and year(b.created_at) = year(c.month) 
  --                  and actual_gains - budgeted_gains <= 0 
  --                  then round((actual_gains - budgeted_gains) - 2*(actual_gains - budgeted_gains),2)
  --              else null
  --            end as gains_difference
            , {{ calculate_forecast_difference('b.created_at', 'c.month', 'b.actual_gains', 'c.quantity * b.price') }} AS gains_difference
    


           -- , total_price_xproduct
        from stg_products as a
        inner join int_order_item_price as b
            on a.product_id = b.product_id
        inner join stg_budget as c
            on a.product_id = c.product_id
      --  order by order_id
    )

select distinct *
from fct_forecast
order by year, month