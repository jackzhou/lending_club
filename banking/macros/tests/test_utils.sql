{% macro assert_equal(actual_cte='actual', expected_cte='expected') %}

    select * from {{ actual_cte }}  except select * from {{ expected_cte }}
    union all
    select * from {{ expected_cte }} except select * from {{ actual_cte }}
    
{% endmacro %}