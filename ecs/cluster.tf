resource "aws_ecs_cluster" "test" {
  name = "test"
}

resource "aws_ecs_service" "test" {
  name            = "test"
  cluster         = aws_ecs_cluster.test.arn
  task_definition = aws_ecs_task_definition.test.arn
  desired_count   = 1

  launch_type = "EC2"

  load_balancer {
    target_group_arn = aws_lb_target_group.test.id
    container_name   = "hello_world"
    container_port = "80"
  }

}

resource "aws_ecs_task_definition" "test" {
  family                = "hello_world"
  container_definitions = file("service.json")
}

resource "aws_cloudwatch_log_group" "hello_world" {
  name              = "hello_world"
  retention_in_days = 1
}
