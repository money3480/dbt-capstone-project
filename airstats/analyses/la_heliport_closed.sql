SELECT 
* 
FROM {{ ref('scd_silver_airports') }} 
WHERE airport_ident = '01CN'