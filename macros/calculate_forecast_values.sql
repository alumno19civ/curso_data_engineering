
{% macro calculate_forecast_values(created_at, month_col, data) %}
    case
        when month({{ created_at }}) = month({{ month_col }}) and year({{ created_at }}) = year({{ month_col }})
        then {{ data }}
        else null
    end
{% endmacro %}