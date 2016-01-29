begin;
	delete from summary_stats_mv;

	insert into summary_stats_mv
	-- all time
	(with active_players as (
		select count(distinct player_id) num_players 
		from player_game_stats pgs
		where pgs.player_id > 2
	)
	select 
	  'all' scope,
	  row_number() over (order by count(*) desc) rn, 
	  ap.num_players,
	  g.game_type_cd, 
	  count(*)
	from games g cross join active_players ap
	group by scope, ap.num_players, g.game_type_cd)

	-- daily
	UNION
	(with active_players as (
		select count(distinct player_id) num_players 
		from player_game_stats pgs
		where pgs.player_id > 2
		and pgs.create_dt >= now() at time zone 'utc' - interval '1 day'
	)
	select 
	  'day' scope,
	  row_number() over (order by count(*) desc) rn, 
	  ap.num_players,
	  g.game_type_cd, 
	  count(*)
	from games g cross join active_players ap
	where g.create_dt >= now() at time zone 'utc' - interval '1 day'
	group by scope, ap.num_players, g.game_type_cd);

end;
