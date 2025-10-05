


module "vpc" {
    source              = "terraform-aws-modules/vpc/aws"
    version             = "5.8.1"

    cidr                = var.vpc_cidr_block

    azs                 = data.aws_availability_zones.available.names
    private_subnets     = slice(var.private_subnet_cidr_blocks, 0, 2)
    public_subnets      = slice(var.public_subnet_cidr_blocks, 0, 2)

    enable_nat_gateway  = false
    enable_vpn_gateway  = false
}

module "app_security_group" {
    source              = "terraform-aws-modules/security-group/aws//modules/web"
    version             = "5.1.2"

    name                = "web-server-sg"
    description         = "Security group for web-servers with HTTP ports open within VPC"
    vpc_id              = module.vpc.vpc_id

    ingress_cidr_blocks = module.vpc.public_subnets_cidr_blocks
}

module "lb_security_group" {
    source              = "terraform-aws-modules/security-group/aws//modules/web"
    version             = "5.1.2"

    name                = "lb-sg-project-alpha-${var.env_name}"
    description         = "Security group for load balancer with HTTP ports open within VPC"
    vpc_id              = module.vpc.vpc_id

    ingress_cidr_blocks = ["0.0.0.0/0"]
}


module "elb_http" {
  source  = "terraform-aws-modules/elb/aws"
  version = "4.0.2"

  # Ensure load balancer name is unique
  name = "lb-${random_string.lb_id.result}-project-alpha-dev"

  internal = false

  security_groups = [module.lb_security_group.security_group_id]
  subnets         = module.vpc.public_subnets

  number_of_instances = length(module.ec2_instances.instance_ids)
  instances           = module.ec2_instances.instance_ids

  listener = [{
    instance_port     = "80"
    instance_protocol = "HTTP"
    lb_port           = "80"
    lb_protocol       = "HTTP"
  }]

  health_check = {
    target              = "HTTP:80/index.html"
    interval            = 10
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
  }
}

module "ec2_instances" {
    source              = "./modules/aws-instance"

    instance_count      = var.instances_per_subnet * length(module.vpc.private_subnets)
    instance_type       = var.instance_type
    subnet_ids          = module.vpc.private_subnets[*]
    security_group_ids  = [module.app_security_group.security_group_id]
}

