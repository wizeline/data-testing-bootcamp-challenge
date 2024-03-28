WITH _interactions AS (
    SELECT country_code, video_id, SUM(interaction_events) total_interactions
      FROM viewership_data
    GROUP BY country_code, video_id
    HAVING SUM(interaction_events) >= 150
), _ranking as (
    SELECT country_code, video_id, total_interactions,
           ROW_NUMBER() OVER (PARTITION BY country_code ORDER BY total_interactions desc) _ranking_no
      FROM _interactions
)

SELECT country_code, video_id, total_interactions
  FROM _ranking
 WHERE _ranking_no = 1
ORDER BY country_code
