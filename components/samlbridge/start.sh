#!/bin/sh

# start cron
cron -f &

# run apache
apache2-foreground
