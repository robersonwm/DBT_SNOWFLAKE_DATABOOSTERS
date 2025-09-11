{{ config(tags=['dash_sales_bi']) }}

SELECT 
    --llama a la macro que contiene la funcion "generate_id"
    {{generate_id('CARMAKE')}} AS ID_CARMAKE,
    CARMAKE
FROM {{ ref("psg_montly_sales_make") }}
GROUP BY CARMAKE 


/*
SELECT 
RANK() OVER(ORDER BY CARMAKE)
 AS ID_CARMAKE,
    CARMAKE
FROM DATABOOSTERS.dbt_rmiranda.psg_montly_sales_make
GROUP BY CARMAKE
*/