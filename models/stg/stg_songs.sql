--stg_songs.sql
{{ config(
    materialized='table'
) }}
WITH cleaned_songs AS (
    SELECT
        song_id,
        UPPER(title) AS title,
        UPPER(artist) AS artist,
        album,
        release_year,
        COALESCE(genre, 'Unknown') AS genre
    FROM {{ source('spotify', 'songs') }}
)
SELECT * FROM cleaned_songs
