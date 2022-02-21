variable "region" {
  description = "Deployment Region"
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "Given name in the credential file"
  type        = string
  default     = "default"
}

variable "shared_credentials_file" {
  description = "Profile file with credentials to the AWS account"
  type        = string
  default     = "C:/Users/Minion1/.aws/credentials"
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default = {
    application = "Learning-Test"
    env         = "Test"
  }
}