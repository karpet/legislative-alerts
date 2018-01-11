test:
	bundle exec rspec

run:
	foreman start

runprod:
	foreman start -f Procfile.production

deploy:
	git pull
	bundle install
	rake db:migrate
	rake assets:precompile
	rake restart
	bundle exec bin/delayed_job restart

.PHONY: test run deploy runprod
