#!/usr/bin/env sh

#set Poland localTime
echo "setting Poland timeZone"
cp /usr/share/zoneinfo/Europe/Warsaw /etc/localtime -f
echo "Europe/Warsaw" >  /etc/timezone

echo "WAITING 100sec to systems up"
sleep 50
echo "50sec remaining"
#sleep 50

dateTime=$(date +'%Y-%m-%d-%H.%M')
echo $dateTime
echo "### $dateTime STARTING 1 LOAD TESTING OF $FIRST_WORKER_HOST:$FIRST_WORKER_PORT ###"
resultsFolder=./test-results/$dateTime
tempResultsFolder=./temp-test-results
mkdir $resultsFolder

mkdir $tempResultsFolder/
./bin/jmeter -Jjmeter.reportgenerator.overall_granularity=2000 -JforcePerfmonFile=true -Jhostadress=$FIRST_WORKER_HOST -Jhostport=$FIRST_WORKER_PORT  -n -t ./test-scenarios/simple.jmx -l $tempResultsFolder/results.log -e -o $tempResultsFolder/report/ -JperfmonReportPath=$tempResultsFolder -JaggregateReportPath=$tempResultsFolder -JsummaryReportPath=$tempResultsFolder -JgraphReportPath=$tempResultsFolder -JtableReportPath=$tempResultsFolder
mv $tempResultsFolder/ $resultsFolder/1-$FIRST_WORKER_HOST/

echo "WAITING 100sec to systems up"
sleep 3
echo "3sec remaining"
sleep 3

mkdir $tempResultsFolder/
echo "### STARTING 2 LOAD TESTING OF $SECOND_WORKER_HOST:$SECOND_WORKER_PORT###"
./bin/jmeter -Jjmeter.reportgenerator.overall_granularity=2000 -Jhostadress=$SECOND_WORKER_HOST -Jhostport=$SECOND_WORKER_PORT  -n -t ./test-scenarios/simple.jmx -l $tempResultsFolder/results.log -e -o $tempResultsFolder/report/ -JperfmonReportPath=$tempResultsFolder -JaggregateReportPath=$tempResultsFolder -JsummaryReportPath=$tempResultsFolder -JgraphReportPath=$tempResultsFolder -JtableReportPath=$tempResultsFolder
mv $tempResultsFolder/ $resultsFolder/2-$SECOND_WORKER_HOST/


# echo "WAITING 100sec to systems up"
# sleep 3
# echo "3sec remaining"
# sleep 3

mkdir $tempResultsFolder/
echo "### STARTING 3 LOAD TESTING OF $THIRD_WORKER_HOST:$THIRD_WORKER_PORT###"
./bin/jmeter -Jjmeter.reportgenerator.overall_granularity=2000 -Jhostadress=$THIRD_WORKER_HOST -Jhostport=$THIRD_WORKER_PORT  -n -t ./test-scenarios/simple.jmx -l $tempResultsFolder/results.log -e -o $tempResultsFolder/report/ -JperfmonReportPath=$tempResultsFolder -JaggregateReportPath=$tempResultsFolder -JsummaryReportPath=$tempResultsFolder -JgraphReportPath=$tempResultsFolder -JtableReportPath=$tempResultsFolder
mv $tempResultsFolder/ $resultsFolder/3-$THIRD_WORKER_HOST/

echo "### LOAD TESTING FINISHED ###"

