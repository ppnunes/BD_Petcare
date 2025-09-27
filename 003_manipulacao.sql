USE BD_Petcare;

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


SELECT
    CE.titulo AS Titulo_Conteudo,
    T.nome AS Tutor_Acessou
FROM
    ConteudoEducativo CE
JOIN
    TutorConteudo TC ON CE.id_conteudo = TC.id_conteudo
JOIN
    Tutor T ON TC.id_tutor = T.id_tutor
ORDER BY
    CE.titulo, T.nome;


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



UPDATE Pedido
SET
    status = 'Em Preparação'
WHERE
    id_pedido = 2;

UPDATE Medicamento
SET
    preco = preco + 5.00
WHERE
    estoque > 40;

UPDATE Administrador
SET
    cargo = 'Gerente de TI',
    nivel_de_acesso = 15
WHERE
    id_administrador = 1; 


UPDATE Pet
SET
    nome = 'Max',
    data_nascimento = '2022-03-20'
WHERE
    id_pet = 5;


DELETE FROM ConteudoEducativo
WHERE
    titulo = 'Vacinação obrigatória';
    
select *
from conteudoEducativo;

DELETE FROM Pet
WHERE
    nome = 'Nina';
    
select *
from pet;

DELETE FROM PetMedicamento
WHERE
    id_medicamento = 1;
    
select *
from petMedicamento;


DELETE FROM Tutor
WHERE
    id_tutor = 10;
    
select *
from tutor;