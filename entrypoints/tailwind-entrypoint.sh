#!/bin/sh

set -e

RUBYOPT="--yjit" bundle exec rails tailwindcss:watch
