CREATE TABLE user_collection_joiner
(
	collection_id		UUID NOT NULL,
	user_id				INTEGER NOT NULL,
	
	CONSTRAINT fk_collection
		FOREIGN KEY(collection_id)
			REFERENCES user_collections(collection_id)
			ON DELETE CASCADE, /* When collection is deleted, delete all its members */
	CONSTRAINT fk_user
		FOREIGN KEY(user_id)
			REFERENCES users(user_id)
			ON DELETE CASCADE /* When user is deleted, delete it from all collections */
);