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

start:
	source $$HOME/.rvm/environments/ruby-`cat .ruby-version`
	/usr/bin/nohup make runprod > log/nohup.log &

stop:
	kill -HUP `cat tmp/pids/puma.pid`
	test -f tmp/pids/delayed_job.pid && kill -HUP `cat tmp/pids/delayed_job.pid`

deploy:
	ssh legalerts@legalerts.us 'cd legislative-alerts && bin/deploy'

restart:
	rake restart
	bundle exec bin/delayed_job restart

.PHONY: test run deploy runprod restart console db alerts
