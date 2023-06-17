/* 
  Create an S3 bucket access control list (ACL)
*/
# resource "aws_s3_bucket_acl" "s3_bucket_acl_myapp" {
#   bucket = "myapp-prod"
#   acl    = "private"
# }

/* 
  Create an S3 bucket to store the application version
*/
resource "aws_s3_bucket" "s3_bucket_myapp" {
  bucket = "myapp-prod-1234567890"
}

/* 
  Upload the application version to the S3 bucket
  
  The source attribute is the path to the application version
*/
resource "aws_s3_object" "s3_bucket_object_myapp" {
  bucket = aws_s3_bucket.s3_bucket_myapp.id
  key    = var.language == "java" ? "app.jar" : "app.go"
  source = var.language == "java" ? "./api/app.jar" : "./api/app.go"
}
