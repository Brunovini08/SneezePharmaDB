# :pill: SneezePharma — Sistema de Gestão Farmacêutica (SSMS)
## :blue_book: Descrição do Projeto
O **SneezePharma** é um sistema de gestão completo para uma rede de farmácias, desenvolvido inteiramente em **SQL Server Management Studio (SSMS)**.
O projeto implementa a lógica de negócio exclusivamente com **tabelas, constraints e triggers**, sem uso de linguagens externas.
O sistema gerencia **clientes, fornecedores, princípios ativos, medicamentos, compras, vendas e manipulação de medicamentos**, garantindo integridade e automação via SQL.
---
## :jigsaw: Estrutura do Banco de Dados
O banco foi estruturado com **relacionamentos normalizados** e **regras de negócio automáticas**, garantindo integridade e consistência.
Principais módulos:
- :standing_person: **Clientes e Telefones**
- :factory: **Fornecedores**
- :alembic: **Princípios Ativos**
- :pill: **Medicamentos**
- :moneybag: **Compras e Vendas**
- :test_tube: **Produção (Manipulação)**
- :warning: **Clientes e Fornecedores Restritos**
---
## :card_index_dividers: Estrutura dos 5 Arquivos SQL
| Arquivo | Nome sugerido | Função principal |
|----------|----------------|------------------|
| **SneezePharma-Schema.sql** | Criação de todas as tabelas | Define a estrutura base do banco, chaves primárias e relacionamentos. |
| **SneezePharma-Triggers.sql** | Implementação de triggers | Automatiza regras de negócio (limite de itens, atualização de datas, bloqueio de exclusão física). |
| **SneezePharma-Procedure.sql** | Implementação de Procedure | Automatiza regras de negócio (bloqueio de exclusão física). |
| **SneezePharma-INSERTS.sql** | Inserção de dados iniciais *(este arquivo)* | Insere registros base para testes: situações, categorias, clientes, fornecedores, princípios ativos, etc. |
| **SneezePharma-SELECTS.sql** | Criação de views e relatórios | Gera relatórios como vendas por período, medicamentos mais vendidos e compras por fornecedor. |
---
## :gear: Regras de Negócio (via Triggers e Constraints)
- **Exclusão lógica:** registros apenas marcados como inativos (`Situacao = 'I'`).
- **Validação de idade:** clientes com mínimo de **18 anos**.
- **Tempo mínimo de empresa:** fornecedores com **2 anos de abertura**.
- **Limite de itens:**
  - Vendas → até **3 medicamentos por venda**
  - Compras → até **3 princípios ativos por compra**
- **Atualização automática:**
  - `UltimaCompra`, `UltimaVenda`, `UltimoFornecimento`
- **Bloqueios automáticos:**
  - Não permitir venda para cliente em restrição
  - Não permitir compra de fornecedor bloqueado
- **Controle de produção:**
  - Cada registro de manipulação contém **apenas 1 medicamento**
- **Proibição de DELETE físico** nas tabelas principais (somente `UPDATE Situacao`).
---
## :bricks: Tabelas Principais
```
Customers
Phones
Suppliers
Ingredients
Medicine
Purchases
PurchaseItem
Sales
SalesItems
Produce
ProduceItem
RestrictedCustomers
RestrictedSuppliers
Situation
Category
```
---
## :bar_chart: Relatórios Implementados
- :date: **Vendas por período**
- :pill: **Medicamentos mais vendidos**
- :receipt: **Compras por fornecedor**
- :gear: **Produção e consumo de princípios ativos**
---
## :hammer_and_wrench: Tecnologias e Recursos
- **SQL Server Management Studio (SSMS)**
- **T-SQL (Transact-SQL)**
- **Triggers, Procedures, Views e Constraints**
- **Chaves primárias, estrangeiras e exclusões lógicas**
- **Controle automatizado de integridade referencial**
---
## :rocket: Como Executar o Projeto
1. **Abra o SQL Server Management Studio (SSMS)** e conecte-se ao seu servidor SQL.
2. **Execute o arquivo de criação do banco e tabelas:**
   ```sql
   -- Criação do banco de dados e de todas as tabelas
   SneezePharma-Schema.sql
   ```
3. **Execute o arquivo de criação dos gatilhos (triggers):**
   ```sql
   -- Criação dos gatilhos responsáveis pelas regras de negócio
   SneezePharma-Triggers.sql
   ```
4. **Execute o arquivo de criação das procedures:**
   ```sql
   -- Criação das procedures utilizadas nas operações do sistema
   SneezePharma-Procedure.sql
   ```
5. **Execute o arquivo de inserção de dados iniciais:**
   ```sql
   -- Inserção de registros base (situações, categorias, clientes, fornecedores, etc.)
   SneezePharma-INSERTS.sql
   ```
6. **Execute o arquivo de consultas e relatórios:**
   ```sql
   -- Consultas de verificação e relatórios analíticos
   SneezePharma-SELECTS.sql
   ```
---
### :mag: Testes recomendados após execução
- **INSERT** em tabelas de vendas para validar o limite de **3 itens por venda**.
- **DELETE** em tabelas principais para confirmar bloqueio de exclusão física.
- **UPDATE** em vendas, compras e produções para verificar a atualização automática de datas.
- **EXEC** das procedures criadas para validar regras de negócio e geração de relatórios.
- **SELECT** nas views e consultas para checar os dados inseridos.
---
## Créditos:
**Projeto acadêmico desenvolvido em SQL Server Management Studio (SSMS)**
:date: Módulo: Banco de Dados Avançado
:busts_in_silhouette: Equipe: Grupo SneezePharma
:mortar_board: Orientação: Felipe — Módulo de C#/SQL
## Modelagem: Entidade-Relacionamento
**Link: https://excalidraw.com/#json=PxLWXQOKAN-N067z-aNab,2DfK4AzUoaSxnpImmLIkCA**
## Modelagem: Diagrama Relacional
**Link: https://www.drawdb.app/editor?shareId=4c3c4289bd15fe6d208c3cc8ab6c6dde**
