variable "chave_ssh" {
  description = "Nome da chave SSH que será passada para o módulo"
  type        = string
}

variable "bloco_ips_liberados" {
  type        = string
  description = "Define os endereços de IP liberados"
}