FROM python:3.14.2-slim-bookworm

# Potentially remove this in production builds
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Install UV: https://docs.astral.sh/uv/guides/integration/docker/
COPY --from=ghcr.io/astral-sh/uv:0.9.18 /uv /uvx /bin/

# Copy the project into the image
COPY . /app

# Disable development dependencies
ENV UV_NO_DEV=1

# Sync the project into a new environment, asserting the lockfile is up to date
WORKDIR /app
RUN uv sync --locked

# Expose port 8000
EXPOSE 8000

# Default number of workers (can be overridden with -e GUNICORN_WORKERS=N)
ENV GUNICORN_WORKERS=2

# Use exec form (JSON array) for proper signal handling
RUN chmod +x /app/web.sh
CMD ["/app/web.sh"]
