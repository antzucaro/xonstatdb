create table active_maps_mv(
	sort_order integer,
	map_id bigint,
	map_name character varying(128),
	games integer,
	create_dt timestamp without time zone default (now() at time zone 'UTC')
);

ALTER TABLE xonstat.active_maps_mv OWNER TO xonstat;
