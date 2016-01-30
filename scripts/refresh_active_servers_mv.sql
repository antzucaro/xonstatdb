begin;
    delete from active_servers_mv;

    insert into active_servers_mv
    select row_number() over(order by count(1) desc) sort_order, s.server_id, s.name, count(1) games
    from servers s join games g on s.server_id = g.server_id
    where g.create_dt >= now() at time zone 'UTC' - interval '1 week'
    group by 2, 3;
end;
