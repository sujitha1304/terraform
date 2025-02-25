# main.tf

# Specify the provider (AWS)
provider "aws" {
  region = "var.region"  # You can change this to your preferred AWS region
}

# Create a security group to allow inbound SSH traffic (port 22)
resource "aws_security_group" "allow_ssh" {
  name_prefix = "allow_ssh_"
  description = "Allow SSH access"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (can be restricted)
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance
resource "aws_instance" "example" {
  ami           = "var.aws_ami"  # Replace with the AMI ID of your choice
  instance_type = "var.instancetype"             # You can choose any EC2 instance type

  # Specify the security group
  security_groups = [aws_security_group.allow_ssh.name]

  # Add tags to the instance
  tags = {
    Name = "MyTerraformInstance"
  }

  # Optional: Define the key pair to use for SSH access
  key_name = "var.aws_key"  # Replace with your key pair name
}