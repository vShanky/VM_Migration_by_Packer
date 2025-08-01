packer {
  required_plugins {
    azure = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/azure"
    }
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "azure-arm" "azure-ubuntu" {
  subscription_id  = "<your-subscription-id>"
  client_id        = "<your-sp-id>"
  client_secret    = "<your-sp-password>"
  tenant_id        = "<your-tenant-id>"
  managed_image_resource_group_name = "packer-rg"
  managed_image_name                = "custom-ubuntu"
  managed_image_location            = "eastus"
  os_type         = "Linux"
  image_publisher = "Canonical"
  image_offer     = "UbuntuServer"
  image_sku       = "18.04-LTS"
  location        = "eastus"
  vm_size         = "Standard_B1s"
}

source "amazon-ebs" "aws-ubuntu" {
  region     = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-18.04*"
      virtualization-type = "hvm"
      root-device-type     = "ebs"
    }
    owners      = ["099720109477"]
    most_recent = true
  }
  instance_type = "t2.micro"
  ssh_username  = "ubuntu"
  ami_name      = "custom-ubuntu-aws"
}

build {
  sources = ["source.azure-arm.azure-ubuntu", "source.amazon-ebs.aws-ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo systemctl enable nginx"
    ]
  }
}
