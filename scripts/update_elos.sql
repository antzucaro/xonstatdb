begin;
  update player_elos
  set elo=least(elo-1, 100.00)
  where update_dt < (current_timestamp at time zone 'UTC' - interval '30 days');
end;
