# Kodable Task

To check for and start a local PostgreSQL instance, you can run the `./initdb.sh` script. This will check if any 'postgres' processes are running, start one if necessary, and create the appropriate user and database. It will log errors if either already exists, but will continue execution.

`./closedb.sh` will shut down the postgres server.

To run tests, execute the following:
```
environment="testing" bundle exec rspec
```
It will use an sqlite db connection (no need to have postgres running) and cleanup its temporary `test.db` after completion so it's always run on a fresh install.

For some odd reason, simply running `rackup` wasn't able to discover the `pg` module and would fail. As such, I recommend running
```
bundle exec rspec
```
 to start the server.