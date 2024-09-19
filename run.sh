#!/bin/sh
set -e

crond -f -S -l 0 -c /cron 