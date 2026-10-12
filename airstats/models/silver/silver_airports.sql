WITH SRC_AIRPORTS AS (
    SELECT 
    * 
    FROM {{ref('src_airports')}}
)

SELECT 
* 
FROM SRC_AIRPORTS