#!/bin/bash
# Script to generate user and database in POSTGRESQL from command line

# Functions
ok() { echo -e '\e[32m'$1'\e[m'; } # Green

EXPECTED_ARGS=3
E_BADARGS=65
PSQL=`which psql`
# default user: postgres
USER="<youruser>"
PASS="PGPASSWORD=<yourpassword>"

 
Q1="create database  $1;"
Q2="create user $2;"
Q3="alter user $2 with encrypted password '$3';"
Q4="grant all privileges on database $1 to $2;"
SQL="${Q1}${Q2}${Q3}${Q4}"
 
if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Uso: $0 dbname  dbnewuser dbnewpass"
  exit $E_BADARGS
fi
 

export $PASS
$PSQL -U $USER  -c "$Q1"
ok "Database: $1 created"
$PSQL -U $USER  -c "$Q2"
ok "User: $2 created" 
$PSQL -U $USER  -c "$Q3"
ok "Password: $3 assigned" 
$PSQL -U $USER  -c "$Q4"
ok "Grant all: created" 
 
ok "Database $1 and user $2 created with a password $3"