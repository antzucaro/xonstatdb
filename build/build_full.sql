-- drop tables first in reverse order
drop table if exists player_skills;
drop table if exists player_game_nonparticipants;
drop table if exists player_game_frag_matrix;
drop table if exists player_agg_stats_mv;
drop table if exists merged_servers;
drop table if exists player_medals;
drop table if exists active_maps_mv;
drop table if exists active_servers_mv;
drop table if exists active_players_mv;
drop table if exists summary_stats_mv;
drop table if exists player_groups;
drop table if exists player_game_anticheats;
drop table if exists team_game_stats;
drop table if exists summary_stats cascade;
drop table if exists player_map_captimes;
drop table if exists player_ladder_ranks;
drop table if exists cd_ladder cascade;
drop table if exists player_ranks_history cascade;
drop table if exists player_ranks cascade;
drop table if exists player_elos cascade;
drop table if exists player_nicks cascade;
drop table if exists db_version cascade;
drop table if exists hashkeys cascade;
drop table if exists player_weapon_stats cascade;
drop table if exists achievements cascade;
drop table if exists cd_achievement cascade;
--drop table if exists game_mutators cascade;
drop table if exists player_game_stats cascade;
drop table if exists games cascade;
--drop table if exists map_game_types cascade;
drop table if exists maps cascade;
drop table if exists servers cascade;
drop table if exists cd_game_type cascade;
drop table if exists cd_weapon cascade;
--drop table if exists cd_mutator cascade;
drop table if exists players cascade;

-- table definitions
\i tables/players.tab
--\i tables/cd_mutator.tab
\i tables/cd_game_type.tab
\i tables/cd_weapon.tab
\i tables/servers.tab
\i tables/maps.tab
--\i tables/map_game_types.tab
\i tables/games.tab
\i tables/player_game_stats.tab
--\i tables/game_mutators.tab
\i tables/cd_achievement.tab
\i tables/achievements.tab
\i tables/player_weapon_stats.tab
\i tables/hashkeys.tab
\i tables/db_version.tab
\i tables/player_nicks.tab
\i tables/player_elos.tab
\i tables/player_ranks.tab
\i tables/player_ranks_history.tab
\i tables/cd_ladder.tab
\i tables/player_ladder_ranks.tab
\i tables/player_map_captimes.tab
\i tables/summary_stats.tab
\i tables/team_game_stats.tab
\i tables/player_game_anticheats.tab
\i tables/player_groups.tab
\i tables/summary_stats_mv.tab
\i tables/active_players_mv.tab
\i tables/active_servers_mv.tab
\i tables/active_maps_mv.tab
\i tables/player_medals.tab
\i tables/merged_servers.tab
\i tables/player_agg_stats_mv.tab
\i tables/player_game_frag_matrix.tab
\i tables/player_game_nonparticipants.tab
\i tables/player_skills.tab

begin;

-- game types
insert into cd_game_type(game_type_cd, descr)
values('arena', 'Arena');
insert into cd_game_type(game_type_cd, descr)
values('as', 'Assault');
insert into cd_game_type(game_type_cd, descr)
values('ctf', 'Capture The Flag');
insert into cd_game_type(game_type_cd, descr)
values('ca', 'Clan Arena');
insert into cd_game_type(game_type_cd, descr)
values('dm', 'Deathmatch');
insert into cd_game_type(game_type_cd, descr)
values('dom', 'Domination');
insert into cd_game_type(game_type_cd, descr)
values('ft', 'Freezetag');
insert into cd_game_type(game_type_cd, descr)
values('ka', 'Keepaway');
insert into cd_game_type(game_type_cd, descr)
values('tka', 'Team Keepaway');
insert into cd_game_type(game_type_cd, descr)
values('kh', 'Keyhunt');
insert into cd_game_type(game_type_cd, descr)
values('lms', 'Last Man Standing');
insert into cd_game_type(game_type_cd, descr)
values('nb', 'Nexball');
insert into cd_game_type(game_type_cd, descr)
values('ons', 'Onslaught');
insert into cd_game_type(game_type_cd, descr)
values('rc', 'Race');
insert into cd_game_type(game_type_cd, descr)
values('cts', 'Complete This Stage');
insert into cd_game_type(game_type_cd, descr)
values('rune', 'Runematch');
insert into cd_game_type(game_type_cd, descr)
values('tdm', 'Team Deathmatch');
insert into cd_game_type(game_type_cd, descr)
values('duel', 'Duel');
insert into cd_game_type(game_type_cd, descr)
values('mayhem', 'Mayhem');
insert into cd_game_type(game_type_cd, descr)
values('tmayhem', 'Team Mayhem');

