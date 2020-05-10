# initialize master
./1-run-amazon-instances.sh 1 t2.large

# initialize workers
./1-run-amazon-instances.sh 3 t2.medium

echo "waiting 60 sec to get instances ready"
sleep 60

master=$(sh ./2-get-running-instances.sh "t2.large" | sed -e ':a' -e '$!{' -e 'N' -e 'ba' -e '}' -e 's/\n/ /g')
echo "master: $master"

workers=$(sh ./2-get-running-instances.sh "t2.medium" | tr {} ' ')
echo "workers: $workers"

# run performance test on instances
echo "$master $workers" | xargs ./3-run-performence-check.sh

./99-terminate-amazon-instances.sh