{% macro interest_rate_calc(balance, has_loan) %}
(
    case
        when {{ balance }} < 10000 then 0.01
        when {{ balance }} < 20000 then 0.015
        else 0.02
    end
    +
    case
        when {{ has_loan }} then 0.005
        else 0
    end
)
{% endmacro %}