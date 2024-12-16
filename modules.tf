module "ec2_network" {
  source         = "./modules/network"
  cidr_block     = var.cidr_block
  project_name   = var.project_name
  tags           = var.tags
  region         = var.region
  instance_count = var.instance_count

}