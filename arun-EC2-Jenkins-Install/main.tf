terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = var.profile
  region  = var.region
}

resource "aws_security_group" "ec2_public_security_group" {
  name = "EC2-Public-Arun"
  description = "Internet reaching access for EC2 Instances"
  vpc_id = "vpc-d161c1ac"

  ingress {
    from_port = 8080
    protocol = "TCP"
    to_port = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    protocol = "TCP"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }  
}

resource "aws_instance" "Jenkins_Ec2_app_server" {
  instance_type = var.instance_type
  ami = var.ami_id
  key_name = "Arun-Key-Pair-New"
  security_groups = ["${aws_security_group.ec2_public_security_group.name}"]
#  iam_instance_profile = ["${aws_iam_instance_profile.admin_profile.name}"]
  user_data = <<-EOF
    #!/bin/bash
    sudo yum -y update
    sudo amazon-linux-extras install -y java-openjdk11
    sudo /usr/sbin/alternatives --config java
    sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
    sudo amazon-linux-extras install epel -y
    sudo yum install -y jenkins
    sudo chkconfig jenkins on
    sudo service jenkins start
    sudo sleep 30
    sudo cd /usr/local/bin
    sudo yum -y install git
    sudo sleep 10
    sudo cd /usr/local/bin  
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
    sudo yum -y install terraform
    sudo terraform --version
  EOF

  tags = {
    Name = "Auto Jenkins Creation thru EC2"
    LOB = var.lob_dev
  }
}
