# Data Testing Bootcamp Challenge
Welcome to the Data Testing Challenge, which is a part of the Wizeline Non-functional Testing Bootcamp 2024.

## Requirement
Business team needs to review the data sets are getting the correct data.
They talk with the Data Engineer in order to review the queries that were used to generate the data sets.

Your task is to identify and fix an issue in a couple of SQL queries from the given Data Test scenario.

## Getting Started
### Pre-requisites
1. Ensure that the latest version of Python is installed in your system.
   - Go to the official Python website at [python.org](https://www.python.org/) or use [homebrew](https://formulae.brew.sh/formula/python@3.10#default)
   - After installing the wizard if you want to check the Python version installed run the following command on a terminal.
   ```
   python –version
   ```
2. Dependencies installation: (Open a terminal on your code viewer)
   - Pandas
   ```
   pip install pandas
   ```
   - Duckdb
   ```
   pip install duckdb
   ```
   - Pytest
   ```
   pip install pytest
   ```

### Prepare your environment
1. Clone this repo via HTTP or SSH.
Example via SSH:
```
git clone git@github.com:wizeline/data-testing-bootcamp-challenge.git
```
2. In your terminal change to the directory where the code of this repository is stored.
```
cd data-testing-bootcamp-challenge
```
3. Create a virtual environment for your challenge.
```
python3 -m venv venv/data-testing-challenge
```
4. Activate the python virtual environment.
Example on MacOS:
```
source venv/data-testing-challenge/bin/activate
```
5. Install the dependencies of this project by executing the following command.
```
pip install -r requirements.txt
```

### Challenge
1. Execute the following command to run the test cases for this challenge.
```
pytest -v ./tests
```
2. If we encounter a failure, we need to identify the errors causing it and resolve them!

3. Create a new branch with your name and submit your solution with the following naming convention.
```
DataTesting_YourNameGoesHere
```

# Have fun!


