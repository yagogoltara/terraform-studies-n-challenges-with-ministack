# 🎯 Desafio SkyBank - Fase 3: Modularização e Abstração de Infraestrutura

## 📋 Descrição do Desafio
Até o momento, a infraestrutura base do **SkyBank** (Buckets S3 e Filas SQS) foi desenvolvida de forma monolítica, onde todos os recursos estão declarados na raiz do projeto. Embora funcional, essa abordagem não escala no cenário real de Engenharia de Plataforma e DevOps, pois impede a reutilização segura de código por outros times ou subprojetos da organização.

O objetivo desta fase é realizar uma **refatoração arquitetural (refactoring)** completo do componente de mensageria, isolando a lógica de criação de filas SQS dentro de um **Módulo Local Reutilizável**.

---

## 🛠️ Regras de Arquitetura e Design

Para que o módulo seja considerado resiliente e reutilizável pelo mercado, ele deve seguir os seguintes princípios:

1. **Princípio da Caixa Preta (Abstração):**
   O código dentro da pasta do módulo (`modules/sqs/`) deve ser totalmente agnóstico. Ele **não deve conter referências diretas** a termos específicos do negócio atual, como `"skybank"`, `"pix"` ou `"dev"`. Ele deve apenas receber parâmetros genéricos e criar o recurso.

2. **Inversão de Dependência (Inputs):**
   Toda a inteligência de nomenclatura e concatenação de strings (ex: `${var.project_name}-${each.value}-${var.environment}`) deve permanecer no código da **raiz**. O valor já processado e pronto deve ser injetado como input para o módulo.

3. **Encapsulamento de Estado (Outputs):**
   O módulo deve expor explicitamente quais dados ele disponibiliza para o mundo externo através de seu próprio arquivo de outputs. A raiz do projeto deverá obrigatoriamente consumir esses dados de forma indireta.

---

## 🗂️ Estrutura de Diretórios Alvo

A árvore de arquivos do seu projeto deve refletir estritamente a estrutura abaixo após a refatoração:

```text
├── main.tf                 # Chamada dos Buckets S3 e invocação do Módulo SQS
├── providers.tf            # Configuração do Provider AWS e endpoints do MiniStack
├── terraform.tfvars        # Valores das variáveis globais
├── variables.tf            # Declaração das variáveis globais da raiz
├── outputs.tf              # Outputs finais exibidos no terminal do operador
├── README.md               # Esta documentação
└── modules/
    └── sqs/                # Diretório isolado do Módulo de SQS
        ├── main.tf         # Declaração pura e agnóstica do resource "aws_sqs_queue"
        ├── variables.tf    # Variáveis de entrada (inputs) necessárias para o módulo
        └── outputs.tf      # Dados de saída (outputs) que o módulo exporta
```