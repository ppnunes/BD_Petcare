-- Esquema ajustado conforme o diagrama (Imagem 1)
-- Inclui DROP TABLE IF EXISTS para evitar conflitos na criação

-- Ordem de DROP deve respeitar as dependências de FK
DROP TABLE IF EXISTS ItemPedido;
DROP TABLE IF EXISTS Pedido;
DROP TABLE IF EXISTS PetMedicamento;
DROP TABLE IF EXISTS Vacina;
DROP TABLE IF EXISTS Pet;
DROP TABLE IF EXISTS TelefoneTutor;
DROP TABLE IF EXISTS TutorConteudo;
DROP TABLE IF EXISTS ConteudoEducativo;
DROP TABLE IF EXISTS Medicamento;
DROP TABLE IF EXISTS Administrador;
DROP TABLE IF EXISTS Tutor;
DROP TABLE IF EXISTS Usuario;

-- Usuário (generalização)
CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tutor (especialização de Usuário)
CREATE TABLE Tutor (
    id_tutor INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100) NOT NULL,
    rua VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    bairro VARCHAR(60) NOT NULL,
    CEP VARCHAR(10) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
);

-- Telefone do Tutor (multivalorado)
CREATE TABLE TelefoneTutor (
    id_telefone INT AUTO_INCREMENT PRIMARY KEY,
    id_tutor INT NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_tutor) REFERENCES Tutor(id_tutor) ON DELETE CASCADE
);

-- Administrador (especialização de Usuário)
CREATE TABLE Administrador (
    id_administrador INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT UNIQUE NOT NULL,
    cargo VARCHAR(50),
    nivel_de_acesso INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
);

-- Pet
CREATE TABLE Pet (
    id_pet INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    especie VARCHAR(30) NOT NULL,
    raca VARCHAR(40),
    data_nascimento DATE,
    sexo VARCHAR(10),
    id_tutor INT NOT NULL,
    FOREIGN KEY (id_tutor) REFERENCES Tutor(id_tutor) ON DELETE CASCADE
);

-- Vacina (fraca dependente de Pet)
CREATE TABLE Vacina (
    id_vacina INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    validade DATE NOT NULL,
    data_aplicacao DATE NOT NULL,
    id_pet INT NOT NULL,
    FOREIGN KEY (id_pet) REFERENCES Pet(id_pet) ON DELETE CASCADE
);

-- Medicamento
CREATE TABLE Medicamento (
    id_medicamento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    fabricante VARCHAR(60),
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL
);

-- Uso de Medicamento pelo Pet (PetMedicamento)
CREATE TABLE PetMedicamento (
    id_pet INT NOT NULL,
    id_medicamento INT NOT NULL,
    dosagem VARCHAR(50),
    observacao TEXT,
    PRIMARY KEY (id_pet, id_medicamento),
    FOREIGN KEY (id_pet) REFERENCES Pet(id_pet) ON DELETE CASCADE,
    FOREIGN KEY (id_medicamento) REFERENCES Medicamento(id_medicamento) ON DELETE CASCADE
);

-- Conteúdo Educativo
CREATE TABLE ConteudoEducativo (
    id_conteudo INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    tipo VARCHAR(40) NOT NULL,
    descricao TEXT,
    data_publicacao DATE NOT NULL
);

-- TutorConteudo (associativa N:N entre Tutor e ConteudoEducativo)
CREATE TABLE TutorConteudo (
    id_tutor INT NOT NULL,
    id_conteudo INT NOT NULL,
    data_interacao DATE,
    PRIMARY KEY (id_tutor, id_conteudo),
    FOREIGN KEY (id_tutor) REFERENCES Tutor(id_tutor) ON DELETE CASCADE,
    FOREIGN KEY (id_conteudo) REFERENCES ConteudoEducativo(id_conteudo) ON DELETE CASCADE
);

-- Pedido
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
    FOREIGN KEY (id_tutor) REFERENCES Tutor(id_tutor) ON DELETE CASCADE
);

-- ItemPedido (associativa N:N entre Pedido e Medicamento)
CREATE TABLE ItemPedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_medicamento INT NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_medicamento) REFERENCES Medicamento(id_medicamento) ON DELETE CASCADE,
    UNIQUE (id_pedido, id_medicamento)
);