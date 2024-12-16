
# Application Load Balancer (ALB)
resource "aws_lb" "web_server" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = module.ec2_network.subnet_ids # Subnets geradas pelo módulo de rede

  enable_deletion_protection = false
}

# Target Group para o ALB
resource "aws_lb_target_group" "web_server" {
  name        = "${var.project_name}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.ec2_network.vpc_id # VPC gerada pelo módulo de rede
  target_type = "instance"
}

# Listener para o ALB
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web_server.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_server.arn
  }
}

# Associação de todas as instâncias EC2 ao Target Group
resource "aws_lb_target_group_attachment" "web_server_attachment" {
  count            = var.instance_count
  target_group_arn = aws_lb_target_group.web_server.arn
  target_id        = aws_instance.web_server[count.index].id
  port             = 80
}
