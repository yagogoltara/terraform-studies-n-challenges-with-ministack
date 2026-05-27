# 🎯 Desafio SkyBank - Fase 3 (Avançado): Inversão de Controle e Abstração Total de Módulos

## 📋 Descrição do Cenário
O **SkyBank** está expandindo a sua plataforma e vai lançar um novo produto de Empréstimos (`loans`). Este novo sistema exige uma arquitetura de mensageria diferente do sistema de Pix, demandando filas SQS com tempos de retenção e comportamentos customizados.

Seu objetivo é refatorar o módulo de SQS criado anteriormente para transformá-lo em um componente de infraestrutura 100% genérico (estilo "Caixa Preta"). O módulo não deve mais conter loops internos ou regras de negócio; em vez disso, a **raiz do projeto** controlará os loops e ditará as regras de nomenclatura, consumindo o mesmo módulo para propósitos totalmente diferentes.

---

## 🛠️ Regras de Arquitetura (O que muda?)

1. **Inversão do `for_each`:**
   O meta-argumento `for_each` deve ser removido de dentro do módulo (`modules/sqs/main.tf`) e movido para a **raiz do projeto** (`./main.tf`), sendo declarado na chamada do bloco `module`.

2. **Módulo de Recurso Único (Single Resource Module):**
   O recurso `aws_sqs_queue` dentro do módulo deve criar apenas **uma** fila por chamada, utilizando um identificador genérico (sugestão: `this` ou `main`). Ele deve apenas aceitar o nome final e as tags totalmente processadas vindas de fora.

3. **Parametrização Dinâmica via Mapas de Objetos:**
   Para o sistema de Empréstimos, o Terraform deverá iterar sobre um mapa de objetos complexos, permitindo que cada fila gerada pelo mesmo bloco possua configurações técnicas distintas (como tempos de retenção diferentes).

---

## 🗂️ Requisitos por Arquivo (Lista de Tasks)

### 🧱 1. Submódulo SQS (`modules/sqs/`)
* [ ] **`main.tf`**: Remover o `for_each`. Alterar o nome interno do resource para `this`. Configurar os argumentos para lerem estritamente as variáveis locais do módulo.
* [ ] **`variables.tf`**: Simplificar as variáveis. O módulo deve solicitar apenas: `queue_name`, `delay_seconds`, `message_retention_seconds`, `max_message_size` e `tags`. Remover variáveis globais como `project_name` ou `environment` deste escopo.
* [ ] **`outputs.tf`**: Alterar para exportar apenas o ARN e a URL da fila individual gerada pelo recurso único (ex: `aws_sqs_queue.this.arn`).

### 🎛️ 2. Raiz do Projeto (`./`)
* [ ] **`variables.tf`**: Manter a lista de strings para o Pix, mas criar uma nova variável chamada `loans_queues_config`. O tipo dela deve ser um mapa de objetos: `map(object({ delay = number, retention = number }))`.
* [ ] **`terraform.tfvars`**: 
  * Popular a nova variável de empréstimos criando duas chaves: `analysis` e `disbursement`.
  * Definir tempos de retenção diferentes para cada uma delas (ex: 2 dias para análise e 5 dias para desembolso, convertidos para segundos).
* [ ] **`main.tf`**:
  * **Bloco do Pix**: Refatorar a chamada do módulo antigo para aplicar o `for_each = toset(...)` na raiz e passar o nome da fila já interpolado.
  * **Bloco de Empréstimos**: Criar uma nova chamada de módulo (`module "loans_queues"`) aplicando o `for_each` sobre o mapa de objetos configurado. Utilizar a herança de `each.key` para compor o nome e `each.value` para extrair os parâmetros técnicos.
* [ ] **`outputs.tf`**: Adaptar os outputs globais utilizando expressões `for` para mapear e exibir separadamente no terminal os ARNs das filas criadas pelo módulo do Pix e os ARNs criados pelo módulo de Empréstimos.

---

## 📦 Critérios de Aceitação e Entregáveis

O desafio será considerado concluído com sucesso quando:
1. O comando `terraform init` for executado para reestruturar os mapeamentos de módulos.
2. O comando `terraform plan` rodar sem erros de escopo (garantindo que o módulo não tente buscar variáveis locais inexistentes como `local.common_tags`).
3. O terminal exibir o output final organizando as filas de forma visual em blocos separados de chaves e valores.