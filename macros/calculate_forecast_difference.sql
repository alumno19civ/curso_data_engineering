
{% macro calculate_forecast_difference(created_at, month_col, actual, budgeted) %}
    case
        when month({{ created_at }}) = month({{ month_col }}) and year({{ created_at }}) = year({{ month_col }})
        then
            case
                when {{ actual }} - {{ budgeted }} > 0
                then {{ actual }} - {{ budgeted }}
                else ({{ actual }} - {{ budgeted }}) - 2 * ({{ actual }} - {{ budgeted }})
            end
        else null
    end
{% endmacro %}
