variable "chave_ssh" {
  type        = string
  description = "Chave SSH de acesso ao ambiente"
}

variable "nome_ec2" {
  type        = string
  description = "Nome da instância EC2"
}

variable "bloco_ips_liberados" {
  type        = list(string)
  description = "Define os endereços de IP liberados"
}