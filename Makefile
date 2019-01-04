test:
	bundle exec rspec

alerts:
	bundle exec rake alerts:check

run:
	foreman start

runprod:
	foreman start -f Procfile.production

deploy:
	ssh legalerts@legalerts.us 'cd legislative-alerts && bin/deploy'

restart:
	rake restart
	bundle exec bin/delayed_job restart

.PHONY: test run deploy runprod
