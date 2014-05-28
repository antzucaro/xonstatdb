begin;
  update player_elos pe
  set elo=greatest(100, elo - ((current_date - (update_dt::date)-31)/7+1))
  where update_dt < (current_timestamp at time zone 'UTC' - interval '30 days')
  and not exists (
    select 1
    from player_elos
    where player_id = pe.player_id
    and update_dt >= (current_timestamp at time zone 'UTC' - interval '30 days')
  )
  and elo != 100;
end;
