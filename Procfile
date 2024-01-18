web: bundle exec bin/rails server -p $PORT -e $RAILS_ENV
console: bundle exec bin/rails console
js: yarn build --watch
css: yarn build:css --watch
worker: bundle exec sidekiq -e $RAILS_ENV -C config/sidekiq.yml
release: rake db:migrate
