FROM ruby:2.6.0

RUN apt-get update \
  && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt-get install nodejs --yes \
  && npm install yarn -g

WORKDIR /app

RUN git clone https://github.com/docker-hy/rails-example-project.git rails

WORKDIR /app/rails

RUN bundle install \
  && export SECRET_KEY_BASE=$(RAILS_ENV=production rake secret) \
  && rake assets:precompile \
  && rails db:migrate RAILS_ENV=production

COPY start.sh .

EXPOSE 3000

CMD [ "./start.sh" ]
