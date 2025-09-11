/*
--obtiene una lista con los registros unicos de la tabla MARKETING_PIVOTED_PERFORMANCE por la columna CHANNEL_NAME
--obtiene lista con los registros unicos de la tabla MARKETING_PIVOTED_PERFORMANCE por la columna METRIC_NAME
--llama a la macro "get_distinct_values_simplified"
*/

{%- set channels_to_pivot = get_distinct_values_simplified(
    table_relation=source('raw_bi_car', 'MARKETING_PIVOTED_PERFORMANCE'),
    column_name='CHANNEL_NAME'
) -%}
{%- set metrics_to_pivot = get_distinct_values_simplified(
    table_relation=source('raw_bi_car', 'MARKETING_PIVOTED_PERFORMANCE'),
    column_name='METRIC_NAME'
) -%}



SELECT 
    campaign_id,
    report_date,
    --ciclos por cada elemento de las listas 'channels_to_pivot' y 'metrics_to_pivot'
    {% for channel in channels_to_pivot -%} 
        {% for metric in metrics_to_pivot -%}
            --compara cada elemento de las listas contra los elementos de la columna channel_name y metric_name de la BD
            --y hace una sumatoria de su columna 'metric_value' correspondiente
            SUM(CASE WHEN channel_name = '{{ channel }}' AND metric_name = '{{ metric }}' THEN metric_value ELSE 0 END) AS {{ channel.lower().replace(' ', '_') }}_{{ metric.lower()}} --columna de salida
            
            {% if not loop.last %}, {% endif %} --continua analizando la lista mientras existan comas separadoras
        {%- endfor %}
        {% if not loop.last %}, {% endif %}
    {%- endfor %}
FROM {{ source('raw_bi_car', 'MARKETING_PIVOTED_PERFORMANCE') }}
GROUP BY 
    campaign_id,
    report_date
ORDER BY
    campaign_id,
    report_date



/*
SELECT 
    campaign_id,
    report_date,
    SUM(CASE WHEN channel_name = 'Email Marketing' AND metric_name = 'clics' THEN metric_value ELSE 0 END) 
            AS email_marketing_clics
            
            , SUM(CASE WHEN channel_name = 'Email Marketing' AND metric_name = 'conversiones' THEN metric_value ELSE 0 END) 
            AS email_marketing_conversiones
            
            , SUM(CASE WHEN channel_name = 'Email Marketing' AND metric_name = 'gasto' THEN metric_value ELSE 0 END) 
            AS email_marketing_gasto
            
            , SUM(CASE WHEN channel_name = 'Email Marketing' AND metric_name = 'impresiones' THEN metric_value ELSE 0 END) 
            AS email_marketing_impresiones
            
            
        , SUM(CASE WHEN channel_name = 'Facebook Ads' AND metric_name = 'clics' THEN metric_value ELSE 0 END) 
            AS facebook_ads_clics
            
            , SUM(CASE WHEN channel_name = 'Facebook Ads' AND metric_name = 'conversiones' THEN metric_value ELSE 0 END) 
            AS facebook_ads_conversiones
            
            , SUM(CASE WHEN channel_name = 'Facebook Ads' AND metric_name = 'gasto' THEN metric_value ELSE 0 END) 
            AS facebook_ads_gasto
            
            , SUM(CASE WHEN channel_name = 'Facebook Ads' AND metric_name = 'impresiones' THEN metric_value ELSE 0 END) 
            AS facebook_ads_impresiones
            
            
        , SUM(CASE WHEN channel_name = 'Google Ads' AND metric_name = 'clics' THEN metric_value ELSE 0 END) 
            AS google_ads_clics
            
            , SUM(CASE WHEN channel_name = 'Google Ads' AND metric_name = 'conversiones' THEN metric_value ELSE 0 END) 
            AS google_ads_conversiones
            
            , SUM(CASE WHEN channel_name = 'Google Ads' AND metric_name = 'gasto' THEN metric_value ELSE 0 END) 
            AS google_ads_gasto
            
            , SUM(CASE WHEN channel_name = 'Google Ads' AND metric_name = 'impresiones' THEN metric_value ELSE 0 END) 
            AS google_ads_impresiones
            
            
        , SUM(CASE WHEN channel_name = 'Organic Search' AND metric_name = 'clics' THEN metric_value ELSE 0 END) 
            AS organic_search_clics
            
            , SUM(CASE WHEN channel_name = 'Organic Search' AND metric_name = 'conversiones' THEN metric_value ELSE 0 END) 
            AS organic_search_conversiones
            
            , SUM(CASE WHEN channel_name = 'Organic Search' AND metric_name = 'gasto' THEN metric_value ELSE 0 END) 
            AS organic_search_gasto
            
            , SUM(CASE WHEN channel_name = 'Organic Search' AND metric_name = 'impresiones' THEN metric_value ELSE 0 END) 
            AS organic_search_impresiones
            
            
        , SUM(CASE WHEN channel_name = 'TikTok Ads' AND metric_name = 'clics' THEN metric_value ELSE 0 END) 
            AS tiktok_ads_clics
            
            , SUM(CASE WHEN channel_name = 'TikTok Ads' AND metric_name = 'conversiones' THEN metric_value ELSE 0 END) 
            AS tiktok_ads_conversiones
            
            , SUM(CASE WHEN channel_name = 'TikTok Ads' AND metric_name = 'gasto' THEN metric_value ELSE 0 END) 
            AS tiktok_ads_gasto
            
            , SUM(CASE WHEN channel_name = 'TikTok Ads' AND metric_name = 'impresiones' THEN metric_value ELSE 0 END) 
            AS tiktok_ads_impresiones
            
            
        
FROM DATABOOSTERS.PUBLIC.MARKETING_PIVOTED_PERFORMANCE
GROUP BY 
    campaign_id,
    report_date
ORDER BY
    campaign_id,
    report_date

*/

