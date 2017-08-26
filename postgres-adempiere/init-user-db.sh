#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
--CREATE USER adempiere WITH CREATEDB PASSWORD 'adempiere';

  CREATE ROLE adempiere SUPERUSER LOGIN PASSWORD 'adempiere';
  ALTER ROLE adempiere SET search_path TO adempiere, pg_catalog;

  CREATE DATABASE adempiere WITH ENCODING='UNICODE' OWNER=adempiere;
  GRANT ALL PRIVILEGES ON DATABASE adempiere TO adempiere;
EOSQL

# Check if /ExpDat.dmp file exist then import it!
file_name="/ExpDat.dmp"
if [ -f "$file_name" ]
then
  echo "$file_name found. Will import DB dump!!!"
  psql -d adempiere --username adempiere -f $file_name
else
  echo "$file_name not found. Will NOT import DB dump."
fi
