instances=$(aws ec2 describe-instances --filters Name=instance-state-name,Values=running --query "Reservations[*].Instances[*].[InstanceId]" --output text | grep -P "i")
aws ec2 terminate-instances --instance-ids $instances
