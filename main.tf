locals {
  subnet1 = module.networking.public_subnet_1
  subnet2 = module.networking.public_subnet_2
  security_groups = module.networking.sg_load_balancer
}

module "networking" {
  source    = "./modules/networking"
  namespace = var.namespace
}

module "ssh-key" {
  source    = "./modules/ssh-key"
  namespace = var.namespace
}

module "ec2" {
  source     = "./modules/ec2"
  namespace  = var.namespace
  vpc        = module.networking.vpc
  sg_pub_id  = module.networking.sg_pub_id
  sg_priv_id = module.networking.sg_priv_id
  key_name   = module.ssh-key.key_name
}

resource "aws_lb" "alb" {
    name = "husain-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [local.security_groups]
    subnets = [
    "${local.subnet1}",
    "${local.subnet2}",
    ]

    enable_deletion_protection = true
    
    tags = {
        provisioner = "husain-tf"
    }
}

resource "aws_lb_target_group" "backend_tg" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  
  name     = "TG-backend-php"
  port     = 9000
  protocol = "HTTP"
  vpc_id   = "${module.networking.vpc_id}"
}

resource "aws_lb_target_group_attachment" "backend_tg_attach" {
  target_group_arn = "${aws_lb_target_group.backend_tg.arn}"
  target_id = module.ec2.private_instance_id
  port = 9000
}

resource "aws_alb_listener" "backend_listnener" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = "${aws_lb_target_group.backend_tg.arn}"
  }
}