This is the source for **xonstatdb**, the [Xonotic][xonotic] [Statistics database][xonstat].
All code herein is intended for the PostgreSQL database management server.

----

To build, first create the user that will own all of the objects in the database.
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

    postgres=# \q

Next, as your regular system user, log into the newly created database
using the user account you just created.
Do this from the root directory of your project checkout.

    $ psql -U xonstat xonstatdb

You might need to force postgres to not use ident, if you get an error
like *Peer authentication failed for user "xonstat"*:

    $ psql -h localhost -U xonstat xonstatdb

Create the schema in which all of the xonstat tables will reside:

    xonstatdb=>
    
    CREATE SCHEMA xonstat
        AUTHORIZATION xonstat;

Create the plpgsql language, if it doesn't exist:

    CREATE LANGUAGE plpgsql;

Now load the initial tables:

    \i build/build_full.sql

   *Note: You will see a lot of NOTICE messages. This is normal.*

And that's it!

Do note that there are a few maintenance scripts that can be used
once the database begins accumulating data. These can be found in 
the scripts subdirectory. A summary of what they do follows:

  update\_elos.sql - will decrease player elo records by one point 
                    day for every day after 30 days of inactivity
                    until they hit the elo "floor" of 100. This 
                    prevents inactive players from staying on the 
                    leaderboard/ranks for too long.

  update\_ranks.sql - will populate the player\_ranks table each day
                     according to the elo values when it is run.

There is also a "merge players" function in the functions sub-
directory. This can be used to merge two players together into one
record in the presentation layer of XonStat. It can be run as follows:

  select merge\_players(winner\_player\_id, loser\_player\_id);

The "winner" player ID is the account that remains active after the
transaction.

Enjoy!

[xonotic]: http://www.xonotic.org/
[xonstat]: http://stats.xonotic.org/

----

Project is licensed GPLv3.
