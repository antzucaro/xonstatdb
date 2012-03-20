-- Yo dawg, I heard you liked stats...

-- count of games for the given year
select date_part('month', create_dt), count(*) 
from games 
where date_part('year', create_dt) = 2012 
group by date_part('month', create_dt) 
order by date_part('month', create_dt);

-- count of game types for the given year
select game_type_cd, count(*) 
from games 
where date_part('year', create_dt) = 2012 
group by game_type_cd 
order by count(*) desc;

-- count of unique players playing in the given month
select date_part('month', create_dt), count(distinct player_id)
from player_game_stats
where date_part('year', create_dt) = 2012 
group by date_part('month', create_dt) 
order by date_part('month', create_dt);

-- count of servers with the most games
select servers.name, count(*)
from servers, games
where servers.server_id = games.server_id
and date_part('year', games.create_dt) = 2012 
group by servers.name
order by count(*) desc;

-- count of maps with the most games
select maps.name, count(*)
from games, maps
where maps.map_id = games.map_id
and date_part('year', games.create_dt) = 2012 
group by maps.name
order by count(*) desc;

-- new players by month
select date_part('month', create_dt), count(*)
from players
where date_part('year', create_dt) = 2012
group by date_part('month', create_dt)
order by date_part('month', create_dt);
