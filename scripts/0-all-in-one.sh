dateTime="$(date +'%Y-%m-%d-%H:%M:%S')"
echo "New running $dateTime" | tee -a script.log 

# working m5.large
# c5.large

# # $0.17 per Hour
masterInstance=t2.large
# # $0.096 per Hour
workerInstance=t2.medium 

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

masterPrivate=$(sh ./5-get-private-dns.sh $masterInstance)
echo "$(date +'%Y-%m-%d-%H:%M:%S') - masterPrivate: $masterPrivate" | tee -a script.log 
workerPrivate=$(sh ./5-get-private-dns.sh $workerInstance | sed -e ':a' -e '$!{' -e 'N' -e 'ba' -e '}' -e 's/\n/ /g')
echo "$(date +'%Y-%m-%d-%H:%M:%S') - workerPrivate: $workerPrivate" | tee -a script.log 

# run performance test on instances
echo "$master $workers $masterPrivate $workerPrivate" | xargs ./3-run-performence-check.sh

echo "$(date +'%Y-%m-%d-%H:%M:%S') - terminate workers: $workers" | tee -a script.log 
./98-terminate-workers.sh $workerInstance

echo "$(date +'%Y-%m-%d-%H:%M:%S') - fetching results: $workers" | tee -a script.log 
./4-fetch-results.sh $master

echo "$(date +'%Y-%m-%d-%H:%M:%S') - terminate master: $master" | tee -a script.log 
./98-terminate-workers.sh $masterInstance

echo "THANK YOU FOR USING THIS 'FRAMEWORK' "
