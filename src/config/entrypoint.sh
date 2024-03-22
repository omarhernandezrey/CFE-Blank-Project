#!/bin/bash

# Set the running Gunicorn port based on an Environment variable
APP_PORT=${PORT:-8000}

# Go to the docker-created app directory where the code is copied
cd /app/

# Apply database migrations
/opt/venv/bin/python manage.py migrate

# Run the Gunicorn server on the cfehome.wsgi:application
/opt/venv/bin/gunicorn cfehome.wsgi:application --bind "0.0.0.0:$APP_PORT"
