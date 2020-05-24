aws ec2 run-instances --image-id ami-0323c3dd2da7fb37d --count $1 --instance-type $2 --key-name master-thesis --security-group-ids sg-0d1c328afa970f9fd --output json

