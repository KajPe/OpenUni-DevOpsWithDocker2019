##### Building stage #####
FROM ruby:2.6.0-alpine as build-stage

# Bundle configuration
ENV BUNDLE_APP_CONFIG="/app/rails/.bundle"

RUN apk update \
  && apk upgrade \
  # Add package dependecies
  && apk add --update --no-cache \
    git build-base curl-dev yaml-dev zlib-dev nodejs \
    yarn sqlite sqlite-dev sqlite-libs tzdata \
  # Clone project
  && mkdir /app \
  && cd /app \
  && git clone https://github.com/docker-hy/rails-example-project.git rails

# Set workdir
WORKDIR /app/rails

# Setup and install project
RUN bundle config --global frozen 1 \
  && bundle install --path=vendor/bundle \
  && export SECRET_KEY_BASE=$(RAILS_ENV=production rake secret) \
  && yarn install --production \
  && rake assets:precompile \
  && bin/rails db:migrate RAILS_ENV=production \
  # Clean up (remove not needed files)
  && rm -rf vendor/bundle/ruby/2.6.0/cache/*.gem \
  && find vendor/bundle/ruby/2.6.0/gems/ -name "*.c" -delete \
  && find vendor/bundle/ruby/2.6.0/gems/ -name "*.o" -delete \
  && rm -rf node_modules tmp/cache app/assets vendor/assets spec .git .gitignore


##### Final image #####
FROM ruby:2.6.0-alpine

# Bundle configuration
ENV BUNDLE_APP_CONFIG="/app/rails/.bundle"

# Set workdir
WORKDIR /app/rails

# Copy project (compiled) over to image
COPY --from=build-stage /app /app

# Copy start script into image
COPY start.sh .

RUN apk update \
  && apk upgrade \
  # Add package dependecies
  && apk add --update --no-cache tzdata sqlite-libs nodejs \
  # Make start.sh script runnable
  && chmod +x start.sh \
  #
  # Set ownership
  #
  && cd /app \
  # Create group www-data
  && addgroup -S www-data \
  # Create user www-data
  && adduser -S www-data \
  # Make www-data owner of everything under /app
  && chown -R www-data:www-data * \
  # Set sticky bit on all under /app
  && chmod g+s .

# Run container as user www-data
USER www-data

# Expose port 3000
EXPOSE 3000

# Run start.sh on container start
CMD [ "./start.sh" ]
