resource "aws_ecs_cluster" "techverito-ecs-cluster" {
  name = "${var.name}-ecs-cluster-3"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

#module "ecs-fargate" {
#  source  = "umotif-public/ecs-fargate/aws"
#  version = "~> 6.1.0"
#
#  name_prefix        = "techverito-ecs-service-2"
#  vpc_id             = aws_vpc.ecs_vpc.id
#  private_subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
#
#  cluster_id = aws_ecs_cluster.techverito-ecs-cluster.id
#
#  task_container_image   = "136052446758.dkr.ecr.us-east-2.amazonaws.com/techverito:latest"
#  task_definition_cpu    = 256
#  task_definition_memory = 512
#
#  task_container_port             = 80
#  task_container_assign_public_ip = true
#
#  load_balanced = false
#
#  target_groups = [
#    {
#      target_group_name = "tg-fargate-example"
#      container_port    = 80
#    }
#  ]
#
#  health_check = {
#    port = "traffic-port"
#    path = "/"
#  }
#
#  tags = var.tags
#}


# update file container-def, so it's pulling image from ecr
resource "aws_ecs_task_definition" "techverito-task-definition-3" {
  family                = "techverito-taskdef-3"
  container_definitions = file("container-definitions/container-def.json")
  tags = var.tags
}

resource "aws_ecs_service" "service" {
  name            = "web-service"
  cluster         = aws_ecs_cluster.techverito-ecs-cluster.id
  task_definition = aws_ecs_task_definition.techverito-task-definition-3.arn
  desired_count   = 10
  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  # Optional: Allow external changes without Terraform plan difference(for example ASG)
  lifecycle {
    ignore_changes = [desired_count]
  }
}

data "aws_ecs_container_definition" "techverito-ecs-container" {
  task_definition = aws_ecs_task_definition.techverito-task-definition-3.id
  container_name  = "techverito-container-3"
}

