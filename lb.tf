resource "aws_lb" "alb" {
  name               = "mi-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [
    aws_subnet.subnet1.id,
    aws_subnet.subnet2.id
  ]
    tags = {
        Name = "mi-alb"
    }       
}   


resource "aws_lb_target_group" "tg" {
  name     = "mi-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.red_vpc.id

  tags = {
    Name = "mi-tg"
  }
}

resource "aws_lb_target_group_attachment" "ec2v1_attach" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.ec2v1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "ec2v2_attach" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.ec2v2.id
  port             = 80
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

output "alb_dns" {
  value = aws_lb.alb.dns_name
}