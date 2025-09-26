-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS BD_Petcare;

USE BD_Petcare;

-- Remoção de tabelas na ordem inversa de dependência (FK)
DROP TABLE IF EXISTS ItemPedido;
DROP TABLE IF EXISTS Pedido;
DROP TABLE IF EXISTS PetMedicamento;
DROP TABLE IF EXISTS Vacina;
DROP TABLE IF EXISTS TutorConteudo;
DROP TABLE IF EXISTS ConteudoEducativo;
DROP TABLE IF EXISTS Pet;
DROP TABLE IF EXISTS Medicamento;
DROP TABLE IF EXISTS Administrador;
DROP TABLE IF EXISTS Tutor;
DROP TABLE IF EXISTS Usuario;

-- Tabela Usuário (generalização)
CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    senha VARCHAR(255) NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabela Tutor (especialização de Usuário)
CREATE TABLE Tutor (
    id_tutor INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(14) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(11) NOT NULL,
    rua VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    bairro VARCHAR(60) NOT NULL,
    CEP VARCHAR(10) NOT NULL,
    CONSTRAINT FK_Tutor_Usuario 
        FOREIGN KEY (id_usuario) 
        REFERENCES Usuario(id_usuario) 
        ON DELETE CASCADE
);

-- Tabela Administrador (especialização de Usuário)
CREATE TABLE Administrador (
    id_administrador INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL UNIQUE,
    cargo VARCHAR(50),
    nivel_de_acesso INT,
    CONSTRAINT FK_Admin_Usuario 
        FOREIGN KEY (id_usuario) 
        REFERENCES Usuario(id_usuario) 
        ON DELETE CASCADE
);

-- Tabela Pet
CREATE TABLE Pet (
    id_pet INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    especie VARCHAR(30) NOT NULL,
    raca VARCHAR(40),
    data_nascimento DATE,
    sexo VARCHAR(10),
    id_tutor INT NOT NULL,
    CONSTRAINT FK_Pet_Tutor 
        FOREIGN KEY (id_tutor) 
        REFERENCES Tutor(id_tutor) 
        ON DELETE CASCADE
);

-- Tabela Vacina (dependente de Pet)
CREATE TABLE Vacina (
    id_vacina INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    validade DATE NOT NULL,
    data_aplicacao DATE NOT NULL,
    id_pet INT NOT NULL,
    CONSTRAINT FK_Vacina_Pet 
        FOREIGN KEY (id_pet) 
        REFERENCES Pet(id_pet) 
        ON DELETE CASCADE
);

-- Tabela Medicamento
CREATE TABLE Medicamento (
    id_medicamento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    fabricante VARCHAR(60),
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL
);

-- Tabela de associação Pet-Medicação
CREATE TABLE PetMedicamento (
    id_pet INT NOT NULL,
    id_medicamento INT NOT NULL,
    dosagem VARCHAR(50),
    observacao TEXT,
    PRIMARY KEY (id_pet, id_medicamento),
    CONSTRAINT FK_PetMed_Pet 
        FOREIGN KEY (id_pet) 
        REFERENCES Pet(id_pet) 
        ON DELETE CASCADE,
    CONSTRAINT FK_PetMed_Medicamento 
        FOREIGN KEY (id_medicamento) 
        REFERENCES Medicamento(id_medicamento) 
        ON DELETE CASCADE
);

-- Tabela Conteúdo Educativo
CREATE TABLE ConteudoEducativo (
    id_conteudo INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    tipo VARCHAR(40) NOT NULL,
    descricao TEXT,
    data_publicacao DATE NOT NULL
);

-- Tabela de associação Tutor-Conteúdo
CREATE TABLE TutorConteudo (
    id_tutor INT NOT NULL,
    id_conteudo INT NOT NULL,
    PRIMARY KEY (id_tutor, id_conteudo),
    CONSTRAINT FK_TC_Tutor 
        FOREIGN KEY (id_tutor) 
        REFERENCES Tutor(id_tutor) 
        ON DELETE CASCADE,
    CONSTRAINT FK_TC_Conteudo 
        FOREIGN KEY (id_conteudo) 
        REFERENCES ConteudoEducativo(id_conteudo) 
        ON DELETE CASCADE
);

-- Tabela Pedido
CREATE TABLE Pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_tutor INT NOT NULL,
    data_pedido DATE NOT NULL,
    valorTotal DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    rua VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    bairro VARCHAR(60) NOT NULL,
    CEP VARCHAR(10) NOT NULL,
    CONSTRAINT FK_Pedido_Tutor 
        FOREIGN KEY (id_tutor) 
        REFERENCES Tutor(id_tutor) 
        ON DELETE CASCADE
);

-- Tabela ItemPedido (associação Pedido-Medicação)
CREATE TABLE ItemPedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_medicamento INT NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_ItemPedido_Pedido 
        FOREIGN KEY (id_pedido) 
        REFERENCES Pedido(id_pedido) 
        ON DELETE CASCADE,
    CONSTRAINT FK_ItemPedido_Medicamento 
        FOREIGN KEY (id_medicamento) 
        REFERENCES Medicamento(id_medicamento) 
        ON DELETE CASCADE,
    UNIQUE (id_pedido, id_medicamento)
);