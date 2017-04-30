begin;
    -- save the history
    insert into player_ranks_history
    select * from player_ranks;

    -- get rid of the existing ranks and refresh them using
    -- the latest elo information for each game type
    delete from player_ranks;

    insert into player_ranks(player_id, nick, game_type_cd, elo, rank)
    select p.player_id, p.nick, pe.game_type_cd, pe.elo, row_number() 
    over (partition by pe.game_type_cd order by pe.elo desc, pe.create_dt)
    from players p, player_elos pe
    where p.player_id = pe.player_id
    and p.active_ind = True
    and pe.active_ind = True
    --and pe.games >= 32
    and pe.elo > 100;

end;
