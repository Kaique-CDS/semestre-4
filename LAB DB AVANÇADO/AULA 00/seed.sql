-- Inserindo Regiões
INSERT INTO REGIOES (ID_REGIAO, NOME_DA_REGIAO) VALUES 
(1, 'América do Sul'),
(2, 'América do Norte'),
(3, 'Europa');

-- Inserindo Países
INSERT INTO PAISES (ID_PAIS, NOME_DO_PAIS, ID_REGIAO) VALUES 
(1, 'Brasil', 1),
(2, 'Estados Unidos', 2),
(3, 'Inglaterra', 3);

-- Inserindo Localizações
INSERT INTO LOCALIZACOES (ID_LOCALIZACAO, ENDERECO, CEP, CIDADE, ESTADO_PROVINCIA, ID_PAIS) VALUES 
(1, 'Av. Paulista, 1000', '01311-000', 'São Paulo', 'SP', 1),
(2, '5th Avenue, 350', '10118', 'Nova York', 'NY', 2),
(3, 'Baker Street, 221B', 'NW1 6XE', 'Londres', 'Greater London', 3);

-- Inserindo Cargos
INSERT INTO CARGOS (ID_CARGO, TITULO_DO_CARGO, SALARIO_MINIMO, SALARIO_MAXIMO) VALUES 
(1, 'Desenvolvedor Backend', 3500.00, 9500.00),
(2, 'Analista de Sistemas', 4000.00, 11000.00),
(3, 'Gerente de TI', 8000.00, 18000.00);

-- Inserindo Departamentos (ID_GERENTE começa como NULL devido à ordem de inserção)
INSERT INTO DEPARTAMENTOS (ID_DEPARTAMENTO, NOME_DO_DEPARTAMENTO, ID_GERENTE, ID_LOCALIZACAO) VALUES 
(1, 'Desenvolvimento de Software', NULL, 1),
(2, 'Infraestrutura', NULL, 2),
(3, 'Suporte Técnico', NULL, 1);

-- Inserindo Funcionários (O primeiro é o gerente)
INSERT INTO FUNCIONARIOS (ID_FUNCIONARIO, ID_GERENTE, ID_DEPARTAMENTO, NOME, SOBRENOME, EMAIL, TELEFONE, DATA_DE_CONTRATACAO, ID_CARGO, SALARIO, PERCENTUAL_DE_COMISSAO) VALUES 
(1, NULL, 1, 'Carlos', 'Mendes', 'carlos.mendes@empresa.com', '11999999999', '2022-01-15', 3, 12000.00, NULL),
(2, 1, 1, 'Ana', 'Souza', 'ana.souza@empresa.com', '11988888888', '2023-03-10', 1, 6500.00, 0.05),
(3, 1, 1, 'Felipe', 'Rocha', 'felipe.rocha@empresa.com', '11977777777', '2024-02-20', 2, 5000.00, NULL);

-- Atualizando o gerente do departamento agora que o funcionário existe
UPDATE DEPARTAMENTOS SET ID_GERENTE = 1 WHERE ID_DEPARTAMENTO = 1;

-- Inserindo Histórico de Cargos
INSERT INTO HISTORICO_DE_CARGOS (ID_FUNCIONARIO, DATA_INICIO, DATA_FIM, ID_CARGO, ID_DEPARTAMENTO) VALUES 
(1, '2022-01-15', '2023-12-31', 2, 1), -- Carlos foi Analista antes de ser Gerente
(2, '2023-03-10', '2024-01-10', 2, 1), -- Ana foi Analista antes de ser Desenvolvedora
(3, '2021-05-01', '2024-02-19', 1, 3); -- Felipe estava em outro cargo/departamento antes