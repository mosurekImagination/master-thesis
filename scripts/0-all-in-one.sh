dateTime="$(date +'%Y-%m-%d-%H:%M:%S')"
echo "New running $dateTime" | tee -a script.log 

masterInstance=c5n.xlarge
workerInstance=c5n.large

./99-terminate-amazon-instances.sh

# initialize master
./1-run-amazon-instances.sh 1 $masterInstance

# # initialize workers
./1-run-amazon-instances.sh 3 $workerInstance

echo "$(date +'%Y-%m-%d-%H:%M:%S') - waiting 60 sec to get instances ready"
sleep 60

master=$(sh ./2-get-running-instances.sh $masterInstance)
echo "$(date +'%Y-%m-%d-%H:%M:%S') - master: $master" | tee -a script.log 

workers=$(sh ./2-get-running-instances.sh $workerInstance | sed -e ':a' -e '$!{' -e 'N' -e 'ba' -e '}' -e 's/\n/ /g')
echo "$(date +'%Y-%m-%d-%H:%M:%S') - workers: $workers" | tee -a script.log 

# run performance test on instances
echo "$master $workers" | xargs ./3-run-performence-check.sh

echo "$(date +'%Y-%m-%d-%H:%M:%S') - terminate workers: $workers" | tee -a script.log 
./98-terminate-workers.sh $workerInstance

echo "$(date +'%Y-%m-%d-%H:%M:%S') - fetching results: $workers" | tee -a script.log 
./4-fetch-results.sh $master

echo "$(date +'%Y-%m-%d-%H:%M:%S') - terminate master: $master" | tee -a script.log 
# ./98-terminate-workers.sh $masterInstance

echo "THANK YOU FOR USING THIS 'FRAMEWORK' "
