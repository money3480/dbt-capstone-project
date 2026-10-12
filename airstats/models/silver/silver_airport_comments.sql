{{
    config
    (
        materialized = 'incremental',
        on_schema_change='fail'
    )

}}
WITH SRC_AIRPORT_COMMENTS AS (
    SELECT * FROM {{ ref('src_airport_comments') }}
)
SELECT 
COMMENT_ID,
AIRPORT_IDENT,
COMMENT_TIMESTAMP,
NVL(MEMBER_NICKNAME,'__UNKNOWN__') AS MEMBER_NICKNAME,
COMMENT_SUBJECT,
COMMENT_BODY,
current_timestamp() AS LOADED_AT
FROM SRC_AIRPORT_COMMENTS
where COMMENT_BODY IS NOT NULL AND COMMENT_BODY !=''
{% if is_incremental() %}
    AND COMMENT_ID > (SELECT MAX(T.COMMENT_ID) FROM {{ this }} T)
{% endif %}