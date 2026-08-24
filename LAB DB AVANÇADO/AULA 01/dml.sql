-- 1. Liste todos os empregados que têm um salário (salary) entre 1000 e 2000.
SELECT * 
FROM employees 
WHERE salary BETWEEN 1000 AND 2000;

-- 2. Liste os números e nomes dos departamentos ordenados por nome do departamento. (departaments)
SELECT department_id, department_name 
FROM departments 
ORDER BY department_name;

-- 3. Liste todos os tipos diferentes de funções desempenhadas pelos empregados.
SELECT DISTINCT job_id 
FROM employees;

-- 4. Liste a informação detalhada dos empregados dos departamentos 10 e 20 por ordem alfabética do nome.
SELECT * 
FROM employees 
WHERE department_id IN (10, 20) 
ORDER BY first_name;

-- 5. Liste os nomes e funções de todos os empregados de escritório (clerk) do departamento 50.
SELECT first_name, last_name, job_id 
FROM employees 
WHERE department_id = 50 
AND job_id LIKE '%CLERK%';

-- 6. Apresente todos os nomes de empregados que tenham th ou ll.
SELECT first_name, last_name 
FROM employees 
WHERE first_name LIKE '%th%' OR first_name LIKE '%ll%' 
   OR last_name LIKE '%th%' OR last_name LIKE '%ll%';

-- 7. Liste o nome, função e salário para todos os empregados que tenham um chefe (mgr).
SELECT first_name, last_name, job_id, salary 
FROM employees 
WHERE manager_id IS NOT NULL;

-- 8. Apresente o nome e a remuneração total (14 vezes o salário mais a comissão) para todos os empregados.
SELECT first_name, last_name, (salary * 14) + NVL(commission_pct, 0) AS "Remuneracao Total" 
FROM employees;

-- 9. Apresente todos os empregados que foram admitidos durante 1987.
SELECT * 
FROM employees 
WHERE hire_date BETWEEN '1987-01-01' AND '1987-12-31';

-- 10. Liste o nome, salário anual (14 vezes o salário mensal) e comissão para todo o pessoal de vendas (SALESMAN).
SELECT first_name, last_name, (salary * 14) AS "Salario Anual", commission_pct 
FROM employees 
WHERE job_id = 'SALESMAN' OR job_id LIKE '%SA_REP%';