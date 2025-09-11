
--lista con las tablas y columnas a utilizar para realizar la union de tablas
{%- set regional_sales_sources = [
    'REGIONAL_SALES_EU',
    'REGIONAL_SALES_NA',
    'REGIONAL_SALES_APAC'
] -%}


{%- set core_columns = [
    'order_id',
    'order_date',
    'customer_id',
    'product_id',
    'quantity',
    'total_amount'
] -%}


--SELECT dentro del ciclo a fin de cambiar dinamicamente la tabla en el regional_sales_sources
{% for sales_source_relation in regional_sales_sources %}
SELECT 
    '{{ sales_source_relation }}' AS sales_region_table,  --columna con la tabla de donde proviene la informacion
    {% for column_name in core_columns -%}               --columna de column_core en una tabla especifica
    {{ column_name }}
    {%- if not loop.last %}, {% endif %}                --continua analizando la lista mientras existan comas separadoras           
    {%- endfor %}
FROM {{ source('raw_bi_car', sales_source_relation) }} 
{% if not loop.last %}                                  --mientras no sea el ultimo registro de la lista de tablas
UNION ALL
{% endif %}
{%endfor %}



/*
SELECT 
    REGIONAL_SALES_EU AS sales_region_table,
    order_id, order_date, customer_id, product_id, quantity, total_amount
FROM DATABOOSTERS.PUBLIC.REGIONAL_SALES_EU 

UNION ALL


SELECT 
    REGIONAL_SALES_NA AS sales_region_table,
    order_id, order_date, customer_id, product_id, quantity, total_amount
FROM DATABOOSTERS.PUBLIC.REGIONAL_SALES_NA 

UNION ALL


SELECT 
    REGIONAL_SALES_APAC AS sales_region_table,
    order_id, order_date, customer_id, product_id, quantity, total_amount
FROM DATABOOSTERS.PUBLIC.REGIONAL_SALES_APAC 
*/