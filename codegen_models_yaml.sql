
-- codegen para generar yml de modelos stg de sql_server_dbo
{{ codegen.generate_model_yaml(
    model_names= ['stg_sql_server_dbo__addresses','stg_sql_server_dbo__event_type','stg_sql_server_dbo__events',
    'stg_sql_server_dbo__order_items','stg_sql_server_dbo__orders','stg_sql_server_dbo__products','stg_sql_server_dbo__promos',
    'stg_sql_server_dbo__shipping_service','stg_sql_server_dbo__status','stg_sql_server_dbo__tracking','stg_sql_server_dbo__tracking_status',
    'stg_sql_server_dbo__users']
) }}

-- codegen para generar yml de las bases de sql_server_dbo
{{ codegen.generate_model_yaml(
    model_names= ['base_sql_server_dbo__promos','base_sql_server_dbo__orders','base_sql_server_dbo__events']
) }}

-- codegen google_sheets
{{ codegen.generate_model_yaml(
    model_names= ['stg_google_sheets__budget']
) }}

-- codegen para generar yml de modelos de marts
{{ codegen.generate_model_yaml(
    model_names= ['dim_addresses','dim_products','dim_promo','dim_event_type',
    'dim_shipping_service','dim_status','dim_time','dim_users','dim_budget',
    'dim_tracking_status','fct_order_products','fct_monthly_sales_forecast']
) }}
