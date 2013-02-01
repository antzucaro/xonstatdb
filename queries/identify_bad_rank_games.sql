select game_id 
from player_game_stats 
where create_dt >= '2013-01-01' 
group by game_id 
having min(rank) = 2;
