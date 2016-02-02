begin;
    delete from active_maps_mv;

    insert into active_maps_mv
    select row_number() over(order by count(1) desc) sort_order, m.map_id, m.name, count(1) games
    from maps m join games g on m.map_id = g.map_id
    where g.create_dt >= now() at time zone 'UTC' - interval '1 week'
    group by 2, 3
    ;
end;
