CREATE TABLE IF NOT EXISTS Genre (
	genre_ID SERIAL PRIMARY KEY,
	name VARCHAR(30) NOT NULL
);
CREATE TABLE IF NOT EXISTS Performer (
	performer_ID SERIAL PRIMARY KEY,
	name VARCHAR(30) NOT NULL
);
CREATE TABLE IF NOT EXISTS GenrePerfomer (
	genre_ID INTEGER REFERENCES Genre(genre_ID),
	performer_ID INTEGER REFERENCES Performer(performer_ID),
	CONSTRAINT genreperfomer_ID PRIMARY KEY (genre_ID, performer_ID)
);
CREATE TABLE IF NOT EXISTS Albums (
	album_ID SERIAL PRIMARY KEY,
	album_name VARCHAR(30) NOT NULL,
	year_of_release DATE
);
CREATE TABLE IF NOT EXISTS PerformerAlbums (
	album_ID INTEGER REFERENCES Albums(album_ID),
	performer_ID INTEGER REFERENCES Performer(performer_ID),
	CONSTRAINT performeralbums_ID PRIMARY KEY (album_ID, performer_ID)
);
CREATE TABLE IF NOT EXISTS Track (
	track_ID SERIAL PRIMARY KEY,
	track_name VARCHAR(40) NOT NULL,
	duration INTEGER NOT NULL,
	album_ID INTEGER REFERENCES Albums(album_ID) NOT NULL
);
CREATE TABLE IF NOT EXISTS Сollection (
	collection_ID SERIAL PRIMARY KEY,
	collection_name VARCHAR(40) NOT NULL,
	year_of_release DATE
);
CREATE TABLE IF NOT EXISTS CollectionTrack (
	track_ID INTEGER REFERENCES Track(track_ID),
	collection_ID INTEGER REFERENCES Сollection(collection_ID),
	CONSTRAINT collectiontrack_ID PRIMARY KEY (track_ID, collection_ID)
);