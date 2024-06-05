WITH int_date AS (
    {{ dbt_date.get_date_dimension("2020-01-01", "2030-12-31") }} 

)

SELECT
    date_day AS date_id,
    day_of_week,
    day_of_week_name,
    day_of_month,
    day_of_year,
    week_of_year,
    month_name,
    month_of_year,
    quarter_of_year,
    year_number
FROM int_date
