-- how many distinct player_ids play in multiple months
select count(*) 
from players
where
player_id in (
   select distinct player_id 
   from player_game_stats 
   where create_dt between (current_timestamp at time zone 'UTC' - interval '1 month') 
                       and (current_timestamp at time zone 'UTC')
)
and player_id in (
   select distinct player_id 
   from player_game_stats 
   where create_dt between (current_timestamp at time zone 'UTC' - interval '2 month') 
                       and (current_timestamp at time zone 'UTC' - interval '1 month')
)
and player_id in (
   select distinct player_id 
   from player_game_stats 
      where create_dt between (current_timestamp at time zone 'UTC' - interval '3 month') 
                       and (current_timestamp at time zone 'UTC' - interval '2 month')
)
;