/* 
  Create an Elastic Beanstalk application
*/
resource "aws_elastic_beanstalk_application" "beanstalk_myapp" {
  name        = "myapp"
  description = "Golang application deployed with Terraform"
}

/* 
  Create an Elastic Beanstalk application version

  The bucket and key attributes are the S3 bucket and object created above
*/
resource "aws_elastic_beanstalk_application_version" "beanstalk_myapp_version" {
  application = aws_elastic_beanstalk_application.beanstalk_myapp.name
  bucket      = aws_s3_bucket.s3_bucket_myapp.id
  key         = aws_s3_object.s3_bucket_object_myapp.id
  name        = "myapp"
}

/* 
  Create an Elastic Beanstalk environment

  The application and version_label attributes are the application and version created above

  The solution_stack_name attribute is the platform to deploy the application to (Go 1)

  The settings attribute is a list of configuration options for the environment
*/
resource "aws_elastic_beanstalk_environment" "beanstalk_myapp_env" {
  name                = "myapp-prod"
  application         = aws_elastic_beanstalk_application.beanstalk_myapp.name
  solution_stack_name = var.language == "java" ? "64bit Amazon Linux 2 v3.4.8 running Corretto 17" : "64bit Amazon Linux 2 v3.7.3 running Go 1"
  version_label       = aws_elastic_beanstalk_application_version.beanstalk_myapp_version.name

  setting {
    name      = "SERVER_PORT"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = var.language == "java" ? "8000" : "8080"
  }

  setting {
    namespace = "aws:ec2:instances"
    name      = "InstanceTypes"
    value     = "t2.micro"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = aws_vpc.demo_vpc.id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = aws_subnet.demo_public_subnet.id
  }
}