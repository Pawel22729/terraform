resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "network"
  subnets            = ["subnet-41d9d60c", "subnet-accc35d6"]
}

resource "aws_lb_listener" "test" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}

resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port = "80"
  protocol = "TCP"
  target_type = "instance"
  vpc_id   = "vpc-727bde1a"

  depends_on = [aws_lb.test]
}