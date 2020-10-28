This directory is responsible for collecting data from news API 
and inserting this data into the postgreSQL database: thenewsroom_database

# SET UP VIRTUAL ENV #

1. navigate to the capstone-project-comp3900-w17a-212-monolith/theNewsroom/news-collector/ directory
2. Create virtual environment called 'env': $ virtualenv --python=/usr/bin/python2.7 env
3. Activate the python virtual environment from this directory: $ source env/bin/activate
	- To deactivate the virtual environment, do: $ deactivate
4. Install dependencies:$ pip install -r requirements.txt

# TO COLLECT DATA #

1. Activate virtual env: $ source env/bin/activate

2. Run the python script: $ python collect_news.py

~ once you've collected data, you need to update thenewsroom_database file (theNewsRoom/API/postgres_db/init/03-Guardian_Data) that is loaded when running docker-compose up ~

3. To update this file, just run: $ ./update_db


