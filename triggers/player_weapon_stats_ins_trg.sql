CREATE OR REPLACE FUNCTION player_weapon_stats_ins()
RETURNS TRIGGER AS $$
BEGIN
    IF (NEW.create_dt >= DATE '2013-04-01' AND NEW.create_dt < DATE '2013-07-01') THEN
        INSERT INTO player_weapon_stats_2013Q2 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2013-07-01' AND NEW.create_dt < DATE '2013-10-01') THEN
        INSERT INTO player_weapon_stats_2013Q3 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2013-10-01' AND NEW.create_dt < DATE '2014-01-01') THEN
        INSERT INTO player_weapon_stats_2013Q4 VALUES (NEW.*);

    -- 2014
    ELSIF (NEW.create_dt >= DATE '2014-01-01' AND NEW.create_dt < DATE '2014-04-01') THEN
        INSERT INTO player_weapon_stats_2014Q1 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2014-04-01' AND NEW.create_dt < DATE '2014-07-01') THEN
        INSERT INTO player_weapon_stats_2014Q2 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2014-07-01' AND NEW.create_dt < DATE '2014-10-01') THEN
        INSERT INTO player_weapon_stats_2014Q3 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2014-10-01' AND NEW.create_dt < DATE '2015-01-01') THEN
        INSERT INTO player_weapon_stats_2014Q4 VALUES (NEW.*);

    ELSE
        RAISE EXCEPTION 'Date out of range.  Fix the player_weapon_stats_ins() trigger!';
    END IF;
    RETURN NULL;
END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS player_weapon_stats_ins_trg ON xonstat.player_weapon_stats;
CREATE TRIGGER player_weapon_stats_ins_trg
    BEFORE INSERT on xonstat.player_weapon_stats
    FOR EACH ROW EXECUTE PROCEDURE player_weapon_stats_ins();
