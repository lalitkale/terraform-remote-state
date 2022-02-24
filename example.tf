module "tf_remote_state" {
  source = "./module"
  role        = "AWSReservedSSO_ProjectPermissionSet_046ca60d08f56f83"
  application = "my-test-app"

  tags = {
    team            = "my-team"
    "contact-email" = "my-team@my-company.com"
    application     = "my-app"
    environment     = "dev"
    customer        = "my-customer"
  }
}
