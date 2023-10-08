module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs              = var.vpc_azs
  public_subnets   = var.vpc_public_subnets
  private_subnets  = var.vpc_private_subnets 

  enable_nat_gateway = true
  enable_vpn_gateway = false
  single_nat_gateway = true

  public_subnet_names   = var.vpc_public_subnet_name
  private_subnet_names  = var.vpc_private_subnet_name

  tags = {
    Environment = var.environment
    Project= var.project
    Assignment=var.assignment
  }
}


resource "aws_security_group" "sg_bastion" {
  name = "SG-Bastion"
  vpc_id = module.vpc.vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]  #[var.my_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Environment = var.environment
    Project= var.project
    Assignment=var.assignment
    Name = "SG-Bastion"
  }
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_security_group" "sg_public" {
  name = "SG-Public"
  vpc_id = module.vpc.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]  #[var.my_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Environment = var.environment
    Project= var.project
    Assignment=var.assignment
    Name = "SG-Public"
  }
}


resource "aws_security_group" "sg_private" {
  name = "SG-Private"
  vpc_id = module.vpc.vpc_id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Environment = var.environment
    Project= var.project
    Assignment=var.assignment
    Name = "SG-Private"
  }
}