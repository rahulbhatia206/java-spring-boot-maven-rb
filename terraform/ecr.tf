#Create ECR

resource "aws_ecr_repository" "techverito-repo" {
  name = "${var.name}-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}