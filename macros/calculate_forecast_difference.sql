
{% macro calculate_forecast_difference(created_at, month_col, actual, budgeted) %}
    case
        when month({{ created_at }}) = month({{ month_col }}) and year({{ created_at }}) = year({{ month_col }})
            then
                {{ actual }} - {{ budgeted }}
        else null
    end
{% endmacro %}
