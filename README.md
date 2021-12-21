# Documentation Open Data Hub instance Deployment (ODH)
## Description

This module aims to deploy an instance of the ODH platform into an Openshift cluster

## Requirements

- AWS CLI (recommended for best practices), see [here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) to install AWS CLI
- Terraform version 1.1.0, see [here](https://learn.hashicorp.com/tutorials/terraform/install-cli) to install terraform
- One AWS account , see [here](https://aws.amazon.com/fr/premiumsupport/knowledge-center/create-and-activate-aws-account/) to create an AWS account.
- One RedHat Openshift account, see [here](https://sso.redhat.com/auth/realms/redhat-external/protocol/openid-connect/registrations?client_id=https%3A%2F%2Fwww.redhat.com%2Fwapps%2Fugc-oidc&redirect_uri=https%3A%2F%2Fwww.redhat.com%2Fwapps%2Fugc%2Fprotected%2Faccount.html&response_type=code&scope=openid) to create an RedHat Openshift account.
- Subscription to ROSA on AWS, see [here](https://aws.amazon.com/fr/rosa/) for more informations.
- An Openshift cluster 

## Usage 
```hcl
module "odh" {
  source         = "../"
  AWS_KEY_ID     = var.AWS_KEY_ID
  AWS_SECRET_KEY = var.AWS_SECRET_KEY
  REDHAT_TOKEN   = var.REDHAT_TOKEN
  tags           = var.tags
}
```
Go [here](example/variables.tf) for an example

## Module
This module use an internal module called terraform-aws-module-vpc that provision a vpc with one EC2 instance, the EC2 instance use [ROSA](https://aws.amazon.com/fr/rosa/) to access your openshift cluster on Redhat and deploy in an instance of ODH.

## Resources 
| Name | Type | 
|-------------|-----------------------|
|[aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/Instance)| resource |
|[aws_key_pair](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair)| resource |
|[file](https://www.terraform.io/docs/language/resources/provisioners/file.html) | provisioner |
|[remote-exec](https://www.terraform.io/docs/language/resources/provisioners/remote-exec.html) | provisioner |


## Inputs
| Name        | Description           | Type | Default | Required |
|-------------|-----------------------|------|---------|----------|
|AWS_KEY_ID   | Aws access key from env variable | ``string`` | | yes |
|AWS_SECRET_KEY | Aws secret key from env variable | ``string`` | | yes |
|REDHAT_TOKEN | Redhat token | ``string`` | | yes |
|ec2 | Configure EC2 instance | ``any`` | [See here](./variables.tf) | no |
|cluster_name | Openshift cluster name | ``string`` | "openshift-test" | no |
|tags | resources tags | ``map(any)`` | [See here](./variables.tf) | no |
|ssh_key_path | ssh key to access ec2 instance | ``string`` | "./keys/id_rsa" | no |
|aws_region | AWS region to deploy infra | ``string`` | "us-east-1" | no |
|odh_project_name | Name of the odh project to be create | ``string`` | "odh-project-test" | no |
|odh_project_display_name | Display name of the odh project to be create | ``string`` | "ODH" | no |
|odh_instance_name | Name of the odh instance to deploy | ``string`` | "opendatahub" | no |

## Outputs
| Name         | Description           |
|--------------|-----------------------|
|ec2_public_ip | EC2 PUBLIC IP         |


## Dependencies
This module has no externals dependencies yet

## Authors
Module is maintained by Nelson Gougou
