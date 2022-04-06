#!/usr/bin/env bash
TRUST="{   \"Version\": \"2012-10-17\",   \"Statement\": [     {       \"Effect\": \"Allow\",       \"Principal\": {         \"Service\": \"codebuild.amazonaws.com\"       },       \"Action\": \"sts:AssumeRole\"     }   ] }"

echo '{ "Version": "2012-10-17", "Statement": [ { "Effect": "Allow", "Action": "eks:Describe*", "Resource": "*" } ] }' > /tmp/iam-role-policy

aws iam create-role --role-name codebuild-gem-cpbe-build-service-role1 --assume-role-policy-document "$TRUST" --output text --query 'arn:aws:iam::947681381905:role/service-role/cpbe-role'

aws iam put-role-policy --role-name codebuild-gem-cpbe-build-service-role1 --policy-name eks-describe --policy-document file:///tmp/iam-role-policy

aws iam attach-role-policy --role-name codebuild-gem-cpbe-build-service-role1 --policy-arn arn:aws:iam::aws:policy/CloudWatchLogsFullAccess

aws iam attach-role-policy --role-name codebuild-gem-cpbe-build-service-role1 --policy-arn arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess

aws iam attach-role-policy --role-name codebuild-gem-cpbe-build-service-role1 --policy-arn arn:aws:iam::aws:policy/AWSCodeCommitFullAccess

aws iam attach-role-policy --role-name codebuild-gem-cpbe-build-service-role1 --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess

aws iam attach-role-policy --role-name codebuild-gem-cpbe-build-service-role1 --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess