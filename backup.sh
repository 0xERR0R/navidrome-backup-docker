#!/usr/bin/env bash

set -e

WORKDIR=/tmp/backup
mkdir -p $WORKDIR

echo "starting navidrome backup"

echo "creating database backup"
sqlite3 /data/navidrome.db ".backup $WORKDIR/navidrome.db"

echo "generating reports"

for f in /opt/reports/*.sql
do
    echo "executing report $f"
    report_file=$(basename $f)
    cat $f | sqlite3 -column -header /data/navidrome.db > $WORKDIR/"${report_file%.*}".txt
done

backup_file="backup_$(date +"%Y%m%d_%H%M%S").zip"
echo "creating backup archive $backup_file"


zip -jr /out/$backup_file $WORKDIR

rm -rf $WORKDIR

echo "done"