#!/bin/bash
set -e
echo "Running release.sh"
uv run manage.py migrate
uv run manage.py collectstatic
