variable "profile" {
  description = "user to declare profile"
  default = "default"
}
variable "region" {
  description = "user to declare region"
  default = "us-east-1"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "ami_id" {
    default = "ami-0ba0f49e823b50d7f"
}

variable "lob_dev" {
    default = "jenkins-Dev"
}
