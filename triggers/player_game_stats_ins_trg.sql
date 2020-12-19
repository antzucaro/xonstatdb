CREATE OR REPLACE FUNCTION player_game_stats_ins()
RETURNS TRIGGER AS $$
BEGIN
	IF (NEW.create_dt >= DATE '2020-01-01' AND NEW.create_dt < DATE '2020-04-01') THEN
		INSERT INTO player_game_stats_2020Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-04-01' AND NEW.create_dt < DATE '2020-07-01') THEN
		INSERT INTO player_game_stats_2020Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-07-01' AND NEW.create_dt < DATE '2020-10-01') THEN
		INSERT INTO player_game_stats_2020Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-10-01' AND NEW.create_dt < DATE '2021-01-01') THEN
		INSERT INTO player_game_stats_2020Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-01-01' AND NEW.create_dt < DATE '2021-04-01') THEN
		INSERT INTO player_game_stats_2021Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-04-01' AND NEW.create_dt < DATE '2021-07-01') THEN
		INSERT INTO player_game_stats_2021Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-07-01' AND NEW.create_dt < DATE '2021-10-01') THEN
		INSERT INTO player_game_stats_2021Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-10-01' AND NEW.create_dt < DATE '2022-01-01') THEN
		INSERT INTO player_game_stats_2021Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-01-01' AND NEW.create_dt < DATE '2022-04-01') THEN
		INSERT INTO player_game_stats_2022Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-04-01' AND NEW.create_dt < DATE '2022-07-01') THEN
		INSERT INTO player_game_stats_2022Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-07-01' AND NEW.create_dt < DATE '2022-10-01') THEN
		INSERT INTO player_game_stats_2022Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-10-01' AND NEW.create_dt < DATE '2023-01-01') THEN
		INSERT INTO player_game_stats_2022Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-01-01' AND NEW.create_dt < DATE '2023-04-01') THEN
		INSERT INTO player_game_stats_2023Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-04-01' AND NEW.create_dt < DATE '2023-07-01') THEN
		INSERT INTO player_game_stats_2023Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-07-01' AND NEW.create_dt < DATE '2023-10-01') THEN
		INSERT INTO player_game_stats_2023Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-10-01' AND NEW.create_dt < DATE '2024-01-01') THEN
		INSERT INTO player_game_stats_2023Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-01-01' AND NEW.create_dt < DATE '2024-04-01') THEN
		INSERT INTO player_game_stats_2024Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-04-01' AND NEW.create_dt < DATE '2024-07-01') THEN
		INSERT INTO player_game_stats_2024Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-07-01' AND NEW.create_dt < DATE '2024-10-01') THEN
		INSERT INTO player_game_stats_2024Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-10-01' AND NEW.create_dt < DATE '2025-01-01') THEN
		INSERT INTO player_game_stats_2024Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-01-01' AND NEW.create_dt < DATE '2025-04-01') THEN
		INSERT INTO player_game_stats_2025Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-04-01' AND NEW.create_dt < DATE '2025-07-01') THEN
		INSERT INTO player_game_stats_2025Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-07-01' AND NEW.create_dt < DATE '2025-10-01') THEN
		INSERT INTO player_game_stats_2025Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-10-01' AND NEW.create_dt < DATE '2026-01-01') THEN
		INSERT INTO player_game_stats_2025Q4 VALUES (NEW.*);
	ELSE
		RAISE EXCEPTION 'Date out of range. Fix the player_game_stats_ins() trigger!';
	END IF;
	RETURN NULL;
END
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS player_game_stats_ins_trg ON xonstat.player_game_stats;
CREATE TRIGGER player_game_stats_ins_trg
    BEFORE INSERT on xonstat.player_game_stats
    FOR EACH ROW EXECUTE PROCEDURE player_game_stats_ins();
