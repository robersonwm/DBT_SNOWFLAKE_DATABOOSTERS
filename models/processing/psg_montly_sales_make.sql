{{
    config(
        materialized='table',
        tag=['processing', 'sales', 'carmake']
    )
}}

--MATERIALIZA LA CONSULTA EN UNA TABLA EN SNOWFLAKE - si no se especifica materialized='table', crea una vista(VIEW)

--referecia a la capa staging - ref("stg_sales_data_202p") (bronze)
--DATE_TRUNC(): vuelve cualquier fecha al primer dia del mes correspondiente
SELECT 
    DATE_TRUNC('MONTH', DDATE) AS DDATE,
    SALESPERSON,
    CARMAKE,
    SUM(SALEPRICE - COMNEA) AS TOTALSALE,
    SUM(COMNEA) AS TOTALCOM
FROM {{ ref("stg_sales_data_202p") }}
GROUP BY DATE_TRUNC('MONTH', DDATE), SALESPERSON, CARMAKE