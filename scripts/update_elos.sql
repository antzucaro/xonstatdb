begin;
  update player_elos
  set elo=greatest(100, elo - ((current_date - (update_dt::date)-31)/7))
  where update_dt < (current_timestamp at time zone 'UTC' - interval '30 days')
  and elo != 100;
end;
