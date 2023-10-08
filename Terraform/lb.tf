resource "aws_lb_target_group" "alb-jenkins" {
  name        = "tf-example-lb-alb-tg"
  target_type = "alb"
  port        = 80
  protocol    = "TCP"
  vpc_id      = aws_vpc.main.id
}

resource "aws_elb" "jenkins_elb" {
        subnets    = module.vpc.public_subnets[*]
    cross_zone_load_balancing = true
    security_groups       = [aws_security_group.sg_public.id]
    instances             = module.ec2_instances2[*].id

    listener {
        instance_port     = 8080
        instance_protocol = "http"
        lb_port           = 80
        lb_protocol       = "http"
     }

     health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        target              = "TCP:8080"
        interval            = 5
    }

    tags = {
        Environment = var.environment
        Project= var.project
        Assignment=var.assignment
        Name = "jenkins_elb"
    }
 }