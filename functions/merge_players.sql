create or replace function merge_players(p_winner_player_id players.player_id%TYPE, p_loser_player_id players.player_id%TYPE) RETURNS void as
$$
declare
   rowcount integer;
   weighted_elo record;
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

   -- take the weighted average of the elos and sum the games to get the new total
   FOR weighted_elo IN (select game_type_cd, elo_sum/game_count aggregate_elo, game_count
      from (
         select game_type_cd, greatest(sum(games*elo),1) elo_sum, sum(games) game_count 
         from player_elos 
         where player_id in (p_winner_player_id, p_loser_player_id) 
         group by game_type_cd
      ) es)
   LOOP
      update xonstat.player_elos
      set elo = weighted_elo.aggregate_elo, games = weighted_elo.game_count
      where player_id = p_winner_player_id
      and game_type_cd = weighted_elo.game_type_cd;

      raise notice 'New % Elo is %.', weighted_elo.game_type_cd, weighted_elo.aggregate_elo;
   END LOOP;

   -- update the existing player_elos entries that have a higher elo on the loser
   -- update xonstat.player_elos pe
   -- set elo = newpe.elo
   -- from
      -- (select lpe.game_type_cd, lpe.elo
      -- from xonstat.player_elos wpe, xonstat.player_elos lpe
      -- where wpe.game_type_cd = lpe.game_type_cd
      -- and wpe.player_id = 67
      -- and lpe.player_id = 720
      -- and lpe.elo > wpe.elo) newpe
   -- where player_id = 67
   -- and pe.game_type_cd = newpe.game_type_cd;

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
