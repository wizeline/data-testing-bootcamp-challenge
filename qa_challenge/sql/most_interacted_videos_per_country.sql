WITH Interactions AS (
    SELECT
        country_code,
        video_id,
        SUM(interaction_events) AS total_interactions
    FROM
        viewership_data
    GROUP BY
        country_code, video_id
    HAVING
        SUM(interaction_events) >= 150
),
RankedVideos AS (
    SELECT
        country_code,
        video_id,
        total_interactions,
        ROW_NUMBER() OVER (
            PARTITION BY country_code
            ORDER BY total_interactions DESC
        ) AS rank
    FROM
        Interactions
)
SELECT
    country_code,
    video_id,
    total_interactions
FROM
    RankedVideos
WHERE
    rank = 1
ORDER BY
    country_code;
