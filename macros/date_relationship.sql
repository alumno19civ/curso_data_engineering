{% test date_relationship(model, column_name, extra_column) %}

select
    count(*)
from {{ model }}
where {{ column_name }} > {{ extra_column }}
having count(*)> 1

{% endtest %}