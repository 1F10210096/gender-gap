ARG RUBY_VERSION=3.4.1
FROM ruby:$RUBY_VERSION-slim as base

WORKDIR /rails


# Set development environment
ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle"

# Install required packages (PostgreSQL client added, SQLite removed)
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential git libvips pkg-config \
    nodejs yarn libpq-dev && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install application gems
COPY Gemfile Gemfile.lock ./ 
RUN bundle install --jobs=4 --retry=3

# Copy application code
COPY . . 

# Run and own only the runtime files as a non-root user for security
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails /rails db log storage tmp Gemfile.lock


# Copy the docker-entrypoint.sh script into the container and make it executable
COPY docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh

USER rails:rails

# Expose the application port
EXPOSE 3000

# Set the entrypoint to use the custom script
ENTRYPOINT ["docker-entrypoint.sh"]

# Start the Rails server with Puma
CMD ["./bin/rails", "server", "-b", "0.0.0.0", "-e", "$RAILS_ENV"]

