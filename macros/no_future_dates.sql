{% test no_future_dates(model, column_name) %}
   
   select * --*
   from {{ model }}
   where {{column_name}} > CURRENT_TIMESTAMP
  -- having count(*) > 1

{% endtest %}
