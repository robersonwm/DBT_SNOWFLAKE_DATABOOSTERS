--Este test pasa si esta consulta devuelve cero filas
--Selecciona cualquier registro de la tabla de hechos donde las metricas clave sean negativas

SELECT
    DDATE,
    ID_SALESPERSON,
    ID_CARMAKE,
    TOTALSALE,
    TOTALCOM
FROM
    {{ ref('fct_montly_sales') }}
WHERE
    TOTALSALE < 0 OR TOTALCOM < 0