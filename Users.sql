CREATE TABLE users (
	user_id INTEGER NOT NULL,
	username VARCHAR(64) NOT NULL,
	password VARCHAR(64) NOT NULL,
	email_address VARCHAR(256) NOT NULL,
	PRIMARY KEY (user_id)
);

CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE OR REPLACE FUNCTION hashpasswordfunc() RETURNS TRIGGER AS $hashpasswordfunc$
   BEGIN
      new.password := encode(digest(new.password, 'sha256'), 'hex');
      RETURN NEW;
   END;
$hashpasswordfunc$ LANGUAGE plpgsql;

CREATE TRIGGER hash_password BEFORE INSERT ON users FOR EACH ROW EXECUTE PROCEDURE hashpasswordfunc();