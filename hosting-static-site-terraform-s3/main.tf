terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.72.1"
    }
      random = {
      source = "hashicorp/random"
      version = "3.6.3"
    }
    
  }
}

# Provider Configuration

provider "aws" {
    region ="us-east-1"
}

resource "random_id" "random-id" {
  byte_length = 8
  
}
# Bucket Creation
resource "aws_s3_bucket" "static_webapp_bucket" {
    bucket = "static-web-app-bucket-${random_id.random-id.hex}" # using the random name with random provider
  
}
# public access and configuration
resource "aws_s3_bucket_public_access_block" "webapp-public-access" {
  bucket = aws_s3_bucket.static_webapp_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "webapp-policy" {
  bucket = aws_s3_bucket.static_webapp_bucket.id
  policy = jsonencode(
    {
             Version = "2012-10-17",
             Id = "Policy1709736489815",
             Statement: [
                {
                    Sid = "Stmt1709736487808",
                    Effect = "Allow",
                    Principal = "*",
                    Action = "s3:GetObject",
                    Resource = "arn:aws:s3:::${aws_s3_bucket.static_webapp_bucket.id}/*"
                }
            ]
        }
        
  )
  
}

resource "aws_s3_bucket_website_configuration" "conf-webapp" {
  bucket = aws_s3_bucket.static_webapp_bucket.id

  index_document {
    suffix = "index.html"
  }
}

# File Uploads
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.static_webapp_bucket.bucket
  source = "./index.html"
  key = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "assets" {
  bucket = aws_s3_bucket.static_webapp_bucket.bucket
  source = "./style.css"
  key = "style.css"
  content_type = "text/css"
}


# website Endpoint
output "name" {
  value = aws_s3_bucket_website_configuration.conf-webapp.website_endpoint
  
}