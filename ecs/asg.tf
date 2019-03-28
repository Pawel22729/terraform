resource "aws_launch_template" "test" {
  name_prefix   = "test"
  image_id      = "ami-0380c676fcff67fd5"
  instance_type = "t2.micro"
}

resource "aws_launch_configuration" "test" {
  name          = "test"
  image_id      = "ami-0380c676fcff67fd5"
  instance_type = "t2.micro"
}
resource "aws_autoscaling_group" "test" {
  name                 = "terraform-asg-example"
  launch_configuration = "${aws_launch_configuration.test.name}"
  availability_zones = ["eu-west-2a"]
  min_size             = 1
  max_size             = 1
}
