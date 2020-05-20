#!/usr/bin/env sh

#set Poland localTime
echo "setting Poland timeZone"
cp /usr/share/zoneinfo/Europe/Warsaw /etc/localtime -f
echo "Europe/Warsaw" >  /etc/timezone

echo "### CREATING RESULTS DIRECTORY ###"
dateTime="$(date +'%Y-%m-%d--%H-%M-%S')"
echo $dateTime
resultsFolder=./test-results/$dateTime
tempResultsFolder=./temp-test-results
mkdir $resultsFolder

FIRST_WORKER_RESULTS=$resultsFolder/1-$FIRST_WORKER_HOST/
SECOND_WORKER_RESULTS=$resultsFolder/2-$SECOND_WORKER_HOST/
THIRD_WORKER_RESULTS=$resultsFolder/3-$THIRD_WORKER_HOST/
FOURTH_WORKER_RESULTS=$resultsFolder/4-$FOURTH_WORKER_HOST/

mkdir $FIRST_WORKER_RESULTS
mkdir $SECOND_WORKER_RESULTS
mkdir $THIRD_WORKER_RESULTS
mkdir $FOURTH_WORKER_RESULTS

# # (
# echo "### $dateTime STARTING 1 LOAD TESTING OF $FIRST_WORKER_HOST:$FIRST_WORKER_PORT ###"
# JVM_ARGS="-Xms1024m -Xmx2048m" ./bin/jmeter.sh -Jjmeter.reportgenerator.overall_granularity=2000 -Jhostadress=$FIRST_WORKER_HOST -Jhostport=$FIRST_WORKER_PORT  -n -t ./test-scenarios/simple.jmx -l $FIRST_WORKER_RESULTS/results.log -e -o $FIRST_WORKER_RESULTS/report/ -JperfmonReportPath=$FIRST_WORKER_RESULTS -JaggregateReportPath=$FIRST_WORKER_RESULTS -JsummaryReportPath=$FIRST_WORKER_RESULTS -JgraphReportPath=$FIRST_WORKER_RESULTS -JtableReportPath=$FIRST_WORKER_RESULTS
# echo "### $dateTime FINISHED 1 LOAD TESTING OF $FIRST_WORKER_HOST:$FIRST_WORKER_PORT ###"
# # )&

# # # (
# echo "### STARTING 2 LOAD TESTING OF $SECOND_WORKER_HOST:$SECOND_WORKER_PORT###"
# JVM_ARGS="-Xms1024m -Xmx2048m" ./bin/jmeter.sh -Jjmeter.reportgenerator.overall_granularity=2000 -Jhostadress=$SECOND_WORKER_HOST -Jhostport=$SECOND_WORKER_PORT  -n -t ./test-scenarios/simple.jmx -l $SECOND_WORKER_RESULTS/results.log -e -o $SECOND_WORKER_RESULTS/report/ -JperfmonReportPath=$SECOND_WORKER_RESULTS -JaggregateReportPath=$SECOND_WORKER_RESULTS -JsummaryReportPath=$SECOND_WORKER_RESULTS -JgraphReportPath=$SECOND_WORKER_RESULTS -JtableReportPath=$SECOND_WORKER_RESULTS
# echo "### FINISHED 2 LOAD TESTING OF $SECOND_WORKER_HOST:$SECOND_WORKER_PORT###"
# # # )&

# # # (
# echo "### STARTING 3 LOAD TESTING OF $THIRD_WORKER_HOST:$THIRD_WORKER_PORT###"
# JVM_ARGS="-Xms1024m -Xmx2048m" ./bin/jmeter.sh -Jjmeter.reportgenerator.overall_granularity=2000 -Jhostadress=$THIRD_WORKER_HOST -Jhostport=$THIRD_WORKER_PORT  -n -t ./test-scenarios/simple.jmx -l $THIRD_WORKER_RESULTS/results.log -e -o $THIRD_WORKER_RESULTS/report/ -JperfmonReportPath=$THIRD_WORKER_RESULTS -JaggregateReportPath=$THIRD_WORKER_RESULTS -JsummaryReportPath=$THIRD_WORKER_RESULTS -JgraphReportPath=$THIRD_WORKER_RESULTS -JtableReportPath=$THIRD_WORKER_RESULTS
# echo "### FINISHED 3 LOAD TESTING OF $THIRD_WORKER_HOST:$THIRD_WORKER_PORT###"
# # ) &

# # (
echo "### STARTING 4 LOAD TESTING OF $FOURTH_WORKER_HOST:$FOURTH_WORKER_PORT###"
JVM_ARGS="-Xms1024m -Xmx2048m" ./bin/jmeter.sh -Jjmeter.reportgenerator.overall_granularity=2000 -Jhostadress=$FOURTH_WORKER_HOST -Jhostport=$FOURTH_WORKER_PORT  -n -t ./test-scenarios/simple.jmx -l $FOURTH_WORKER_RESULTS/results.log -e -o $FOURTH_WORKER_RESULTS/report/ -JperfmonReportPath=$FOURTH_WORKER_RESULTS -JaggregateReportPath=$FOURTH_WORKER_RESULTS -JsummaryReportPath=$FOURTH_WORKER_RESULTS -JgraphReportPath=$FOURTH_WORKER_RESULTS -JtableReportPath=$FOURTH_WORKER_RESULTS
echo "### FINISHED 4 LOAD TESTING OF $FOURTH_WORKER_HOST:$FOURTH_WORKER_PORT###"
# # ) &

# wait 
# trap : TERM INT # prevent script bash from closing
# tail -f /dev/null & wait

