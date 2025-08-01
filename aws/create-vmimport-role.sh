#!/bin/bash
set -e

ROLE_NAME="vmimport"

echo "Creating IAM role for VM Import..."
aws iam create-role --role-name $ROLE_NAME --assume-role-policy-document '{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Principal": {"Service": "vmie.amazonaws.com"},
    "Action": "sts:AssumeRole"
  }]
}' || echo "Role already exists."

echo "Attaching policy..."
aws iam put-role-policy \
  --role-name $ROLE_NAME \
  --policy-name vmimport \
  --policy-document '{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:GetBucketLocation", "s3:GetObject", "s3:ListBucket"],
      "Resource": [
        "arn:aws:s3:::my-vhd-bucket",
        "arn:aws:s3:::my-vhd-bucket/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": ["ec2:ModifySnapshotAttribute", "ec2:CopySnapshot", "ec2:RegisterImage", "ec2:Describe*"],
      "Resource": "*"
    }
  ]
}'
