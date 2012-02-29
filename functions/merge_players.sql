create or replace function merge_players(p_winner_player_id players.player_id%TYPE, p_loser_player_id players.player_id%TYPE) RETURNS void as
$$
declare
   rowcount integer;   
begin
   -- start with weapon stats
   update player_weapon_stats
   set player_id = p_winner_player_id
   where player_id = p_loser_player_id;

   get diagnostics rowcount = ROW_COUNT;
   raise notice '% weapon stat rows updated.', rowcount;

   -- then game stats
   update player_game_stats
   set player_id = p_winner_player_id
   where player_id = p_loser_player_id;

   get diagnostics rowcount = ROW_COUNT;
   raise notice '% game stat rows updated.', rowcount;

   -- then hashkeys (winner takes the loser's hashkey)
   update hashkeys
   set player_id = p_winner_player_id
   where player_id = p_loser_player_id;
   
   get diagnostics rowcount = ROW_COUNT;
   raise notice '% hashkeys copied.', rowcount;

   -- and finally deactivate the old player record
   update players set active_ind = false where player_id = p_loser_player_id;
end;
$$
language plpgsql;