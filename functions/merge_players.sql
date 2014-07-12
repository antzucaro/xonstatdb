create or replace function merge_players(p_winner_player_id players.player_id%TYPE, p_loser_player_id players.player_id%TYPE) RETURNS void as
$$
declare
   rowcount integer;
   r record;
begin
   raise notice 'Merging % and %', p_winner_player_id, p_loser_player_id;

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

   -- copy player_elos entries that don't currently exist for the winner
   insert into xonstat.player_elos
   select p_winner_player_id, game_type_cd, games, elo from xonstat.player_elos pe
   where player_id = p_loser_player_id
   and not exists (select 1 from xonstat.player_elos where player_id = p_winner_player_id and game_type_cd = pe.game_type_cd);

   -- Take the aggregate # of games and the *greatest* Elo 
   -- value and use that going forward
   FOR r in (
     select game_type_cd, sum(games) sum_games, 
     max(elo) max_elo, max(update_dt) max_update_dt
     from player_elos
     where player_id in (p_winner_player_id, p_loser_player_id) 
     group by game_type_cd
   )
   LOOP
      update xonstat.player_elos
      set elo = r.max_elo, games = r.sum_games, update_dt = r.max_update_dt
      where player_id = p_winner_player_id
      and game_type_cd = r.game_type_cd
      and games != r.sum_games;

      raise notice 'New % Elo is %.', r.game_type_cd, r.max_elo;
   END LOOP;

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
