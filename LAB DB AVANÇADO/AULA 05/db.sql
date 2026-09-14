-- ====================================================================
-- a) CRIAÇÃO DAS TABELAS, RELACIONAMENTOS, 
-- b) RESTRIÇÕES (NOT NULL/CHECK) E 
-- c) SEQUENCES
-- ====================================================================

-- 1. Departamento
CREATE SEQUENCE seq_departamento;
CREATE TABLE Departamento (
    cd_departamento INT PRIMARY KEY,
    ds_setor VARCHAR(100) NOT NULL -- (b) Restrição NOT NULL
);

-- 2. Funcionario (N dependem de 1 Departamento)
CREATE SEQUENCE seq_funcionario;
CREATE TABLE Funcionario (
    cd_funcionario INT PRIMARY KEY,
    ds_funcionario VARCHAR(100) NOT NULL,
    vl_salario DECIMAL(10,2) CHECK (vl_salario > 0), -- (b) Restrição CHECK
    cd_telefone VARCHAR(20),
    cd_departamento INT,
    FOREIGN KEY (cd_departamento) REFERENCES Departamento(cd_departamento)
);

-- 3. Projeto
CREATE SEQUENCE seq_projeto;
CREATE TABLE Projeto (
    cd_projeto INT PRIMARY KEY,
    ds_projeto VARCHAR(100) NOT NULL,
    vl_orcamento DECIMAL(12,2) CHECK (vl_orcamento >= 0) -- (b) Restrição CHECK
);

-- 4. Participa (Relacionamento N:M entre Funcionario e Projeto)
CREATE TABLE Participa (
    cd_funcionario INT,
    cd_projeto INT,
    dt_inicio DATE NOT NULL,
    hr_trabalho INT CHECK (hr_trabalho > 0), -- (b) Restrição CHECK
    PRIMARY KEY (cd_funcionario, cd_projeto),
    FOREIGN KEY (cd_funcionario) REFERENCES Funcionario(cd_funcionario),
    FOREIGN KEY (cd_projeto) REFERENCES Projeto(cd_projeto)
);

-- 5. Deposito
CREATE SEQUENCE seq_deposito;
CREATE TABLE Deposito (
    cd_deposito INT PRIMARY KEY,
    ds_deposito VARCHAR(100) NOT NULL,
    ds_endereco VARCHAR(200) NOT NULL -- (b) Restrição NOT NULL
);

-- 6. Pecas (N dependem de 1 Deposito)
CREATE SEQUENCE seq_peca;
CREATE TABLE Pecas (
    cd_peca INT PRIMARY KEY,
    ds_peca VARCHAR(100) NOT NULL,
    ds_cor VARCHAR(30),
    qt_peso DECIMAL(10,2) CHECK (qt_peso > 0), -- (b) Restrição CHECK
    cd_deposito INT,
    FOREIGN KEY (cd_deposito) REFERENCES Deposito(cd_deposito)
);

-- 7. Fornecedor
CREATE SEQUENCE seq_fornecedor;
CREATE TABLE Fornecedor (
    cd_fornecedor INT PRIMARY KEY,
    ds_fornecedor VARCHAR(100) NOT NULL,
    ds_endereco VARCHAR(200)
);

-- 8. Itens (Relacionamento Ternário M:N entre Projeto, Pecas e Fornecedor)
CREATE TABLE Itens (
    cd_projeto INT,
    cd_peca INT,
    cd_fornecedor INT,
    qt_pecaUtilizada INT CHECK (qt_pecaUtilizada >= 0), -- (b) Restrição CHECK
    PRIMARY KEY (cd_projeto, cd_peca, cd_fornecedor),
    FOREIGN KEY (cd_projeto) REFERENCES Projeto(cd_projeto),
    FOREIGN KEY (cd_peca) REFERENCES Pecas(cd_peca),
    FOREIGN KEY (cd_fornecedor) REFERENCES Fornecedor(cd_fornecedor)
);

-- ====================================================================
-- d) INSERÇÃO DE DADOS (Pelo menos 2 tuplas por tabela)
-- Nota: A sintaxe 'seq_nome.NEXTVAL' é padrão Oracle. 
-- (Em PostgreSQL use 'NEXTVAL('seq_nome')').
-- ====================================================================

-- Departamento
INSERT INTO Departamento VALUES (seq_departamento.NEXTVAL, 'Tecnologia da Informação');
INSERT INTO Departamento VALUES (seq_departamento.NEXTVAL, 'Recursos Humanos');

-- Funcionario
INSERT INTO Funcionario VALUES (seq_funcionario.NEXTVAL, 'Carlos Andrade', 4500.00, '11999999999', 1);
INSERT INTO Funcionario VALUES (seq_funcionario.NEXTVAL, 'Ana Costa', 5200.00, '11988888888', 1);

