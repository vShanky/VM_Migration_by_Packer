#!/bin/bash
set -e

echo "Importing image to AWS AMI..."
aws ec2 import-image \
  --description "Imported Azure Image" \
  --disk-containers file://aws/containers.json

echo "Check progress with:"
echo "aws ec2 describe-import-image-tasks"
