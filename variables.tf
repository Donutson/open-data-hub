################# Secrets #########################
variable "AWS_KEY_ID" {
  type        = string
  description = "Aws access key from env variable "
}


variable "AWS_SECRET_KEY" {
  type        = string
  description = "Aws secret key from env variable "
}


variable "REDHAT_TOKEN" {
  type        = string
  description = "Redhat token"
}
################# Secrets #########################


################# EC2 #########################
variable "ec2" {
  type        = any
  description = "our ec2 instance info"

  default = {
    ami  = "ami-02e136e904f3da870"
    type = "t2.micro"

    connection = {
      type = "ssh"
      user = "ec2-user"
    }

    provisioners = {
      odh_instance = {
        source      = "manifests/odh-instance.yml"
        destination = "odh-instance.yml"
      }

      odh_sub = {
        source      = "manifests/odh-sub.yml"
        destination = "odh-sub.yml"
      }
    }
  }
}
################# EC2 #########################


################# Openshit cluster #########################
variable "cluster_name" {
  type        = string
  description = "Openshift cluster name"
  default     = "openshift-test"
}
################# Openshit cluster #########################


################# Tags #########################
variable "tags" {
  type        = map(any)
  description = "Define tags"
  default = {
    Application   = "odh"
    Environment = "test"
  }
}
################# Tags #########################


################# key #########################
variable "ssh_key_path" {
  type        = string
  description = "ssh key to access ec2 instance"
  default     = "./keys/id_rsa"
}
################# key #########################


################# terraform #########################
variable "aws_region" {
  type        = string
  description = "AWS region to deploy infra"
  default     = "us-east-1"
}
################# terraform #########################


################# ODH #########################
variable "odh_project_name" {
  type = string
  description = "Name of the odh project to be create"
  default = "odh-project-test"
}

variable "odh_project_display_name" {
  type = string
  description = "Display name of the odh project to be create"
  default = "ODH"
}


variable "odh_instance_name" {
  type = string
  description = "Name of the odh instance to deploy"
  default = "opendatahub"
}
################# ODH #########################