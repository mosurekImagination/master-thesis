#!/usr/bin/env sh

#set Poland localTime
echo "setting Poland timeZone"
cp /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
echo "Europe/Warsaw" >  /etc/timezone
apk del tzdata

echo "WAITING 100sec to systems up"
# sleep 3
echo "3sec remaining"
# sleep 3

dateTime=$(date +'%Y-%m-%d-%H.%M')
echo $dateTime
echo "### $dateTime STARTING 1 LOAD TESTING OF $FIRST_WORKER_HOST:$FIRST_WORKER_PORT ###"
resultsFolder=./test-results/$dateTime
mkdir ./temp-test-results/
mkdir $resultsFolder

./bin/jmeter -Jhostadress=$FIRST_WORKER_HOST -Jport=$FIRST_WORKER_PORT  -n -t ./test-scenarios/simple.jmx -l ./temp-test-results/results.log -e -o ./temp-test-results/raport/
mv ./temp-test-results/ $resultsFolder/1-$FIRST_WORKER_HOST/

echo "WAITING 100sec to systems up"
sleep 3
echo "3sec remaining"
sleep 3

mkdir ./temp-test-results/
echo "### STARTING 2 LOAD TESTING OF $SECOND_WORKER_HOST:$SECOND_WORKER_PORT###"
./bin/jmeter -Jhostadress=$SECOND_WORKER_HOST -Jport=$SECOND_WORKER_PORT  -n -t ./test-scenarios/simple.jmx -l ./temp-test-results/results.log -e -o ./temp-test-results/raport/
mv ./temp-test-results/ $resultsFolder/2-$SECOND_WORKER_HOST/

echo "WAITING 100sec to systems up"
sleep 3
echo "3sec remaining"
sleep 3

mkdir ./temp-test-results/
echo "### STARTING 3 LOAD TESTING OF $THIRD_WORKER_HOST:$THIRD_WORKER_PORT###"
./bin/jmeter -Jhostadress=$THIRD_WORKER_HOST -Jport=$THIRD_WORKER_PORT  -n -t ./test-scenarios/simple.jmx -l ./temp-test-results/results.log -e -o ./temp-test-results/raport/
mv ./temp-test-results/ $resultsFolder/3-$THIRD_WORKER_HOST/

echo "### LOAD TESTING FINISHED ###"

