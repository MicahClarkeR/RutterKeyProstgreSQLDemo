CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE TABLE videos
(
	video_id		uuid DEFAULT uuid_generate_v1(), /* Could use v4 for generation on random numbers - instead of MAC, timestamp, and random value. */
	date_uploaded	DATE NOT NULL,
	uploader		int NOT NULL,
	
	PRIMARY KEY (video_id),
	CONSTRAINT fk_user
		FOREIGN KEY(uploader)
			REFERENCES users(user_id)
			ON DELETE CASCADE /* When uploader is deleted, delete all their videos */
);

CREATE OR REPLACE FUNCTION timestampvideo() RETURNS TRIGGER AS $timestampvideo$
   BEGIN
      new.date_uploaded := current_timestamp;
      RETURN NEW;
   END;
$timestampvideo$ LANGUAGE plpgsql;

CREATE TRIGGER timestamp_video BEFORE INSERT ON videos FOR EACH ROW EXECUTE PROCEDURE timestampvideo();