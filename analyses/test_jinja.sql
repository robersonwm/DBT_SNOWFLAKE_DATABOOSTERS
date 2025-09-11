SELECT * 
FROM {{ ref("stg_sales_data_202p") }}
LIMIT 10