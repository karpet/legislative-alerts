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

c: console

install:
	bundle check || bundle install

run:
	foreman start

runprod:
	foreman start -f Procfile.production

start:
	/usr/bin/nohup make runprod > log/nohup.log &

stop:
	(test -f tmp/pids/puma.pid && kill -HUP `cat tmp/pids/puma.pid`) || echo 'puma not running'
	bundle exec bin/delayed_job stop

deploy:
	ssh legalerts@legalerts.us 'cd legislative-alerts && bin/deploy'

restart:
	rake restart
	bundle exec bin/delayed_job restart

.PHONY: test run deploy runprod restart console db alerts
