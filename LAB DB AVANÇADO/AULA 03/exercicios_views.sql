-- 1. Mostrar o nome e o salário dos funcionários que recebem entre 6 e 8 mil
CREATE VIEW vw_func_salario_6_8 AS
SELECT nome, salario
FROM Funcionario
WHERE salario BETWEEN 6000.00 AND 8000.00
ORDER BY salario ASC;

-- 2. Mostrar o nome o e cargo de todos os funcionários
CREATE VIEW vw_func_cargo AS
SELECT f.nome AS nome_funcionario, c.nome AS nome_cargo
FROM Funcionario f
INNER JOIN Cargo c ON f.cod_cargo = c.codigo
ORDER BY f.nome ASC;

-- 3. Mostrar o nome de todos os departamentos e seus respectivos funcionários
CREATE VIEW vw_depto_func AS
SELECT d.nome AS nome_departamento, f.nome AS nome_funcionario
FROM Departamento d
INNER JOIN Funcionario f ON d.codigo = f.cod_depto
ORDER BY d.nome ASC, f.nome ASC;

-- 4. Mostrar o nome e o salário dos funcionários que trabalham no departamento de compras
CREATE VIEW vw_func_compras AS
SELECT f.nome, f.salario
FROM Funcionario f
INNER JOIN Departamento d ON f.cod_depto = d.codigo
WHERE d.nome = 'compras';

-- 5. Mostrar o nome do funcionário e o nome da cidade (cidades com a palavra 'São')
CREATE VIEW vw_func_cidade_sao AS
SELECT f.nome AS nome_funcionario, c.nome AS nome_cidade
FROM Funcionario f
INNER JOIN Cidade c ON f.cod_cidade = c.codigo
WHERE c.nome LIKE '%São%';

-- 6. Nome, salário e cargo dos funcionários que moram em Campinas
CREATE VIEW vw_func_campinas AS
SELECT f.nome AS nome_funcionario, f.salario, ca.nome AS nome_cargo
FROM Funcionario f
INNER JOIN Cargo ca ON f.cod_cargo = ca.codigo
INNER JOIN Cidade ci ON f.cod_cidade = ci.codigo
WHERE ci.nome = 'Campinas'
ORDER BY f.salario DESC;

-- 7. Mostrar o nome, a cidade onde mora, e o departamento dos estagiários
CREATE VIEW vw_func_estagiarios AS
SELECT f.nome AS nome_funcionario, ci.nome AS nome_cidade, d.nome AS nome_departamento
FROM Funcionario f
INNER JOIN Cidade ci ON f.cod_cidade = ci.codigo
INNER JOIN Departamento d ON f.cod_depto = d.codigo
INNER JOIN Cargo ca ON f.cod_cargo = ca.codigo
WHERE ca.nome = 'estagiario';

-- 8. Mostrar o nome de todos os funcionários que são subordinados do gerente Antonio Leite
CREATE VIEW vw_subordinados_antonio AS
SELECT f.nome
FROM Funcionario f
INNER JOIN Funcionario g ON f.gerente = g.codigo
WHERE g.nome = 'Antonio Leite'
ORDER BY f.nome ASC;