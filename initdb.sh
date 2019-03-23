#!/bin/bash

TEST=$(ps -A | grep postgres | wc -l)

if [[ $TEST -le 1 ]]; then
  echo "starting postgres..."
  pg_ctl -D /usr/local/var/postgres start
  createuser pizza --no-password
  createdb pizza
fi


