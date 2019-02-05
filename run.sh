#!/bin/sh
source $HOME/.rvm/environments/ruby-`cat .ruby-version`
/bin/nohup make runprod > log/nohup.log &
