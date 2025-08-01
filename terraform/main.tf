provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "imported_vm" {
  ami           = "ami-xxxxxxxx" # Replace with AMI after import
  instance_type = "t2.medium"

  tags = {
    Name = "Imported-From-Azure"
  }
}
