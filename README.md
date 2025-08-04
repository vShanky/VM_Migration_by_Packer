# VM Migration by Packer

This repository provides scripts and automation to **migrate a custom Packer-built image** from **Microsoft Azure** to **Amazon Web Services (AWS)**.

The migration process involves:
1. Exporting an Azure Managed Image to VHD  
2. Downloading the VHD  
3. Uploading the VHD to AWS S3  
4. Importing it as an AMI to launch EC2 instances  

---

## 🚀 Features

- ✅ Automates Azure → AWS VM migration  
- ✅ Includes ready-to-use Azure CLI and AWS CLI scripts  
- ✅ IAM role creation for AWS VM Import/Export  
- ✅ Optional Terraform script to automatically launch EC2 instances  
- ✅ Optional Packer template to build images for both Azure & AWS simultaneously  
- ✅ Image preparation script for AWS driver compatibility  

---

## 📂 Project Structure

```
VM_Migration_by_Packer/
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
```

---

## 🛠️ Prerequisites

- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)  
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)  
- [Packer](https://developer.hashicorp.com/packer)  
- [Terraform](https://developer.hashicorp.com/terraform) *(optional)*  
- Proper Azure and AWS credentials configured  

---

## 📜 Migration Steps

### **1️⃣ Export Azure Image**
```bash
bash azure/export-image.sh
bash azure/download-image.sh
```

### **2️⃣ Upload to AWS**
```bash
bash aws/upload-to-s3.sh
bash aws/create-vmimport-role.sh
```

### **3️⃣ Import VHD as AMI**
```bash
bash aws/import-image.sh
```

Monitor progress:
```bash
aws ec2 describe-import-image-tasks
```

---

## 💻 Launch EC2 Instance (Optional)

After AMI import is complete, update the AMI ID in Terraform and deploy:

```bash
terraform -chdir=terraform init
terraform -chdir=terraform apply
```

---

## 🖼️ Architecture

<img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/c652f0b3-5fdf-41bd-b8d9-38bda533ddce" />


---

## ⚠️ Notes

- Ensure the Azure image is **generalized** before export.  
- Install AWS drivers using `scripts/prepare-image.sh`.  
- Migration duration may take **20–90 minutes** depending on the image size.  
- Windows images require **Sysprep** before creating the Azure Managed Image.  

---

## 🤝 Contributing

Contributions, suggestions, and improvements are welcome! Please open an issue or submit a pull request.

---

## 📄 License

This project is licensed under the **MIT License**.
