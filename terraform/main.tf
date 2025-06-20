provider "aws" {
  region = "us-west-2"  # Replace with your desired AWS region
}

resource "aws_s3_bucket" "static_site" {
  bucket = "my-static-site-bucket"  # Replace with your desired S3 bucket name
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_iam_role" "codebuild_role" {
  name = "codebuild-service-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "codebuild.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_policy" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_codebuild_project" "static_site_build" {
  name          = "StaticSiteBuild"
  service_role  = aws_iam_role.codebuild_role.arn
  source {
    type      = "GITHUB"
    location  = "https://github.com/your-username/static-site"  # 🔁 Replace with your GitHub repo URL
  }
  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:5.0"
    type         = "LINUX_CONTAINER"
    environment_variables = [
      {
        name  = "S3_BUCKET"
        value = aws_s3_bucket.static_site.bucket
      }
    ]
  }
}

resource "aws_codepipeline" "static_site_pipeline" {
  name     = "StaticSitePipeline"
  role_arn = aws_iam_role.codebuild_role.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.static_site.bucket
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        Owner      = "your-github-username"       # 🔁 Replace with your GitHub username
        Repo       = "static-site"                # 🔁 Replace with your GitHub repo name
        Branch     = "main"
        OAuthToken = "your-github-oauth-token"    # 🔁 Replace with your GitHub OAuth token
      }
    }
  }

  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"
      configuration = {
        ProjectName = aws_codebuild_project.static_site_build.name
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "S3"
      input_artifacts = ["build_output"]
      version         = "1"
      configuration = {
        BucketName = aws_s3_bucket.static_site.bucket
        Extract    = "true"
      }
    }
  }
}
