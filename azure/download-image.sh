#!/bin/bash
set -e

STORAGE_ACCOUNT="mystorageacct"
CONTAINER_NAME="images"
BLOB_NAME="custom-ubuntu.vhd"

echo "Downloading image locally..."
az storage blob download \
  --account-name $STORAGE_ACCOUNT \
  --container-name $CONTAINER_NAME \
  --name $BLOB_NAME \
  --file $BLOB_NAME
