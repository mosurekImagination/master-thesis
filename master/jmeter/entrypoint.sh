#!/usr/bin/env sh
rm ./test-results/ -R
./bin/jmeter -Jhostadress=$HOST_ADRESS -Jport=$HOST_PORT  -n -t ./test-scenarios/simple.jmx -l ./test-results/results.log -e -o ./test-results/raport/