DO $$
DECLARE
	username TEXT := 'railed';
	password TEXT := 'sUp3r&ecureP@ssw0rd!';
BEGIN
	-- Check if the user already exists
	IF NOT EXISTS (SELECT FROM pg_catalog.pg_user WHERE usename = username) THEN
		EXECUTE format('CREATE USER %I WITH PASSWORD %L', username, password);
		EXECUTE format('ALTER USER %I WITH SUPERUSER', username);
	END IF;
END $$ LANGUAGE plpgsql;
