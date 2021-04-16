#!/bin/bash
# Lists all the AWS resources linked to the vpc Id passed in as argument
# Assumed that the profile is passed as well

vpc=$1
if [ -z $vpc ]; then
  echo "vpc id is required"
  echo "usage: list-vpc vpc awsprofile"
  exit 99
fi

awsprofile=$2
if [ -z $awsprofile ]; then
  echo "aws profile is required"
  echo "usage: list-vpc vpc awsprofile"
  exit 99
fi

echo "Listing AWS resources for $vpc" 
aws ec2 describe-internet-gateways --profile $awsprofile --filters 'Name=attachment.vpc-id,Values='$vpc | grep InternetGatewayId
aws ec2 describe-subnets --profile $awsprofile --filters 'Name=vpc-id,Values='$vpc | grep SubnetId
aws ec2 describe-route-tables --profile $awsprofile --filters 'Name=vpc-id,Values='$vpc | grep RouteTableId
aws ec2 describe-network-acls --profile $awsprofile --filters 'Name=vpc-id,Values='$vpc | grep NetworkAclId
aws ec2 describe-vpc-peering-connections --profile $awsprofile --filters 'Name=requester-vpc-info.vpc-id,Values='$vpc | grep VpcPeeringConnectionId
aws ec2 describe-vpc-endpoints --profile $awsprofile --filters 'Name=vpc-id,Values='$vpc | grep VpcEndpointId
aws ec2 describe-nat-gateways --profile $awsprofile --filter 'Name=vpc-id,Values='$vpc | grep NatGatewayId
aws ec2 describe-security-groups --filters 'Name=vpc-id,Values='$vpc | grep GroupId
aws ec2 describe-instances --profile $awsprofile --filters 'Name=vpc-id,Values='$vpc | grep InstanceId
aws ec2 describe-vpn-connections --profile $awsprofile --filters 'Name=vpc-id,Values='$vpc | grep VpnConnectionId
aws ec2 describe-vpn-gateways --profile $awsprofile --filters 'Name=attachment.vpc-id,Values='$vpc | grep VpnGatewayId
aws ec2 describe-network-interfaces --profile $awsprofile --filters 'Name=vpc-id,Values='$vpc | grep NetworkInterfaceId
aws iam list-instance-profiles --profile $awsprofile
aws elbv2 describe-target-groups --profile $awsprofile
exit 0
