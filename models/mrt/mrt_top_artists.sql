{{ config(
    materialized='table'
) }}

WITH recent_listening AS (
    SELECT
        l.song_id,
        s.artist,
        l.minutes_listened
    FROM {{ ref('stg_listening_data') }} AS l
    LEFT JOIN {{ ref('stg_songs') }} AS s
        ON l.song_id = s.song_id
    WHERE listen_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY)
)
, artist_minutes AS (
    SELECT
artist,
        SUM(minutes_listened) AS total_minutes_listened
    FROM recent_listening
    GROUP BY artist
)
SELECT
    artist,
    total_minutes_listened
FROM artist_minutes
ORDER BY total_minutes_listened DESC
LIMIT 10