MASTER_HOST=$1
MASTER_PORT=8080

WEBFLUX_MONGODB_HOST=$2
WEBFLUX_MONGODB_PORT=8081

BOOT_MYSQL_HOST=$3
BOOT_PORT=8082

WEBFLUX_MYSQL_HOST=$4
WEBFLUX_MYSQL_PORT=8083


hosts=($MASTER_HOST $WEBFLUX_MONGODB_HOST $BOOT_MYSQL_HOST $WEBFLUX_MYSQL_HOST)

echo "adding fingerprints"
for host in ${hosts[*]}
do
ssh-keyscan -H $host >> ~/.ssh/known_hosts
done

echo "set up servers"
for host in ${hosts[*]}
do
echo "configuring: $host"
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
ENDSSH

done

#run master metrics
echo "running master"
ssh -i "master-thesis.pem" ec2-user@$MASTER_HOST <<-ENDSSH
cd master-thesis
sudo WEBFLUX_MONGODB_HOST=$WEBFLUX_MONGODB_HOST BOOT_MYSQL_HOST=$BOOT_MYSQL_HOST WEBFLUX_MYSQL_HOST=$WEBFLUX_MYSQL_HOST docker-compose up master prometheus
ENDSSH

# run worker-boot-mysql
echo "running worker-boot-mysql"
ssh -i "master-thesis.pem" ec2-user@$BOOT_MYSQL_HOST <<-ENDWORKER
cd master-thesis
sudo MASTER_HOST=$MASTER_HOST BOOT_MYSQL_HOST=$BOOT_MYSQL_HOST docker-compose up -d worker-boot-mysql mysql
ENDWORKER

# run worker-webflux-mongodb
echo "running worker-webflux-mongodb"
ssh -i "master-thesis.pem" ec2-user@$WEBFLUX_MONGODB_HOST <<-ENDWORKER
cd master-thesis
sudo MASTER_HOST=$MASTER_HOST WEBFLUX_MONGODB_HOST=$WEBFLUX_MONGODB_HOST docker-compose up -d worker-webflux-mongodb mongodb 
ENDWORKER

# run worker-webflux-mysql
echo "running worker-webflux-mysql"
ssh -i "master-thesis.pem" ec2-user@$WEBFLUX_MYSQL_HOST <<-ENDWORKER
cd master-thesis
sudo MASTER_HOST=$MASTER_HOST WEBFLUX_MYSQL_HOST=$WEBFLUX_MYSQL_HOST docker-compose up -d worker-webflux-mysql webflux-mysql
ENDWORKER
#configure worker-webflux-mongodb

#run tests on master
echo "running master"
ssh -i "master-thesis.pem" ec2-user@$MASTER_HOST <<-ENDSSH
cd master-thesis
sudo WEBFLUX_MONGODB_HOST=$WEBFLUX_MONGODB_HOST BOOT_MYSQL_HOST=$BOOT_MYSQL_HOST WEBFLUX_MYSQL_HOST=$WEBFLUX_MYSQL_HOST docker-compose up jmeter
ENDSSH