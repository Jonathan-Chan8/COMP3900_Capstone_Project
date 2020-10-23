This directory is responsible for collecting data from news API 
and inserting this data into the postgreSQL database: thenewsroom_database


# TO COLLECT DATA #

1. Activate the python virtual environment from this directory: $ source env/bin/activate
	- This will run python2.7 (NOT SURE IF THIS WILL WORK FOR OTHERS)
	- To deactivate the virtual environment, do: $ deactivate
	
2. Run the python script: $ python collect_news.py

~ once you've collected data, you need to update thenewsroom_database file (theNewsRoom/API/postgres_db/init/03-Guardian_Data) that is loaded when running docker-compose up ~

3. To update this file, just run: $ ./update_db




