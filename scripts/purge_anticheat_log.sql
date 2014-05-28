begin;
    -- get rid of stuff that is older than 30 days old
    delete from player_game_anticheats
    where create_dt < now() at time zone 'utc' - interval '30 days';
end;
