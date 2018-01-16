# Legislative Alerts

[![Build Status](https://travis-ci.org/legalerts/legislative-alerts.svg?branch=master)](https://travis-ci.org/legalerts/legislative-alerts)

A Rails application for pushing notifications from the OpenStates API.

## Running in production

Example script for running in production behind a proxy:

```bash
#!/bin/sh
source $HOME/.rvm/environments/ruby-`cat .ruby-version`
/bin/nohup make runprod > log/nohup.log &
```
