DROP TABLE IF EXISTS spotify_albums CASCADE;
DROP TABLE IF EXISTS spotify_artists CASCADE;
DROP TABLE IF EXISTS spotify_tracks CASCADE;
DROP TABLE IF EXISTS usa_top_50 CASCADE;

CREATE TABLE spotify_albums(
	album_id VARCHAR NOT NULL PRIMARY KEY,
	album_name VARCHAR,
	release_date DATE,
	total_tracks INT,
	album_url VARCHAR,
);

CREATE TABLE spotify_artists (
	artist_id VARCHAR PRIMARY KEY 
	artist_name VARCHAR
	artist_url VARCHAR
);


CREATE TABLE spotify_tracks (
	unique_identifier VARCHAR NOT NULL PRIMARY KEY,
	song_id VARCHAR NOT NULL,
	song_name VARCHAR NOT NULL,
	duration_ms INT,
	song_url VARCHAR,
	popularity INT,
	date_time_played DATE,
	album_id VARCHAR,
	artist_id VARCHAR,
	date_time_inserted VARCHAR,
	FOREIGN KEY (album_id) REFERENCES spotify_albums(album_id),
	FOREIGN KEY (artist_id) REFERENCES spotify_artists(artist_id)
);

CREATE TABLE usa_top_50 (
	unique_identifier VARCHAR PRIMARY KEY,
	artist_name TEXT,
	song_name TEXT,
	song_id VARCHAR,
	danceability FLOAT,
	energy FLOAT,
	key INT,
	loudness FLOAT,
	mode INT,
	speechiness FLOAT,
	instrumentalness FLOAT,
	liveness FLOAT,
	valence FLOAT,
	tempo FLOAT,
	duration_ms FLOAT,
	time_signature INT,
	FOREIGN KEY (unique_identifier) REFERENCES spotify_tracks (unique_identifier)
	FOREIGN KEY (artist_name) REFERENCES spotify_artists (artist_name)
	FOREIGN KEY (song_name) REFERENCES spotify_tracks (song_name)
	FOREIGN KEY (song_id) REFERENCES spotify_tracks (song_id)
);