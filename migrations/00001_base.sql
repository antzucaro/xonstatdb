-- +goose Up

-- Schema
CREATE SCHEMA IF NOT EXISTS xonstat;


-- Table definitions

-- players
CREATE TABLE IF NOT EXISTS xonstat.players
(
  player_id serial NOT NULL,
  nick character varying(128),
  stripped_nick character varying(128),
  "location" character varying(100),
  email_addr character varying(255),
  active_ind boolean NOT NULL default true,
  create_dt timestamp without time zone NOT NULL DEFAULT (current_timestamp at time zone 'UTC'),
  CONSTRAINT players_pk PRIMARY KEY (player_id)
);

ALTER TABLE xonstat.players OWNER TO xonstat;

-- cd_game_type
CREATE TABLE IF NOT EXISTS xonstat.cd_game_type
(
  game_type_cd character varying(10) NOT NULL,
  descr character varying(100) NOT NULL,
  active_ind boolean NOT NULL DEFAULT true,
  CONSTRAINT cd_game_type_pk PRIMARY KEY (game_type_cd)
);

ALTER TABLE xonstat.cd_game_type OWNER TO xonstat;

-- cd_weapon
CREATE TABLE IF NOT EXISTS xonstat.cd_weapon
(
  weapon_cd character varying(15) NOT NULL,
  descr character varying(100) NOT NULL,
  active_ind boolean NOT NULL DEFAULT true,
  CONSTRAINT cd_weapon_pk PRIMARY KEY (weapon_cd)
);

ALTER TABLE xonstat.cd_weapon OWNER TO xonstat;

-- servers
CREATE TABLE IF NOT EXISTS xonstat.servers
(
  server_id serial NOT NULL,
  "name" character varying(64),
  "location" character varying(100),
  ip_addr character varying(50),
  port integer,
  hashkey character varying(44),
  public_key character varying(725),
  revision character varying(50),
  pure_ind boolean NOT NULL DEFAULT true,
  impure_cvars integer NULL,
  elo_ind boolean NOT NULL DEFAULT true,
  categories character varying(10)[],
  active_ind boolean NOT NULL DEFAULT true,
  create_dt timestamp without time zone NOT NULL DEFAULT (current_timestamp at time zone 'UTC'),
  CONSTRAINT servers_pk PRIMARY KEY (server_id)
);

ALTER TABLE xonstat.servers OWNER TO xonstat;

-- maps
CREATE TABLE IF NOT EXISTS xonstat.maps
(
  map_id serial NOT NULL,
  "name" character varying(64) NOT NULL,
  "version" integer NOT NULL DEFAULT 1,
  pk3_name character varying(100),
  curl_url character varying(300),
  create_dt timestamp without time zone NOT NULL DEFAULT (current_timestamp at time zone 'UTC'),
  CONSTRAINT maps_pk PRIMARY KEY (map_id)
);

ALTER TABLE xonstat.maps OWNER TO xonstat;

