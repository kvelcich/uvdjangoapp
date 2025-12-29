#!/bin/bash
set -e

echo "Running database migrations..."
uv run python manage.py migrate --noinput
