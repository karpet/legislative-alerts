test:
	bundle exec rspec

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
