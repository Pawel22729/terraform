resource "aws_launch_configuration" "test" {
  name          = "test"
  image_id      = "ami-0376206bb575c76dd"
  instance_type = "t3.small"
  iam_instance_profile = "ecsInstanceRole"
  user_data = <<EOF
      #!/bin/bash
      echo ECS_CLUSTER=test >> /etc/ecs/ecs.config
      EOF
}
resource "aws_autoscaling_group" "test" {
  name                 = "terraform-asg-example"
  launch_configuration = "${aws_launch_configuration.test.name}"
  availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  min_size             = 1
  max_size             = 1
}
