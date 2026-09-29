# Demo-Image mit vorinstallierten Gems, damit `docker compose up` sofort startet
FROM ruby:3.4
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
EXPOSE 3000
CMD ["sh", "-c", "bin/setup && bin/dev"]
