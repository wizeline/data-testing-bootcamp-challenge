
## Errors while running tests :

pytest dependency is missing: 

Fix: `pip install pytest`

## Inspecting the implemented Tests 
The file containing the tests is `tests/test_sql.py`

We are using a single test which is parameterized 
to run the same test the parameter for each execution defines the sql file and the expected results csv file :
```
"query_name", ["most_interacted_videos_per_country", "avg_age_by_gender"]
```

The errors from running the test without changes are in `errors.txt`

## Working through each issue:

Tests were Isolated so that we can focus on one issue when testing and debugging the test results

For this we can comment out the query we'll be debugging:
```
@pytest.mark.parametrize(
    "query_name", [
    #"most_interacted_videos_per_country"
    #,
    #"avg_age_by_gender"
    ]
)
```

## Thought process:

### Understanding where data comes from:
In tests/conftest.py we are using a module level fixture that will define a module level argument value for our tests `db` :
```
with duckdb.connect(":memory:") as conn:
        for dataset in (assets_folder / "source").glob("*.csv"):
```

based on the files included in the project, 
we can read that the db data comes from `tests/assets/source/vewership_data.csv`
which ends up generating an "in memory sql database" 
with a table name `viewership_data` and the following rows for the table:
`subscription_status,ratings,languages,device_type,location,playback_quality,interaction_events`

### Failed test: most_interacted_videos_per_country

`most_interacted_videos_per_country.csv`
Based on the error, we can see that the query is returning LESS results than expected:
```
E       DataFrame shape mismatch
E       [left]:  (24, 3)
E       [right]: (81, 3)
```
we can analyze the expected results data:
`most_interacted_videos_per_country.csv`
we can see that no value from the  `total_interactions` is below 150 as the query filters out so we can continue to analyze other conditions the query  `most_interacted_videos_per_country.sql`
performs,
this led to test the `ranking_no` filter that's performed and check the right value that's required to match the results.
`where _ranking_no <= 1`

Changing the filter for the `ranking_no` from GTE to 2 to 
LTE to 1 fixed the test.

### Failed test: avg_age_by_gender


The average from the expected results is "DIFFERENT" across all results compared to the
average results returned from the query, which are all the same:

```
DataFrame.iloc[:, 2] (column name="avg_age") values are different (100.0 %)
E           [index]: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
E           [left]:  [70, 70, 70, 70, 70, 70, 70, 70, 70, 70, 70, 70]
E           [right]: [38.72885032537961, 40.78924731182796, 41.71822033898305, 38.89125295508274, 39.78076062639821, 38.83438155136268, 40.22857142857143, 39.80510440835267, 39.361607142857146, 39.93918918918919, 38.72222222222222, 38.5]
```

By analyzing the query the average obtained is calculated by the aggregated max function: `max(age) avg_age`
implying by the name of the query and the results seen from the expected results, it looks like the results should be calculated by the average function `avg(age) avg_age`
which the expected results seem to be yielding rather than a fixed "high" value yielded by  the actual results.

Changing the aggregator function from max to avg fixed the test.