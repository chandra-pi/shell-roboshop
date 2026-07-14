#!/bin/bash

AMI_ID="ami-0220d79f3f480ecf5"
SG_ID="sg-0beda789759f4ad50"  # replace it with your details
INSTANCES=("mongodb" "catalogue" "frontend")
ZONE_ID="Z0906595WCJPC66S1LJS"
DOMAIN_NAME="devaws84s.online"


for instance in ${INSTANCES[@]}
do
    INSTANCE_ID=$(aws ec2 run-instances --image-id ami-0220d79f3f480ecf5 --instance-type t2.micro 
    --security-group-ids sg-0beda789759f4ad50 --tag-specifications "ResourceType=instance,
    Tags=[{Key=Name, Value=$instance}]" --query "Instances[0].InstanceId" --output text)
    if [ $instance != "frontend"]
    then
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID 
        --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
    else
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID 
        --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
    fi
    echo "$instance equal to : $IP"
done

