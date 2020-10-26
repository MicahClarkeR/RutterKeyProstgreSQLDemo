CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE TABLE user_collections
(
	collection_id		UUID DEFAULT uuid_generate_v1(),
	title				VARCHAR(256) NOT NULL,
	
	PRIMARY KEY(collection_id)
);