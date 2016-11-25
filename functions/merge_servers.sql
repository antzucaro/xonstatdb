create or replace function merge_servers(p_winner_server_id servers.server_id%TYPE, p_loser_server_id servers.server_id%TYPE) 
RETURNS void as
$$
declare
    rowcount integer;
    w_server record;
    l_server record;
begin
    raise notice 'Merging servers % and %', p_winner_server_id, p_loser_server_id;

    select * into w_server from servers where server_id = p_winner_server_id;
    select * into l_server from servers where server_id = p_loser_server_id;

    -- hashkey check: if both have hashkeys and they are different, we
    -- shouldn't merge them!
    if w_server.hashkey is not null and l_server.hashkey is not null and w_server.hashkey != l_server.hashkey then
        raise exception 'Both servers have hashkeys and they are different! Not merging.';
    end if;

    -- fill in the "important" missing attributes
    if w_server.ip_addr is null and l_server.ip_addr is not null then
        w_server.ip_addr := l_server.ip_addr;
    end if;

    if w_server.hashkey is null and l_server.hashkey is not null then
        w_server.hashkey := l_server.hashkey;
    end if;

    if w_server.revision is null and l_server.revision is not null then
        w_server.revision := l_server.revsion;
    end if;

    -- games get moved to the new server
    update games set server_id = p_winner_server_id where server_id = p_loser_server_id;

    get diagnostics rowcount = ROW_COUNT;
    raise notice '% game rows updated.', rowcount;

    -- update attributes rescued from the losing server
    update servers set
        ip_addr = w_server.ip_addr,
        hashkey = w_server.hashkey,
        revision = w_server.revision
    where server_id = p_winner_server_id;

    -- now deactivate the old server
    update servers set active_ind = false where server_id = p_loser_server_id;

    raise notice 'Server #% deactivated.', p_loser_server_id;
end;
$$
language plpgsql;
