# Use the official Ruby 3.0 Alpine image as the base image
FROM ruby:2.7.8-slim

# Install dependencies

RUN apt-get update \
    && apt-get install -y build-essential git \
                          libpq-dev tree nano curl \
                          npm \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y yarn \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# COPY Gemfile Gemfile.lock /app/

# Copy the entrypoint script into the container
COPY docker/dev/entrypoint.sh /app/docker/dev/entrypoint.sh

RUN echo 'PS1="\[\e[38;5;215m\]lovevery\[\e[m\]\[\e[38;5;15m\] : \[\e[m\]\[\e[38;5;68m\]\w\[\e[m\]\[\e[38;5;231m\] \$ \[\e[m\]"' >> ~/.bashrc

# Make the entrypoint script executable
RUN chmod +x /app/docker/dev/entrypoint.sh

# Specify the entrypoint to start a bash console
ENTRYPOINT ["/app/docker/dev/entrypoint.sh"]
