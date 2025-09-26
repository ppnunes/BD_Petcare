-- População inicial do banco de dados ajustada para o novo esquema e com 10 tutores e seus pets

-- Usuários (tutores e um administrador)
INSERT INTO Usuario (senha) VALUES
('senha123'),
('admin123'),
('senha456'),
('senha789'),
('senha234'),
('senha987'),
('senha654'),
('senha741'),
('senha852'),
('senha963'),
('senha159');


-- Tutor (relacionando aos usuários)
INSERT INTO Tutor (id_usuario, nome, CPF, email, telefone, rua, numero, bairro, CEP) VALUES
(1, 'Carlos Silva', '123.456.789-00', 'carlos.tutor@email.com', '11999991111', 'Rua das Flores', '123', 'Centro', '12345-678'),
(3, 'Joana Costa', '234.567.890-11', 'joana.costa@email.com', '21988881234', 'Av. Brasil', '200', 'Jardim', '23456-789'),
(4, 'Ricardo Lima', '345.678.901-22', 'ricardo.lima@email.com', '31977774321', 'Rua da Paz', '45', 'Boa Vista', '34567-890'),
(5, 'Fernanda Souza', '456.789.012-33', 'fernanda.souza@email.com', '41966662345', 'Rua Verde', '67', 'Parque', '45678-901'),
(6, 'Paulo Mendes', '567.890.123-44', 'paulo.mendes@email.com', '51955553456', 'Av. Central', '89', 'Centro', '56789-012'),
(7, 'Ana Paula', '678.901.234-55', 'ana.paula@email.com', '61944444567', 'Rua Azul', '101', 'Vila Nova', '67890-123'),
(8, 'Marcos Vinicius', '789.012.345-66', 'marcos.vinicius@email.com', '71933335678', 'Rua Rio', '202', 'Industrial', '78901-234'),
(9, 'Juliana Rocha', '890.123.456-77', 'juliana.rocha@email.com', '81922226789', 'Av. Atlântica', '303', 'Praia', '89012-345'),
(10, 'Roberto Duarte', '901.234.567-88', 'roberto.duarte@email.com', '85900008901', 'Rua Lago', '404', 'Lagoa', '90123-456'),
(11, 'Isabela Martins', '012.345.678-99', 'isabela.martins@email.com', '85900008902', 'Rua Sol', '505', 'Jardim', '01234-567');


-- Telefones dos Tutores removidos (campo telefone está na tabela Tutor)

INSERT INTO Administrador (id_usuario, cargo, nivel_de_acesso) VALUES
(2, 'Administrador Geral', 10);

-- Pets dos Tutores
INSERT INTO Pet (nome, especie, raca, data_nascimento, sexo, id_tutor) VALUES
('Rex', 'Cachorro', 'Labrador', '2020-05-10', 'Macho', 1),
('Mimi', 'Gato', 'Siamês', '2019-07-22', 'Fêmea', 1),
('Thor', 'Cachorro', 'Pastor Alemão', '2018-11-01', 'Macho', 2),
('Luna', 'Gato', 'Persa', '2021-01-15', 'Fêmea', 3),
('Bidu', 'Cachorro', 'Poodle', '2022-03-18', 'Macho', 4),
('Mel', 'Gato', 'Vira-lata', '2021-06-10', 'Fêmea', 5),
('Bob', 'Cachorro', 'Bulldog', '2019-09-25', 'Macho', 6),
('Simba', 'Gato', 'Maine Coon', '2020-12-30', 'Macho', 7),
('Lola', 'Cachorro', 'Shih-tzu', '2021-04-14', 'Fêmea', 8),
('Tigrão', 'Gato', 'Bengal', '2022-05-05', 'Macho', 9),
('Pingo', 'Cachorro', 'Dálmata', '2020-08-20', 'Macho', 10),
('Nina', 'Gato', 'Angorá', '2022-02-11', 'Fêmea', 10);

-- Vacinas para alguns pets
INSERT INTO Vacina (nome, validade, data_aplicacao, id_pet) VALUES
('V8', '2026-05-10', '2023-05-10', 1),
('Antirrábica', '2025-07-22', '2024-07-22', 2),
('V10', '2025-11-01', '2022-11-01', 3),
('Tríplice Viral Felina', '2024-01-15', '2022-01-15', 4),
('V8', '2026-03-18', '2023-03-18', 5),
('Antirrábica', '2024-06-10', '2023-06-10', 6);

-- Medicamentos
INSERT INTO Medicamento (nome, descricao, fabricante, preco, estoque) VALUES
('Vermífugo', 'Medicamento para vermes', 'PetPharma', 35.00, 50),
('Antibiótico', 'Para infecções bacterianas', 'AnimalCare', 60.00, 30),
('Anti-inflamatório', 'Reduz inflamações', 'VetPlus', 45.00, 25);

-- Uso de Medicamento pelo Pet
INSERT INTO PetMedicamento (id_pet, id_medicamento, dosagem, observacao) VALUES
(1, 1, '5ml', 'Uso mensal'),
(2, 2, '2 comprimidos', 'Após refeição'),
(3, 3, '1 comprimido', 'Durante 7 dias'),
(4, 1, '3ml', 'Reforço após 15 dias');

-- Conteúdos Educativos
INSERT INTO ConteudoEducativo (titulo, tipo, descricao, data_publicacao) VALUES
('Cuidados com filhotes', 'Artigo', 'Dicas essenciais para novos tutores.', '2024-01-15'),
('Vacinação obrigatória', 'Vídeo', 'A importância das vacinas para pets.', '2024-03-10');

INSERT INTO TutorConteudo (id_tutor, id_conteudo) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 2);

-- Pedidos (endereços de entrega preenchidos conforme campos do Tutor)
INSERT INTO Pedido (id_tutor, data_pedido, valorTotal, status, rua, numero, bairro, CEP) VALUES
(1, '2025-09-20', 70.00, 'Concluído', 'Rua das Flores', '123', 'Centro', '12345-678'),
(2, '2025-09-21', 60.00, 'Pendente', 'Av. Brasil', '200', 'Jardim', '23456-789'),
(3, '2025-09-22', 45.00, 'Concluído', 'Rua da Paz', '45', 'Boa Vista', '34567-890');

-- Itens dos pedidos (associando pedidos a medicamentos)
INSERT INTO ItemPedido (id_pedido, id_medicamento, quantidade, valor_unitario) VALUES
(1, 1, 2, 35.00),
(2, 2, 1, 60.00),
(3, 3, 1, 45.00);