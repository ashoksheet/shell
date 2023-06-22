#!/bin/bash

#Get the root org ID
aws organizations list-roots > a.json
parent_id=$(grep -oP '(?<="Id": ")[^"]*' a.json)
rm a.json
echo $parent_id

#List the ORG details in root Organization
aws organizations list-organizational-units-for-parent --parent-id $parent_id

#User input for Region
echo Please provide the region
read region_input
region=${region_input}

#User input for ORG ARN
echo Please enter the Organization ARN to apply the Gurdrails
read org_arn
org=${org_arn}

#Gurdrails applying
aws controltower enable-control --control-identifier arn:aws:controltower:$region::control/AWS-GR_RESTRICT_ROOT_USER_ACCESS_KEYS --target-identifier $org --region $region
aws controltower enable-control --control-identifier arn:aws:controltower:$region::control/AWS-GR_RESTRICT_ROOT_USER --target-identifier $org --region $region
aws controltower enable-control --control-identifier arn:aws:controltower:$region::control/AWS-GR_ENCRYPTED_VOLUMES --target-identifier $org --region $region
aws controltower enable-control --control-identifier arn:aws:controltower:$region::control/AWS-GR_RESTRICTED_COMMON_PORTS --target-identifier $org --region $region
aws controltower enable-control --control-identifier arn:aws:controltower:$region::control/AWS-GR_RESTRICTED_SSH --target-identifier $org --region $region
aws controltower enable-control --control-identifier arn:aws:controltower:$region::control/AWS-GR_ROOT_ACCOUNT_MFA_ENABLED --target-identifier $org --region $region
aws controltower enable-control --control-identifier arn:aws:controltower:$region::control/AWS-GR_S3_BUCKET_PUBLIC_READ_PROHIBITED --target-identifier $org --region $region
echo script will continue after a minute 
sleep 60
aws controltower enable-control --control-identifier arn:aws:controltower:$region::control/AWS-GR_S3_BUCKET_PUBLIC_WRITE_PROHIBITED --target-identifier $org --region $region
aws controltower enable-control --control-identifier arn:aws:controltower:$region::control/AWS-GR_EC2_VOLUME_INUSE_CHECK --target-identifier $org --region $region
aws controltower enable-control --control-identifier arn:aws:controltower:$region::control/AWS-GR_EBS_OPTIMIZED_INSTANCE --target-identifier $org --region $region
aws controltower enable-control --control-identifier arn:aws:controltower:$region::control/AWS-GR_RDS_INSTANCE_PUBLIC_ACCESS_CHECK --target-identifier $org --region $region
aws controltower enable-control --control-identifier arn:aws:controltower:$region::control/AWS-GR_RDS_SNAPSHOTS_PUBLIC_PROHIBITED --target-identifier $org --region $region
aws controltower enable-control --control-identifier arn:aws:controltower:$region::control/AWS-GR_RDS_STORAGE_ENCRYPTED --target-identifier $org --region $region
aws controltower enable-control --control-identifier arn:aws:controltower:$region::control/AWS-GR_DETECT_CLOUDTRAIL_ENABLED_ON_MEMBER_ACCOUNTS --target-identifier $org --region $region

