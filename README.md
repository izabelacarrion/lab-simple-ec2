# 🚀 AWS EC2 Terraform Lab: Staging vs Production

Este repositório contém um laboratório prático focado no provisionamento de infraestrutura como código (IaC) utilizando **Terraform** e automação via **GitHub Actions**. O objetivo é demonstrar o ciclo de vida de instâncias EC2 gerenciadas por **Workspaces** e protegidas por regras dinâmicas de segurança.



## 🛠️ Tecnologias Utilizadas

* **Cloud:** AWS (EC2, VPC, Security Groups)
* **IaC:** Terraform (v1.7.0+)
* **CI/CD:** GitHub Actions (OIDC Authentication)
* **Security Scan:** tfsec
* **Backend:** S3 para armazenamento de State e Lock (via DynamoDB/S3)

## 📂 Estrutura do Projeto

```text
.
├── .github/workflows/
│   ├── deploy.yml      # Pipeline de validação, scan e apply
│   └── destroy.yml     # Pipeline manual para destruição da infra
├── modules/            # Módulo reutilizável para o componente EC2
│   ├── main.tf         # Definição da instância e regras
│   ├── variables.tf    # Variáveis internas do módulo
│   └── sg.tf           # Gerenciamento de Security Group Rules
├── main.tf             # Chamada do módulo e Provedores
├── variables.tf        # Variáveis globais (Root)
└── backend.hcl         # Configuração de Backend (gerado dinamicamente)
```

## 🔐 Segurança e Variáveis

O projeto utiliza **GitHub Secrets** para gerenciar dados sensíveis.

Para rodar este laboratório, configure os seguintes secrets no repositório:

| Secret | Descrição | Exemplo |
|--------|------------|----------|
| `AWS_ROLE_ARN` | ARN da Role IAM configurada para OIDC | `arn:aws:iam::123456789012:role/github-oidc` |
| `BACKEND_CONFIG` | Parâmetros do Backend S3 | `bucket="meu-tf-state"`<br>`region="us-east-1"` |
| `IPS_PERMITIDOS` | Lista de IPs para acesso SSH (um por linha) | `192.168.x.x/32`<br>`172.16.x.x/32` |
| `CHAVE_STAG` | Nome da Key Pair AWS para o ambiente staging | `chave-staging` |
| `CHAVE_PROD` | Nome da Key Pair AWS para o ambiente production | `chave-production` |

---

### 📌 Observações Importantes

- Os IPs devem estar **um por linha** no Secret `IPS_PERMITIDOS`.
- O `BACKEND_CONFIG` é injetado dinamicamente no pipeline para configurar o backend remoto.
- A autenticação com a AWS é realizada via **OIDC**, evitando o uso de Access Keys fixas.

## 💡 Detalhes Técnicos

### 🔄 Workspaces Adaptáveis

O projeto utiliza lógica baseada em **branches** para alternar automaticamente entre ambientes via GitHub Actions.

Mapeamento de branches para workspaces:

- `staging` ➜ Workspace `stag`
- `production` ➜ Workspace `prod`

Essa abordagem garante:

- Isolamento lógico do **Terraform State**
- Separação de configurações por ambiente
- Deploy automatizado baseado na estratégia de branch

---
## ⚠️ Notas de Laboratório (Simplificação)

Neste projeto, as instâncias de ambos os ambientes compartilham o **Security Group Default da VPC**.

Em cenários reais de produção, recomenda-se:

- Criar **VPCs separadas por ambiente**
- Criar **Security Groups isolados por workspace**
- Aplicar políticas de menor privilégio (Principle of Least Privilege)

Isso evita conflitos de regras duplicadas e aumenta a segurança da arquitetura.

---

## 🎓 Contexto do Projeto

Este é um projeto de estudos focado em:

- Automação de infraestrutura (Infrastructure as Code)
- Boas práticas de CI/CD
- Segurança em nuvem
- Gerenciamento de ambientes com Workspaces

O objetivo é consolidar conhecimentos em **Terraform, AWS e GitHub Actions**, aplicando conceitos reais de mercado em um ambiente controlado de laboratório.

© 2026 - Desenvolvido por Izabela Carrion para fins de estudo em Cloud & DevOps.
