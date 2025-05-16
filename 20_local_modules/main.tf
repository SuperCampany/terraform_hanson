module "webserver" {
  source = "./modules/ec2"

  instance_type = var.instance_type
}
