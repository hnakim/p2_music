# ETL Project - Spotify

Building an ETL out of Spotify API. This ETL program will extract data from my Spotify Account with Spotipy Python library. Specifically, we are interested in extracting our daily listening history and the daily top 50 songs in United States. Then, we will transform the data using Python to clean it up, create unique identifiers, and load it into a PostgreSQL database. The loading piece of the ETL is a PostgreSQL database that is on our local machine. From there, we utilized SQL to query the data and Python to check for validations, perform transformation on the raw data extracted from the API (json), create DataFrames, and load the data utlizing the SQLAlchemy ORM.

A relational SQL database was chosen over a non-relational NoSQL database because of the way our data is structured. In other words, our tables are rigid meaning that the data is nomalized in strictly defined tables. Moreover, it also means that there are clearly defined relationships between the tables. In our case, this means shared unique_identifiers, album_id, and artist (please refer to the ERD for more insight on the relationships between tables). We also chose SQL because of its ability to scale vertically and not horizontally, meaning we can update the data over time but keep all the variables (columns) the same.

![ETL-Project (1)](https://user-images.githubusercontent.com/111074755/203250832-d047c9cf-59a5-4486-ae5c-725e486870ae.png)

## Extracting: Spotify API using Spotipy Library

We extracted data out of the Spotify API using the current_user_recently_played endpoint, as well as the daily_top_50_usa endpoint to get the 50 most recently played tracks and the daily top 50 songs in United States. The result of calling these two endpoints are dictionaries which we will then take and create multiple dataframes, after cleaning it up first. Spotify has great documentation and great examples on their website for their API. Please review our code for further information.

## Transforming: Python and Pandas

We extracted the Spotify data using Python to transform the data with Pandas. We also performed some basic checks on the data within the code. There was an extremely necessary step was to create a unique record id for each track that was played. We don't want to pull in the same track that was played at the same time in the database as that would be a duplicate, but we would want to have duplicate tracks in our database because you can listen to a track more than once. We created a new value for each track that combined Spotify's song_id for the songs and the time that we played the track. We converted the date-time of the song played to the UNIX timestamp version so creating an ID with it was simpler. You cannot play more than one song at a time on a single Spotify account so this was good logic to implement. To prepare the data for loading, we implemented two different data structures (List of Dictionaries and Dictionaries of Lists), we go into more detail in the code. We then transform those data structures into a dataframe to do some cleaning around the date-time datatypes, create the unique identifier for each song, and prepare to load into the Postgresql Database. The code for this step is in this file.

## Load: Utilizing SQLAlchemy Python library and PostgreSQL

We created a database on local computer using PostgreSQL to store all of the Spotify data that we are ingesting with this ETL process. We created four tables and the SQL query for the creation of these tables can be found in the SQL file. To load the data into PostgreSQL, we use the pandas method .to_sql to load the data into the tables. Please see the ERD below for reference.


![drawSQL-export-2022-11-22_00_23](https://user-images.githubusercontent.com/111074755/203240741-46398b73-9ab6-46a8-bd00-a8706da56ee7.png)

