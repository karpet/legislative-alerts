test:
	bundle exec rspec

alerts:
	bundle exec rake alerts:check

report:
	bundle exec rake alerts:report

db:
	bundle exec rails dbconsole

console:
	bundle exec rails console

run:
	foreman start

runprod:
	foreman start -f Procfile.production

deploy:
	ssh legalerts@legalerts.us 'cd legislative-alerts && bin/deploy'

restart:
	rake restart
	bundle exec bin/delayed_job restart

.PHONY: test run deploy runprod restart console db alerts
