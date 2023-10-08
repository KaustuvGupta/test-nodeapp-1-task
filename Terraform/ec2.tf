resource "aws_key_pair" "TF_keypair" {
  key_name   = "TF_keypair"
  public_key = tls_private_key.private_key_rsa.public_key_openssh
}

resource "tls_private_key" "private_key_rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "TF_key"{
    content = tls_private_key.private_key_rsa.private_key_pem
    filename = "sshkeypair.pem"
}


module "ec2_instances1" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  #version = "3.5.0"
  count   = 1

  name = "Bastion"

  ami                    = "ami-053b0d53c279acc90"
  instance_type          = "t2.medium"
  key_name                  = "TF_keypair" #"ECS-EC2-KP"
  monitoring                =true
  vpc_security_group_ids = [aws_security_group.sg_bastion.id]
  subnet_id              = module.vpc.public_subnets[0]
  associate_public_ip_address   = "true"

  tags = {
    Environment = var.environment
    Project= var.project
    Assignment=var.assignment
    Name = "Bastion"
  }
}

module "ec2_instances2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  #version = "3.5.0"
  count   = 1

  name = "Jenkins"

  ami                    = "ami-053b0d53c279acc90"
  instance_type          = "t2.medium"
  key_name                  = "TF_keypair" #"ECS-EC2-KP"
  monitoring                =true
  vpc_security_group_ids = [aws_security_group.sg_private.id]
  subnet_id              = module.vpc.private_subnets[0]

  tags = {
    Environment = var.environment
    Project= var.project
    Assignment=var.assignment
    Name = "Jenkins"
  }
}

module "ec2_instances3" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  #version = "3.5.0"
  count   = 1

  name = "app"

  ami                    = "ami-053b0d53c279acc90"
  instance_type          = "t2.medium"
  key_name                  = "TF_keypair" #"ECS-EC2-KP"
  monitoring                =true
  vpc_security_group_ids = [aws_security_group.sg_private.id]
  subnet_id              = module.vpc.private_subnets[0]

  tags = {
    Environment = var.environment
    Project= var.project
    Assignment=var.assignment
    Name = "app"
  }
}