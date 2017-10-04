CREATE OR REPLACE FUNCTION player_game_frag_matrix_ins()
RETURNS TRIGGER AS $$
BEGIN
	IF (NEW.create_dt >= DATE '2017-10-01' AND NEW.create_dt < DATE '2018-01-01') THEN
		INSERT INTO player_game_frag_matrix_2017Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2018-01-01' AND NEW.create_dt < DATE '2018-04-01') THEN
		INSERT INTO player_game_frag_matrix_2018Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2018-04-01' AND NEW.create_dt < DATE '2018-07-01') THEN
		INSERT INTO player_game_frag_matrix_2018Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2018-07-01' AND NEW.create_dt < DATE '2018-10-01') THEN
		INSERT INTO player_game_frag_matrix_2018Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2018-10-01' AND NEW.create_dt < DATE '2019-01-01') THEN
		INSERT INTO player_game_frag_matrix_2018Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2019-01-01' AND NEW.create_dt < DATE '2019-04-01') THEN
		INSERT INTO player_game_frag_matrix_2019Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2019-04-01' AND NEW.create_dt < DATE '2019-07-01') THEN
		INSERT INTO player_game_frag_matrix_2019Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2019-07-01' AND NEW.create_dt < DATE '2019-10-01') THEN
		INSERT INTO player_game_frag_matrix_2019Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2019-10-01' AND NEW.create_dt < DATE '2020-01-01') THEN
		INSERT INTO player_game_frag_matrix_2019Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-01-01' AND NEW.create_dt < DATE '2020-04-01') THEN
		INSERT INTO player_game_frag_matrix_2020Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-04-01' AND NEW.create_dt < DATE '2020-07-01') THEN
		INSERT INTO player_game_frag_matrix_2020Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-07-01' AND NEW.create_dt < DATE '2020-10-01') THEN
		INSERT INTO player_game_frag_matrix_2020Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-10-01' AND NEW.create_dt < DATE '2021-01-01') THEN
		INSERT INTO player_game_frag_matrix_2020Q4 VALUES (NEW.*);
	ELSE
		RAISE EXCEPTION 'Date out of range. Fix the player_game_frag_matrix_ins() trigger!';
	END IF;
	RETURN NULL;
END
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS player_game_frag_matrix_ins_trg ON xonstat.player_game_frag_matrix;
CREATE TRIGGER player_game_frag_matrix_ins_trg
    BEFORE INSERT on xonstat.player_game_frag_matrix
    FOR EACH ROW EXECUTE PROCEDURE player_game_frag_matrix_ins();
