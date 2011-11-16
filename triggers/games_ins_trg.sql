CREATE OR REPLACE FUNCTION games_ins()
RETURNS TRIGGER AS $$
BEGIN
    IF (NEW.create_dt >= DATE '2011-04-01' AND NEW.create_dt < DATE '2011-07-01') THEN
        INSERT INTO games_2011Q2 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2011-07-01' AND NEW.create_dt < DATE '2011-10-01') THEN
        INSERT INTO games_2011Q3 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2011-10-01' AND NEW.create_dt < DATE '2012-01-01') THEN
        INSERT INTO games_2011Q4 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2012-01-01' AND NEW.create_dt < DATE '2012-04-01') THEN
        INSERT INTO games_2012Q1 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2012-04-01' AND NEW.create_dt < DATE '2012-07-01') THEN
        INSERT INTO games_2012Q2 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2012-07-01' AND NEW.create_dt < DATE '2012-10-01') THEN
        INSERT INTO games_2012Q3 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2012-10-01' AND NEW.create_dt < DATE '2013-01-01') THEN
        INSERT INTO games_2012Q4 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2013-01-01' AND NEW.create_dt < DATE '2013-04-01') THEN
        INSERT INTO games_2013Q1 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2013-04-01' AND NEW.create_dt < DATE '2013-07-01') THEN
        INSERT INTO games_2013Q2 VALUES (NEW.*);
    ELSE
        RAISE EXCEPTION 'Date out of range.  Fix the games_ins() trigger!';
    END IF;
    RETURN NULL;
END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS games_ins_trg ON xonstat.games;
CREATE TRIGGER games_ins_trg
    BEFORE INSERT on xonstat.games
    FOR EACH ROW EXECUTE PROCEDURE games_ins();
