-- This transaction and corresponding anonymous block will update the
-- player_agg_stats_mv table. Change the values of "since" and "until" below to
-- control the window of players you want to update.
begin; 

do $$
declare
    since timestamp without time zone := now() at time zone 'UTC' - interval '4 weeks';
    until timestamp without time zone := now() at time zone 'UTC';
begin
    -- clear the slots for the upcoming records
    delete 
    from player_agg_stats_mv
    where player_id in (
        select distinct player_id 
        from player_game_stats
        where player_id > 2
        and create_dt between since and until
    );

    insert into player_agg_stats_mv
    select
       p.player_id,
       agg_stats.game_type_cd game_type_cd,
       p.nick,
       p.stripped_nick,
       max(agg_stats.create_dt) last_seen,
       coalesce(sum(win) + sum(loss), 0) games,
       coalesce(sum(win), 0) wins,
       coalesce(sum(loss), 0) losses,
       coalesce(sum(kills), 0) kills,
       coalesce(sum(deaths), 0) deaths,
       coalesce(sum(suicides), 0) suicides,
       coalesce(sum(captures), 0) captures,
       coalesce(sum(pickups), 0) pickups,
       coalesce(sum(drops), 0) drops,
       coalesce(sum(carrier_frags), 0) carrier_frags,
       coalesce(round(sum(alivetime)/60), 0) alivetime    
    from
       (select
          pgs.player_id,
          g.game_id,
          g.game_type_cd,
          g.create_dt,
          case                      
             when g.winner = pgs.team then 1                      
             when pgs.scoreboardpos = 1 then 1                      
             else 0                    
          end win,
          case                      
             when g.winner = pgs.team then 0                      
             when pgs.scoreboardpos = 1 then 0                      
             else 1                    
          end loss,
          pgs.kills,
          pgs.deaths,
          pgs.suicides,
          pgs.captures,
          pgs.pickups,
          pgs.drops,
          pgs.carrier_frags,
          extract(epoch from pgs.alivetime) alivetime            
       from
          games g,
          player_game_stats pgs             
       where
          g.game_id = pgs.game_id             
          and pgs.player_id > 2
          and pgs.player_id in (
             select distinct player_id 
             from player_game_stats
             where player_id > 2
             and create_dt between since and until
          )
       ) agg_stats
    join
       players p 
          on p.player_id = agg_stats.player_id            
       group by
          p.player_id,
          p.nick,
          p.stripped_nick,
          agg_stats.game_type_cd
    ;

exception when others then
    raise notice 'something went wrong';
end$$;

commit;
