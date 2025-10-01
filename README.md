## 🐾Sistema de Gerenciamento de Clínica Veterinária (BD_Petcare)

Este projeto consiste em um sistema de gerenciamento para uma clínica veterinária, incluindo controle de tutores, pets, vacinas, medicamentos, pedidos e conteúdos educativos. O banco de dados foi modelado para contemplar entidades fortes, fracas, associativas e especializadas.

## Sumário

* Descrição do Projeto
* Ambiente Necessário
* Como Executar
* Descrição dos Scripts SQL
* Exemplos de Consultas
* Descrição das Tabelas e Relacionamentos
* Especialização (Generalização/Especialização)
* Cardinalidades
* Tipos de Atributos
* Chaves
* Equipe

## Descrição do Projeto

O objetivo deste sistema é fornecer uma solução completa para a gestão de informações em uma clínica veterinária. As funcionalidades incluem:
* Cadastro de tutores e seus pets.
* Registro de vacinas aplicadas em pets.
* Controle de medicamentos e estoque.
* Gestão de pedidos e seus itens.
* Acesso a conteúdos educativos para os tutores.

## Ambiente Necessário

Para a execução deste projeto, é necessário um Sistema de Gerenciamento de Banco de Dados (SGBD).
* SGBD Recomendado: MySQL. Os scripts foram desenvolvidos utilizando a sintaxe do MySQL (ex: AUTO_INCREMENT, CREATE DATABASE IF NOT EXISTS).
* Outros SGBDs: É possível adaptar os scripts para outros SGBDs como o PostgreSQL, mas pode ser necessário ajustar a sintaxe de alguns comandos.

## Como Executar

Siga este guia passo a passo para criar, popular e testar o banco de dados.
1. Clone o repositório:
Bash

git clone https://github.com/ppnunes/BD_Petcare.git
2. Acesse a pasta do projeto:
Bash

cd BD_Petcare
3. Crie e popule o banco de dados: Execute os scripts SQL na ordem correta. O primeiro script cria a estrutura e o segundo insere os dados iniciais.
* Script de Criação do Schema: Bash  mysql -u seu_usuario -p < 001_schema.sql
*    
* Script de Inserção de Dados: Bash  mysql -u seu_usuario -p BD_Petcare < 002_insercao.sql
*     Nota: Após a execução do primeiro comando, o banco BD_Petcare já existirá. O segundo comando popula as tabelas dentro dele.
4. Verifique e teste o banco de dados: Para testar e interagir com os dados, execute o terceiro script, que contém diversas consultas, atualizações e exclusões de exemplo.
Bash

mysql -u seu_usuario -p BD_Petcare < 003_manipulacao.sql
Você também pode abrir um cliente MySQL, conectar-se ao banco BD_Petcare e executar as queries do arquivo 003_manipulacao.sql individualmente.

## Descrição dos Scripts SQL

* 001_schema.sql: Este script é responsável por toda a estruturação do banco. Ele cria o banco de dados BD_Petcare e define todas as tabelas, suas colunas, chaves primárias (PK), chaves estrangeiras (FK) e os relacionamentos entre elas.
* 002_insercao.sql: Após a criação da estrutura, este script popula o banco de dados com dados de exemplo. São inseridos registros de usuários, tutores, pets, vacinas, medicamentos, entre outros, permitindo que o sistema seja testado com um conjunto de dados coerente.
* 003_manipulacao.sql: Contém exemplos de comandos da Linguagem de Manipulação de Dados (DML). Inclui consultas (SELECT) para extrair informações, comandos de atualização (UPDATE) para modificar registros e comandos de exclusão (DELETE) para remover dados.

## Exemplos de Consultas

Abaixo estão alguns exemplos de consultas presentes no arquivo 003_manipulacao.sql para verificar o funcionamento do banco.
1. Listar pets que nasceram depois de 2020 e seus respectivos tutores:
SQL

SELECT
    P.nome AS Nome_Pet,
    T.nome AS Nome_Tutor,
    P.raca AS Raca
FROM
    Pet P
JOIN
    Tutor T ON P.id_tutor = T.id_tutor
WHERE
    P.data_nascimento > '2020-12-31'
ORDER BY
    P.data_nascimento;
2. Verificar medicamentos com baixo estoque (menos de 35 unidades):
SQL

SELECT
    nome AS Nome_Medicamento,
    estoque AS Quantidade_Estoque,
    preco AS Preco_Unitario
FROM
    Medicamento
WHERE
    estoque < 35
ORDER BY
    estoque DESC;
3. Listar todos os pedidos com status "Concluído":
SQL

