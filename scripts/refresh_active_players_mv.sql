begin;
	delete from active_players_mv;

	insert into active_players_mv
	select row_number() over(order by sum(pgs.alivetime) desc) sort_order, p.player_id, p.nick, sum(pgs.alivetime) alivetime
	from players p join player_game_stats pgs on p.player_id = pgs.player_id
	where pgs.create_dt >= (now() at time zone 'UTC' - interval '1 week')
	and p.active_ind = true
	and p.player_id > 2
	group by 2, 3;
end;
