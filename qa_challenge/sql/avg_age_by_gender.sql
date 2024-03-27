-- Select the genre, gender, and average age from the viewership_data table
SELECT 
    genre, -- Select the genre column
    gender, -- Select the gender column
    AVG(age) AS avg_age -- Calculate the average age and alias it as avg_age
FROM 
    viewership_data -- Specify the viewership_data table
GROUP BY 
    genre, gender -- Group the data by genre and gender
ORDER BY 
    genre, gender; -- Sort the results by genre and gender
