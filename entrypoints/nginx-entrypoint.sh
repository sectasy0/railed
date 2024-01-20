#!/bin/sh

set -e

/usr/local/nginx/sbin/nginx -g "daemon off;" -c /etc/nginx/nginx.conf
