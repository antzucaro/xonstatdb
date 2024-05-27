# XonStatDB

This is the source for the database underlying [XonStat][xonstat], the statistics application for the arena-style FPS [Xonotic][xonotic]. 
All code herein is intended for the PostgreSQL database management server.

## Clone

```
git clone git@gitlab.com:xonotic/xonstatdb.git
```

## Prepare

Prepare the database by first creating the user that will own all of the objects in the database.
You must run this as an administrator user in your cluster.
See your operating system's guidelines for how this is set up on your system.

    create user xonstat with password 'xonstat';

   *Note: please change this password*

Or from the commandline:

    # su - postgres  (as root)
    postgres$ createuser -P xonstat  (this will prompt you for the users password)

Next, create the database itself:

    $ psql
    postgres=#

    CREATE DATABASE xonstatdb
      WITH ENCODING='UTF8'
        OWNER=xonstat
        CONNECTION LIMIT=-1;

If you intend to use the `drop_and_load.shl` script in the scripts folder, you may want to give
the application user superuser within the database. To do that you can use the following command:

    postgres=# alter user xonstat with superuser;

When done, exit the psql prompt: 

    postgres=# \q

Next, as your regular system user, log into the newly created database
using the user account you just created.
Do this from the root directory of your project checkout.

    $ psql -U xonstat xonstatdb

You might need to force postgres to not use ident, if you get an error
like *Peer authentication failed for user "xonstat"*:

    $ psql -h localhost -U xonstat xonstatdb


Create the plpgsql language, if it doesn't exist:

    CREATE LANGUAGE plpgsql;

## Initialize

Initial schema setup and subsequent migrations for XonStatDB are handled using [goose][goose]. You may want to familiarize yourself with that tool before proceeding. 

```
goose postgres "user=xonstat host=localhost dbname=xonstatdb sslmode=disable password=$PASSWORD" up
```

That's it!

## Maintenance Scripts

There are a few maintenance scripts that can be used
once the database begins accumulating data. These can be found in 
the scripts subdirectory and are intended to be implemented as cron jobs.
 
A summary of what they do follows:

- refresh_*.sh: refreshes data in various materialized views
- purge_anticheat_log.sh: prunes the anticheat signal data 

An example crontab using these: 
```
# refresh the materialized views in xonstatdb
00 07 * * * ~/bin/refresh_summary_stats.sh
10 07 * * * ~/bin/refresh_active_players.sh
15 07 * * * ~/bin/refresh_active_servers.sh
20 07 * * * ~/bin/refresh_active_maps.sh
25 07 * * * ~/bin/refresh_recent_game_stats.sh

# prune the anticheats
20 08 * * * ~/bin/purge_anticheat_log.sh
```

 

[xonotic]: http://www.xonotic.org/
[xonstat]: http://stats.xonotic.org/
[goose]: https://github.com/pressly/goose

----

Project is licensed GPLv3.