-- weapons
insert into cd_weapon(weapon_cd, descr) values('laser', 'Laser');
insert into cd_weapon(weapon_cd, descr) values('shotgun', 'Shotgun');
insert into cd_weapon(weapon_cd, descr) values('uzi', 'Machine Gun');
insert into cd_weapon(weapon_cd, descr) values('grenadelauncher', 'Mortar');
insert into cd_weapon(weapon_cd, descr) values('electro', 'Electro');
insert into cd_weapon(weapon_cd, descr) values('crylink', 'Crylink');
insert into cd_weapon(weapon_cd, descr) values('nex', 'Nex');
insert into cd_weapon(weapon_cd, descr) values('hagar', 'Hagar');
insert into cd_weapon(weapon_cd, descr) values('rocketlauncher', 'Rocket Launcher');
insert into cd_weapon(weapon_cd, descr) values('minstanex', 'MinstaNex');
insert into cd_weapon(weapon_cd, descr) values('rifle', 'Camping Rifle');
insert into cd_weapon(weapon_cd, descr) values('fireball', 'Fireball');
insert into cd_weapon(weapon_cd, descr) values('minelayer', 'Minelayer');
insert into cd_weapon(weapon_cd, descr) values('seeker', 'T.A.G. Seeker');
insert into cd_weapon(weapon_cd, descr) values('tuba', '@!#%''n Tuba');
insert into cd_weapon(weapon_cd, descr) values('hlac', 'Heavy Laser Assault Cannon');
insert into cd_weapon(weapon_cd, descr) values('hook', 'Grappling Hook');
insert into cd_weapon(weapon_cd, descr) values('porto', 'Port-O-Launch');
insert into cd_weapon(weapon_cd, descr) values('blaster', 'Blaster');
insert into cd_weapon(weapon_cd, descr) values('devastator', 'Devastator');
insert into cd_weapon(weapon_cd, descr) values('machinegun', 'Machine Gun');
insert into cd_weapon(weapon_cd, descr) values('mortar', 'Mortar');
insert into cd_weapon(weapon_cd, descr) values('vaporizer', 'Vaporizer');
insert into cd_weapon(weapon_cd, descr) values('vortex', 'Vortex');
insert into cd_weapon(weapon_cd, descr) values('arc', 'Arc');
insert into cd_weapon(weapon_cd, descr) values('okhmg', 'Overkill Heavy Machine Gun');
insert into cd_weapon(weapon_cd, descr) values('oknex', 'Overkill Nex');
insert into cd_weapon(weapon_cd, descr) values('okshotgun', 'Overkill Shotgun');
insert into cd_weapon(weapon_cd, descr) values('okmachinegun', 'Overkill Machine Gun');
insert into cd_weapon(weapon_cd, descr) values('okrpc', 'Overkill Rocket-Propelled Chainsaw');

