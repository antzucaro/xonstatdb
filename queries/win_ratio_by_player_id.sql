-- win ratio per player, per game type
SELECT game_type_cd,
       SUM(win),
       SUM(loss)
FROM   (SELECT g.game_id,
               g.game_type_cd,
               CASE
                 WHEN g.winner = pgs.team THEN 1
                 WHEN pgs.rank = 1 THEN 1
                 ELSE 0
               END win,
               CASE
                 WHEN g.winner = pgs.team THEN 0
                 WHEN pgs.rank = 1 THEN 0
                 ELSE 1
               END loss
        FROM   games g,
               player_game_stats pgs
        WHERE  g.game_id = pgs.game_id
               AND pgs.player_id = 6) win_loss
GROUP  BY game_type_cd;
