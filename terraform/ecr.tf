##################################################
# Frontend ECR Repository
##################################################

resource "aws_ecr_repository" "frontend" {

  name                 = "research-frontend"

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "research-frontend"
    Environment = "Development"
    Project     = var.project_name
  }
}

##################################################
# Backend ECR Repository
##################################################

resource "aws_ecr_repository" "backend" {

  name                 = "research-backend"

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "research-backend"
    Environment = "Development"
    Project     = var.project_name
  }
}