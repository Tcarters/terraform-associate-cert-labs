
provider "aws" {
  region = var.provider_region

}

module "vpc" {
  source              = "terraform-aws-modules/vpc/aws"
  version             = "6.2.0"

  name                = var.vpc_name
  cidr                = var.vpc_cidr

  azs                 = var.vpc_azs
  private_subnets     = var.vpc_private_subnets
  public_subnets      = var.vpc_public_subnets

  enable_nat_gateway  = var.vpc_enable_nat_gateway

  tags                = var.vpc_tags
}

module "ec2_instances" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "5.5.0"
  
  count                  = 2
  name                   = "${var.env_name}-ec2-cluster-${count.index}"

  ami                    = "ami-01b6d88af12965bb6"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = var.env_name 
  }
}

module "website_s3_bucket" {
    source      = "./modules/aws-s3-static-website-bucket"

    bucket_name = "${var.s3_bucket_name}-${var.env_name}"
  
    tags = {
        Terraform = "true"
        Environment = var.env_name
    }       
    
}