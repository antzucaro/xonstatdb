BEGIN;
    -- Populate the table using a different name.
    CREATE TABLE recent_game_stats_mv_new AS

    SELECT 
    pgs.player_game_stat_id, g.game_id, g.server_id, g.map_id, p.player_id, p.nick, pgs.score, pgs.alivetime

    FROM player_game_stats pgs
    INNER JOIN players p USING (player_id)
    INNER JOIN games g USING (game_id)

    WHERE
    p.player_id > 2 
    AND p.active_ind = true
    AND pgs.create_dt BETWEEN (now() at time zone 'UTC' - interval '30 days') AND (now() at time zone 'UTC' + interval '1 day')
    AND g.create_dt BETWEEN (now() at time zone 'UTC' - interval '30 days') AND (now() at time zone 'UTC' + interval '1 day');

    -- Index it
    CREATE INDEX recent_game_stats_mv_new_ix001 on recent_game_stats_mv_new(server_id);
    CREATE INDEX recent_game_stats_mv_new_ix002 on recent_game_stats_mv_new(map_id);

    -- Drop the old stuff, rename the stuff
    DROP TABLE IF EXISTS recent_game_stats_mv CASCADE;
    ALTER TABLE recent_game_stats_mv_new RENAME TO recent_game_stats_mv;

    DROP INDEX IF EXISTS recent_game_stats_mv_ix001;
    ALTER INDEX recent_game_stats_mv_new_ix001 RENAME to recent_game_stats_mv_ix001;

    DROP INDEX IF EXISTS recent_game_stats_mv_ix002;
    ALTER INDEX recent_game_stats_mv_new_ix002 RENAME to recent_game_stats_mv_ix002;

COMMIT; 