#!/bin/bash
set -e

# Use environment variable or default to 2 workers
WORKERS=${GUNICORN_WORKERS:-2}

echo "Running database migrations..."
uv run python manage.py migrate --noinput

echo "Collecting static files..."
uv run python manage.py collectstatic --noinput --clear

echo "Starting gunicorn with $WORKERS workers..."

# exec replaces the shell process with gunicorn
# This ensures signals go directly to gunicorn
exec uv run gunicorn uvdjangoapp.wsgi:application \
    --bind 0.0.0.0:8000 \
    --workers "$WORKERS"
