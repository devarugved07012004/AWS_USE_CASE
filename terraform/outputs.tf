output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.static_site.bucket
}

output "codebuild_project_name" {
  description = "The name of the CodeBuild project"
  value       = aws_codebuild_project.static_site_build.name
}

output "codepipeline_name" {
  description = "The name of the CodePipeline"
  value       = aws_codepipeline.static_site_pipeline.name
}
