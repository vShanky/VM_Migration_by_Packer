# VM_Migration_by_Packer
This repository provides scripts and automation to **migrate a custom Packer-built image from Microsoft Azure to Amazon Web Services (AWS).**

The process involves:

Exporting an Azure managed image to VHD
Downloading the VHD
Uploading it to AWS S3
Importing it as an AMI to launch EC2 instances

🚀 Features
✅ Automates Azure → AWS migration
✅ Includes Azure CLI and AWS CLI scripts
✅ IAM role creation for VM Import/Export
✅ Optional Terraform script to launch EC2 instance
✅ Optional Packer multi-cloud build (AWS & Azure)
✅ Image preparation script for AWS compatibility

📂 Project Structure

azure-to-aws-image-migration/
│── README.md
│── azure/
│   ├── export-image.sh          # Export managed image to VHD
│   ├── download-image.sh        # Download VHD locally
│── aws/
│   ├── upload-to-s3.sh          # Upload VHD to AWS S3
│   ├── create-vmimport-role.sh  # Create IAM role for import
│   ├── import-image.sh          # Import VHD as AMI
│   ├── containers.json          # Disk container config
│── scripts/
│   └── prepare-image.sh         # Prepare Azure image for AWS
│── terraform/
│   └── main.tf                  # Launch EC2 from imported AMI
│── packer/
│   └── multi-cloud.pkr.hcl      # Build images for Azure & AWS

🛠️ Prerequisites
Azure CLI
AWS CLI
Packer
Terraform (optional)
Proper Azure and AWS credentials configured

📜 Migration Steps
1️⃣ Export Azure Image
bash azure/export-image.sh
bash azure/download-image.sh

2️⃣ Upload to AWS
bash aws/upload-to-s3.sh
bash aws/create-vmimport-role.sh

3️⃣ Import VHD as AMI
bash aws/import-image.sh

Monitor progress:
aws ec2 describe-import-image-tasks

💻 Launch EC2 Instance (Optional)
After import completes, update the AMI ID in Terraform and deploy:
terraform -chdir=terraform init
terraform -chdir=terraform apply

🖼️ Architecture
<img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/f5f1ea5b-6cfd-46b9-ba83-5a4f4da0949d" />

⚠️ Notes
Ensure the Azure image is generalized before export.
Install AWS drivers (see scripts/prepare-image.sh).
Migration may take 20–90 minutes depending on VHD size.
Windows images require Sysprep before creating Azure managed image.
