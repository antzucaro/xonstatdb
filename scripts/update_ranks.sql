begin;
    delete from player_ranks;

    insert into player_ranks(player_id, nick, game_type_cd, elo, rank)
    select p.player_id, p.nick, pe.game_type_cd, pe.elo, rank() 
    over (partition by pe.game_type_cd order by pe.elo desc)
    from players p, player_elos pe
    where p.player_id = pe.player_id;

end;
