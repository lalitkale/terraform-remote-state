# terraform-remote-state

A Terraform module that configures an s3 bucket for use with Terraform's remote state feature.

Useful for creating a common bucket naming convention and attaching a bucket policy using the specified role.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| application | the application that will be using this remote state | string | - | yes |
| block\_public\_access | ensure bucket access is "Bucket and objects not public" | bool | `true` | no |
| multipart\_days |  | string | `3` | no |
| multipart\_delete | incomplete multipart upload deletion | string | `true` | no |
| role | the primary role that will be used to access the tf remote state | string | - | yes |
| additional\_roles | additional roles that will be granted access to the remote state | list of strings | \[] | no |
| tags | tags to apply the created S3 bucket | map | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| bucket | the created bucket |

## usage example

setup the remote state bucket

```hcl
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }
}

module "tf_remote_state" {
  source = "github.com/lalitkale/terraform-remote-state"

  role          = "aws-ent-prod-devops"
  application   = "my-test-app"

  tags = {
    team            = "my-team"
    "contact-email" = "my-team@my-company.com"
    application     = "my-app"
    environment     = "dev"
    customer        = "my-customer"
  }
}

output "bucket" {
  value = module.tf_remote_state.bucket
}
```

```bash
$ terraform init
$ terraform apply

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:
bucket = tf-state-my-test-app
```

Now configure your script to use the remote state bucket.  Note that you need to be logged in to the specified role in order to apply your scripts.

```hcl
terraform {
  backend "s3" {
    region  = "us-east-1"
    bucket  = "tf-state-my-test-app"
    key     = "dev.terraform.tfstate"
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tf_remote_state"></a> [tf\_remote\_state](#module\_tf\_remote\_state) | ./module | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->