-- Criação e uso do Banco de Dados
CREATE DATABASE Universidade;
USE Universidade;

-- 1. Tabela Professores
CREATE TABLE Professores (
    matricula INT,
    nome VARCHAR(100) CONSTRAINT nn_prof_nome NOT NULL,
    RG VARCHAR(20),
    sexo CHAR(1),
    idade INT,
    titulacao VARCHAR(20),
    categoria VARCHAR(20),
    nroTurmas INT,
    CONSTRAINT pk_professores PRIMARY KEY (matricula),
    CONSTRAINT uk_prof_rg UNIQUE (RG),
    CONSTRAINT chk_prof_sexo CHECK (sexo IN ('M', 'F')),
    CONSTRAINT chk_prof_idade CHECK (idade BETWEEN 21 AND 80),
    CONSTRAINT chk_prof_titulacao CHECK (titulacao IN ('graduado', 'especialista', 'mestre', 'doutor')),
    CONSTRAINT chk_prof_categoria CHECK (categoria IN ('auxiliar', 'assistente', 'adjunto', 'titular')),
    CONSTRAINT chk_prof_nroturmas CHECK (nroTurmas >= 0)
);

-- 2. Tabela Cursos
CREATE TABLE Cursos (
    codigo INT,
    nome VARCHAR(100) CONSTRAINT nn_curso_nome NOT NULL,
    duracao INT,
    coordenador INT,
    CONSTRAINT pk_cursos PRIMARY KEY (codigo),
    CONSTRAINT chk_curso_duracao CHECK (duracao BETWEEN 4 AND 12),
    CONSTRAINT fk_curso_coordenador FOREIGN KEY (coordenador) 
        REFERENCES Professores(matricula) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE
);

-- 3. Tabela Alunos
CREATE TABLE Alunos (
    matricula INT,
    nome VARCHAR(100) CONSTRAINT nn_aluno_nome NOT NULL,
    RG VARCHAR(20),
    sexo CHAR(1),
    idade INT,
    curso INT, 
    CONSTRAINT pk_alunos PRIMARY KEY (matricula),
    CONSTRAINT uk_aluno_rg UNIQUE (RG),
    CONSTRAINT chk_aluno_sexo CHECK (sexo IN ('M', 'F')),
    CONSTRAINT chk_aluno_idade CHECK (idade BETWEEN 17 AND 90),
    CONSTRAINT fk_aluno_curso FOREIGN KEY (curso) 
        REFERENCES Cursos(codigo)
);

-- 4. Tabela Disciplinas
CREATE TABLE Disciplinas (
    codigo INT,
    nome VARCHAR(100) CONSTRAINT nn_disc_nome NOT NULL,
    creditos INT,
    CONSTRAINT pk_disciplinas PRIMARY KEY (codigo),
    CONSTRAINT chk_disc_creditos CHECK (creditos BETWEEN 2 AND 8)
);

-- 5. Tabela Currículos
CREATE TABLE Curriculos (
    curso INT,
    disciplina INT,
    fase INT,
    CONSTRAINT pk_curriculos PRIMARY KEY (curso, disciplina),
    CONSTRAINT chk_curr_fase CHECK (fase BETWEEN 1 AND 12),
    CONSTRAINT fk_curr_curso FOREIGN KEY (curso) 
        REFERENCES Cursos(codigo) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE,
    CONSTRAINT fk_curr_disciplina FOREIGN KEY (disciplina) 
        REFERENCES Disciplinas(codigo) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE
);

-- 6. Tabela Turmas
CREATE TABLE Turmas (
    disciplina INT,
    codigo INT,
    vagas INT,
    professor INT CONSTRAINT nn_turma_prof NOT NULL,
    CONSTRAINT pk_turmas PRIMARY KEY (disciplina, codigo),
    CONSTRAINT chk_turma_vagas CHECK (vagas > 0),
    CONSTRAINT fk_turma_professor FOREIGN KEY (professor) 
        REFERENCES Professores(matricula)
);

-- 7. Tabela Matrículas
CREATE TABLE Matriculas (
    aluno INT,
    disciplina INT,
    turma INT,
    CONSTRAINT pk_matriculas PRIMARY KEY (aluno, disciplina, turma),
    CONSTRAINT fk_mat_aluno FOREIGN KEY (aluno) 
        REFERENCES Alunos(matricula) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE,
    CONSTRAINT fk_mat_turma FOREIGN KEY (disciplina, turma) 
        REFERENCES Turmas(disciplina, codigo)
);