#!/bin/bash

sudo apt-get update
sudo apt-get install -y sqlite3

# Use 50% of RAM for sqlite buffers
awk '/MemTotal/ { printf "PRAGMA cache_size=-%.0f", $2*0.5 }' /proc/meminfo > sqliterc

sqlite3 mydb < create.sql

wget --continue 'https://datasets.clickhouse.com/hits_compatible/hits.csv.gz'
gzip -d hits.csv.gz

time sqlite3 -init sqliterc mydb '.import --csv hits.csv hits'

time sqlite3 -init sqliterc mydb < index.sql

wc -c mydb

./run.sh 2>&1 | tee log.txt

cat log.txt |
  grep -P '^real|^Error' |
  sed -r -e 's/^Error.*$/null/; s/^real\s*([0-9.]+)m([0-9.]+)s$/\1 \2/' |
  awk '{ if ($2) { print $1 * 60 + $2 } else { print $1 } }' |
  awk '{ if ($1 == "null") { skip = 1 } else { if (i % 3 == 0) { printf "[" }; printf skip ? "null" : $1; if (i % 3 != 2) { printf "," } else { print "]," }; ++i; skip = 0; } }'
