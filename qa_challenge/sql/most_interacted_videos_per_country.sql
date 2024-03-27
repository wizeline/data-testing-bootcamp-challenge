-- Calculate total interactions for each combination of country_code and video_id
WITH _interactions AS (
    SELECT 
        country_code,
        video_id,
        SUM(interaction_events) AS total_interactions
    FROM 
        viewership_data
    GROUP BY 
        country_code, video_id
    HAVING 
        SUM(interaction_events) >= 150 -- Filter out combinations with total interactions less than 150
), 
-- Rank videos within each country based on total interactions
_ranking AS (
    SELECT 
        country_code,
        video_id,
        total_interactions,
        ROW_NUMBER() OVER (PARTITION BY country_code ORDER BY total_interactions DESC) AS _ranking_no
    FROM 
        _interactions
)
-- Select the top-ranked video for each country
SELECT 
    country_code,
    video_id,
    total_interactions
FROM 
    _ranking
WHERE 
    _ranking_no = 1 -- Select only the top-ranked video for each country
ORDER BY 
    country_code;
