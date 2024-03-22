FROM python:3.11.1-slim as builder

# copy project
COPY ./src /app
WORKDIR /app

# Set environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Update system and install dependencies
RUN apt-get update && \
    apt-get install -y locales \
                        libmemcached-dev \
                        libpq-dev \
                        libjpeg-dev \
                        zlib1g-dev && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen && \
    dpkg-reconfigure locales && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN python -m venv /opt/venv && \
    /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install -r /app/requirements.txt

# Make scripts executable
RUN chmod +x /app/config/migrate.sh && \
    chmod +x /app/config/entrypoint.sh

CMD ["/app/config/entrypoint.sh"]
