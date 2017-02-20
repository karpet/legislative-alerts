test:
	bundle exec rspec

run:
	foreman start

deploy:
	git pull
	rake assets:precompile
	touch tmp/restart.txt

.PHONY: test run deploy