-- achievements
insert into cd_achievement(achievement_cd, descr, active_ind)
values(1, 'Play a game online.', 'Y');
insert into cd_achievement(achievement_cd, descr, active_ind)
values(2, 'Play each of the game types.', 'Y');
insert into cd_achievement(achievement_cd, descr, active_ind)
values(3, 'Register online.', 'Y');
insert into cd_achievement(achievement_cd, descr, active_ind)
values(4, 'Get higher than 50% nex accuracy in a single game.', 'Y');
insert into cd_achievement(achievement_cd, descr, active_ind)
values(5, 'Play in 50 games.', 'Y');
insert into cd_achievement(achievement_cd, descr, active_ind)
values(6, 'Play in 100 games.', 'Y');
insert into cd_achievement(achievement_cd, descr, active_ind)
values(7, 'Play in 250 games.', 'Y');
insert into cd_achievement(achievement_cd, descr, active_ind)
values(8, 'Play in 500 games.', 'Y');
insert into cd_achievement(achievement_cd, descr, active_ind)
values(9, 'Play in 1000 games.', 'Y');
insert into cd_achievement(achievement_cd, descr, active_ind)
values(10,'Get more than 10 carrier kills in a single game.', 'Y');
insert into cd_achievement(achievement_cd, descr, active_ind)
values(11,'Get more than 5 captures in a single game.', 'Y');
insert into cd_achievement(achievement_cd, descr, active_ind)
values(12,'Accumulate 10 hours of play.', 'Y');
insert into cd_achievement(achievement_cd, descr, active_ind)
values(13,'Accumulate 24 hours of play.', 'Y');
insert into cd_achievement(achievement_cd, descr, active_ind)
values(14,'Accumulate 48 hours of play.', 'Y');
insert into cd_achievement(achievement_cd, descr, active_ind)
values(15,'Accumulate 1 week of play.', 'Y');
insert into cd_achievement(achievement_cd, descr, active_ind)
values(16,'Get more than 5 laser kills in a single game.', 'Y');
insert into cd_achievement(achievement_cd, descr, active_ind)
values(17,'Get more than 10 laser kills in a single game.', 'Y');
insert into cd_achievement(achievement_cd, descr, active_ind)
values(18,'Get greater than 25% accuracy with the machine gun in a single game.', 'Y');
insert into cd_achievement(achievement_cd, descr, active_ind)
values(19,'Get more frags than deaths in a single game.', 'Y');
insert into cd_achievement(achievement_cd, descr, active_ind)
values(20,'Be the highest scorer in a game.', 'Y');

-- mutators
--insert into cd_mutator(mutator_cd, name)
--values(1, 'g_dodging');
--insert into cd_mutator(mutator_cd, name)
--values(2, 'g_minstagib');
--insert into cd_mutator(mutator_cd, name)
--values(3, 'g_nix');
--insert into cd_mutator(mutator_cd, name)
--values(4, 'g_rocket_flying');
--insert into cd_mutator(mutator_cd, name)
--values(5, 'g_weaponarena');
--insert into cd_mutator(mutator_cd, name)
--values(6, 'g_start_weapon_laser');
--insert into cd_mutator(mutator_cd, name)
--values(7, 'sv_gravity');
--insert into cd_mutator(mutator_cd, name)
--values(8, 'g_cloaked');
--insert into cd_mutator(mutator_cd, name)
--values(9, 'g_grappling_hook');
--insert into cd_mutator(mutator_cd, name)
--values(10, 'g_midair');
--insert into cd_mutator(mutator_cd, name)
--values(11, 'g_vampire');
--insert into cd_mutator(mutator_cd, name)
--values(12, 'g_pinata');
--insert into cd_mutator(mutator_cd, name)
--values(13, 'g_weapon_stay');
--insert into cd_mutator(mutator_cd, name)
--values(14, 'g_bloodloss');
--insert into cd_mutator(mutator_cd, name)
--values(15, 'g_jetpack');

-- bots and untracked players have special records in player
insert into players (nick) values ('Bot');
insert into players (nick) values ('Untracked Player');

-- triggers 
\i triggers/games_ins_trg.sql
\i triggers/player_game_stats_ins_trg.sql
\i triggers/player_weapon_stats_ins_trg.sql
\i triggers/team_game_stats_ins_trg.sql
\i triggers/player_game_frag_matrix_ins_trg.sql
\i triggers/player_game_nonparticipants_ins_trg.sql

-- version tracking
insert into db_version(version, descr) values('1.0.0', 'Initial build');

commit;
