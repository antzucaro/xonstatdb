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

Create the pgplsql language, if it doesn't exist:

    CREATE LANGUAGE plpgsql;

Now load the initial tables:

    \i build/build_full.sql

   *Note: You will see a lot of NOTICE messages. This is normal.*

And that's it!

[xonotic]: http://www.xonotic.org/
[xonstat]: http://stats.xonotic.org/

----

Project is licensed GPLv3.
