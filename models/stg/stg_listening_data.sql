{{ config(
    materialized='table'
) }}
WITH cleaned_listening_data AS (
    SELECT
        song_id,
        CAST(listen_date AS DATE) AS listen_date,
        COALESCE(minutes_listened, 0) AS minutes_listened
    FROM {{ source('spotify', 'listening_data') }}
)
SELECT * FROM cleaned_listening_data