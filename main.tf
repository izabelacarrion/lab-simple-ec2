module "lab-simple-ec2" {
  source    = "./modules"
  nome_ec2  = "izac-lab-simpleec2-${terraform.workspace}"
  chave_ssh = var.chave_ssh
}