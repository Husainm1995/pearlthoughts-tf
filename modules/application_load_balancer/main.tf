resource "aws_lb" "alb" {
    name = "husain-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [var.security_groups]
    subnets = [var.subnets]

    enable_deletion_protection = true
    
    tags = {
        provisioner = "husain-tf"
    }
}