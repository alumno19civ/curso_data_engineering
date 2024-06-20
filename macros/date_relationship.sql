{% test date_relationship(model, column_name, extra_column) %}

select *
from {{ model }}
where {{ column_name }} > {{ extra_column }}

{% endtest %}