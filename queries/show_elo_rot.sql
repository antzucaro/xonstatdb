select 
  player_id,
  game_type_cd,
  elo current_elo, 
  update_dt last_update_dt, 
  (current_date - (update_dt::date)) number_of_days, 
  (current_date - (update_dt::date))-30 number_of_days_past_30, 
  (current_date - (update_dt::date)-31)/7+1 penalty,
  greatest(100, elo - ((current_date - (update_dt::date)-31)/7+1)) new_elo
from player_elos
where 
  update_dt < (current_timestamp at time zone 'UTC' - interval '30 days')
  and elo != 100;