-- Projeto
INSERT INTO Projeto VALUES (seq_projeto.NEXTVAL, 'Migração de Banco de Dados', 150000.00);
INSERT INTO Projeto VALUES (seq_projeto.NEXTVAL, 'Atualização de Servidores', 80000.00);

-- Participa (Usando IDs 1 e 2 gerados acima)
INSERT INTO Participa VALUES (1, 1, TO_DATE('2026-09-01', 'YYYY-MM-DD'), 8);
INSERT INTO Participa VALUES (2, 1, TO_DATE('2026-09-02', 'YYYY-MM-DD'), 6);
INSERT INTO Participa VALUES (1, 2, TO_DATE('2026-09-10', 'YYYY-MM-DD'), 4);

-- Deposito
INSERT INTO Deposito VALUES (seq_deposito.NEXTVAL, 'Depósito Central', 'Rua das Flores, 123');
INSERT INTO Deposito VALUES (seq_deposito.NEXTVAL, 'Depósito Secundário', 'Avenida Brasil, 1500');

-- Pecas
INSERT INTO Pecas VALUES (seq_peca.NEXTVAL, 'Servidor Rack', 'Preto', 15.5, 1);
INSERT INTO Pecas VALUES (seq_peca.NEXTVAL, 'Cabo de Rede Cat6', 'Azul', 0.5, 1);

-- Fornecedor
INSERT INTO Fornecedor VALUES (seq_fornecedor.NEXTVAL, 'Tech Data Brasil', 'Av. Paulista, 1000');
INSERT INTO Fornecedor VALUES (seq_fornecedor.NEXTVAL, 'InfraParts', 'Rua Augusta, 500');

-- Itens (Associando os IDs 1 e 2)
INSERT INTO Itens VALUES (1, 1, 1, 2);
INSERT INTO Itens VALUES (1, 2, 2, 4); -- Quantidade menor que 5 para testar a View II
INSERT INTO Itens VALUES (2, 1, 1, 10);

-- ====================================================================
-- e) CRIAÇÃO DE QUATRO ÍNDICES
-- ====================================================================

CREATE INDEX idx_funcionario_nome ON Funcionario(ds_funcionario);
CREATE INDEX idx_projeto_nome ON Projeto(ds_projeto);
CREATE INDEX idx_peca_nome ON Pecas(ds_peca);
CREATE INDEX idx_fornecedor_nome ON Fornecedor(ds_fornecedor);

-- ====================================================================
-- f) CRIAÇÃO DAS VISÕES (VIEWS)
-- ====================================================================

-- i. Mostre as peças e seus fornecedores considerando o nome do projeto que utiliza as mesmas.
CREATE VIEW vw_pecas_fornecedores_projeto AS
SELECT 
    p.ds_peca, 
    f.ds_fornecedor, 
    pr.ds_projeto
FROM Itens i
JOIN Pecas p ON i.cd_peca = p.cd_peca
JOIN Fornecedor f ON i.cd_fornecedor = f.cd_fornecedor
JOIN Projeto pr ON i.cd_projeto = pr.cd_projeto;

-- ii. Mostre todos os endereços dos depósitos que estão com peças em quantidade menor que cinco.
-- (Baseado na qt_pecaUtilizada da tabela Itens, já que a tabela Pecas não possui campo de quantidade em estoque no MER).
CREATE VIEW vw_depositos_baixa_quantidade AS
SELECT DISTINCT 
    d.ds_endereco
FROM Deposito d
JOIN Pecas p ON d.cd_deposito = p.cd_deposito
JOIN Itens i ON p.cd_peca = i.cd_peca
WHERE i.qt_pecaUtilizada < 5;

-- iii. Mostre o nome dos projetos em que existem mais de um funcionário relacionado a ele.
CREATE VIEW vw_projetos_multiplos_funcionarios AS
SELECT 
    pr.ds_projeto
FROM Projeto pr
JOIN Participa pa ON pr.cd_projeto = pa.cd_projeto
GROUP BY pr.cd_projeto, pr.ds_projeto
HAVING COUNT(pa.cd_funcionario) > 1;

-- iv. Mostre os nomes dos funcionários e os departamentos que participam em dois ou mais projetos.
CREATE VIEW vw_funcionarios_multiplos_projetos AS
SELECT 
    f.ds_funcionario, 
    d.ds_setor
FROM Funcionario f
JOIN Departamento d ON f.cd_departamento = d.cd_departamento
JOIN Participa pa ON f.cd_funcionario = pa.cd_funcionario
GROUP BY f.cd_funcionario, f.ds_funcionario, d.ds_setor
HAVING COUNT(pa.cd_projeto) >= 2;