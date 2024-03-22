#!/bin/bash

# Navigate to the Django project root directory
cd /app/

# Migrate the Docker container as needed
/opt/venv/bin/python manage.py migrate
