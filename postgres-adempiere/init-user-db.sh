#!/bin/bash
set -e

ADEMPIERE_USER=adempiere
ADEMPIERE_PASS=adempiere
ADEMPIERE_DB_NAME=adempiere

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
--CREATE USER ${ADEMPIERE_USER} WITH CREATEDB PASSWORD '${ADEMPIERE_PASS}';

  CREATE ROLE ${ADEMPIERE_USER} SUPERUSER LOGIN PASSWORD '${ADEMPIERE_PASS}';
  ALTER ROLE ${ADEMPIERE_USER} SET search_path TO adempiere, pg_catalog;

  CREATE DATABASE ${ADEMPIERE_DB_NAME} WITH ENCODING='UNICODE' OWNER=${ADEMPIERE_USER};
  GRANT ALL PRIVILEGES ON DATABASE ${ADEMPIERE_DB_NAME} TO ${ADEMPIERE_USER};
EOSQL

# Check if /ExpDat.dmp file exist then import it!
file_name="/ExpDat.dmp"
if [ -f "$file_name" ]
then
  echo "$file_name found. Will import DB dump!!!"
  psql -d ${ADEMPIERE_DB_NAME} --username ${ADEMPIERE_USER} -f $file_name
else
  echo "$file_name not found. Will NOT import DB dump."
fi
