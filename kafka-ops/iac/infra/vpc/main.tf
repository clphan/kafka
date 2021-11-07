locals {
  inter_subnet_list = {
    web1 = "172.32.0.0/28"
    web2 = "172.32.0.16/28"
    app1 = "172.32.0.32/28"
    app2 = "172.32.0.48/28"
    db1 = "172.32.0.64/28"
    db2 = "172.32.0.80/28"
  }
  exter_subnet_list = {
    dmz1 = "172.31.0.0/28"
    dmz2 = "172.31.0.16/28"
    mgmt = "172.31.0.32/28"
  }
}

resource "aws_vpc" "infra_vpc" {
  cidr_block          = var.vpc_cidr
  instance_tenancy    = "default"
  enable_dns_support  = true
  enable_dns_hostnames = true

  tags = {
    Name         = var.name
    Environment  = var.environment
    Project-code = var.project_code
  }
}

resource "aws_subnet" "subnets" {
  # for_earch = aws_vpc.infra_vpc.name != "internal_vpc" ?  local.exter_subnet_list : locals.inter_subnet_list
  for_earch = local.inter_subnet_list
  vpc_id = aws_vpc.infra_vpc.id
  availability_zone = "${var.region}a"
  cidr_block = each.value

  tags = {
    # Name = "subnet-${each.key}"
    Environment  = var.environment
    Project-code = var.project_code
  }
}