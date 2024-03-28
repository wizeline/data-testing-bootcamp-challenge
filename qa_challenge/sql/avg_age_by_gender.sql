SELECT genre, gender, AVG(age) avg_age
  FROM viewership_data
GROUP BY genre, gender
ORDER BY genre, gender
