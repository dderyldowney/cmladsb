#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username postgres <<-EOSQL
  CREATE USER python_user WITH PASSWORD 'python_password' CREATEDB CREATEROLE;
  CREATE DATABASE python_db OWNER python_user;
  GRANT ALL PRIVILEGES ON DATABASE python_db TO python_user;
EOSQL

