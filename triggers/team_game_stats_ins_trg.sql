CREATE OR REPLACE FUNCTION team_game_stats_ins()
RETURNS TRIGGER AS $$
BEGIN
    -- 2013
    IF (NEW.create_dt >= DATE '2013-04-01' AND NEW.create_dt < DATE '2013-07-01') THEN
        INSERT INTO team_game_stats_2013Q2 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2013-07-01' AND NEW.create_dt < DATE '2013-10-01') THEN
        INSERT INTO team_game_stats_2013Q3 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2013-10-01' AND NEW.create_dt < DATE '2013-01-01') THEN
        INSERT INTO team_game_stats_2013Q4 VALUES (NEW.*);

    -- 2014
    ELSIF (NEW.create_dt >= DATE '2014-01-01' AND NEW.create_dt < DATE '2014-04-01') THEN
        INSERT INTO team_game_stats_2014Q1 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2014-04-01' AND NEW.create_dt < DATE '2014-07-01') THEN
        INSERT INTO team_game_stats_2014Q2 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2014-07-01' AND NEW.create_dt < DATE '2014-10-01') THEN
        INSERT INTO team_game_stats_2014Q3 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2014-10-01' AND NEW.create_dt < DATE '2015-01-01') THEN
        INSERT INTO team_game_stats_2014Q4 VALUES (NEW.*);

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
