do $$
declare
    cutoff timestamp := now() at time zone 'UTC' - interval '1 week';
begin
    delete from active_servers_mv;

    insert into active_servers_mv
    select row_number() over (order by sum(least(g.duration, pgs.alivetime)) desc) sort_order, 
           s.server_id, s.name, sum(least(g.duration, pgs.alivetime)) play_time
    from servers s join games g on g.server_id = s.server_id
    join player_game_stats pgs on g.game_id = pgs.game_id
    where pgs.player_id > 1
    and s.active_ind = true
    and g.create_dt > cutoff
    and pgs.create_dt > cutoff
    group by s.server_id, s.name
    order by 1;
end;
$$
