#!/usr/bin/env sh

#set Poland localTime
echo "setting Poland timeZone"
cp /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
echo "Europe/Warsaw" >  /etc/timezone
apk del tzdata

echo "WAITING 100sec to systems up"
sleep 3
echo "3sec remaining"
sleep 3

dateTime=$(date +'%Y-%m-%d-%H.%M')
echo $dateTime
echo "### $dateTime STARTING 1 LOAD TESTING OF $FIRST_WORKER_HOST:$FIRST_WORKER_PORT ###"
resultsFolder=./test-results/$dateTime
tempResultsFolder=./temp-test-results #perfmon report is hardcoded to /temp-test-results/perfmon.csv, due to not resolving variables
mkdir $resultsFolder

mkdir $tempResultsFolder/
./bin/jmeter -JforcePerfmonFile=true -Jhostadress=$FIRST_WORKER_HOST -Jhostport=$FIRST_WORKER_PORT  -n -t ./test-scenarios/simple.jmx -l $tempResultsFolder/results.log -e -o $tempResultsFolder/raport/ -JperfmonReportPath=$tempResultsFolder/perfmon.csv -JaggregateReportPath=$tempResultsFolder/aggregateReport.csv -JsummaryReportPath=$tempResultsFolder/summaryReport.csv -JgraphReportPath=$tempResultsFolder/graphReport.csv -JtableReportPath=$tempResultsFolder/graphReport.csv
mv $tempResultsFolder/ $resultsFolder/1-$FIRST_WORKER_HOST/

echo "WAITING 100sec to systems up"
sleep 3
echo "3sec remaining"
sleep 3

mkdir $tempResultsFolder/
echo "### STARTING 2 LOAD TESTING OF $SECOND_WORKER_HOST:$SECOND_WORKER_PORT###"
./bin/jmeter -Jhostadress=$SECOND_WORKER_HOST -Jhostport=$SECOND_WORKER_PORT  -n -t ./test-scenarios/simple.jmx -l $tempResultsFolder/results.log -e -o $tempResultsFolder/raport/ -JperfmonReportPath=$tempResultsFolder/perfmon.csv -JaggregateReportPath=$tempResultsFolder/aggregateReport.csv -JsummaryReportPath=$tempResultsFolder/summaryReport.csv -JgraphReportPath=$tempResultsFolder/graphReport.csv -JtableReportPath=$tempResultsFolder/graphReport.csv
mv $tempResultsFolder/ $resultsFolder/2-$SECOND_WORKER_HOST/


echo "WAITING 100sec to systems up"
sleep 3
echo "3sec remaining"
sleep 3

mkdir $tempResultsFolder/
echo "### STARTING 3 LOAD TESTING OF $THIRD_WORKER_HOST:$THIRD_WORKER_PORT###"
./bin/jmeter -Jhostadress=$THIRD_WORKER_HOST -Jhostport=$THIRD_WORKER_PORT  -n -t ./test-scenarios/simple.jmx -l $tempResultsFolder/results.log -e -o $tempResultsFolder/raport/ -JperfmonReportPath=$tempResultsFolder/perfmon.csv -JaggregateReportPath=$tempResultsFolder/aggregateReport.csv -JsummaryReportPath=$tempResultsFolder/summaryReport.csv -JgraphReportPath=$tempResultsFolder/graphReport.csv -JtableReportPath=$tempResultsFolder/graphReport.csv
mv $tempResultsFolder/ $resultsFolder/3-$THIRD_WORKER_HOST/

echo "### LOAD TESTING FINISHED ###"

