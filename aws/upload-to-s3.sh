#!/bin/bash
set -e

BUCKET="my-vhd-bucket"
FILE="custom-ubuntu.vhd"

echo "Creating S3 bucket..."
aws s3 mb s3://$BUCKET || true

echo "Uploading VHD to S3..."
aws s3 cp $FILE s3://$BUCKET/
