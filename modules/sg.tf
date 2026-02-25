# 1. Descobre automaticamente o IP público atual
data "http" "meu_end_ip" {
  url = "https://checkip.amazonaws.com/"
}


# Busca ID do SG padrao
data "aws_security_group" "sg_default" {
  name = "default"
}

# Cria uma regra de entrada para o meu endereço de IP

resource "aws_vpc_security_group_ingress_rule" "lib_meu_ssh" {
  security_group_id = data.aws_security_group.sg_default.id
  cidr_ipv4         = "${chomp(data.http.meu_end_ip.response_body)}/32"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  description       = "Acesso SSH"
}