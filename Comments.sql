CREATE TABLE comments
(
	comment_id			UUID DEFAULT uuid_generate_v1(),
	date_posted			TIMESTAMP NOT NULL,
	content				VARCHAR(512) NOT NULL,
	posted_by			INT NOT NULL,
	posted_on			UUID,
	
	PRIMARY KEY(comment_id),
	CONSTRAINT fk_user
		FOREIGN KEY(posted_by)
			REFERENCES users(user_id)
			ON DELETE CASCADE, /* When uploader is deleted, delete all their comments */
	CONSTRAINT fk_video
		FOREIGN KEY(posted_on)
			REFERENCES videos(video_id)
			ON DELETE CASCADE /* When video is deleted, delete all its comments */
);

CREATE OR REPLACE FUNCTION timestampcomment() RETURNS TRIGGER AS $timestampcomment$
   BEGIN
      new.date_posted := current_timestamp;
      RETURN NEW;
   END;
$timestampcomment$ LANGUAGE plpgsql;

CREATE TRIGGER timestamp_comment BEFORE INSERT ON comments FOR EACH ROW EXECUTE PROCEDURE timestampcomment();