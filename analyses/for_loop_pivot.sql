{% set target_makes = ['Nissan', 'Honda', 'Chevolet', 'Ford', 'Toyota'] %}

SELECT DDATE, SALESPERSON,
{% for make in target_makes %}
SUM(CASE WHEN CARMAKE = '{{ make }}' THEN TOTALSALE ELSE 0 END) AS sales_{{ make | lower }} {% if not loop.last  %},{% endif %}
{% endfor %}
FROM {{ ref("psg_montly_sales_make") }}
GROUP BY DDATE, SALESPERSON

/*
SELECT DDATE, SALESPERSON,
SUM(CASE WHEN CARMAKE = 'Nissan' THEN TOTALSALE ELSE 0 END) AS sales_nissan ,
SUM(CASE WHEN CARMAKE = 'Honda' THEN TOTALSALE ELSE 0 END) AS sales_honda ,
SUM(CASE WHEN CARMAKE = 'Chevolet' THEN TOTALSALE ELSE 0 END) AS sales_chevolet ,
SUM(CASE WHEN CARMAKE = 'Ford' THEN TOTALSALE ELSE 0 END) AS sales_ford ,
SUM(CASE WHEN CARMAKE = 'Toyota' THEN TOTALSALE ELSE 0 END) AS sales_toyota 
FROM DATABOOSTERS.dbt_rmiranda.psg_montly_sales_make
GROUP BY DDATE, SALESPERSON
*/