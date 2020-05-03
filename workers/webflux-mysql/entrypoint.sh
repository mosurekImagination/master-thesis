#!/usr/bin/env sh

/serverAgent/startAgent.sh & > /dev/null 2>&1 
java -jar mosur-thesis-worker-webflux-mysql-1.0.jar