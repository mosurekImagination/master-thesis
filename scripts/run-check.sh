MASTER_HOST=$1
MASTER_PORT=8080

WEBFLUX_MONGODB_HOST=$2
WEBFLUX_MONGODB_PORT=8081

BOOT_MYSQL_HOST=$3
BOOT_PORT=8082

WEBFLUX_MYSQL_HOST=$4
WEBFLUX_MYSQL_PORT=8083

# hosts=($MASTER_HOST $WEBFLUX_MONGODB_HOST $BOOT_MYSQL_HOST $WEBFLUX_MYSQL_HOST)
hosts=($MASTER_HOST)
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
ENDSSH

done

#run master
ssh -i "master-thesis.pem" ec2-user@$MASTER_HOST <<-ENDSSH
cd master-thesis
sudo WEBFLUX_MONGODB_HOST=$WEBFLUX_MONGODB_HOST BOOT_MYSQL_HOST=$BOOT_MYSQL_HOST WEBFLUX_MYSQL_HOST=$WEBFLUX_MYSQL_HOST docker-compose up -d master prometheus jmeter
ENDSSH
