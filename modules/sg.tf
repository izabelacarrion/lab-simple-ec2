# Busca ID do SG padrao
data "aws_security_group" "sg_default" {
  name = "default"
}

# Cria uma regra de entrada para o meu endereço de IP

resource "aws_vpc_security_group_ingress_rule" "lib_meu_ssh" {
  for_each = toset(compact(split("\n", var.bloco_ips_liberados)))

  security_group_id = data.aws_security_group.sg_default.id
  cidr_ipv4         = trimspace(each.value)
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  description       = "Acesso SSH"
}