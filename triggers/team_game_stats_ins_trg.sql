CREATE OR REPLACE FUNCTION team_game_stats_ins()
RETURNS TRIGGER AS $$
BEGIN
    -- 2011
    IF (NEW.create_dt >= DATE '2011-04-01' AND NEW.create_dt < DATE '2011-07-01') THEN
        INSERT INTO team_game_stats_2011Q2 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2011-07-01' AND NEW.create_dt < DATE '2011-10-01') THEN
        INSERT INTO team_game_stats_2011Q3 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2011-10-01' AND NEW.create_dt < DATE '2012-01-01') THEN
        INSERT INTO team_game_stats_2011Q4 VALUES (NEW.*);

    -- 2012
    ELSIF (NEW.create_dt >= DATE '2012-01-01' AND NEW.create_dt < DATE '2012-04-01') THEN
        INSERT INTO team_game_stats_2012Q1 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2012-04-01' AND NEW.create_dt < DATE '2012-07-01') THEN
        INSERT INTO team_game_stats_2012Q2 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2012-07-01' AND NEW.create_dt < DATE '2012-10-01') THEN
        INSERT INTO team_game_stats_2012Q3 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2012-10-01' AND NEW.create_dt < DATE '2013-01-01') THEN
        INSERT INTO team_game_stats_2012Q4 VALUES (NEW.*);

    -- 2013
    ELSIF (NEW.create_dt >= DATE '2013-01-01' AND NEW.create_dt < DATE '2013-04-01') THEN
        INSERT INTO team_game_stats_2013Q1 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2013-04-01' AND NEW.create_dt < DATE '2013-07-01') THEN
        INSERT INTO team_game_stats_2013Q2 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2013-07-01' AND NEW.create_dt < DATE '2013-10-01') THEN
        INSERT INTO team_game_stats_2013Q2 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2013-10-01' AND NEW.create_dt < DATE '2013-01-01') THEN
        INSERT INTO team_game_stats_2013Q2 VALUES (NEW.*);

    -- 2014
    ELSIF (NEW.create_dt >= DATE '2014-01-01' AND NEW.create_dt < DATE '2014-04-01') THEN
        INSERT INTO team_game_stats_2013Q2 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2014-04-01' AND NEW.create_dt < DATE '2014-07-01') THEN
        INSERT INTO team_game_stats_2013Q2 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2014-07-01' AND NEW.create_dt < DATE '2014-10-01') THEN
        INSERT INTO team_game_stats_2013Q2 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2014-10-01' AND NEW.create_dt < DATE '2015-10-01') THEN
        INSERT INTO team_game_stats_2013Q2 VALUES (NEW.*);

    ELSE
        RAISE EXCEPTION 'Date out of range.  Fix the team_game_stats_ins() trigger!';
    END IF;
    RETURN NULL;
END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS team_game_stats_ins_trg ON xonstat.team_game_stats;
CREATE TRIGGER team_game_stats_ins_trg
    BEFORE INSERT on xonstat.team_game_stats
    FOR EACH ROW EXECUTE PROCEDURE team_game_stats_ins();
