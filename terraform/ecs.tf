resource "aws_ecs_cluster" "altir-ecs-cluster" {
  name = "${var.name}-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_ecs_task_definition" "altir-task-definition" {
  family                = "${var.name}-ecs"
  container_definitions = file("container-definitions/container-def.json")
  tags = var.tags
}

resource "aws_ecs_service" "service" {
  name            = "${var.name}-ecs-service"
  cluster         = aws_ecs_cluster.altir-ecs-cluster.id
  task_definition = aws_ecs_task_definition.altir-task-definition.arn
  desired_count   = 10

  # Optional: Allow external changes without Terraform plan difference(for example ASG)
  lifecycle {
    ignore_changes = [desired_count]
  }
}

