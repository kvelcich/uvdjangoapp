#!/bin/bash
set -e
echo "Running release.sh"

echo "Running database migrations..."
uv run python manage.py migrate --noinput

echo "Collecting static files..."
uv run python manage.py collectstatic --noinput --clear
