#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
--CREATE USER adempiere WITH CREATEDB PASSWORD 'adempiere';

  CREATE ROLE adempiere SUPERUSER LOGIN PASSWORD 'adempiere';
  ALTER ROLE adempiere SET search_path TO adempiere, pg_catalog;

  CREATE DATABASE adempiere WITH ENCODING='UNICODE' OWNER=adempiere;
  GRANT ALL PRIVILEGES ON DATABASE adempiere TO adempiere;
EOSQL

# Commented out for now!!!
# Check if ExpDat.dmp file exist then import it!
# psql -d adempiere --username adempiere -f /ExpDat.dmp

