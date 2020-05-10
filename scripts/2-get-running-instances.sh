aws ec2 describe-instances --filters "Name=instance-state-name,Values=running,Initializing" "Name=instance-type,Values=$1" --query "Reservations[*].Instances[*].[PublicDnsName]" --output text
