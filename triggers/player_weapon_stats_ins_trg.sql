CREATE OR REPLACE FUNCTION player_weapon_stats_ins()
RETURNS TRIGGER AS $$
BEGIN
    IF (create_dt >= DATE '2011-04-01' AND create_dt < DATE '2011-07-01') THEN
        INSERT INTO player_weapon_stats_2011Q2 VALUES (NEW.*);
    ELSIF (create_dt >= DATE '2011-07-01' AND create_dt < DATE '2011-10-01') THEN
        INSERT INTO player_weapon_stats_2011Q3 VALUES (NEW.*);
    ELSIF (create_dt >= DATE '2011-10-01' AND create_dt < DATE '2012-01-01') THEN
        INSERT INTO player_weapon_stats_2011Q4 VALUES (NEW.*);
    ELSIF (create_dt >= DATE '2012-01-01' AND create_dt < DATE '2012-04-01') THEN
        INSERT INTO player_weapon_stats_2012Q1 VALUES (NEW.*);
    ELSIF (create_dt >= DATE '2012-04-01' AND create_dt < DATE '2012-07-01') THEN
        INSERT INTO player_weapon_stats_2012Q2 VALUES (NEW.*);
    ELSIF (create_dt >= DATE '2012-07-01' AND create_dt < DATE '2012-10-01') THEN
        INSERT INTO player_weapon_stats_2012Q3 VALUES (NEW.*);
    ELSIF (create_dt >= DATE '2012-10-01' AND create_dt < DATE '2013-01-01') THEN
        INSERT INTO player_weapon_stats_2012Q4 VALUES (NEW.*);
    ELSIF (create_dt >= DATE '2013-01-01' AND create_dt < DATE '2013-04-01') THEN
        INSERT INTO player_weapon_stats_2013Q1 VALUES (NEW.*);
    ELSIF (create_dt >= DATE '2013-04-01' AND create_dt < DATE '2013-07-01') THEN
        INSERT INTO player_weapon_stats_2013Q2 VALUES (NEW.*);
    ELSE
        RAISE EXCEPTION 'Date out of range.  Fix the player_weapon_stats_ins() trigger!';
    END IF;
    RETURN NULL;
END;
$$
LANGUAGE plpgsql;
