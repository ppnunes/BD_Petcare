
# Projeto de Laboratório de Banco de Dados

Este projeto consiste em um sistema de gerenciamento para uma clínica veterinária, incluindo controle de tutores, pets, vacinas, medicamentos, pedidos e conteúdos educativos. O banco de dados foi modelado para contemplar entidades fortes, fracas, associativas e especializadas, conforme descrito abaixo.

## Como rodar o projeto com Docker Compose

Para facilitar a execução do banco de dados, utilize o Docker Compose. Certifique-se de ter o Docker e o Docker Compose instalados em sua máquina.

1. No terminal, navegue até a pasta do projeto:
2. Execute o comando para subir os containers:
	```sh
	docker-compose up
	```
3. O banco de dados estará disponível conforme definido no arquivo `docker-compose.yml` (localhost:3306).

4. Para parar os containers:
	```sh
	docker-compose down
	```

# Descrição das Tabelas do Projeto

## Entidades Fortes

| Tabela             | Atributos                                                                 |
|--------------------|---------------------------------------------------------------------------|
| **Tutor**          | id_tutor (PK), nome, CPF, telefone, email, endereço                       |
| **Pet**            | id_pet (PK), nome, espécie, raça, data_nascimento, sexo, id_tutor (FK)     |
| **Medicamento**    | id_medicamento (PK), nome, descrição, fabricante, preço, estoque           |
| **ConteudoEducativo** | id_conteudo (PK), titulo, tipo, descricao, data_publicacao              |
| **Pedido**         | id_pedido (PK), data_pedido, valor_total, status                           |

## Entidades Fracas

| Tabela   | Atributos                                             |
|----------|-------------------------------------------------------|
| **Vacina** | id_vacina (PK), nome, validade, data_aplicacao, id_pet (FK) |

## Entidades Associativas

| Tabela         | Atributos                                             |
|----------------|-------------------------------------------------------|
| **PetMedicamento** | id_pet (FK), id_medicamento (FK)                  |
| **ItemPedido**     | id_item (PK), id_pedido (FK), id_medicamento (FK), quantidade, valor_unitario |
| **TutorConteudo**  | id_tutor (FK), id_conteudo (FK)                    |

## Entidades Especializadas

| Tabela           | Atributos                                  |
|------------------|--------------------------------------------|
| **Usuário**      | id_usuario (PK), nome, email, senha        |
| **Tutor**        | especialização de Usuário                  |
| **Administrador**| especialização de Usuário                  |

---

## Cardinalidades

- **Tutor – Pet:** 1:N (um tutor pode ter vários pets)
- **Pet – Vacina:** 1:N (um pet pode ter várias vacinas)
- **Tutor – Conteúdo Educativo:** N:N (associativa TutorConteudo)
- **Pedido – Medicamento:** N:N (associativa ItemPedido)
- **Usuário – Tutor / Usuário – Administrador:** especialização (generalização/especialização)

---

## Tipos de Atributos

**Simples:** nome, CPF, email, sexo, data_nascimento, titulo, fabricante, preço, estoque, status

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