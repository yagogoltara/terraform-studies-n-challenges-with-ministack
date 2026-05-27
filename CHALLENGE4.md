# 🎯 Desafio SkyBank - Fase 4: Descentralização de Estado e State Remoto

## 📋 Descrição do Desafio
Até este momento, o arquivo terraform.tfstate (o cérebro do Terraform que mapeia o código com os recursos reais) reside exclusivamente no disco rígido da sua máquina local. Em ambientes corporativos e times de DevOps, essa abordagem é inviável, pois impede o trabalho colaborativo, gera riscos severos de perda de dados e possibilita condições de corrida (duas pessoas aplicando alterações simultaneamente).

O objetivo desta fase final é migrar o estado da infraestrutura do SkyBank para um armazenamento centralizado e seguro (State Remoto) utilizando um Bucket S3 simulado no MiniStack.

---

## 🛠️ Regras de Arquitetura (O que muda?)

1. Imutabilidade de Variáveis no Bloco Backend:
   O bloco backend "s3" do Terraform possui uma limitação nativa de design: ele é avaliado antes do carregamento do core do Terraform. Portanto, ele não aceita variáveis (var.xxx) ou referências a locals. Toda a configuração deve ser declarada com valores fixos (hardcoded).

2. Isolamento de Estado (Key Path):
   O arquivo de estado deve ser armazenado dentro do bucket seguindo uma convenção de caminhos lógica (ex: dev/skybank.tfstate), permitindo que, no futuro, outros ambientes (como prod/skybank.tfstate) possam coexistir no mesmo bucket sem sobrescrever os dados uns dos outros.

3. Simulação de Ambiente Local (Bypass de Validação):
   Como o backend nativo do Terraform tentará se conectar aos endpoints reais da AWS global, propriedades específicas de bypass (como skip_credentials_validation e skip_metadata_api_check) e o redirecionamento de endpoints para o localhost:4566 devem ser rigorosamente configurados.

---

## 🚀 Guia de Execução Técnico (As Tasks)

### 🧱 Task 1: Identificação do Cofre (Bootstrapping)
* [ ] Escolha um dos buckets S3 que você já criou através do Terraform na Fase 1 (ex: skybank-bucket-configs-dev) para atuar como o repositório oficial do seu estado remoto.
* [ ] Nota Mental: No mundo real, os recursos de backend (Bucket S3 e Tabela DynamoDB) são criados previamente de forma manual ou através de um script separado de bootstrap, garantindo que eles já existam antes do comando de inicialização principal.

### 🎛️ Task 2: Configuração do Bloco Backend
* [ ] Abra o arquivo provider.tf na raiz do seu projeto.
* [ ] Adicione o bloco backend "s3" dentro do escopo do bloco inicial terraform {}.
* [ ] Configure os argumentos estáticos: bucket, key, region, access_key, secret_key e o bloco interno endpoints apontando para o S3 do MiniStack (http://localhost:4566).

### 🚚 Task 3: A Migração do Estado (A Prova de Fogo)
* [ ] Execute o comando de inicialização instruindo o Terraform a migrar o histórico:
  terraform init -migrate-state
* [ ] Analise as mensagens exibidas no terminal. O Terraform deve detectar a mudança do backend local para o remoto e perguntar se você deseja copiar os dados de estado existentes.
* [ ] Confirme a operação digitando yes.

### 🛡️ Task 4: Validação da Caixa Preta
* [ ] Após a migração bem-sucedida, mova o seu arquivo terraform.tfstate local antigo (e o arquivo .backup, se houver) para fora da pasta do projeto (ou delete-o temporariamente).
* [ ] Execute um terraform plan. O Terraform deve rodar perfeitamente, provando que ele buscou todo o histórico de infraestrutura de dentro do container do MiniStack, e não mais do seu computador.

---

## 📦 Critérios de Aceitação e Entregáveis

O desafio será considerado concluído com sucesso quando você retornar:

1. O código completo do seu arquivo provider.tf atualizado com o bloco de backend.
2. O log do terminal contendo a mensagem de sucesso do comando terraform init -migrate-state.
3. O resultado de um terraform plan subsequente, comprovando que o estado remoto está sincronizado e operando sem apontar nenhuma destruição ou recriação pendente de recursos.