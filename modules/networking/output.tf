output "vpc" {
  value = module.vpc
}

output "vpc_id" {
  value = module.vpc.vpc_id  
}

output "sg_pub_id" {
  value = aws_security_group.allow_ssh_pub.id
}

output "sg_priv_id" {
  value = aws_security_group.allow_ssh_priv.id
}

output "sg_load_balancer" {
  value = aws_security_group.sg_load_balancer.id
}

output "public_subnet_1" {
  value = "${element(module.vpc.public_subnets, 0)}"
}

output "public_subnet_2" {
  value = "${element(module.vpc.public_subnets, 1)}"
}

