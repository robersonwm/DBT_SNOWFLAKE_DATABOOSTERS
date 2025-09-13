{% docs desc_fct_montly_sales %}

Esta tabla de hechos es el **corazón del análisis de rendimiento de ventas**. Consolida todas las transformaciones, todas las transacciones de ventas de vehículos a nivel mensual, desglosado por:

- Vendedor
- Marca de vehiculo


**Logica de calculo clave**

- `TOTALSALE`: Se calcula como `SUM(SALESPRICE - COMMISSIONEARNED)`
- `TOTALCOM` : Se calcula como `SUM(COMMISSIONEARNED)`


**Fuentes principales**

- Deriva sus datos del modelo de procesamiento `psg_montly_sales_make`


**Usos comunes:**

- Alimentar el Dashboard principal de ventas en Tableau
- Análisis de ventas mensuales
- Comparacion de rendimiento entre vendedores y marcas


**Consideraciones**

- Los datos se actualizan diariamente, reflejando las ventas del dia anterior
- Asegurese de unir con `dim_date` para analisis de series temporales mas ricos

  {% enddocs %}


{% docs desc_salesperson_id_column %}

Esta es la clave subrogada que identifica de forma unica a un vendedor dentro del sistema analitico. Se genera en el modelo `dim_salesperson` y se utiliza para unir la tabla de hechos con la dimension


**Importante** Siempre use esta columna para los joins con la dimension de vendedores para asegurar la integridad referencial

{%m enddocs %}
