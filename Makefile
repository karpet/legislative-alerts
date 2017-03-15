test:
	bundle exec rspec

run:
	foreman start

runprod:
	foreman -f Profile.production start

deploy:
	git pull
	rake db:migrate
	rake assets:precompile
	touch tmp/restart.txt
	bundle exec bin/delayed_job restart

.PHONY: test run deploy runprod