SELECT
    P.id_pedido AS ID_Pedido,
    T.nome AS Nome_Tutor,
    P.valorTotal AS Valor_Total,
    P.data_pedido AS Data_Pedido
FROM
    Pedido P
JOIN
    Tutor T ON P.id_tutor = T.id_tutor
WHERE
    P.status = 'Concluído'
ORDER BY
    P.data_pedido;


## Descrição das Tabelas e Relacionamentos


## Entidades Fortes
- **Entidades fortes** (Tutor, Pet, Medicamento, Pedido, Conteúdo Educativo)
 
| Tabela             | Atributos                                                                 |
|--------------------|---------------------------------------------------------------------------|
| **Tutor**          | id_tutor (PK), nome, CPF, telefone, email, endereço                       |
| **Pet**            | id_pet (PK), nome, espécie, raça, data_nascimento, sexo, id_tutor (FK)     |
| **Medicamento**    | id_medicamento (PK), nome, descrição, fabricante, preço, estoque           |
| **ConteudoEducativo** | id_conteudo (PK), titulo, tipo, descricao, data_publicacao              |
| **Pedido**         | id_pedido (PK), data_pedido, valor_total, status, endereço_entrega                           |

## Entidades Fracas
- **Entidades fracas** (Vacina)
 
| Tabela   | Atributos                                             |
|----------|-------------------------------------------------------|
| **Vacina** | id_vacina (PK), nome, validade, data_aplicacao, id_pet (FK) |

## Entidades Associativas
- **Entidades associativas** (PetMedicamento, ItemPedido, TutorConteudo)
 

| Tabela         | Atributos                                             |
|----------------|-------------------------------------------------------|
| **PetMedicamento** | id_pet (FK), id_medicamento (FK)                  |
| **ItemPedido**     | id_item (PK), id_pedido (FK), id_medicamento (FK), quantidade, valor_unitario |
| **TutorConteudo**  | id_tutor (FK), id_conteudo (FK)                    |


## Especialização (Generalização/Especialização)

Tabela	Atributos
Usuário:	id_usuario (PK), nome, email, senha
Tutor:	especialização de Usuário
Administrador:	especialização de Usuário

## Entidades Especializadas
- **Entidades especializadas** (Usuário → Tutor / Administrador)
 
| Tabela           | Atributos                                  |
|------------------|--------------------------------------------|
| **Usuário**      | id_usuario (PK), nome, email, senha        |
| **Tutor**        | especialização de Usuário                  |
| **Administrador**| especialização de Usuário                  |


  ## Cardinalidades

* Tutor – Pet: 1:N (um tutor pode ter vários pets)
* Pet – Vacina: 1:N (um pet pode ter várias vacinas)
* Tutor – Conteúdo Educativo: N:N (via tabela associativa TutorConteudo)
* Pedido – Medicamento: N:N (via tabela associativa ItemPedido)

## Tipos de Atributos

**Simples:** 
- Nome, CPF, email, sexo, data_nascimento, titulo, fabricante, preço, estoque, status

**Compostos:**
- Endereço → rua, número, bairro, CEP

**Multivalorados:**
- Telefone do Tutor (um tutor pode ter mais de um número)

---

## Chaves

**Primárias (PK):**
- id_tutor, id_pet, id_medicamento, id_conteudo, id_pedido, id_usuario, id_vacina

**Estrangeiras (FK):**
- id_tutor em Pet
- id_pedido e id_medicamento em ItemPedido
- id_tutor e id_conteudo em TutorConteudo
- id_pet em Vacina (se considerada fraca dependente de Pet)

**Compostas:**
- Em ItemPedido: (id_pedido, id_medicamento)
- Em TutorConteudo: (id_tutor, id_conteudo)


## Equipe

* Priscila Nunes
    * Criação do diagrama lógico e físico.
    * Desenvolvimento do script de criação do banco de dados.
    * Desenvolvimento do script de inserção de dados.
* Erick Ferreira
    * Redação da documentação final, detalhando os diagramas, tabelas, relacionamentos, escolhas de tipos de dados e o processo de normalização.
* Anna Beatriz e Emanoel Alexandre
    * Desenvolvimento de todos os scripts de manipulação de dados (SELECT, UPDATE, DELETE).
    * Organização do repositório, incluindo a elaboração do arquivo README.md com instruções de uso.
* Camile Felix e Fabiana Souza
    * Reunião de todo o material produzido pela equipe.
    * Execução dos scripts para gerar evidências de funcionamento (logs e prints).
    * Montagem, formatação e revisão do documento final em PDF.
