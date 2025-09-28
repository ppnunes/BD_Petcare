
# 🐾 Sistema de Gerenciamento de Clínica Veterinária

Este projeto consiste em um sistema de gerenciamento para uma clínica veterinária, incluindo controle de tutores, pets, vacinas, medicamentos, pedidos e conteúdos educativos. O banco de dados foi modelado para contemplar entidades fortes, fracas, associativas e especializadas, conforme descrito abaixo.

## 📑 Sumário
- [Descrição do Projeto](#descrição-do-projeto)
- [Descrição das Tabelas](#descrição-das-tabelas)
- [Funcionalidades](#funcionalidades)
- [Cardinalidades](#cardinalidades)
- [Tipos de Atributos](#tipos-de-atributos)
- [Chaves](#chaves)
- [Equipe](#equipe)

# Descrição das Tabelas do Projeto

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

## Entidades Especializadas
- **Entidades especializadas** (Usuário → Tutor / Administrador)
 
| Tabela           | Atributos                                  |
|------------------|--------------------------------------------|
| **Usuário**      | id_usuario (PK), nome, email, senha        |
| **Tutor**        | especialização de Usuário                  |
| **Administrador**| especialização de Usuário                  |

## ✅ Funcionalidades
- Cadastro de tutores e seus pets  
- Registro de vacinas aplicadas em pets  
- Controle de medicamentos e estoque  
- Gestão de pedidos e itens de pedido  
- Acesso a conteúdos educativos para tutores 
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

## 👨‍💻 Equipe
- Erick (modelagem)
- Priscila, Ana Beatriz e Emanoel (modelagem, consultas SQL e organização)
- Camile e Fabiana (documentação, scripts e finalização)

## ▶️ Como Executar
1. Clone este repositório:
```bash
git clone https://github.com/ppnunes/BD_Petcare.git
```
2. Acesse a pasta do projeto:
```bash
cd BD_Petcare
```
3. Importe o script SQL no seu SGBD:
```bash
mysql -u usuario -p < script.sql
```
ou
```bash
psql -U usuario -d banco < script.sql
```
4. Execute as queries de teste no arquivo `consultas.sql`. 
 
