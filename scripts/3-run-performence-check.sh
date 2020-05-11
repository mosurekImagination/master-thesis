# echo "MASTER_HOST: $1"
MASTER_HOST=$1
MASTER_PORT=8080
MASTER_PRIVATE=$5

# echo "WEBFLUX_MONGODB_HOST: $2"
WEBFLUX_MONGODB_HOST=$2
WEBFLUX_MONGODB_PORT=8081
WEBFLUX_MONGODB_PRIVATE=$6

# echo "BOOT_MYSQL_HOST: $3"
BOOT_MYSQL_HOST=$3
BOOT_PORT=8082
BOOT_MYSQL_PRIVATE=$7

# echo "WEBFLUX_MYSQL_HOST: $4"
WEBFLUX_MYSQL_HOST=$4
WEBFLUX_MYSQL_PORT=8083
WEBFLUX_MYSQL_PRIVATE=$8

#logging settings
echo $dateTime | tee -a script.log 
echo "MASTER: $MASTER_HOST:$MASTER_PORT" | tee -a script.log 
echo "WEBFLUX_MONGODB: $WEBFLUX_MONGODB_HOST:$WEBFLUX_MONGODB_PORT" | tee -a script.log 
echo "BOOT_MYSQL: $BOOT_MYSQL_HOST:$BOOT_PORT" | tee -a script.log 
echo "WEBFLUX_MYSQL: $WEBFLUX_MYSQL_HOST:$WEBFLUX_MYSQL_PORT" | tee -a script.log 

echo "MASTER_PRIVATE: $MASTER_PRIVATE" | tee -a script.log 
echo "WEBFLUX_MONGODB_PRIVATE: $WEBFLUX_MONGODB_PRIVATE" | tee -a script.log 
echo "BOOT_MYSQL_PRIVATE: $BOOT_MYSQL_PRIVATE" | tee -a script.log 
echo "WEBFLUX_MYSQL_PRIVATE: $WEBFLUX_MYSQL_PRIVATE" | tee -a script.log 

sleep 10

hosts=($MASTER_HOST $WEBFLUX_MONGODB_HOST $BOOT_MYSQL_HOST $WEBFLUX_MYSQL_HOST)

echo "$(date +'%Y-%m-%d-%H:%M:%S') - adding fingerprints" | tee -a script.log 
for host in ${hosts[*]}
do
echo "$(date +'%Y-%m-%d-%H:%M:%S') - host: $host" | tee -a script.log 
ssh-keyscan -H $host >> ~/.ssh/known_hosts
done

echo "$(date +'%Y-%m-%d-%H:%M:%S') - setting up servers" | tee -a script.log 
for host in ${hosts[*]}
do
(
echo "$(date +'%Y-%m-%d-%H:%M:%S') - configuring: $host" | tee -a script.log 
ssh -i "master-thesis.pem" ec2-user@$host <<-'ENDSSH'

# One may need to remove the packages they installed using docker provided links
sudo rm /etc/yum.repos.d/docker-ce.repo

sudo yum update -y

# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# docker
sudo amazon-linux-extras install docker -y
sudo service docker start

# git and repo
sudo yum install git -y
git clone https://github.com/mosurekImagination/master-thesis.git
sudo find ./ -iname entrypoint.sh -type f -exec chmod +x {} \;
sudo find ./ -iname jmeter.sh -type f -exec chmod +x {} \;
sudo find ./ -iname startAgent.sh -type f -exec chmod +x {} \;
ENDSSH

echo "$(date +'%Y-%m-%d-%H:%M:%S') - configuration finished: $host" | tee -a script.log 
) &
done
wait

(
#run master metrics
echo "$(date +'%Y-%m-%d-%H:%M:%S') - running master core" | tee -a script.log 
ssh -i "master-thesis.pem" ec2-user@$MASTER_HOST <<-ENDSSH
cd master-thesis
sudo WEBFLUX_MONGODB_HOST=$WEBFLUX_MONGODB_PRIVATE BOOT_MYSQL_HOST=$BOOT_MYSQL_PRIVATE WEBFLUX_MYSQL_HOST=$WEBFLUX_MYSQL_PRIVATE docker-compose up -d master prometheus
ENDSSH
echo "$(date +'%Y-%m-%d-%H:%M:%S') - master core is running" | tee -a script.log 
) &

(
# run worker-boot-mysql
echo "$(date +'%Y-%m-%d-%H:%M:%S') - running worker-boot-mysql" | tee -a script.log 
ssh -i "master-thesis.pem" ec2-user@$BOOT_MYSQL_HOST <<-ENDWORKER
cd master-thesis
sudo MASTER_HOST=$MASTER_PRIVATE BOOT_MYSQL_HOST=$BOOT_MYSQL_HOST docker-compose up -d worker-boot-mysql mysql
ENDWORKER
echo "$(date +'%Y-%m-%d-%H:%M:%S') - worker-boot-mysql is running" | tee -a script.log 
) &

(
# run worker-webflux-mongodb
echo "$(date +'%Y-%m-%d-%H:%M:%S') - running worker-webflux-mongodb" | tee -a script.log 
ssh -i "master-thesis.pem" ec2-user@$WEBFLUX_MONGODB_HOST <<-ENDWORKER
cd master-thesis
sudo MASTER_HOST=$MASTER_PRIVATE WEBFLUX_MONGODB_HOST=$WEBFLUX_MONGODB_HOST docker-compose up -d worker-webflux-mongodb mongodb 
ENDWORKER
echo "$(date +'%Y-%m-%d-%H:%M:%S') - worker-webflux-mongodb is running" | tee -a script.log 
) &

(
# run worker-webflux-mysql
echo "$(date +'%Y-%m-%d-%H:%M:%S') - running worker-webflux-mysql" | tee -a script.log 
ssh -i "master-thesis.pem" ec2-user@$WEBFLUX_MYSQL_HOST <<-ENDWORKER
cd master-thesis
sudo MASTER_HOST=$MASTER_PRIVATE WEBFLUX_MYSQL_HOST=$WEBFLUX_MYSQL_HOST docker-compose up -d worker-webflux-mysql webflux-mysql
ENDWORKER
echo "$(date +'%Y-%m-%d-%H:%M:%S') - worker-webflux-mysql is running" | tee -a script.log 
) &

wait
#run tests on master
echo "$(date +'%Y-%m-%d-%H:%M:%S') - running master jmeter" | tee -a script.log 
ssh -i "master-thesis.pem" ec2-user@$MASTER_HOST <<-ENDSSH
cd master-thesis
sudo WEBFLUX_MONGODB_HOST=$WEBFLUX_MONGODB_PRIVATE BOOT_MYSQL_HOST=$BOOT_MYSQL_PRIVATE WEBFLUX_MYSQL_HOST=$WEBFLUX_MYSQL_PRIVATE docker-compose up jmeter
ENDSSH

echo "$(date +'%Y-%m-%d-%H:%M:%S') - testing finished" | tee -a script.log 