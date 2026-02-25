#Procurando a AMI para uso na EC2
data "aws_ami" "amazon_linux" {
  most_recent = true       # Procura versao mais recente
  owners      = ["amazon"] # Qual é o dono dessa imagem, ID da Amazon


  filter {
    name   = "name" # Nome da AMI
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type" # Tipo de virtualizacao
    values = ["hvm"]
  }

}

# Criando instancia EC2
resource "aws_instance" "simple_ec2" {
  ami           = data.aws_ami.amazon_linux.id #Pega o ID da imagem
  instance_type = "t2.micro"

  # Adiciona IP publico dinâmico
  associate_public_ip_address = true

  # Adiciona Chave SSH
  key_name = var.chave_ssh

  # Criando nome do volume e tamanho do volume
  root_block_device {
    volume_size = 8
  }

  tags = {
    Name        = "izac-lab-simpleec2-${terraform.workspace}"
    Plataforma  = data.aws_ami.amazon_linux.platform_details
    Environment = terraform.workspace
  }

}