-- games
CREATE TABLE IF NOT EXISTS xonstat.games
(
  game_id bigserial NOT NULL,
  start_dt timestamp without time zone NOT NULL,
  game_type_cd character varying(10) NOT NULL,
  server_id integer NOT NULL,
  map_id integer NOT NULL,
  duration interval,
  winner integer,
  match_id character varying(64),
  mod character varying(64),
  create_dt timestamp without time zone NOT NULL DEFAULT (current_timestamp at time zone 'UTC'),
  players integer[],
  CONSTRAINT games_pk PRIMARY KEY (game_id),
  CONSTRAINT games_fk001 FOREIGN KEY (game_type_cd)
      REFERENCES xonstat.cd_game_type (game_type_cd) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT games_fk002 FOREIGN KEY (server_id)
      REFERENCES xonstat.servers (server_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT games_fk003 FOREIGN KEY (map_id)
      REFERENCES xonstat.maps (map_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT games_uk001 UNIQUE (server_id, match_id)
);

CREATE INDEX IF NOT EXISTS games_ix001 on games(create_dt);

ALTER TABLE xonstat.games OWNER TO xonstat;

CREATE TABLE IF NOT EXISTS xonstat.games_2014q1 ( 
	CHECK ( create_dt >= DATE '2014-01-01' AND create_dt < DATE '2014-04-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2014q2 ( 
	CHECK ( create_dt >= DATE '2014-04-01' AND create_dt < DATE '2014-07-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2014q3 ( 
	CHECK ( create_dt >= DATE '2014-07-01' AND create_dt < DATE '2014-10-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2014q4 ( 
	CHECK ( create_dt >= DATE '2014-10-01' AND create_dt < DATE '2015-01-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2015q1 ( 
	CHECK ( create_dt >= DATE '2015-01-01' AND create_dt < DATE '2015-04-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2015q2 ( 
	CHECK ( create_dt >= DATE '2015-04-01' AND create_dt < DATE '2015-07-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2015q3 ( 
	CHECK ( create_dt >= DATE '2015-07-01' AND create_dt < DATE '2015-10-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2015q4 ( 
	CHECK ( create_dt >= DATE '2015-10-01' AND create_dt < DATE '2016-01-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2016q1 ( 
	CHECK ( create_dt >= DATE '2016-01-01' AND create_dt < DATE '2016-04-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2016q2 ( 
	CHECK ( create_dt >= DATE '2016-04-01' AND create_dt < DATE '2016-07-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2016q3 ( 
	CHECK ( create_dt >= DATE '2016-07-01' AND create_dt < DATE '2016-10-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2016q4 ( 
	CHECK ( create_dt >= DATE '2016-10-01' AND create_dt < DATE '2017-01-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2017q1 ( 
	CHECK ( create_dt >= DATE '2017-01-01' AND create_dt < DATE '2017-04-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2017q2 ( 
	CHECK ( create_dt >= DATE '2017-04-01' AND create_dt < DATE '2017-07-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2017q3 ( 
	CHECK ( create_dt >= DATE '2017-07-01' AND create_dt < DATE '2017-10-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2017q4 ( 
	CHECK ( create_dt >= DATE '2017-10-01' AND create_dt < DATE '2018-01-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2018q1 ( 
	CHECK ( create_dt >= DATE '2018-01-01' AND create_dt < DATE '2018-04-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2018q2 ( 
	CHECK ( create_dt >= DATE '2018-04-01' AND create_dt < DATE '2018-07-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2018q3 ( 
	CHECK ( create_dt >= DATE '2018-07-01' AND create_dt < DATE '2018-10-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2018q4 ( 
	CHECK ( create_dt >= DATE '2018-10-01' AND create_dt < DATE '2019-01-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2019q1 ( 
	CHECK ( create_dt >= DATE '2019-01-01' AND create_dt < DATE '2019-04-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2019q2 ( 
	CHECK ( create_dt >= DATE '2019-04-01' AND create_dt < DATE '2019-07-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2019q3 ( 
	CHECK ( create_dt >= DATE '2019-07-01' AND create_dt < DATE '2019-10-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2019q4 ( 
	CHECK ( create_dt >= DATE '2019-10-01' AND create_dt < DATE '2020-01-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2020q1 ( 
	CHECK ( create_dt >= DATE '2020-01-01' AND create_dt < DATE '2020-04-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2020q2 ( 
	CHECK ( create_dt >= DATE '2020-04-01' AND create_dt < DATE '2020-07-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2020q3 ( 
	CHECK ( create_dt >= DATE '2020-07-01' AND create_dt < DATE '2020-10-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2020q4 ( 
	CHECK ( create_dt >= DATE '2020-10-01' AND create_dt < DATE '2021-01-01' ) 
) INHERITS (games);

CREATE TABLE IF NOT EXISTS xonstat.games_2021q1 ( 
    CONSTRAINT games_2021q1_pk PRIMARY KEY (game_id),
	CHECK ( create_dt >= DATE '2021-01-01' AND create_dt < DATE '2021-04-01' ) 
) INHERITS (games);

CREATE INDEX IF NOT EXISTS games_2021q1_ix001 on games_2021q1(create_dt);
CREATE INDEX IF NOT EXISTS games_2021q1_ix002 on games_2021q1 using gin(players);
CREATE UNIQUE INDEX IF NOT EXISTS games_2021q1_pk on games_2021q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.games_2021q2 ( 
    CONSTRAINT games_2021q2_pk PRIMARY KEY (game_id),
	CHECK ( create_dt >= DATE '2021-04-01' AND create_dt < DATE '2021-07-01' ) 
) INHERITS (games);

CREATE INDEX IF NOT EXISTS games_2021q2_ix001 on games_2021q2(create_dt);
CREATE INDEX IF NOT EXISTS games_2021q2_ix002 on games_2021q2 using gin(players);
CREATE UNIQUE INDEX IF NOT EXISTS games_2021q2_pk on games_2021q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.games_2021q3 ( 
    CONSTRAINT games_2021q3_pk PRIMARY KEY (game_id),
	CHECK ( create_dt >= DATE '2021-07-01' AND create_dt < DATE '2021-10-01' ) 
) INHERITS (games);

CREATE INDEX IF NOT EXISTS games_2021q3_ix001 on games_2021q3(create_dt);
CREATE INDEX IF NOT EXISTS games_2021q3_ix002 on games_2021q3 using gin(players);
CREATE UNIQUE INDEX IF NOT EXISTS games_2021q3_pk on games_2021q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.games_2021q4 ( 
    CONSTRAINT games_2021q4_pk PRIMARY KEY (game_id),
	CHECK ( create_dt >= DATE '2021-10-01' AND create_dt < DATE '2022-01-01' ) 
) INHERITS (games);

CREATE INDEX IF NOT EXISTS games_2021q4_ix001 on games_2021q4(create_dt);
CREATE INDEX IF NOT EXISTS games_2021q4_ix002 on games_2021q4 using gin(players);
CREATE UNIQUE INDEX IF NOT EXISTS games_2021q4_pk on games_2021q4(game_id);

CREATE TABLE IF NOT EXISTS xonstat.games_2022q1 ( 
    CONSTRAINT games_2022q1_pk PRIMARY KEY (game_id),
	CHECK ( create_dt >= DATE '2022-01-01' AND create_dt < DATE '2022-04-01' ) 
) INHERITS (games);

CREATE INDEX IF NOT EXISTS games_2022q1_ix001 on games_2022q1(create_dt);
CREATE INDEX IF NOT EXISTS games_2022q1_ix002 on games_2022q1 using gin(players);
CREATE UNIQUE INDEX IF NOT EXISTS games_2022q1_pk on games_2022q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.games_2022q2 ( 
    CONSTRAINT games_2022q2_pk PRIMARY KEY (game_id),
	CHECK ( create_dt >= DATE '2022-04-01' AND create_dt < DATE '2022-07-01' ) 
) INHERITS (games);

CREATE INDEX IF NOT EXISTS games_2022q2_ix001 on games_2022q2(create_dt);
CREATE INDEX IF NOT EXISTS games_2022q2_ix002 on games_2022q2 using gin(players);
CREATE UNIQUE INDEX IF NOT EXISTS games_2022q2_pk on games_2022q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.games_2022q3 ( 
    CONSTRAINT games_2022q3_pk PRIMARY KEY (game_id),
	CHECK ( create_dt >= DATE '2022-07-01' AND create_dt < DATE '2022-10-01' ) 
) INHERITS (games);

CREATE INDEX IF NOT EXISTS games_2022q3_ix001 on games_2022q3(create_dt);
CREATE INDEX IF NOT EXISTS games_2022q3_ix002 on games_2022q3 using gin(players);
CREATE UNIQUE INDEX IF NOT EXISTS games_2022q3_pk on games_2022q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.games_2022q4 ( 
    CONSTRAINT games_2022q4_pk PRIMARY KEY (game_id),
	CHECK ( create_dt >= DATE '2022-10-01' AND create_dt < DATE '2023-01-01' ) 
) INHERITS (games);

CREATE INDEX IF NOT EXISTS games_2022q4_ix001 on games_2022q4(create_dt);
CREATE INDEX IF NOT EXISTS games_2022q4_ix002 on games_2022q4 using gin(players);
CREATE UNIQUE INDEX IF NOT EXISTS games_2022q4_pk on games_2022q4(game_id);

CREATE TABLE IF NOT EXISTS xonstat.games_2023q1 ( 
    CONSTRAINT games_2023q1_pk PRIMARY KEY (game_id),
	CHECK ( create_dt >= DATE '2023-01-01' AND create_dt < DATE '2023-04-01' ) 
) INHERITS (games);

CREATE INDEX IF NOT EXISTS games_2023q1_ix001 on games_2023q1(create_dt);
CREATE INDEX IF NOT EXISTS games_2023q1_ix002 on games_2023q1 using gin(players);
CREATE UNIQUE INDEX IF NOT EXISTS games_2023q1_pk on games_2023q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.games_2023q2 ( 
    CONSTRAINT games_2023q2_pk PRIMARY KEY (game_id),
	CHECK ( create_dt >= DATE '2023-04-01' AND create_dt < DATE '2023-07-01' ) 
) INHERITS (games);

CREATE INDEX IF NOT EXISTS games_2023q2_ix001 on games_2023q2(create_dt);
CREATE INDEX IF NOT EXISTS games_2023q2_ix002 on games_2023q2 using gin(players);
CREATE UNIQUE INDEX IF NOT EXISTS games_2023q2_pk on games_2023q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.games_2023q3 ( 
    CONSTRAINT games_2023q3_pk PRIMARY KEY (game_id),
	CHECK ( create_dt >= DATE '2023-07-01' AND create_dt < DATE '2023-10-01' ) 
) INHERITS (games);

CREATE INDEX IF NOT EXISTS games_2023q3_ix001 on games_2023q3(create_dt);
CREATE INDEX IF NOT EXISTS games_2023q3_ix002 on games_2023q3 using gin(players);
CREATE UNIQUE INDEX IF NOT EXISTS games_2023q3_pk on games_2023q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.games_2023q4 ( 
    CONSTRAINT games_2023q4_pk PRIMARY KEY (game_id),
	CHECK ( create_dt >= DATE '2023-10-01' AND create_dt < DATE '2024-01-01' ) 
) INHERITS (games);

CREATE INDEX IF NOT EXISTS games_2023q4_ix001 on games_2023q4(create_dt);
CREATE INDEX IF NOT EXISTS games_2023q4_ix002 on games_2023q4 using gin(players);
CREATE UNIQUE INDEX IF NOT EXISTS games_2023q4_pk on games_2023q4(game_id);

CREATE TABLE IF NOT EXISTS xonstat.games_2024q1 ( 
    CONSTRAINT games_2024q1_pk PRIMARY KEY (game_id),
	CHECK ( create_dt >= DATE '2024-01-01' AND create_dt < DATE '2024-04-01' ) 
) INHERITS (games);

CREATE INDEX IF NOT EXISTS games_2024q1_ix001 on games_2024q1(create_dt);
CREATE INDEX IF NOT EXISTS games_2024q1_ix002 on games_2024q1 using gin(players);
CREATE UNIQUE INDEX IF NOT EXISTS games_2024q1_pk on games_2024q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.games_2024q2 ( 
    CONSTRAINT games_2024q2_pk PRIMARY KEY (game_id),
	CHECK ( create_dt >= DATE '2024-04-01' AND create_dt < DATE '2024-07-01' ) 
) INHERITS (games);

CREATE INDEX IF NOT EXISTS games_2024q2_ix001 on games_2024q2(create_dt);
CREATE INDEX IF NOT EXISTS games_2024q2_ix002 on games_2024q2 using gin(players);
CREATE UNIQUE INDEX IF NOT EXISTS games_2024q2_pk on games_2024q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.games_2024q3 ( 
    CONSTRAINT games_2024q3_pk PRIMARY KEY (game_id),
	CHECK ( create_dt >= DATE '2024-07-01' AND create_dt < DATE '2024-10-01' ) 
) INHERITS (games);

CREATE INDEX IF NOT EXISTS games_2024q3_ix001 on games_2024q3(create_dt);
CREATE INDEX IF NOT EXISTS games_2024q3_ix002 on games_2024q3 using gin(players);
CREATE UNIQUE INDEX IF NOT EXISTS games_2024q3_pk on games_2024q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.games_2024q4 ( 
    CONSTRAINT games_2024q4_pk PRIMARY KEY (game_id),
	CHECK ( create_dt >= DATE '2024-10-01' AND create_dt < DATE '2025-01-01' ) 
) INHERITS (games);

CREATE INDEX IF NOT EXISTS games_2024q4_ix001 on games_2024q4(create_dt);
CREATE INDEX IF NOT EXISTS games_2024q4_ix002 on games_2024q4 using gin(players);
CREATE UNIQUE INDEX IF NOT EXISTS games_2024q4_pk on games_2024q4(game_id);

CREATE TABLE IF NOT EXISTS xonstat.games_2025q1 ( 
    CONSTRAINT games_2025q1_pk PRIMARY KEY (game_id),
	CHECK ( create_dt >= DATE '2025-01-01' AND create_dt < DATE '2025-04-01' ) 
) INHERITS (games);

CREATE INDEX IF NOT EXISTS games_2025q1_ix001 on games_2025q1(create_dt);
CREATE INDEX IF NOT EXISTS games_2025q1_ix002 on games_2025q1 using gin(players);
CREATE UNIQUE INDEX IF NOT EXISTS games_2025q1_pk on games_2025q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.games_2025q2 ( 
    CONSTRAINT games_2025q2_pk PRIMARY KEY (game_id),
	CHECK ( create_dt >= DATE '2025-04-01' AND create_dt < DATE '2025-07-01' ) 
) INHERITS (games);

CREATE INDEX IF NOT EXISTS games_2025q2_ix001 on games_2025q2(create_dt);
CREATE INDEX IF NOT EXISTS games_2025q2_ix002 on games_2025q2 using gin(players);
CREATE UNIQUE INDEX IF NOT EXISTS games_2025q2_pk on games_2025q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.games_2025q3 ( 
    CONSTRAINT games_2025q3_pk PRIMARY KEY (game_id),
	CHECK ( create_dt >= DATE '2025-07-01' AND create_dt < DATE '2025-10-01' ) 
) INHERITS (games);

CREATE INDEX IF NOT EXISTS games_2025q3_ix001 on games_2025q3(create_dt);
CREATE INDEX IF NOT EXISTS games_2025q3_ix002 on games_2025q3 using gin(players);
CREATE UNIQUE INDEX IF NOT EXISTS games_2025q3_pk on games_2025q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.games_2025q4 ( 
    CONSTRAINT games_2025q4_pk PRIMARY KEY (game_id),
	CHECK ( create_dt >= DATE '2025-10-01' AND create_dt < DATE '2026-01-01' ) 
) INHERITS (games);

CREATE INDEX IF NOT EXISTS games_2025q4_ix001 on games_2025q4(create_dt);
CREATE INDEX IF NOT EXISTS games_2025q4_ix002 on games_2025q4 using gin(players);
CREATE UNIQUE INDEX IF NOT EXISTS games_2025q4_pk on games_2025q4(game_id);

-- player_game_stats
CREATE TABLE IF NOT EXISTS xonstat.player_game_stats
(
  player_game_stat_id bigserial NOT NULL,
  player_id integer NOT NULL,
  game_id bigint NOT NULL,
  nick character varying(128),
  stripped_nick character varying(128),
  team integer,
  "rank" integer,
  alivetime interval,
  kills integer,
  deaths integer,
  suicides integer,
  score integer,
  "time" interval,
  captures integer,
  pickups integer,
  drops integer,
  "returns" integer,
  collects integer,
  destroys integer,
  pushes integer,
  carrier_frags integer,
  elo_delta numeric,
  fastest interval,
  avg_latency numeric,
  teamrank integer,
  scoreboardpos integer,
  laps integer,
  revivals integer,
  lives integer,
  create_dt timestamp without time zone NOT NULL DEFAULT (current_timestamp at time zone 'UTC'),
  CONSTRAINT player_game_stats_pk PRIMARY KEY (player_game_stat_id),
  CONSTRAINT player_game_stats_fk001 FOREIGN KEY (player_id)
      REFERENCES xonstat.players (player_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT player_game_stats_fk002 FOREIGN KEY (game_id)
      REFERENCES xonstat.games (game_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE INDEX IF NOT EXISTS player_game_stats_ix01 on player_game_stats(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_ix02 on player_game_stats(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_ix03 on player_game_stats(player_id);
ALTER TABLE xonstat.player_game_stats OWNER TO xonstat;

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2014q1 ( 
    CONSTRAINT player_game_stats_2014q1_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2014-01-01' AND create_dt < DATE '2014-04-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2014q1_pk on player_game_stats_2014q1(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2014q1_ix001 on player_game_stats_2014q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2014q1_ix002 on player_game_stats_2014q1(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2014q1_ix003 on player_game_stats_2014q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2014q2 ( 
    CONSTRAINT player_game_stats_2014q2_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2014-04-01' AND create_dt < DATE '2014-07-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2014q2_pk on player_game_stats_2014q2(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2014q2_ix001 on player_game_stats_2014q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2014q2_ix002 on player_game_stats_2014q2(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2014q2_ix003 on player_game_stats_2014q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2014q3 ( 
    CONSTRAINT player_game_stats_2014q3_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2014-07-01' AND create_dt < DATE '2014-10-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2014q3_pk on player_game_stats_2014q3(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2014q3_ix001 on player_game_stats_2014q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2014q3_ix002 on player_game_stats_2014q3(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2014q3_ix003 on player_game_stats_2014q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2014q4 ( 
    CONSTRAINT player_game_stats_2014q4_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2014-10-01' AND create_dt < DATE '2015-01-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2014q4_pk on player_game_stats_2014q4(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2014q4_ix001 on player_game_stats_2014q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2014q4_ix002 on player_game_stats_2014q4(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2014q4_ix003 on player_game_stats_2014q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2015q1 ( 
    CONSTRAINT player_game_stats_2015q1_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2015-01-01' AND create_dt < DATE '2015-04-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2015q1_pk on player_game_stats_2015q1(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2015q1_ix001 on player_game_stats_2015q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2015q1_ix002 on player_game_stats_2015q1(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2015q1_ix003 on player_game_stats_2015q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2015q2 ( 
    CONSTRAINT player_game_stats_2015q2_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2015-04-01' AND create_dt < DATE '2015-07-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2015q2_pk on player_game_stats_2015q2(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2015q2_ix001 on player_game_stats_2015q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2015q2_ix002 on player_game_stats_2015q2(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2015q2_ix003 on player_game_stats_2015q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2015q3 ( 
    CONSTRAINT player_game_stats_2015q3_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2015-07-01' AND create_dt < DATE '2015-10-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2015q3_pk on player_game_stats_2015q3(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2015q3_ix001 on player_game_stats_2015q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2015q3_ix002 on player_game_stats_2015q3(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2015q3_ix003 on player_game_stats_2015q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2015q4 ( 
    CONSTRAINT player_game_stats_2015q4_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2015-10-01' AND create_dt < DATE '2016-01-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2015q4_pk on player_game_stats_2015q4(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2015q4_ix001 on player_game_stats_2015q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2015q4_ix002 on player_game_stats_2015q4(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2015q4_ix003 on player_game_stats_2015q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2016q1 ( 
    CONSTRAINT player_game_stats_2016q1_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2016-01-01' AND create_dt < DATE '2016-04-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2016q1_pk on player_game_stats_2016q1(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2016q1_ix001 on player_game_stats_2016q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2016q1_ix002 on player_game_stats_2016q1(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2016q1_ix003 on player_game_stats_2016q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2016q2 ( 
    CONSTRAINT player_game_stats_2016q2_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2016-04-01' AND create_dt < DATE '2016-07-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2016q2_pk on player_game_stats_2016q2(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2016q2_ix001 on player_game_stats_2016q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2016q2_ix002 on player_game_stats_2016q2(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2016q2_ix003 on player_game_stats_2016q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2016q3 ( 
    CONSTRAINT player_game_stats_2016q3_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2016-07-01' AND create_dt < DATE '2016-10-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2016q3_pk on player_game_stats_2016q3(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2016q3_ix001 on player_game_stats_2016q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2016q3_ix002 on player_game_stats_2016q3(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2016q3_ix003 on player_game_stats_2016q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2016q4 ( 
    CONSTRAINT player_game_stats_2016q4_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2016-10-01' AND create_dt < DATE '2017-01-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2016q4_pk on player_game_stats_2016q4(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2016q4_ix001 on player_game_stats_2016q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2016q4_ix002 on player_game_stats_2016q4(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2016q4_ix003 on player_game_stats_2016q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2017q1 ( 
    CONSTRAINT player_game_stats_2017q1_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2017-01-01' AND create_dt < DATE '2017-04-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2017q1_pk on player_game_stats_2017q1(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2017q1_ix001 on player_game_stats_2017q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2017q1_ix002 on player_game_stats_2017q1(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2017q1_ix003 on player_game_stats_2017q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2017q2 ( 
    CONSTRAINT player_game_stats_2017q2_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2017-04-01' AND create_dt < DATE '2017-07-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2017q2_pk on player_game_stats_2017q2(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2017q2_ix001 on player_game_stats_2017q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2017q2_ix002 on player_game_stats_2017q2(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2017q2_ix003 on player_game_stats_2017q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2017q3 ( 
    CONSTRAINT player_game_stats_2017q3_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2017-07-01' AND create_dt < DATE '2017-10-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2017q3_pk on player_game_stats_2017q3(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2017q3_ix001 on player_game_stats_2017q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2017q3_ix002 on player_game_stats_2017q3(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2017q3_ix003 on player_game_stats_2017q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2017q4 ( 
    CONSTRAINT player_game_stats_2017q4_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2017-10-01' AND create_dt < DATE '2018-01-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2017q4_pk on player_game_stats_2017q4(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2017q4_ix001 on player_game_stats_2017q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2017q4_ix002 on player_game_stats_2017q4(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2017q4_ix003 on player_game_stats_2017q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2018q1 ( 
    CONSTRAINT player_game_stats_2018q1_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2018-01-01' AND create_dt < DATE '2018-04-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2018q1_pk on player_game_stats_2018q1(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2018q1_ix001 on player_game_stats_2018q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2018q1_ix002 on player_game_stats_2018q1(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2018q1_ix003 on player_game_stats_2018q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2018q2 ( 
    CONSTRAINT player_game_stats_2018q2_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2018-04-01' AND create_dt < DATE '2018-07-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2018q2_pk on player_game_stats_2018q2(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2018q2_ix001 on player_game_stats_2018q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2018q2_ix002 on player_game_stats_2018q2(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2018q2_ix003 on player_game_stats_2018q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2018q3 ( 
    CONSTRAINT player_game_stats_2018q3_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2018-07-01' AND create_dt < DATE '2018-10-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2018q3_pk on player_game_stats_2018q3(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2018q3_ix001 on player_game_stats_2018q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2018q3_ix002 on player_game_stats_2018q3(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2018q3_ix003 on player_game_stats_2018q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2018q4 ( 
    CONSTRAINT player_game_stats_2018q4_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2018-10-01' AND create_dt < DATE '2019-01-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2018q4_pk on player_game_stats_2018q4(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2018q4_ix001 on player_game_stats_2018q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2018q4_ix002 on player_game_stats_2018q4(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2018q4_ix003 on player_game_stats_2018q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2019q1 ( 
    CONSTRAINT player_game_stats_2019q1_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2019-01-01' AND create_dt < DATE '2019-04-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2019q1_pk on player_game_stats_2019q1(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2019q1_ix001 on player_game_stats_2019q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2019q1_ix002 on player_game_stats_2019q1(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2019q1_ix003 on player_game_stats_2019q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2019q2 ( 
    CONSTRAINT player_game_stats_2019q2_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2019-04-01' AND create_dt < DATE '2019-07-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2019q2_pk on player_game_stats_2019q2(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2019q2_ix001 on player_game_stats_2019q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2019q2_ix002 on player_game_stats_2019q2(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2019q2_ix003 on player_game_stats_2019q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2019q3 ( 
    CONSTRAINT player_game_stats_2019q3_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2019-07-01' AND create_dt < DATE '2019-10-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2019q3_pk on player_game_stats_2019q3(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2019q3_ix001 on player_game_stats_2019q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2019q3_ix002 on player_game_stats_2019q3(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2019q3_ix003 on player_game_stats_2019q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2019q4 ( 
    CONSTRAINT player_game_stats_2019q4_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2019-10-01' AND create_dt < DATE '2020-01-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2019q4_pk on player_game_stats_2019q4(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2019q4_ix001 on player_game_stats_2019q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2019q4_ix002 on player_game_stats_2019q4(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2019q4_ix003 on player_game_stats_2019q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2020q1 ( 
    CONSTRAINT player_game_stats_2020q1_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2020-01-01' AND create_dt < DATE '2020-04-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2020q1_pk on player_game_stats_2020q1(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2020q1_ix001 on player_game_stats_2020q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2020q1_ix002 on player_game_stats_2020q1(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2020q1_ix003 on player_game_stats_2020q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2020q2 ( 
    CONSTRAINT player_game_stats_2020q2_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2020-04-01' AND create_dt < DATE '2020-07-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2020q2_pk on player_game_stats_2020q2(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2020q2_ix001 on player_game_stats_2020q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2020q2_ix002 on player_game_stats_2020q2(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2020q2_ix003 on player_game_stats_2020q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2020q3 ( 
    CONSTRAINT player_game_stats_2020q3_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2020-07-01' AND create_dt < DATE '2020-10-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2020q3_pk on player_game_stats_2020q3(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2020q3_ix001 on player_game_stats_2020q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2020q3_ix002 on player_game_stats_2020q3(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2020q3_ix003 on player_game_stats_2020q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2020q4 ( 
    CONSTRAINT player_game_stats_2020q4_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2020-10-01' AND create_dt < DATE '2021-01-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2020q4_pk on player_game_stats_2020q4(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2020q4_ix001 on player_game_stats_2020q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2020q4_ix002 on player_game_stats_2020q4(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2020q4_ix003 on player_game_stats_2020q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2021q1 ( 
    CONSTRAINT player_game_stats_2021q1_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2021-01-01' AND create_dt < DATE '2021-04-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2021q1_pk on player_game_stats_2021q1(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2021q1_ix001 on player_game_stats_2021q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2021q1_ix002 on player_game_stats_2021q1(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2021q1_ix003 on player_game_stats_2021q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2021q2 ( 
    CONSTRAINT player_game_stats_2021q2_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2021-04-01' AND create_dt < DATE '2021-07-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2021q2_pk on player_game_stats_2021q2(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2021q2_ix001 on player_game_stats_2021q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2021q2_ix002 on player_game_stats_2021q2(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2021q2_ix003 on player_game_stats_2021q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2021q3 ( 
    CONSTRAINT player_game_stats_2021q3_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2021-07-01' AND create_dt < DATE '2021-10-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2021q3_pk on player_game_stats_2021q3(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2021q3_ix001 on player_game_stats_2021q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2021q3_ix002 on player_game_stats_2021q3(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2021q3_ix003 on player_game_stats_2021q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2021q4 ( 
    CONSTRAINT player_game_stats_2021q4_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2021-10-01' AND create_dt < DATE '2022-01-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2021q4_pk on player_game_stats_2021q4(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2021q4_ix001 on player_game_stats_2021q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2021q4_ix002 on player_game_stats_2021q4(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2021q4_ix003 on player_game_stats_2021q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2022q1 ( 
    CONSTRAINT player_game_stats_2022q1_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2022-01-01' AND create_dt < DATE '2022-04-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2022q1_pk on player_game_stats_2022q1(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2022q1_ix001 on player_game_stats_2022q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2022q1_ix002 on player_game_stats_2022q1(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2022q1_ix003 on player_game_stats_2022q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2022q2 ( 
    CONSTRAINT player_game_stats_2022q2_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2022-04-01' AND create_dt < DATE '2022-07-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2022q2_pk on player_game_stats_2022q2(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2022q2_ix001 on player_game_stats_2022q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2022q2_ix002 on player_game_stats_2022q2(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2022q2_ix003 on player_game_stats_2022q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2022q3 ( 
    CONSTRAINT player_game_stats_2022q3_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2022-07-01' AND create_dt < DATE '2022-10-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2022q3_pk on player_game_stats_2022q3(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2022q3_ix001 on player_game_stats_2022q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2022q3_ix002 on player_game_stats_2022q3(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2022q3_ix003 on player_game_stats_2022q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2022q4 ( 
    CONSTRAINT player_game_stats_2022q4_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2022-10-01' AND create_dt < DATE '2023-01-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2022q4_pk on player_game_stats_2022q4(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2022q4_ix001 on player_game_stats_2022q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2022q4_ix002 on player_game_stats_2022q4(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2022q4_ix003 on player_game_stats_2022q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2023q1 ( 
    CONSTRAINT player_game_stats_2023q1_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2023-01-01' AND create_dt < DATE '2023-04-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2023q1_pk on player_game_stats_2023q1(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2023q1_ix001 on player_game_stats_2023q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2023q1_ix002 on player_game_stats_2023q1(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2023q1_ix003 on player_game_stats_2023q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2023q2 ( 
    CONSTRAINT player_game_stats_2023q2_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2023-04-01' AND create_dt < DATE '2023-07-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2023q2_pk on player_game_stats_2023q2(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2023q2_ix001 on player_game_stats_2023q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2023q2_ix002 on player_game_stats_2023q2(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2023q2_ix003 on player_game_stats_2023q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2023q3 ( 
    CONSTRAINT player_game_stats_2023q3_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2023-07-01' AND create_dt < DATE '2023-10-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2023q3_pk on player_game_stats_2023q3(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2023q3_ix001 on player_game_stats_2023q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2023q3_ix002 on player_game_stats_2023q3(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2023q3_ix003 on player_game_stats_2023q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2023q4 ( 
    CONSTRAINT player_game_stats_2023q4_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2023-10-01' AND create_dt < DATE '2024-01-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2023q4_pk on player_game_stats_2023q4(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2023q4_ix001 on player_game_stats_2023q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2023q4_ix002 on player_game_stats_2023q4(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2023q4_ix003 on player_game_stats_2023q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2024q1 ( 
    CONSTRAINT player_game_stats_2024q1_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2024-01-01' AND create_dt < DATE '2024-04-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2024q1_pk on player_game_stats_2024q1(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2024q1_ix001 on player_game_stats_2024q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2024q1_ix002 on player_game_stats_2024q1(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2024q1_ix003 on player_game_stats_2024q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2024q2 ( 
    CONSTRAINT player_game_stats_2024q2_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2024-04-01' AND create_dt < DATE '2024-07-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2024q2_pk on player_game_stats_2024q2(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2024q2_ix001 on player_game_stats_2024q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2024q2_ix002 on player_game_stats_2024q2(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2024q2_ix003 on player_game_stats_2024q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2024q3 ( 
    CONSTRAINT player_game_stats_2024q3_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2024-07-01' AND create_dt < DATE '2024-10-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2024q3_pk on player_game_stats_2024q3(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2024q3_ix001 on player_game_stats_2024q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2024q3_ix002 on player_game_stats_2024q3(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2024q3_ix003 on player_game_stats_2024q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2024q4 ( 
    CONSTRAINT player_game_stats_2024q4_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2024-10-01' AND create_dt < DATE '2025-01-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2024q4_pk on player_game_stats_2024q4(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2024q4_ix001 on player_game_stats_2024q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2024q4_ix002 on player_game_stats_2024q4(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2024q4_ix003 on player_game_stats_2024q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2025q1 ( 
    CONSTRAINT player_game_stats_2025q1_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2025-01-01' AND create_dt < DATE '2025-04-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2025q1_pk on player_game_stats_2025q1(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2025q1_ix001 on player_game_stats_2025q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2025q1_ix002 on player_game_stats_2025q1(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2025q1_ix003 on player_game_stats_2025q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2025q2 ( 
    CONSTRAINT player_game_stats_2025q2_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2025-04-01' AND create_dt < DATE '2025-07-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2025q2_pk on player_game_stats_2025q2(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2025q2_ix001 on player_game_stats_2025q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2025q2_ix002 on player_game_stats_2025q2(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2025q2_ix003 on player_game_stats_2025q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2025q3 ( 
    CONSTRAINT player_game_stats_2025q3_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2025-07-01' AND create_dt < DATE '2025-10-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2025q3_pk on player_game_stats_2025q3(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2025q3_ix001 on player_game_stats_2025q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2025q3_ix002 on player_game_stats_2025q3(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2025q3_ix003 on player_game_stats_2025q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_stats_2025q4 ( 
    CONSTRAINT player_game_stats_2025q4_pk PRIMARY KEY (player_game_stat_id),
	CHECK ( create_dt >= DATE '2025-10-01' AND create_dt < DATE '2026-01-01' ) 
) INHERITS (player_game_stats);

CREATE UNIQUE INDEX IF NOT EXISTS player_game_stats_2025q4_pk on player_game_stats_2025q4(player_game_stat_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2025q4_ix001 on player_game_stats_2025q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_stats_2025q4_ix002 on player_game_stats_2025q4(game_id);
CREATE INDEX IF NOT EXISTS player_game_stats_2025q4_ix003 on player_game_stats_2025q4(player_id);

-- player_weapon_stats
CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats
(
  player_weapon_stats_id bigserial NOT NULL,
  player_id integer NOT NULL,
  game_id bigint NOT NULL,
  player_game_stat_id bigint NOT NULL,
  weapon_cd character varying(15) NOT NULL,
  actual integer NOT NULL default 0,
  max integer NOT NULL default 0,
  hit integer NOT NULL default 0,
  fired integer NOT NULL default 0,
  frags integer NOT NULL default 0,
  create_dt timestamp without time zone NOT NULL DEFAULT (current_timestamp at time zone 'UTC'),
  CONSTRAINT player_weapon_stats_pk PRIMARY KEY (player_weapon_stats_id),
  CONSTRAINT player_weapon_stats_fk001 FOREIGN KEY (player_id)
      REFERENCES xonstat.players (player_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT player_weapon_stats_fk002 FOREIGN KEY (game_id)
      REFERENCES xonstat.games (game_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT player_weapon_stats_fk003 FOREIGN KEY (weapon_cd)
      REFERENCES xonstat.cd_weapon (weapon_cd) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT player_weapon_stats_fk004 FOREIGN KEY (player_game_stat_id)
      REFERENCES xonstat.player_game_stats (player_game_stat_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE INDEX IF NOT EXISTS player_weap_stats_ix01 on player_weapon_stats(create_dt);
CREATE INDEX IF NOT EXISTS player_weap_stats_ix02 on player_weapon_stats(game_id);
CREATE INDEX IF NOT EXISTS player_weap_stats_ix03 on player_weapon_stats(player_id);

ALTER TABLE xonstat.player_weapon_stats OWNER TO xonstat;

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2014q1 ( 
    CONSTRAINT player_weapon_stats_2014q1_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2014-01-01' AND create_dt < DATE '2014-04-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2014q1_ix001 on player_weapon_stats_2014q1(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2014q1_ix002 on player_weapon_stats_2014q1(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2014q1_ix003 on player_weapon_stats_2014q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2014q2 ( 
    CONSTRAINT player_weapon_stats_2014q2_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2014-04-01' AND create_dt < DATE '2014-07-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2014q2_ix001 on player_weapon_stats_2014q2(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2014q2_ix002 on player_weapon_stats_2014q2(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2014q2_ix003 on player_weapon_stats_2014q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2014q3 ( 
    CONSTRAINT player_weapon_stats_2014q3_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2014-07-01' AND create_dt < DATE '2014-10-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2014q3_ix001 on player_weapon_stats_2014q3(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2014q3_ix002 on player_weapon_stats_2014q3(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2014q3_ix003 on player_weapon_stats_2014q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2014q4 ( 
    CONSTRAINT player_weapon_stats_2014q4_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2014-10-01' AND create_dt < DATE '2015-01-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2014q4_ix001 on player_weapon_stats_2014q4(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2014q4_ix002 on player_weapon_stats_2014q4(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2014q4_ix003 on player_weapon_stats_2014q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2015q1 ( 
    CONSTRAINT player_weapon_stats_2015q1_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2015-01-01' AND create_dt < DATE '2015-04-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2015q1_ix001 on player_weapon_stats_2015q1(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2015q1_ix002 on player_weapon_stats_2015q1(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2015q1_ix003 on player_weapon_stats_2015q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2015q2 ( 
    CONSTRAINT player_weapon_stats_2015q2_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2015-04-01' AND create_dt < DATE '2015-07-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2015q2_ix001 on player_weapon_stats_2015q2(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2015q2_ix002 on player_weapon_stats_2015q2(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2015q2_ix003 on player_weapon_stats_2015q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2015q3 ( 
    CONSTRAINT player_weapon_stats_2015q3_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2015-07-01' AND create_dt < DATE '2015-10-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2015q3_ix001 on player_weapon_stats_2015q3(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2015q3_ix002 on player_weapon_stats_2015q3(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2015q3_ix003 on player_weapon_stats_2015q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2015q4 ( 
    CONSTRAINT player_weapon_stats_2015q4_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2015-10-01' AND create_dt < DATE '2016-01-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2015q4_ix001 on player_weapon_stats_2015q4(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2015q4_ix002 on player_weapon_stats_2015q4(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2015q4_ix003 on player_weapon_stats_2015q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2016q1 ( 
    CONSTRAINT player_weapon_stats_2016q1_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2016-01-01' AND create_dt < DATE '2016-04-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2016q1_ix001 on player_weapon_stats_2016q1(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2016q1_ix002 on player_weapon_stats_2016q1(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2016q1_ix003 on player_weapon_stats_2016q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2016q2 ( 
    CONSTRAINT player_weapon_stats_2016q2_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2016-04-01' AND create_dt < DATE '2016-07-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2016q2_ix001 on player_weapon_stats_2016q2(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2016q2_ix002 on player_weapon_stats_2016q2(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2016q2_ix003 on player_weapon_stats_2016q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2016q3 ( 
    CONSTRAINT player_weapon_stats_2016q3_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2016-07-01' AND create_dt < DATE '2016-10-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2016q3_ix001 on player_weapon_stats_2016q3(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2016q3_ix002 on player_weapon_stats_2016q3(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2016q3_ix003 on player_weapon_stats_2016q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2016q4 ( 
    CONSTRAINT player_weapon_stats_2016q4_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2016-10-01' AND create_dt < DATE '2017-01-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2016q4_ix001 on player_weapon_stats_2016q4(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2016q4_ix002 on player_weapon_stats_2016q4(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2016q4_ix003 on player_weapon_stats_2016q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2017q1 ( 
    CONSTRAINT player_weapon_stats_2017q1_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2017-01-01' AND create_dt < DATE '2017-04-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2017q1_ix001 on player_weapon_stats_2017q1(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2017q1_ix002 on player_weapon_stats_2017q1(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2017q1_ix003 on player_weapon_stats_2017q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2017q2 ( 
    CONSTRAINT player_weapon_stats_2017q2_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2017-04-01' AND create_dt < DATE '2017-07-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2017q2_ix001 on player_weapon_stats_2017q2(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2017q2_ix002 on player_weapon_stats_2017q2(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2017q2_ix003 on player_weapon_stats_2017q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2017q3 ( 
    CONSTRAINT player_weapon_stats_2017q3_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2017-07-01' AND create_dt < DATE '2017-10-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2017q3_ix001 on player_weapon_stats_2017q3(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2017q3_ix002 on player_weapon_stats_2017q3(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2017q3_ix003 on player_weapon_stats_2017q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2017q4 ( 
    CONSTRAINT player_weapon_stats_2017q4_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2017-10-01' AND create_dt < DATE '2018-01-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2017q4_ix001 on player_weapon_stats_2017q4(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2017q4_ix002 on player_weapon_stats_2017q4(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2017q4_ix003 on player_weapon_stats_2017q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2018q1 ( 
    CONSTRAINT player_weapon_stats_2018q1_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2018-01-01' AND create_dt < DATE '2018-04-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2018q1_ix001 on player_weapon_stats_2018q1(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2018q1_ix002 on player_weapon_stats_2018q1(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2018q1_ix003 on player_weapon_stats_2018q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2018q2 ( 
    CONSTRAINT player_weapon_stats_2018q2_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2018-04-01' AND create_dt < DATE '2018-07-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2018q2_ix001 on player_weapon_stats_2018q2(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2018q2_ix002 on player_weapon_stats_2018q2(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2018q2_ix003 on player_weapon_stats_2018q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2018q3 ( 
    CONSTRAINT player_weapon_stats_2018q3_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2018-07-01' AND create_dt < DATE '2018-10-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2018q3_ix001 on player_weapon_stats_2018q3(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2018q3_ix002 on player_weapon_stats_2018q3(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2018q3_ix003 on player_weapon_stats_2018q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2018q4 ( 
    CONSTRAINT player_weapon_stats_2018q4_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2018-10-01' AND create_dt < DATE '2019-01-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2018q4_ix001 on player_weapon_stats_2018q4(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2018q4_ix002 on player_weapon_stats_2018q4(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2018q4_ix003 on player_weapon_stats_2018q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2019q1 ( 
    CONSTRAINT player_weapon_stats_2019q1_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2019-01-01' AND create_dt < DATE '2019-04-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2019q1_ix001 on player_weapon_stats_2019q1(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2019q1_ix002 on player_weapon_stats_2019q1(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2019q1_ix003 on player_weapon_stats_2019q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2019q2 ( 
    CONSTRAINT player_weapon_stats_2019q2_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2019-04-01' AND create_dt < DATE '2019-07-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2019q2_ix001 on player_weapon_stats_2019q2(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2019q2_ix002 on player_weapon_stats_2019q2(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2019q2_ix003 on player_weapon_stats_2019q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2019q3 ( 
    CONSTRAINT player_weapon_stats_2019q3_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2019-07-01' AND create_dt < DATE '2019-10-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2019q3_ix001 on player_weapon_stats_2019q3(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2019q3_ix002 on player_weapon_stats_2019q3(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2019q3_ix003 on player_weapon_stats_2019q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2019q4 ( 
    CONSTRAINT player_weapon_stats_2019q4_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2019-10-01' AND create_dt < DATE '2020-01-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2019q4_ix001 on player_weapon_stats_2019q4(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2019q4_ix002 on player_weapon_stats_2019q4(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2019q4_ix003 on player_weapon_stats_2019q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2020q1 ( 
    CONSTRAINT player_weapon_stats_2020q1_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2020-01-01' AND create_dt < DATE '2020-04-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2020q1_ix001 on player_weapon_stats_2020q1(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2020q1_ix002 on player_weapon_stats_2020q1(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2020q1_ix003 on player_weapon_stats_2020q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2020q2 ( 
    CONSTRAINT player_weapon_stats_2020q2_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2020-04-01' AND create_dt < DATE '2020-07-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2020q2_ix001 on player_weapon_stats_2020q2(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2020q2_ix002 on player_weapon_stats_2020q2(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2020q2_ix003 on player_weapon_stats_2020q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2020q3 ( 
    CONSTRAINT player_weapon_stats_2020q3_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2020-07-01' AND create_dt < DATE '2020-10-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2020q3_ix001 on player_weapon_stats_2020q3(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2020q3_ix002 on player_weapon_stats_2020q3(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2020q3_ix003 on player_weapon_stats_2020q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2020q4 ( 
    CONSTRAINT player_weapon_stats_2020q4_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2020-10-01' AND create_dt < DATE '2021-01-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2020q4_ix001 on player_weapon_stats_2020q4(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2020q4_ix002 on player_weapon_stats_2020q4(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2020q4_ix003 on player_weapon_stats_2020q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2021q1 ( 
    CONSTRAINT player_weapon_stats_2021q1_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2021-01-01' AND create_dt < DATE '2021-04-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2021q1_ix001 on player_weapon_stats_2021q1(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2021q1_ix002 on player_weapon_stats_2021q1(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2021q1_ix003 on player_weapon_stats_2021q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2021q2 ( 
    CONSTRAINT player_weapon_stats_2021q2_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2021-04-01' AND create_dt < DATE '2021-07-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2021q2_ix001 on player_weapon_stats_2021q2(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2021q2_ix002 on player_weapon_stats_2021q2(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2021q2_ix003 on player_weapon_stats_2021q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2021q3 ( 
    CONSTRAINT player_weapon_stats_2021q3_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2021-07-01' AND create_dt < DATE '2021-10-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2021q3_ix001 on player_weapon_stats_2021q3(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2021q3_ix002 on player_weapon_stats_2021q3(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2021q3_ix003 on player_weapon_stats_2021q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2021q4 ( 
    CONSTRAINT player_weapon_stats_2021q4_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2021-10-01' AND create_dt < DATE '2022-01-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2021q4_ix001 on player_weapon_stats_2021q4(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2021q4_ix002 on player_weapon_stats_2021q4(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2021q4_ix003 on player_weapon_stats_2021q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2022q1 ( 
    CONSTRAINT player_weapon_stats_2022q1_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2022-01-01' AND create_dt < DATE '2022-04-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2022q1_ix001 on player_weapon_stats_2022q1(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2022q1_ix002 on player_weapon_stats_2022q1(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2022q1_ix003 on player_weapon_stats_2022q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2022q2 ( 
    CONSTRAINT player_weapon_stats_2022q2_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2022-04-01' AND create_dt < DATE '2022-07-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2022q2_ix001 on player_weapon_stats_2022q2(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2022q2_ix002 on player_weapon_stats_2022q2(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2022q2_ix003 on player_weapon_stats_2022q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2022q3 ( 
    CONSTRAINT player_weapon_stats_2022q3_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2022-07-01' AND create_dt < DATE '2022-10-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2022q3_ix001 on player_weapon_stats_2022q3(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2022q3_ix002 on player_weapon_stats_2022q3(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2022q3_ix003 on player_weapon_stats_2022q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2022q4 ( 
    CONSTRAINT player_weapon_stats_2022q4_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2022-10-01' AND create_dt < DATE '2023-01-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2022q4_ix001 on player_weapon_stats_2022q4(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2022q4_ix002 on player_weapon_stats_2022q4(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2022q4_ix003 on player_weapon_stats_2022q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2023q1 ( 
    CONSTRAINT player_weapon_stats_2023q1_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2023-01-01' AND create_dt < DATE '2023-04-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2023q1_ix001 on player_weapon_stats_2023q1(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2023q1_ix002 on player_weapon_stats_2023q1(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2023q1_ix003 on player_weapon_stats_2023q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2023q2 ( 
    CONSTRAINT player_weapon_stats_2023q2_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2023-04-01' AND create_dt < DATE '2023-07-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2023q2_ix001 on player_weapon_stats_2023q2(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2023q2_ix002 on player_weapon_stats_2023q2(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2023q2_ix003 on player_weapon_stats_2023q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2023q3 ( 
    CONSTRAINT player_weapon_stats_2023q3_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2023-07-01' AND create_dt < DATE '2023-10-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2023q3_ix001 on player_weapon_stats_2023q3(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2023q3_ix002 on player_weapon_stats_2023q3(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2023q3_ix003 on player_weapon_stats_2023q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2023q4 ( 
    CONSTRAINT player_weapon_stats_2023q4_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2023-10-01' AND create_dt < DATE '2024-01-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2023q4_ix001 on player_weapon_stats_2023q4(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2023q4_ix002 on player_weapon_stats_2023q4(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2023q4_ix003 on player_weapon_stats_2023q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2024q1 ( 
    CONSTRAINT player_weapon_stats_2024q1_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2024-01-01' AND create_dt < DATE '2024-04-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2024q1_ix001 on player_weapon_stats_2024q1(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2024q1_ix002 on player_weapon_stats_2024q1(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2024q1_ix003 on player_weapon_stats_2024q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2024q2 ( 
    CONSTRAINT player_weapon_stats_2024q2_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2024-04-01' AND create_dt < DATE '2024-07-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2024q2_ix001 on player_weapon_stats_2024q2(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2024q2_ix002 on player_weapon_stats_2024q2(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2024q2_ix003 on player_weapon_stats_2024q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2024q3 ( 
    CONSTRAINT player_weapon_stats_2024q3_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2024-07-01' AND create_dt < DATE '2024-10-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2024q3_ix001 on player_weapon_stats_2024q3(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2024q3_ix002 on player_weapon_stats_2024q3(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2024q3_ix003 on player_weapon_stats_2024q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2024q4 ( 
    CONSTRAINT player_weapon_stats_2024q4_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2024-10-01' AND create_dt < DATE '2025-01-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2024q4_ix001 on player_weapon_stats_2024q4(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2024q4_ix002 on player_weapon_stats_2024q4(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2024q4_ix003 on player_weapon_stats_2024q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2025q1 ( 
    CONSTRAINT player_weapon_stats_2025q1_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2025-01-01' AND create_dt < DATE '2025-04-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2025q1_ix001 on player_weapon_stats_2025q1(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2025q1_ix002 on player_weapon_stats_2025q1(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2025q1_ix003 on player_weapon_stats_2025q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2025q2 ( 
    CONSTRAINT player_weapon_stats_2025q2_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2025-04-01' AND create_dt < DATE '2025-07-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2025q2_ix001 on player_weapon_stats_2025q2(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2025q2_ix002 on player_weapon_stats_2025q2(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2025q2_ix003 on player_weapon_stats_2025q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2025q3 ( 
    CONSTRAINT player_weapon_stats_2025q3_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2025-07-01' AND create_dt < DATE '2025-10-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2025q3_ix001 on player_weapon_stats_2025q3(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2025q3_ix002 on player_weapon_stats_2025q3(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2025q3_ix003 on player_weapon_stats_2025q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_weapon_stats_2025q4 ( 
    CONSTRAINT player_weapon_stats_2025q4_pk PRIMARY KEY (player_weapon_stats_id),
	CHECK ( create_dt >= DATE '2025-10-01' AND create_dt < DATE '2026-01-01' ) 
) INHERITS (player_weapon_stats);

CREATE INDEX IF NOT EXISTS player_weapon_stats_2025q4_ix001 on player_weapon_stats_2025q4(create_dt);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2025q4_ix002 on player_weapon_stats_2025q4(game_id);
CREATE INDEX IF NOT EXISTS player_weapon_stats_2025q4_ix003 on player_weapon_stats_2025q4(player_id);

-- hashkeys
CREATE TABLE IF NOT EXISTS xonstat.hashkeys
(
  player_id integer NOT NULL,
  hashkey character varying(44) NOT NULL,
  active_ind boolean NOT NULL DEFAULT true,
  create_dt timestamp without time zone NOT NULL DEFAULT (current_timestamp at time zone 'UTC'),
  CONSTRAINT hashkeys_pk PRIMARY KEY (player_id, hashkey),
  CONSTRAINT hashkeys_fk001 FOREIGN KEY (player_id)
      REFERENCES xonstat.players (player_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT hashkeys_uk001 UNIQUE (hashkey)
);

ALTER TABLE xonstat.hashkeys OWNER TO xonstat;

-- team_game_stats
CREATE TABLE IF NOT EXISTS xonstat.team_game_stats
(
  team_game_stat_id bigserial NOT NULL,
  game_id bigint NOT NULL,
  team integer NOT NULL,
  score integer,
  rounds integer,
  caps integer,
  create_dt timestamp without time zone NOT NULL DEFAULT (current_timestamp at time zone 'UTC'),
  CONSTRAINT team_game_stats_pk PRIMARY KEY (team_game_stat_id),
  CONSTRAINT team_game_stats_uk001 UNIQUE (game_id, team),
  CONSTRAINT team_game_stats_fk001 FOREIGN KEY (game_id)
      REFERENCES xonstat.games (game_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS team_game_stats_ix01 on team_game_stats(game_id);
ALTER TABLE xonstat.team_game_stats OWNER TO xonstat;

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2014q1 ( 
    CONSTRAINT team_game_stats_2014q1_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2014-01-01' AND create_dt < DATE '2014-04-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2014q1_ix001 on team_game_stats_2014q1(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2014q1_ix002 on team_game_stats_2014q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2014q2 ( 
    CONSTRAINT team_game_stats_2014q2_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2014-04-01' AND create_dt < DATE '2014-07-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2014q2_ix001 on team_game_stats_2014q2(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2014q2_ix002 on team_game_stats_2014q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2014q3 ( 
    CONSTRAINT team_game_stats_2014q3_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2014-07-01' AND create_dt < DATE '2014-10-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2014q3_ix001 on team_game_stats_2014q3(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2014q3_ix002 on team_game_stats_2014q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2014q4 ( 
    CONSTRAINT team_game_stats_2014q4_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2014-10-01' AND create_dt < DATE '2015-01-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2014q4_ix001 on team_game_stats_2014q4(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2014q4_ix002 on team_game_stats_2014q4(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2015q1 ( 
    CONSTRAINT team_game_stats_2015q1_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2015-01-01' AND create_dt < DATE '2015-04-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2015q1_ix001 on team_game_stats_2015q1(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2015q1_ix002 on team_game_stats_2015q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2015q2 ( 
    CONSTRAINT team_game_stats_2015q2_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2015-04-01' AND create_dt < DATE '2015-07-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2015q2_ix001 on team_game_stats_2015q2(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2015q2_ix002 on team_game_stats_2015q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2015q3 ( 
    CONSTRAINT team_game_stats_2015q3_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2015-07-01' AND create_dt < DATE '2015-10-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2015q3_ix001 on team_game_stats_2015q3(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2015q3_ix002 on team_game_stats_2015q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2015q4 ( 
    CONSTRAINT team_game_stats_2015q4_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2015-10-01' AND create_dt < DATE '2016-01-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2015q4_ix001 on team_game_stats_2015q4(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2015q4_ix002 on team_game_stats_2015q4(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2016q1 ( 
    CONSTRAINT team_game_stats_2016q1_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2016-01-01' AND create_dt < DATE '2016-04-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2016q1_ix001 on team_game_stats_2016q1(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2016q1_ix002 on team_game_stats_2016q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2016q2 ( 
    CONSTRAINT team_game_stats_2016q2_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2016-04-01' AND create_dt < DATE '2016-07-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2016q2_ix001 on team_game_stats_2016q2(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2016q2_ix002 on team_game_stats_2016q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2016q3 ( 
    CONSTRAINT team_game_stats_2016q3_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2016-07-01' AND create_dt < DATE '2016-10-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2016q3_ix001 on team_game_stats_2016q3(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2016q3_ix002 on team_game_stats_2016q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2016q4 ( 
    CONSTRAINT team_game_stats_2016q4_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2016-10-01' AND create_dt < DATE '2017-01-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2016q4_ix001 on team_game_stats_2016q4(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2016q4_ix002 on team_game_stats_2016q4(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2017q1 ( 
    CONSTRAINT team_game_stats_2017q1_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2017-01-01' AND create_dt < DATE '2017-04-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2017q1_ix001 on team_game_stats_2017q1(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2017q1_ix002 on team_game_stats_2017q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2017q2 ( 
    CONSTRAINT team_game_stats_2017q2_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2017-04-01' AND create_dt < DATE '2017-07-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2017q2_ix001 on team_game_stats_2017q2(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2017q2_ix002 on team_game_stats_2017q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2017q3 ( 
    CONSTRAINT team_game_stats_2017q3_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2017-07-01' AND create_dt < DATE '2017-10-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2017q3_ix001 on team_game_stats_2017q3(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2017q3_ix002 on team_game_stats_2017q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2017q4 ( 
    CONSTRAINT team_game_stats_2017q4_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2017-10-01' AND create_dt < DATE '2018-01-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2017q4_ix001 on team_game_stats_2017q4(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2017q4_ix002 on team_game_stats_2017q4(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2018q1 ( 
    CONSTRAINT team_game_stats_2018q1_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2018-01-01' AND create_dt < DATE '2018-04-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2018q1_ix001 on team_game_stats_2018q1(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2018q1_ix002 on team_game_stats_2018q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2018q2 ( 
    CONSTRAINT team_game_stats_2018q2_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2018-04-01' AND create_dt < DATE '2018-07-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2018q2_ix001 on team_game_stats_2018q2(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2018q2_ix002 on team_game_stats_2018q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2018q3 ( 
    CONSTRAINT team_game_stats_2018q3_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2018-07-01' AND create_dt < DATE '2018-10-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2018q3_ix001 on team_game_stats_2018q3(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2018q3_ix002 on team_game_stats_2018q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2018q4 ( 
    CONSTRAINT team_game_stats_2018q4_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2018-10-01' AND create_dt < DATE '2019-01-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2018q4_ix001 on team_game_stats_2018q4(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2018q4_ix002 on team_game_stats_2018q4(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2019q1 ( 
    CONSTRAINT team_game_stats_2019q1_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2019-01-01' AND create_dt < DATE '2019-04-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2019q1_ix001 on team_game_stats_2019q1(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2019q1_ix002 on team_game_stats_2019q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2019q2 ( 
    CONSTRAINT team_game_stats_2019q2_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2019-04-01' AND create_dt < DATE '2019-07-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2019q2_ix001 on team_game_stats_2019q2(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2019q2_ix002 on team_game_stats_2019q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2019q3 ( 
    CONSTRAINT team_game_stats_2019q3_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2019-07-01' AND create_dt < DATE '2019-10-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2019q3_ix001 on team_game_stats_2019q3(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2019q3_ix002 on team_game_stats_2019q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2019q4 ( 
    CONSTRAINT team_game_stats_2019q4_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2019-10-01' AND create_dt < DATE '2020-01-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2019q4_ix001 on team_game_stats_2019q4(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2019q4_ix002 on team_game_stats_2019q4(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2020q1 ( 
    CONSTRAINT team_game_stats_2020q1_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2020-01-01' AND create_dt < DATE '2020-04-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2020q1_ix001 on team_game_stats_2020q1(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2020q1_ix002 on team_game_stats_2020q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2020q2 ( 
    CONSTRAINT team_game_stats_2020q2_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2020-04-01' AND create_dt < DATE '2020-07-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2020q2_ix001 on team_game_stats_2020q2(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2020q2_ix002 on team_game_stats_2020q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2020q3 ( 
    CONSTRAINT team_game_stats_2020q3_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2020-07-01' AND create_dt < DATE '2020-10-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2020q3_ix001 on team_game_stats_2020q3(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2020q3_ix002 on team_game_stats_2020q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2020q4 ( 
    CONSTRAINT team_game_stats_2020q4_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2020-10-01' AND create_dt < DATE '2021-01-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2020q4_ix001 on team_game_stats_2020q4(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2020q4_ix002 on team_game_stats_2020q4(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2021q1 ( 
    CONSTRAINT team_game_stats_2021q1_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2021-01-01' AND create_dt < DATE '2021-04-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2021q1_ix001 on team_game_stats_2021q1(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2021q1_ix002 on team_game_stats_2021q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2021q2 ( 
    CONSTRAINT team_game_stats_2021q2_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2021-04-01' AND create_dt < DATE '2021-07-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2021q2_ix001 on team_game_stats_2021q2(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2021q2_ix002 on team_game_stats_2021q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2021q3 ( 
    CONSTRAINT team_game_stats_2021q3_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2021-07-01' AND create_dt < DATE '2021-10-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2021q3_ix001 on team_game_stats_2021q3(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2021q3_ix002 on team_game_stats_2021q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2021q4 ( 
    CONSTRAINT team_game_stats_2021q4_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2021-10-01' AND create_dt < DATE '2022-01-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2021q4_ix001 on team_game_stats_2021q4(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2021q4_ix002 on team_game_stats_2021q4(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2022q1 ( 
    CONSTRAINT team_game_stats_2022q1_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2022-01-01' AND create_dt < DATE '2022-04-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2022q1_ix001 on team_game_stats_2022q1(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2022q1_ix002 on team_game_stats_2022q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2022q2 ( 
    CONSTRAINT team_game_stats_2022q2_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2022-04-01' AND create_dt < DATE '2022-07-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2022q2_ix001 on team_game_stats_2022q2(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2022q2_ix002 on team_game_stats_2022q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2022q3 ( 
    CONSTRAINT team_game_stats_2022q3_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2022-07-01' AND create_dt < DATE '2022-10-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2022q3_ix001 on team_game_stats_2022q3(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2022q3_ix002 on team_game_stats_2022q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2022q4 ( 
    CONSTRAINT team_game_stats_2022q4_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2022-10-01' AND create_dt < DATE '2023-01-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2022q4_ix001 on team_game_stats_2022q4(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2022q4_ix002 on team_game_stats_2022q4(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2023q1 ( 
    CONSTRAINT team_game_stats_2023q1_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2023-01-01' AND create_dt < DATE '2023-04-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2023q1_ix001 on team_game_stats_2023q1(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2023q1_ix002 on team_game_stats_2023q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2023q2 ( 
    CONSTRAINT team_game_stats_2023q2_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2023-04-01' AND create_dt < DATE '2023-07-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2023q2_ix001 on team_game_stats_2023q2(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2023q2_ix002 on team_game_stats_2023q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2023q3 ( 
    CONSTRAINT team_game_stats_2023q3_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2023-07-01' AND create_dt < DATE '2023-10-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2023q3_ix001 on team_game_stats_2023q3(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2023q3_ix002 on team_game_stats_2023q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2023q4 ( 
    CONSTRAINT team_game_stats_2023q4_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2023-10-01' AND create_dt < DATE '2024-01-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2023q4_ix001 on team_game_stats_2023q4(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2023q4_ix002 on team_game_stats_2023q4(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2024q1 ( 
    CONSTRAINT team_game_stats_2024q1_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2024-01-01' AND create_dt < DATE '2024-04-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2024q1_ix001 on team_game_stats_2024q1(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2024q1_ix002 on team_game_stats_2024q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2024q2 ( 
    CONSTRAINT team_game_stats_2024q2_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2024-04-01' AND create_dt < DATE '2024-07-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2024q2_ix001 on team_game_stats_2024q2(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2024q2_ix002 on team_game_stats_2024q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2024q3 ( 
    CONSTRAINT team_game_stats_2024q3_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2024-07-01' AND create_dt < DATE '2024-10-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2024q3_ix001 on team_game_stats_2024q3(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2024q3_ix002 on team_game_stats_2024q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2024q4 ( 
    CONSTRAINT team_game_stats_2024q4_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2024-10-01' AND create_dt < DATE '2025-01-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2024q4_ix001 on team_game_stats_2024q4(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2024q4_ix002 on team_game_stats_2024q4(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2025q1 ( 
    CONSTRAINT team_game_stats_2025q1_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2025-01-01' AND create_dt < DATE '2025-04-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2025q1_ix001 on team_game_stats_2025q1(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2025q1_ix002 on team_game_stats_2025q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2025q2 ( 
    CONSTRAINT team_game_stats_2025q2_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2025-04-01' AND create_dt < DATE '2025-07-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2025q2_ix001 on team_game_stats_2025q2(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2025q2_ix002 on team_game_stats_2025q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2025q3 ( 
    CONSTRAINT team_game_stats_2025q3_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2025-07-01' AND create_dt < DATE '2025-10-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2025q3_ix001 on team_game_stats_2025q3(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2025q3_ix002 on team_game_stats_2025q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.team_game_stats_2025q4 ( 
    CONSTRAINT team_game_stats_2025q4_pk PRIMARY KEY (team_game_stat_id),
	CHECK ( create_dt >= DATE '2025-10-01' AND create_dt < DATE '2026-01-01' ) 
) INHERITS (team_game_stats);

CREATE INDEX IF NOT EXISTS team_game_stats_2025q4_ix001 on team_game_stats_2025q4(create_dt);
CREATE INDEX IF NOT EXISTS team_game_stats_2025q4_ix002 on team_game_stats_2025q4(game_id);

-- player_game_anticheats
CREATE TABLE IF NOT EXISTS xonstat.player_game_anticheats
(
  player_game_anticheat_id bigserial NOT NULL,
  player_id integer NOT NULL,
  game_id bigint NOT NULL,
  key character varying(128),
  value numeric,
  create_dt timestamp without time zone NOT NULL DEFAULT (current_timestamp at time zone 'UTC'),
  CONSTRAINT player_game_anticheats_pk PRIMARY KEY (player_game_anticheat_id),
  CONSTRAINT player_game_anticheats_fk01 FOREIGN KEY (player_id)
      REFERENCES players (player_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE INDEX IF NOT EXISTS player_game_anticheats_ix01 on player_game_anticheats(game_id);
CREATE INDEX IF NOT EXISTS player_game_anticheats_ix02 on player_game_anticheats(player_id);
ALTER TABLE xonstat.player_game_anticheats OWNER TO xonstat;

-- summary_stats_mv
CREATE TABLE IF NOT EXISTS xonstat.summary_stats
(
  summary_stats_id bigserial NOT NULL,
  total_players bigint NOT NULL,
  total_servers bigint NOT NULL,
  total_games bigint NOT NULL,
  total_dm_games bigint NOT NULL,
  total_duel_games bigint NOT NULL,
  total_ctf_games bigint NOT NULL,
  create_dt timestamp without time zone NOT NULL DEFAULT (current_timestamp at time zone 'UTC'),
  CONSTRAINT summary_stats_pk PRIMARY KEY (summary_stats_id)
);

ALTER TABLE xonstat.summary_stats OWNER TO xonstat;

-- active_players_mv
CREATE TABLE IF NOT EXISTS active_players_mv(
	sort_order integer,
	player_id bigint,
	nick character varying(128),
	alivetime interval,
	create_dt timestamp without time zone default (now() at time zone 'UTC'),
    CONSTRAINT active_players_mv_pk PRIMARY KEY (sort_order)
);

ALTER TABLE xonstat.active_players_mv OWNER TO xonstat;

-- active_servers_mv
CREATE TABLE IF NOT EXISTS active_servers_mv(
	sort_order integer,
	server_id bigint,
	server_name character varying(128),
	play_time interval,
	create_dt timestamp without time zone default (now() at time zone 'UTC'),
    CONSTRAINT active_servers_mv_pk PRIMARY KEY (sort_order)
);

ALTER TABLE xonstat.active_servers_mv OWNER TO xonstat;

-- active_maps_mv
CREATE TABLE IF NOT EXISTS active_maps_mv(
	sort_order integer,
	map_id bigint,
	map_name character varying(128),
	games integer,
	create_dt timestamp without time zone default (now() at time zone 'UTC'),
    CONSTRAINT active_maps_mv_pk PRIMARY KEY (sort_order)
);

ALTER TABLE xonstat.active_maps_mv OWNER TO xonstat;

-- merged_servers
CREATE TABLE IF NOT EXISTS xonstat.merged_servers
(
  winning_server_id integer NOT NULL,
  losing_server_id integer NOT NULL,
  unmerged_ind boolean NOT NULL DEFAULT false,
  create_dt timestamp without time zone NOT NULL DEFAULT (current_timestamp at time zone 'UTC'),
  CONSTRAINT merged_servers_pk PRIMARY KEY (winning_server_id, losing_server_id)
);

ALTER TABLE xonstat.merged_servers OWNER TO xonstat;

-- player_agg_stats_mv
CREATE TABLE IF NOT EXISTS xonstat.player_agg_stats_mv
(
  player_id integer NOT NULL,
  game_type_cd character varying(10),
  nick character varying(128),
  stripped_nick character varying(128),
  last_seen timestamp without time zone,
  games integer,
  wins integer,
  losses integer,
  kills integer,
  deaths integer,
  suicides integer,
  captures integer,
  pickups integer,
  drops integer,
  carrier_frags integer,
  alivetime bigint,
  create_dt timestamp without time zone NOT NULL DEFAULT (current_timestamp at time zone 'UTC'),
  CONSTRAINT player_agg_stats_mv_pk PRIMARY KEY (player_id, game_type_cd)
);

ALTER TABLE xonstat.player_agg_stats_mv OWNER TO xonstat;

-- player_game_frage_matrix
CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix
(
  game_id bigint NOT NULL,
  player_game_stat_id bigint NOT NULL,
  player_id integer NOT NULL,
  player_index smallint NOT NULL,
  matrix json NOT NULL,
  create_dt timestamp without time zone NOT NULL DEFAULT (current_timestamp at time zone 'UTC'),
  CONSTRAINT player_game_frag_matrix_pk PRIMARY KEY (game_id, player_game_stat_id),
  CONSTRAINT player_game_frag_matrix_fk001 FOREIGN KEY (game_id)
      REFERENCES xonstat.games (game_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT player_game_frag_matrix_fk002 FOREIGN KEY (player_game_stat_id)
      REFERENCES xonstat.player_game_stats (player_game_stat_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT player_game_frag_matrix_fk003 FOREIGN KEY (player_id)
      REFERENCES xonstat.players (player_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_ix01 on player_game_frag_matrix(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_ix02 on player_game_frag_matrix(game_id);

ALTER TABLE xonstat.player_game_frag_matrix OWNER TO xonstat;

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2017q3 ( 
    CONSTRAINT player_game_frag_matrix_2017q3_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2017-07-01' AND create_dt < DATE '2017-10-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2017q3_ix001 on player_game_frag_matrix_2017q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2017q3_ix002 on player_game_frag_matrix_2017q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2017q4 ( 
    CONSTRAINT player_game_frag_matrix_2017q4_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2017-10-01' AND create_dt < DATE '2018-01-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2017q4_ix001 on player_game_frag_matrix_2017q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2017q4_ix002 on player_game_frag_matrix_2017q4(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2018q1 ( 
    CONSTRAINT player_game_frag_matrix_2018q1_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2018-01-01' AND create_dt < DATE '2018-04-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2018q1_ix001 on player_game_frag_matrix_2018q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2018q1_ix002 on player_game_frag_matrix_2018q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2018q2 ( 
    CONSTRAINT player_game_frag_matrix_2018q2_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2018-04-01' AND create_dt < DATE '2018-07-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2018q2_ix001 on player_game_frag_matrix_2018q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2018q2_ix002 on player_game_frag_matrix_2018q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2018q3 ( 
    CONSTRAINT player_game_frag_matrix_2018q3_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2018-07-01' AND create_dt < DATE '2018-10-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2018q3_ix001 on player_game_frag_matrix_2018q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2018q3_ix002 on player_game_frag_matrix_2018q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2018q4 ( 
    CONSTRAINT player_game_frag_matrix_2018q4_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2018-10-01' AND create_dt < DATE '2019-01-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2018q4_ix001 on player_game_frag_matrix_2018q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2018q4_ix002 on player_game_frag_matrix_2018q4(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2019q1 ( 
    CONSTRAINT player_game_frag_matrix_2019q1_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2019-01-01' AND create_dt < DATE '2019-04-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2019q1_ix001 on player_game_frag_matrix_2019q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2019q1_ix002 on player_game_frag_matrix_2019q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2019q2 ( 
    CONSTRAINT player_game_frag_matrix_2019q2_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2019-04-01' AND create_dt < DATE '2019-07-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2019q2_ix001 on player_game_frag_matrix_2019q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2019q2_ix002 on player_game_frag_matrix_2019q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2019q3 ( 
    CONSTRAINT player_game_frag_matrix_2019q3_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2019-07-01' AND create_dt < DATE '2019-10-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2019q3_ix001 on player_game_frag_matrix_2019q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2019q3_ix002 on player_game_frag_matrix_2019q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2019q4 ( 
    CONSTRAINT player_game_frag_matrix_2019q4_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2019-10-01' AND create_dt < DATE '2020-01-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2019q4_ix001 on player_game_frag_matrix_2019q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2019q4_ix002 on player_game_frag_matrix_2019q4(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2020q1 ( 
    CONSTRAINT player_game_frag_matrix_2020q1_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2020-01-01' AND create_dt < DATE '2020-04-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2020q1_ix001 on player_game_frag_matrix_2020q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2020q1_ix002 on player_game_frag_matrix_2020q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2020q2 ( 
    CONSTRAINT player_game_frag_matrix_2020q2_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2020-04-01' AND create_dt < DATE '2020-07-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2020q2_ix001 on player_game_frag_matrix_2020q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2020q2_ix002 on player_game_frag_matrix_2020q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2020q3 ( 
    CONSTRAINT player_game_frag_matrix_2020q3_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2020-07-01' AND create_dt < DATE '2020-10-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2020q3_ix001 on player_game_frag_matrix_2020q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2020q3_ix002 on player_game_frag_matrix_2020q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2020q4 ( 
    CONSTRAINT player_game_frag_matrix_2020q4_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2020-10-01' AND create_dt < DATE '2021-01-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2020q4_ix001 on player_game_frag_matrix_2020q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2020q4_ix002 on player_game_frag_matrix_2020q4(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2021q1 ( 
    CONSTRAINT player_game_frag_matrix_2021q1_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2021-01-01' AND create_dt < DATE '2021-04-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2021q1_ix001 on player_game_frag_matrix_2021q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2021q1_ix002 on player_game_frag_matrix_2021q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2021q2 ( 
    CONSTRAINT player_game_frag_matrix_2021q2_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2021-04-01' AND create_dt < DATE '2021-07-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2021q2_ix001 on player_game_frag_matrix_2021q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2021q2_ix002 on player_game_frag_matrix_2021q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2021q3 ( 
    CONSTRAINT player_game_frag_matrix_2021q3_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2021-07-01' AND create_dt < DATE '2021-10-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2021q3_ix001 on player_game_frag_matrix_2021q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2021q3_ix002 on player_game_frag_matrix_2021q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2021q4 ( 
    CONSTRAINT player_game_frag_matrix_2021q4_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2021-10-01' AND create_dt < DATE '2022-01-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2021q4_ix001 on player_game_frag_matrix_2021q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2021q4_ix002 on player_game_frag_matrix_2021q4(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2022q1 ( 
    CONSTRAINT player_game_frag_matrix_2022q1_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2022-01-01' AND create_dt < DATE '2022-04-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2022q1_ix001 on player_game_frag_matrix_2022q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2022q1_ix002 on player_game_frag_matrix_2022q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2022q2 ( 
    CONSTRAINT player_game_frag_matrix_2022q2_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2022-04-01' AND create_dt < DATE '2022-07-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2022q2_ix001 on player_game_frag_matrix_2022q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2022q2_ix002 on player_game_frag_matrix_2022q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2022q3 ( 
    CONSTRAINT player_game_frag_matrix_2022q3_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2022-07-01' AND create_dt < DATE '2022-10-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2022q3_ix001 on player_game_frag_matrix_2022q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2022q3_ix002 on player_game_frag_matrix_2022q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2022q4 ( 
    CONSTRAINT player_game_frag_matrix_2022q4_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2022-10-01' AND create_dt < DATE '2023-01-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2022q4_ix001 on player_game_frag_matrix_2022q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2022q4_ix002 on player_game_frag_matrix_2022q4(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2023q1 ( 
    CONSTRAINT player_game_frag_matrix_2023q1_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2023-01-01' AND create_dt < DATE '2023-04-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2023q1_ix001 on player_game_frag_matrix_2023q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2023q1_ix002 on player_game_frag_matrix_2023q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2023q2 ( 
    CONSTRAINT player_game_frag_matrix_2023q2_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2023-04-01' AND create_dt < DATE '2023-07-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2023q2_ix001 on player_game_frag_matrix_2023q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2023q2_ix002 on player_game_frag_matrix_2023q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2023q3 ( 
    CONSTRAINT player_game_frag_matrix_2023q3_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2023-07-01' AND create_dt < DATE '2023-10-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2023q3_ix001 on player_game_frag_matrix_2023q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2023q3_ix002 on player_game_frag_matrix_2023q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2023q4 ( 
    CONSTRAINT player_game_frag_matrix_2023q4_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2023-10-01' AND create_dt < DATE '2024-01-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2023q4_ix001 on player_game_frag_matrix_2023q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2023q4_ix002 on player_game_frag_matrix_2023q4(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2024q1 ( 
    CONSTRAINT player_game_frag_matrix_2024q1_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2024-01-01' AND create_dt < DATE '2024-04-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2024q1_ix001 on player_game_frag_matrix_2024q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2024q1_ix002 on player_game_frag_matrix_2024q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2024q2 ( 
    CONSTRAINT player_game_frag_matrix_2024q2_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2024-04-01' AND create_dt < DATE '2024-07-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2024q2_ix001 on player_game_frag_matrix_2024q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2024q2_ix002 on player_game_frag_matrix_2024q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2024q3 ( 
    CONSTRAINT player_game_frag_matrix_2024q3_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2024-07-01' AND create_dt < DATE '2024-10-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2024q3_ix001 on player_game_frag_matrix_2024q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2024q3_ix002 on player_game_frag_matrix_2024q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2024q4 ( 
    CONSTRAINT player_game_frag_matrix_2024q4_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2024-10-01' AND create_dt < DATE '2025-01-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2024q4_ix001 on player_game_frag_matrix_2024q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2024q4_ix002 on player_game_frag_matrix_2024q4(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2025q1 ( 
    CONSTRAINT player_game_frag_matrix_2025q1_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2025-01-01' AND create_dt < DATE '2025-04-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2025q1_ix001 on player_game_frag_matrix_2025q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2025q1_ix002 on player_game_frag_matrix_2025q1(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2025q2 ( 
    CONSTRAINT player_game_frag_matrix_2025q2_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2025-04-01' AND create_dt < DATE '2025-07-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2025q2_ix001 on player_game_frag_matrix_2025q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2025q2_ix002 on player_game_frag_matrix_2025q2(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2025q3 ( 
    CONSTRAINT player_game_frag_matrix_2025q3_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2025-07-01' AND create_dt < DATE '2025-10-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2025q3_ix001 on player_game_frag_matrix_2025q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2025q3_ix002 on player_game_frag_matrix_2025q3(game_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_frag_matrix_2025q4 ( 
    CONSTRAINT player_game_frag_matrix_2025q4_pk PRIMARY KEY (game_id, player_game_stat_id),
	CHECK ( create_dt >= DATE '2025-10-01' AND create_dt < DATE '2026-01-01' ) 
) INHERITS (player_game_frag_matrix);

CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2025q4_ix001 on player_game_frag_matrix_2025q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_frag_matrix_2025q4_ix002 on player_game_frag_matrix_2025q4(game_id);

-- player_game_nonparticipants
CREATE TABLE IF NOT EXISTS xonstat.player_game_nonparticipants
(
  player_game_nonparticipants_id bigserial NOT NULL,
  player_id integer NOT NULL,
  game_id bigint NOT NULL,
  status character varying(30) NOT NULL,
  nick character varying(128),
  stripped_nick character varying(128),
  alivetime interval,
  score integer,
  create_dt timestamp without time zone NOT NULL DEFAULT (current_timestamp at time zone 'UTC'),
  CONSTRAINT player_game_nonparticipants_pk PRIMARY KEY (player_game_nonparticipants_id),
  CONSTRAINT player_game_nonparticipants_fk001 FOREIGN KEY (player_id)
      REFERENCES xonstat.players (player_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT player_game_nonparticipants_fk002 FOREIGN KEY (game_id)
      REFERENCES xonstat.games (game_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE INDEX IF NOT EXISTS player_game_nonparticipant_ix01 on player_game_nonparticipants(create_dt);
CREATE INDEX IF NOT EXISTS player_game_nonparticipant_ix02 on player_game_nonparticipants(game_id);
CREATE INDEX IF NOT EXISTS player_game_nonparticipant_ix03 on player_game_nonparticipants(player_id);
ALTER TABLE xonstat.player_game_nonparticipants OWNER TO xonstat;

CREATE TABLE IF NOT EXISTS xonstat.player_game_nonparticipants_2020q4 ( 
    CONSTRAINT player_game_nonparticipants_2020q4_pk PRIMARY KEY (player_game_nonparticipants_id),
	CHECK ( create_dt >= DATE '2020-10-01' AND create_dt < DATE '2021-01-01' ) 
) INHERITS (player_game_nonparticipants);

CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2020q4_ix001 on player_game_nonparticipants_2020q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2020q4_ix002 on player_game_nonparticipants_2020q4(game_id);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2020q4_ix003 on player_game_nonparticipants_2020q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_nonparticipants_2021q1 ( 
    CONSTRAINT player_game_nonparticipants_2021q1_pk PRIMARY KEY (player_game_nonparticipants_id),
	CHECK ( create_dt >= DATE '2021-01-01' AND create_dt < DATE '2021-04-01' ) 
) INHERITS (player_game_nonparticipants);

CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2021q1_ix001 on player_game_nonparticipants_2021q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2021q1_ix002 on player_game_nonparticipants_2021q1(game_id);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2021q1_ix003 on player_game_nonparticipants_2021q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_nonparticipants_2021q2 ( 
    CONSTRAINT player_game_nonparticipants_2021q2_pk PRIMARY KEY (player_game_nonparticipants_id),
	CHECK ( create_dt >= DATE '2021-04-01' AND create_dt < DATE '2021-07-01' ) 
) INHERITS (player_game_nonparticipants);

CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2021q2_ix001 on player_game_nonparticipants_2021q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2021q2_ix002 on player_game_nonparticipants_2021q2(game_id);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2021q2_ix003 on player_game_nonparticipants_2021q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_nonparticipants_2021q3 ( 
    CONSTRAINT player_game_nonparticipants_2021q3_pk PRIMARY KEY (player_game_nonparticipants_id),
	CHECK ( create_dt >= DATE '2021-07-01' AND create_dt < DATE '2021-10-01' ) 
) INHERITS (player_game_nonparticipants);

CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2021q3_ix001 on player_game_nonparticipants_2021q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2021q3_ix002 on player_game_nonparticipants_2021q3(game_id);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2021q3_ix003 on player_game_nonparticipants_2021q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_nonparticipants_2021q4 ( 
    CONSTRAINT player_game_nonparticipants_2021q4_pk PRIMARY KEY (player_game_nonparticipants_id),
	CHECK ( create_dt >= DATE '2021-10-01' AND create_dt < DATE '2022-01-01' ) 
) INHERITS (player_game_nonparticipants);

CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2021q4_ix001 on player_game_nonparticipants_2021q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2021q4_ix002 on player_game_nonparticipants_2021q4(game_id);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2021q4_ix003 on player_game_nonparticipants_2021q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_nonparticipants_2022q1 ( 
    CONSTRAINT player_game_nonparticipants_2022q1_pk PRIMARY KEY (player_game_nonparticipants_id),
	CHECK ( create_dt >= DATE '2022-01-01' AND create_dt < DATE '2022-04-01' ) 
) INHERITS (player_game_nonparticipants);

CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2022q1_ix001 on player_game_nonparticipants_2022q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2022q1_ix002 on player_game_nonparticipants_2022q1(game_id);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2022q1_ix003 on player_game_nonparticipants_2022q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_nonparticipants_2022q2 ( 
    CONSTRAINT player_game_nonparticipants_2022q2_pk PRIMARY KEY (player_game_nonparticipants_id),
	CHECK ( create_dt >= DATE '2022-04-01' AND create_dt < DATE '2022-07-01' ) 
) INHERITS (player_game_nonparticipants);

CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2022q2_ix001 on player_game_nonparticipants_2022q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2022q2_ix002 on player_game_nonparticipants_2022q2(game_id);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2022q2_ix003 on player_game_nonparticipants_2022q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_nonparticipants_2022q3 ( 
    CONSTRAINT player_game_nonparticipants_2022q3_pk PRIMARY KEY (player_game_nonparticipants_id),
	CHECK ( create_dt >= DATE '2022-07-01' AND create_dt < DATE '2022-10-01' ) 
) INHERITS (player_game_nonparticipants);

CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2022q3_ix001 on player_game_nonparticipants_2022q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2022q3_ix002 on player_game_nonparticipants_2022q3(game_id);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2022q3_ix003 on player_game_nonparticipants_2022q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_nonparticipants_2022q4 ( 
    CONSTRAINT player_game_nonparticipants_2022q4_pk PRIMARY KEY (player_game_nonparticipants_id),
	CHECK ( create_dt >= DATE '2022-10-01' AND create_dt < DATE '2023-01-01' ) 
) INHERITS (player_game_nonparticipants);

CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2022q4_ix001 on player_game_nonparticipants_2022q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2022q4_ix002 on player_game_nonparticipants_2022q4(game_id);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2022q4_ix003 on player_game_nonparticipants_2022q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_nonparticipants_2023q1 ( 
    CONSTRAINT player_game_nonparticipants_2023q1_pk PRIMARY KEY (player_game_nonparticipants_id),
	CHECK ( create_dt >= DATE '2023-01-01' AND create_dt < DATE '2023-04-01' ) 
) INHERITS (player_game_nonparticipants);

CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2023q1_ix001 on player_game_nonparticipants_2023q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2023q1_ix002 on player_game_nonparticipants_2023q1(game_id);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2023q1_ix003 on player_game_nonparticipants_2023q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_nonparticipants_2023q2 ( 
    CONSTRAINT player_game_nonparticipants_2023q2_pk PRIMARY KEY (player_game_nonparticipants_id),
	CHECK ( create_dt >= DATE '2023-04-01' AND create_dt < DATE '2023-07-01' ) 
) INHERITS (player_game_nonparticipants);

CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2023q2_ix001 on player_game_nonparticipants_2023q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2023q2_ix002 on player_game_nonparticipants_2023q2(game_id);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2023q2_ix003 on player_game_nonparticipants_2023q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_nonparticipants_2023q3 ( 
    CONSTRAINT player_game_nonparticipants_2023q3_pk PRIMARY KEY (player_game_nonparticipants_id),
	CHECK ( create_dt >= DATE '2023-07-01' AND create_dt < DATE '2023-10-01' ) 
) INHERITS (player_game_nonparticipants);

CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2023q3_ix001 on player_game_nonparticipants_2023q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2023q3_ix002 on player_game_nonparticipants_2023q3(game_id);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2023q3_ix003 on player_game_nonparticipants_2023q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_nonparticipants_2023q4 ( 
    CONSTRAINT player_game_nonparticipants_2023q4_pk PRIMARY KEY (player_game_nonparticipants_id),
	CHECK ( create_dt >= DATE '2023-10-01' AND create_dt < DATE '2024-01-01' ) 
) INHERITS (player_game_nonparticipants);

CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2023q4_ix001 on player_game_nonparticipants_2023q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2023q4_ix002 on player_game_nonparticipants_2023q4(game_id);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2023q4_ix003 on player_game_nonparticipants_2023q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_nonparticipants_2024q1 ( 
    CONSTRAINT player_game_nonparticipants_2024q1_pk PRIMARY KEY (player_game_nonparticipants_id),
	CHECK ( create_dt >= DATE '2024-01-01' AND create_dt < DATE '2024-04-01' ) 
) INHERITS (player_game_nonparticipants);

CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2024q1_ix001 on player_game_nonparticipants_2024q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2024q1_ix002 on player_game_nonparticipants_2024q1(game_id);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2024q1_ix003 on player_game_nonparticipants_2024q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_nonparticipants_2024q2 ( 
    CONSTRAINT player_game_nonparticipants_2024q2_pk PRIMARY KEY (player_game_nonparticipants_id),
	CHECK ( create_dt >= DATE '2024-04-01' AND create_dt < DATE '2024-07-01' ) 
) INHERITS (player_game_nonparticipants);

CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2024q2_ix001 on player_game_nonparticipants_2024q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2024q2_ix002 on player_game_nonparticipants_2024q2(game_id);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2024q2_ix003 on player_game_nonparticipants_2024q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_nonparticipants_2024q3 ( 
    CONSTRAINT player_game_nonparticipants_2024q3_pk PRIMARY KEY (player_game_nonparticipants_id),
	CHECK ( create_dt >= DATE '2024-07-01' AND create_dt < DATE '2024-10-01' ) 
) INHERITS (player_game_nonparticipants);

CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2024q3_ix001 on player_game_nonparticipants_2024q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2024q3_ix002 on player_game_nonparticipants_2024q3(game_id);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2024q3_ix003 on player_game_nonparticipants_2024q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_nonparticipants_2024q4 ( 
    CONSTRAINT player_game_nonparticipants_2024q4_pk PRIMARY KEY (player_game_nonparticipants_id),
	CHECK ( create_dt >= DATE '2024-10-01' AND create_dt < DATE '2025-01-01' ) 
) INHERITS (player_game_nonparticipants);

CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2024q4_ix001 on player_game_nonparticipants_2024q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2024q4_ix002 on player_game_nonparticipants_2024q4(game_id);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2024q4_ix003 on player_game_nonparticipants_2024q4(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_nonparticipants_2025q1 ( 
    CONSTRAINT player_game_nonparticipants_2025q1_pk PRIMARY KEY (player_game_nonparticipants_id),
	CHECK ( create_dt >= DATE '2025-01-01' AND create_dt < DATE '2025-04-01' ) 
) INHERITS (player_game_nonparticipants);

CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2025q1_ix001 on player_game_nonparticipants_2025q1(create_dt);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2025q1_ix002 on player_game_nonparticipants_2025q1(game_id);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2025q1_ix003 on player_game_nonparticipants_2025q1(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_nonparticipants_2025q2 ( 
    CONSTRAINT player_game_nonparticipants_2025q2_pk PRIMARY KEY (player_game_nonparticipants_id),
	CHECK ( create_dt >= DATE '2025-04-01' AND create_dt < DATE '2025-07-01' ) 
) INHERITS (player_game_nonparticipants);

CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2025q2_ix001 on player_game_nonparticipants_2025q2(create_dt);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2025q2_ix002 on player_game_nonparticipants_2025q2(game_id);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2025q2_ix003 on player_game_nonparticipants_2025q2(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_nonparticipants_2025q3 ( 
    CONSTRAINT player_game_nonparticipants_2025q3_pk PRIMARY KEY (player_game_nonparticipants_id),
	CHECK ( create_dt >= DATE '2025-07-01' AND create_dt < DATE '2025-10-01' ) 
) INHERITS (player_game_nonparticipants);

CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2025q3_ix001 on player_game_nonparticipants_2025q3(create_dt);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2025q3_ix002 on player_game_nonparticipants_2025q3(game_id);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2025q3_ix003 on player_game_nonparticipants_2025q3(player_id);

CREATE TABLE IF NOT EXISTS xonstat.player_game_nonparticipants_2025q4 ( 
    CONSTRAINT player_game_nonparticipants_2025q4_pk PRIMARY KEY (player_game_nonparticipants_id),
	CHECK ( create_dt >= DATE '2025-10-01' AND create_dt < DATE '2026-01-01' ) 
) INHERITS (player_game_nonparticipants);

CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2025q4_ix001 on player_game_nonparticipants_2025q4(create_dt);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2025q4_ix002 on player_game_nonparticipants_2025q4(game_id);
CREATE INDEX IF NOT EXISTS player_game_nonparticipants_2025q4_ix003 on player_game_nonparticipants_2025q4(player_id);

-- player_skills
CREATE TABLE IF NOT EXISTS xonstat.player_skills
(
  player_id integer NOT NULL,
  game_type_cd character varying(10) NOT NULL,
  mu numeric NOT NULL,
  sigma numeric NOT NULL,
  active_ind boolean NOT NULL default true,
  create_dt timestamp without time zone NOT NULL DEFAULT (current_timestamp at time zone 'UTC'),
  update_dt timestamp without time zone NOT NULL DEFAULT (current_timestamp at time zone 'UTC'),
  CONSTRAINT player_skills_pk PRIMARY KEY (player_id, game_type_cd),
  CONSTRAINT player_skills_fk01 FOREIGN KEY (player_id)
      REFERENCES xonstat.players (player_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT player_skills_fk02 FOREIGN KEY (game_type_cd)
      REFERENCES xonstat.cd_game_type (game_type_cd) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

ALTER TABLE xonstat.player_skills OWNER TO xonstat;


-- +goose StatementBegin
DO $$
BEGIN
    -- Supported game types
    INSERT INTO cd_game_type (game_type_cd, descr) VALUES ('arena', 'Arena');
    INSERT INTO cd_game_type (game_type_cd, descr) VALUES ('as', 'Assault');
    INSERT INTO cd_game_type (game_type_cd, descr) VALUES ('ctf', 'Capture The Flag');
    INSERT INTO cd_game_type (game_type_cd, descr) VALUES ('ca', 'Clan Arena');
    INSERT INTO cd_game_type (game_type_cd, descr) VALUES ('dm', 'Deathmatch');
    INSERT INTO cd_game_type (game_type_cd, descr) VALUES ('dom', 'Domination');
    INSERT INTO cd_game_type (game_type_cd, descr) VALUES ('ft', 'Freezetag');
    INSERT INTO cd_game_type (game_type_cd, descr) VALUES ('ka', 'Keepaway');
    INSERT INTO cd_game_type (game_type_cd, descr) VALUES ('tka', 'Team Keepaway');
    INSERT INTO cd_game_type (game_type_cd, descr) VALUES ('kh', 'Keyhunt');
    INSERT INTO cd_game_type (game_type_cd, descr) VALUES ('lms', 'Last Man Standing');
    INSERT INTO cd_game_type (game_type_cd, descr) VALUES ('nb', 'Nexball');
    INSERT INTO cd_game_type (game_type_cd, descr) VALUES ('ons', 'Onslaught');
    INSERT INTO cd_game_type (game_type_cd, descr) VALUES ('rc', 'Race');
    INSERT INTO cd_game_type (game_type_cd, descr) VALUES ('cts', 'Complete This Stage');
    INSERT INTO cd_game_type (game_type_cd, descr) VALUES ('rune', 'Runematch');
    INSERT INTO cd_game_type (game_type_cd, descr) VALUES ('tdm', 'Team Deathmatch');
    INSERT INTO cd_game_type (game_type_cd, descr) VALUES ('duel', 'Duel');
    INSERT INTO cd_game_type (game_type_cd, descr) VALUES ('mayhem', 'Mayhem');
    INSERT INTO cd_game_type (game_type_cd, descr) VALUES ('tmayhem', 'Team Mayhem');

    -- Supported weapons
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('laser', 'Laser');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('shotgun', 'Shotgun');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('uzi', 'Machine Gun');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('grenadelauncher', 'Mortar');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('electro', 'Electro');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('crylink', 'Crylink');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('nex', 'Nex');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('hagar', 'Hagar');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('rocketlauncher', 'Rocket Launcher');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('minstanex', 'MinstaNex');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('rifle', 'Camping Rifle');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('fireball', 'Fireball');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('minelayer', 'Minelayer');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('seeker', 'T.A.G. Seeker');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('tuba', '@!#%''n Tuba');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('hlac', 'Heavy Laser Assault Cannon');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('hook', 'Grappling Hook');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('porto', 'Port-O-Launch');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('blaster', 'Blaster');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('devastator', 'Devastator');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('machinegun', 'Machine Gun');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('mortar', 'Mortar');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('vaporizer', 'Vaporizer');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('vortex', 'Vortex');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('arc', 'Arc');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('okhmg', 'Overkill Heavy Machine Gun');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('oknex', 'Overkill Nex');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('okshotgun', 'Overkill Shotgun');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('okmachinegun', 'Overkill Machine Gun');
    INSERT INTO cd_weapon (weapon_cd, descr) VALUES ('okrpc', 'Overkill Rocket-Propelled Chainsaw');

    -- Reserved player records for all bots and untracked players
    INSERT INTO players (nick) VALUES ('Bot');
    INSERT INTO players (nick) VALUES ('Untracked Player');

EXCEPTION 
WHEN OTHERS THEN
    RAISE NOTICE 'Inserts are already present in the DB.';
END
$$ LANGUAGE plpgsql;
-- +goose StatementEnd


-- Triggers 
-- +goose StatementBegin
CREATE OR REPLACE FUNCTION games_ins()
RETURNS TRIGGER AS $$
BEGIN
	IF (NEW.create_dt >= DATE '2020-01-01' AND NEW.create_dt < DATE '2020-04-01') THEN
		INSERT INTO games_2020Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-04-01' AND NEW.create_dt < DATE '2020-07-01') THEN
		INSERT INTO games_2020Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-07-01' AND NEW.create_dt < DATE '2020-10-01') THEN
		INSERT INTO games_2020Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-10-01' AND NEW.create_dt < DATE '2021-01-01') THEN
		INSERT INTO games_2020Q4 VALUES (NEW.*);
    ELSIF (NEW.create_dt >= DATE '2021-01-01' AND NEW.create_dt < DATE '2021-04-01') THEN
		INSERT INTO games_2021Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-04-01' AND NEW.create_dt < DATE '2021-07-01') THEN
		INSERT INTO games_2021Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-07-01' AND NEW.create_dt < DATE '2021-10-01') THEN
		INSERT INTO games_2021Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-10-01' AND NEW.create_dt < DATE '2022-01-01') THEN
		INSERT INTO games_2021Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-01-01' AND NEW.create_dt < DATE '2022-04-01') THEN
		INSERT INTO games_2022Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-04-01' AND NEW.create_dt < DATE '2022-07-01') THEN
		INSERT INTO games_2022Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-07-01' AND NEW.create_dt < DATE '2022-10-01') THEN
		INSERT INTO games_2022Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-10-01' AND NEW.create_dt < DATE '2023-01-01') THEN
		INSERT INTO games_2022Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-01-01' AND NEW.create_dt < DATE '2023-04-01') THEN
		INSERT INTO games_2023Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-04-01' AND NEW.create_dt < DATE '2023-07-01') THEN
		INSERT INTO games_2023Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-07-01' AND NEW.create_dt < DATE '2023-10-01') THEN
		INSERT INTO games_2023Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-10-01' AND NEW.create_dt < DATE '2024-01-01') THEN
		INSERT INTO games_2023Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-01-01' AND NEW.create_dt < DATE '2024-04-01') THEN
		INSERT INTO games_2024Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-04-01' AND NEW.create_dt < DATE '2024-07-01') THEN
		INSERT INTO games_2024Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-07-01' AND NEW.create_dt < DATE '2024-10-01') THEN
		INSERT INTO games_2024Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-10-01' AND NEW.create_dt < DATE '2025-01-01') THEN
		INSERT INTO games_2024Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-01-01' AND NEW.create_dt < DATE '2025-04-01') THEN
		INSERT INTO games_2025Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-04-01' AND NEW.create_dt < DATE '2025-07-01') THEN
		INSERT INTO games_2025Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-07-01' AND NEW.create_dt < DATE '2025-10-01') THEN
		INSERT INTO games_2025Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-10-01' AND NEW.create_dt < DATE '2026-01-01') THEN
		INSERT INTO games_2025Q4 VALUES (NEW.*);
	ELSE
		RAISE EXCEPTION 'Date out of range. Fix the games_ins() trigger!';
	END IF;
	RETURN NULL;
END
$$
LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS games_ins_trg ON xonstat.games;

CREATE TRIGGER games_ins_trg BEFORE INSERT on xonstat.games
FOR EACH ROW EXECUTE PROCEDURE games_ins();
-- +goose StatementEnd

-- +goose StatementBegin
CREATE OR REPLACE FUNCTION player_game_stats_ins()
RETURNS TRIGGER AS $$
BEGIN
	IF (NEW.create_dt >= DATE '2020-01-01' AND NEW.create_dt < DATE '2020-04-01') THEN
		INSERT INTO player_game_stats_2020Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-04-01' AND NEW.create_dt < DATE '2020-07-01') THEN
		INSERT INTO player_game_stats_2020Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-07-01' AND NEW.create_dt < DATE '2020-10-01') THEN
		INSERT INTO player_game_stats_2020Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-10-01' AND NEW.create_dt < DATE '2021-01-01') THEN
		INSERT INTO player_game_stats_2020Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-01-01' AND NEW.create_dt < DATE '2021-04-01') THEN
		INSERT INTO player_game_stats_2021Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-04-01' AND NEW.create_dt < DATE '2021-07-01') THEN
		INSERT INTO player_game_stats_2021Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-07-01' AND NEW.create_dt < DATE '2021-10-01') THEN
		INSERT INTO player_game_stats_2021Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-10-01' AND NEW.create_dt < DATE '2022-01-01') THEN
		INSERT INTO player_game_stats_2021Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-01-01' AND NEW.create_dt < DATE '2022-04-01') THEN
		INSERT INTO player_game_stats_2022Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-04-01' AND NEW.create_dt < DATE '2022-07-01') THEN
		INSERT INTO player_game_stats_2022Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-07-01' AND NEW.create_dt < DATE '2022-10-01') THEN
		INSERT INTO player_game_stats_2022Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-10-01' AND NEW.create_dt < DATE '2023-01-01') THEN
		INSERT INTO player_game_stats_2022Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-01-01' AND NEW.create_dt < DATE '2023-04-01') THEN
		INSERT INTO player_game_stats_2023Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-04-01' AND NEW.create_dt < DATE '2023-07-01') THEN
		INSERT INTO player_game_stats_2023Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-07-01' AND NEW.create_dt < DATE '2023-10-01') THEN
		INSERT INTO player_game_stats_2023Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-10-01' AND NEW.create_dt < DATE '2024-01-01') THEN
		INSERT INTO player_game_stats_2023Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-01-01' AND NEW.create_dt < DATE '2024-04-01') THEN
		INSERT INTO player_game_stats_2024Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-04-01' AND NEW.create_dt < DATE '2024-07-01') THEN
		INSERT INTO player_game_stats_2024Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-07-01' AND NEW.create_dt < DATE '2024-10-01') THEN
		INSERT INTO player_game_stats_2024Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-10-01' AND NEW.create_dt < DATE '2025-01-01') THEN
		INSERT INTO player_game_stats_2024Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-01-01' AND NEW.create_dt < DATE '2025-04-01') THEN
		INSERT INTO player_game_stats_2025Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-04-01' AND NEW.create_dt < DATE '2025-07-01') THEN
		INSERT INTO player_game_stats_2025Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-07-01' AND NEW.create_dt < DATE '2025-10-01') THEN
		INSERT INTO player_game_stats_2025Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-10-01' AND NEW.create_dt < DATE '2026-01-01') THEN
		INSERT INTO player_game_stats_2025Q4 VALUES (NEW.*);
	ELSE
		RAISE EXCEPTION 'Date out of range. Fix the player_game_stats_ins() trigger!';
	END IF;
	RETURN NULL;
END
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS player_game_stats_ins_trg ON xonstat.player_game_stats;

CREATE TRIGGER player_game_stats_ins_trg BEFORE INSERT on xonstat.player_game_stats
FOR EACH ROW EXECUTE PROCEDURE player_game_stats_ins();
-- +goose StatementEnd

-- +goose StatementBegin
CREATE OR REPLACE FUNCTION player_weapon_stats_ins()
RETURNS TRIGGER AS $$
BEGIN
	IF (NEW.create_dt >= DATE '2020-01-01' AND NEW.create_dt < DATE '2020-04-01') THEN
		INSERT INTO player_weapon_stats_2020Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-04-01' AND NEW.create_dt < DATE '2020-07-01') THEN
		INSERT INTO player_weapon_stats_2020Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-07-01' AND NEW.create_dt < DATE '2020-10-01') THEN
		INSERT INTO player_weapon_stats_2020Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-10-01' AND NEW.create_dt < DATE '2021-01-01') THEN
		INSERT INTO player_weapon_stats_2020Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-01-01' AND NEW.create_dt < DATE '2021-04-01') THEN
		INSERT INTO player_weapon_stats_2021Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-04-01' AND NEW.create_dt < DATE '2021-07-01') THEN
		INSERT INTO player_weapon_stats_2021Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-07-01' AND NEW.create_dt < DATE '2021-10-01') THEN
		INSERT INTO player_weapon_stats_2021Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-10-01' AND NEW.create_dt < DATE '2022-01-01') THEN
		INSERT INTO player_weapon_stats_2021Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-01-01' AND NEW.create_dt < DATE '2022-04-01') THEN
		INSERT INTO player_weapon_stats_2022Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-04-01' AND NEW.create_dt < DATE '2022-07-01') THEN
		INSERT INTO player_weapon_stats_2022Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-07-01' AND NEW.create_dt < DATE '2022-10-01') THEN
		INSERT INTO player_weapon_stats_2022Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-10-01' AND NEW.create_dt < DATE '2023-01-01') THEN
		INSERT INTO player_weapon_stats_2022Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-01-01' AND NEW.create_dt < DATE '2023-04-01') THEN
		INSERT INTO player_weapon_stats_2023Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-04-01' AND NEW.create_dt < DATE '2023-07-01') THEN
		INSERT INTO player_weapon_stats_2023Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-07-01' AND NEW.create_dt < DATE '2023-10-01') THEN
		INSERT INTO player_weapon_stats_2023Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-10-01' AND NEW.create_dt < DATE '2024-01-01') THEN
		INSERT INTO player_weapon_stats_2023Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-01-01' AND NEW.create_dt < DATE '2024-04-01') THEN
		INSERT INTO player_weapon_stats_2024Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-04-01' AND NEW.create_dt < DATE '2024-07-01') THEN
		INSERT INTO player_weapon_stats_2024Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-07-01' AND NEW.create_dt < DATE '2024-10-01') THEN
		INSERT INTO player_weapon_stats_2024Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-10-01' AND NEW.create_dt < DATE '2025-01-01') THEN
		INSERT INTO player_weapon_stats_2024Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-01-01' AND NEW.create_dt < DATE '2025-04-01') THEN
		INSERT INTO player_weapon_stats_2025Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-04-01' AND NEW.create_dt < DATE '2025-07-01') THEN
		INSERT INTO player_weapon_stats_2025Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-07-01' AND NEW.create_dt < DATE '2025-10-01') THEN
		INSERT INTO player_weapon_stats_2025Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-10-01' AND NEW.create_dt < DATE '2026-01-01') THEN
		INSERT INTO player_weapon_stats_2025Q4 VALUES (NEW.*);
	ELSE
		RAISE EXCEPTION 'Date out of range. Fix the player_weapon_stats_ins() trigger!';
	END IF;
	RETURN NULL;
END
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS player_weapon_stats_ins_trg ON xonstat.player_weapon_stats;

CREATE TRIGGER player_weapon_stats_ins_trg BEFORE INSERT on xonstat.player_weapon_stats
FOR EACH ROW EXECUTE PROCEDURE player_weapon_stats_ins();
-- +goose StatementEnd

-- +goose StatementBegin
CREATE OR REPLACE FUNCTION team_game_stats_ins()
RETURNS TRIGGER AS $$
BEGIN
	IF (NEW.create_dt >= DATE '2020-01-01' AND NEW.create_dt < DATE '2020-04-01') THEN
		INSERT INTO team_game_stats_2020Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-04-01' AND NEW.create_dt < DATE '2020-07-01') THEN
		INSERT INTO team_game_stats_2020Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-07-01' AND NEW.create_dt < DATE '2020-10-01') THEN
		INSERT INTO team_game_stats_2020Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-10-01' AND NEW.create_dt < DATE '2021-01-01') THEN
		INSERT INTO team_game_stats_2020Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-01-01' AND NEW.create_dt < DATE '2021-04-01') THEN
		INSERT INTO team_game_stats_2021Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-04-01' AND NEW.create_dt < DATE '2021-07-01') THEN
		INSERT INTO team_game_stats_2021Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-07-01' AND NEW.create_dt < DATE '2021-10-01') THEN
		INSERT INTO team_game_stats_2021Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-10-01' AND NEW.create_dt < DATE '2022-01-01') THEN
		INSERT INTO team_game_stats_2021Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-01-01' AND NEW.create_dt < DATE '2022-04-01') THEN
		INSERT INTO team_game_stats_2022Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-04-01' AND NEW.create_dt < DATE '2022-07-01') THEN
		INSERT INTO team_game_stats_2022Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-07-01' AND NEW.create_dt < DATE '2022-10-01') THEN
		INSERT INTO team_game_stats_2022Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-10-01' AND NEW.create_dt < DATE '2023-01-01') THEN
		INSERT INTO team_game_stats_2022Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-01-01' AND NEW.create_dt < DATE '2023-04-01') THEN
		INSERT INTO team_game_stats_2023Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-04-01' AND NEW.create_dt < DATE '2023-07-01') THEN
		INSERT INTO team_game_stats_2023Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-07-01' AND NEW.create_dt < DATE '2023-10-01') THEN
		INSERT INTO team_game_stats_2023Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-10-01' AND NEW.create_dt < DATE '2024-01-01') THEN
		INSERT INTO team_game_stats_2023Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-01-01' AND NEW.create_dt < DATE '2024-04-01') THEN
		INSERT INTO team_game_stats_2024Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-04-01' AND NEW.create_dt < DATE '2024-07-01') THEN
		INSERT INTO team_game_stats_2024Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-07-01' AND NEW.create_dt < DATE '2024-10-01') THEN
		INSERT INTO team_game_stats_2024Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-10-01' AND NEW.create_dt < DATE '2025-01-01') THEN
		INSERT INTO team_game_stats_2024Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-01-01' AND NEW.create_dt < DATE '2025-04-01') THEN
		INSERT INTO team_game_stats_2025Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-04-01' AND NEW.create_dt < DATE '2025-07-01') THEN
		INSERT INTO team_game_stats_2025Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-07-01' AND NEW.create_dt < DATE '2025-10-01') THEN
		INSERT INTO team_game_stats_2025Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-10-01' AND NEW.create_dt < DATE '2026-01-01') THEN
		INSERT INTO team_game_stats_2025Q4 VALUES (NEW.*);
	ELSE
		RAISE EXCEPTION 'Date out of range. Fix the team_game_stats_ins() trigger!';
	END IF;
	RETURN NULL;
END
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS team_game_stats_ins_trg ON xonstat.team_game_stats;

CREATE TRIGGER team_game_stats_ins_trg BEFORE INSERT on xonstat.team_game_stats
FOR EACH ROW EXECUTE PROCEDURE team_game_stats_ins();
-- +goose StatementEnd

-- +goose StatementBegin
CREATE OR REPLACE FUNCTION player_game_frag_matrix_ins()
RETURNS TRIGGER AS $$
BEGIN
	IF (NEW.create_dt >= DATE '2020-01-01' AND NEW.create_dt < DATE '2020-04-01') THEN
		INSERT INTO player_game_frag_matrix_2020Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-04-01' AND NEW.create_dt < DATE '2020-07-01') THEN
		INSERT INTO player_game_frag_matrix_2020Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-07-01' AND NEW.create_dt < DATE '2020-10-01') THEN
		INSERT INTO player_game_frag_matrix_2020Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-10-01' AND NEW.create_dt < DATE '2021-01-01') THEN
		INSERT INTO player_game_frag_matrix_2020Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-01-01' AND NEW.create_dt < DATE '2021-04-01') THEN
		INSERT INTO player_game_frag_matrix_2021Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-04-01' AND NEW.create_dt < DATE '2021-07-01') THEN
		INSERT INTO player_game_frag_matrix_2021Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-07-01' AND NEW.create_dt < DATE '2021-10-01') THEN
		INSERT INTO player_game_frag_matrix_2021Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-10-01' AND NEW.create_dt < DATE '2022-01-01') THEN
		INSERT INTO player_game_frag_matrix_2021Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-01-01' AND NEW.create_dt < DATE '2022-04-01') THEN
		INSERT INTO player_game_frag_matrix_2022Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-04-01' AND NEW.create_dt < DATE '2022-07-01') THEN
		INSERT INTO player_game_frag_matrix_2022Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-07-01' AND NEW.create_dt < DATE '2022-10-01') THEN
		INSERT INTO player_game_frag_matrix_2022Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-10-01' AND NEW.create_dt < DATE '2023-01-01') THEN
		INSERT INTO player_game_frag_matrix_2022Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-01-01' AND NEW.create_dt < DATE '2023-04-01') THEN
		INSERT INTO player_game_frag_matrix_2023Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-04-01' AND NEW.create_dt < DATE '2023-07-01') THEN
		INSERT INTO player_game_frag_matrix_2023Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-07-01' AND NEW.create_dt < DATE '2023-10-01') THEN
		INSERT INTO player_game_frag_matrix_2023Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-10-01' AND NEW.create_dt < DATE '2024-01-01') THEN
		INSERT INTO player_game_frag_matrix_2023Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-01-01' AND NEW.create_dt < DATE '2024-04-01') THEN
		INSERT INTO player_game_frag_matrix_2024Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-04-01' AND NEW.create_dt < DATE '2024-07-01') THEN
		INSERT INTO player_game_frag_matrix_2024Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-07-01' AND NEW.create_dt < DATE '2024-10-01') THEN
		INSERT INTO player_game_frag_matrix_2024Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-10-01' AND NEW.create_dt < DATE '2025-01-01') THEN
		INSERT INTO player_game_frag_matrix_2024Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-01-01' AND NEW.create_dt < DATE '2025-04-01') THEN
		INSERT INTO player_game_frag_matrix_2025Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-04-01' AND NEW.create_dt < DATE '2025-07-01') THEN
		INSERT INTO player_game_frag_matrix_2025Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-07-01' AND NEW.create_dt < DATE '2025-10-01') THEN
		INSERT INTO player_game_frag_matrix_2025Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-10-01' AND NEW.create_dt < DATE '2026-01-01') THEN
		INSERT INTO player_game_frag_matrix_2025Q4 VALUES (NEW.*);
	ELSE
		RAISE EXCEPTION 'Date out of range. Fix the player_game_frag_matrix_ins() trigger!';
	END IF;
	RETURN NULL;
END
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS player_game_frag_matrix_ins_trg ON xonstat.player_game_frag_matrix;

CREATE TRIGGER player_game_frag_matrix_ins_trg BEFORE INSERT on xonstat.player_game_frag_matrix
FOR EACH ROW EXECUTE PROCEDURE player_game_frag_matrix_ins();
-- +goose StatementEnd

-- +goose StatementBegin
CREATE OR REPLACE FUNCTION player_game_nonparticipants_ins()
RETURNS TRIGGER AS $$
BEGIN
	IF (NEW.create_dt >= DATE '2020-01-01' AND NEW.create_dt < DATE '2020-04-01') THEN
		INSERT INTO player_game_nonparticipants_2020Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-04-01' AND NEW.create_dt < DATE '2020-07-01') THEN
		INSERT INTO player_game_nonparticipants_2020Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-07-01' AND NEW.create_dt < DATE '2020-10-01') THEN
		INSERT INTO player_game_nonparticipants_2020Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2020-10-01' AND NEW.create_dt < DATE '2021-01-01') THEN
		INSERT INTO player_game_nonparticipants_2020Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-01-01' AND NEW.create_dt < DATE '2021-04-01') THEN
		INSERT INTO player_game_nonparticipants_2021Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-04-01' AND NEW.create_dt < DATE '2021-07-01') THEN
		INSERT INTO player_game_nonparticipants_2021Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-07-01' AND NEW.create_dt < DATE '2021-10-01') THEN
		INSERT INTO player_game_nonparticipants_2021Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2021-10-01' AND NEW.create_dt < DATE '2022-01-01') THEN
		INSERT INTO player_game_nonparticipants_2021Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-01-01' AND NEW.create_dt < DATE '2022-04-01') THEN
		INSERT INTO player_game_nonparticipants_2022Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-04-01' AND NEW.create_dt < DATE '2022-07-01') THEN
		INSERT INTO player_game_nonparticipants_2022Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-07-01' AND NEW.create_dt < DATE '2022-10-01') THEN
		INSERT INTO player_game_nonparticipants_2022Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2022-10-01' AND NEW.create_dt < DATE '2023-01-01') THEN
		INSERT INTO player_game_nonparticipants_2022Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-01-01' AND NEW.create_dt < DATE '2023-04-01') THEN
		INSERT INTO player_game_nonparticipants_2023Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-04-01' AND NEW.create_dt < DATE '2023-07-01') THEN
		INSERT INTO player_game_nonparticipants_2023Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-07-01' AND NEW.create_dt < DATE '2023-10-01') THEN
		INSERT INTO player_game_nonparticipants_2023Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2023-10-01' AND NEW.create_dt < DATE '2024-01-01') THEN
		INSERT INTO player_game_nonparticipants_2023Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-01-01' AND NEW.create_dt < DATE '2024-04-01') THEN
		INSERT INTO player_game_nonparticipants_2024Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-04-01' AND NEW.create_dt < DATE '2024-07-01') THEN
		INSERT INTO player_game_nonparticipants_2024Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-07-01' AND NEW.create_dt < DATE '2024-10-01') THEN
		INSERT INTO player_game_nonparticipants_2024Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2024-10-01' AND NEW.create_dt < DATE '2025-01-01') THEN
		INSERT INTO player_game_nonparticipants_2024Q4 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-01-01' AND NEW.create_dt < DATE '2025-04-01') THEN
		INSERT INTO player_game_nonparticipants_2025Q1 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-04-01' AND NEW.create_dt < DATE '2025-07-01') THEN
		INSERT INTO player_game_nonparticipants_2025Q2 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-07-01' AND NEW.create_dt < DATE '2025-10-01') THEN
		INSERT INTO player_game_nonparticipants_2025Q3 VALUES (NEW.*);
	ELSIF (NEW.create_dt >= DATE '2025-10-01' AND NEW.create_dt < DATE '2026-01-01') THEN
		INSERT INTO player_game_nonparticipants_2025Q4 VALUES (NEW.*);
	ELSE
		RAISE EXCEPTION 'Date out of range. Fix the player_game_nonparticipants_ins() trigger!';
	END IF;
	RETURN NULL;
END
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS player_game_nonparticipants_ins_trg ON xonstat.player_game_nonparticipants;

CREATE TRIGGER player_game_nonparticipants_ins_trg BEFORE INSERT on xonstat.player_game_nonparticipants
FOR EACH ROW EXECUTE PROCEDURE player_game_nonparticipants_ins();
-- +goose StatementEnd


-- +goose Down

-- Drop tables in reverse order
DROP TABLE IF EXISTS player_skills CASCADE;
DROP TABLE IF EXISTS player_game_nonparticipants CASCADE;
DROP TABLE IF EXISTS player_game_frag_matrix CASCADE;
DROP TABLE IF EXISTS player_agg_stats_mv CASCADE;
DROP TABLE IF EXISTS merged_servers CASCADE;
DROP TABLE IF EXISTS active_maps_mv CASCADE;
DROP TABLE IF EXISTS active_servers_mv CASCADE;
DROP TABLE IF EXISTS active_players_mv CASCADE;
DROP TABLE IF EXISTS summary_stats_mv CASCADE;
DROP TABLE IF EXISTS player_game_anticheats CASCADE;
DROP TABLE IF EXISTS team_game_stats CASCADE;
DROP TABLE IF EXISTS summary_stats CASCADE;
DROP TABLE IF EXISTS player_map_captimes CASCADE;
DROP TABLE IF EXISTS hashkeys CASCADE;
DROP TABLE IF EXISTS player_weapon_stats CASCADE;
DROP TABLE IF EXISTS player_game_stats CASCADE;
DROP TABLE IF EXISTS games CASCADE;
DROP TABLE IF EXISTS maps CASCADE;
DROP TABLE IF EXISTS servers CASCADE;
DROP TABLE IF EXISTS cd_game_type CASCADE;
DROP TABLE IF EXISTS cd_weapon CASCADE;
DROP TABLE IF EXISTS players CASCADE;

