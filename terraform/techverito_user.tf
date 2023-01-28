#Create User for Techverito project

data "aws_caller_identity" "current"{

}

#Create Iam User
resource "aws_iam_user" "techverito_iam" {
  name = "${var.name}-user"
  tags = var.tags
}

#Create Key
resource "aws_iam_access_key" "techverito_key" {
  user = aws_iam_user.techverito_iam.name

  depends_on = [
  aws_iam_user.techverito_iam
  ]
}

data "aws_iam_policy_document" "user_policy"{
  statement {
    effect = "Allow"
    actions = [
      "ecr:PutLifecyclePolicy",
      "ecr:PutImageTagMutability",
      "ecr:DescribeImageScanFindings",
      "ecr:StartImageScan",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:GetDownloadUrlForLayer",
      "ecr:ListTagsForResource",
      "ecr:UploadLayerPart",
      "ecr:ListImages",
      "ecr:PutImage",
      "ecr:UntagResource",
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
      "ecr:TagResource",
      "ecr:DescribeRepositories",
      "ecr:StartLifecyclePolicyPreview",
      "ecr:InitiateLayerUpload",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetRepositoryPolicy",
      "ecr:GetLifecyclePolicy",
      "ecr:GetAuthorizationToken",
      "ecr:CompleteLayerUpload"
    ]
    resources = [aws_ecr_repository.techverito-repo.arn]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability"
    ]
    resources = ["*"]
  }
}

# Create Policy from document
resource "aws_iam_user_policy" "techverito-policy" {
  name = "${var.name}-policy"
  policy = data.aws_iam_policy_document.user_policy.json
  user   = aws_iam_user.techverito_iam.name
}