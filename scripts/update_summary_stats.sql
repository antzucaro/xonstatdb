begin;
    -- get rid of the existing summary stats since we're about to refresh
    delete from summary_stats;

    insert into summary_stats(total_players, total_servers, total_games,
                              total_dm_games, total_duel_games, total_ctf_games)
    with total_games as (
       select game_type_cd, count(*) total_games
       from games
       where game_type_cd in ('duel', 'dm', 'ctf')
       group by game_type_cd
    ),
    total_players as (
       select count(*) total_players
       from players
       where active_ind = true
    ),
    total_servers as (
    select count(*) total_servers
       from servers
       where active_ind = true
    )
    select tp.total_players, ts.total_servers, dm.total_games+duel.total_games+ctf.total_games total_games,
           dm.total_games dm_games, duel.total_games duel_games, ctf.total_games ctf_games
    from   total_games dm, total_games duel, total_games ctf, total_players tp, total_servers ts
    where  dm.game_type_cd = 'dm'
    and    ctf.game_type_cd = 'ctf'
    and    duel.game_type_cd = 'duel';

    commit;

end;
