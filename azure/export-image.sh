#!/bin/bash
set -e

RESOURCE_GROUP="packer-rg"
IMAGE_NAME="custom-ubuntu"
STORAGE_ACCOUNT="mystorageacct"
CONTAINER_NAME="images"

echo "Creating storage account..."
az storage account create \
  --name $STORAGE_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --location eastus \
  --sku Standard_LRS

echo "Creating container..."
az storage container create \
  --name $CONTAINER_NAME \
  --account-name $STORAGE_ACCOUNT

echo "Exporting Azure image..."
az image export \
  --resource-group $RESOURCE_GROUP \
  --name $IMAGE_NAME \
  --output vhd \
  --storage-uri "https://$STORAGE_ACCOUNT.blob.core.windows.net/$CONTAINER_NAME/$IMAGE_NAME.vhd"
