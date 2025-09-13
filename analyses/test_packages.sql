
--genera una llave hash única para cada fila, basada en la combinación de dos campos de una tabla
SELECT
    {{dbt_utils.generate_surrogate_key(['CARMAKE', 'SALESPERSON']) }} AS ID
FROM {{ ref("psg_montly_sales_make") }}