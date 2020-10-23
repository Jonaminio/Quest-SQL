-- ---------------- AULA 1 -----------------------
-- ##APAGA O BANCO DE DADOS SE ELE EXISTIR:
-- DROP DATABASE IF EXISTS fathor_2019_2;
-- DROP DATABASE fathor_2019_2;

-- ##CRIA O BANCO DE DADOS;
CREATE SCHEMA fathor_2019_2;
-- ---------------- AULA 2 -----------------------
-- CRIAR TABELA ALUNO
CREATE TABLE fathor_2019_2.aluno(
cpf int(11) NOT NULL,
nome varchar(45) NOT NULL,
sobrenome VARCHAR(45) NOT NULL,
telefone varchar(15) DEFAULT NULL,
PRIMARY KEY (cpf)
);
-- CRIAR A ATBELA SALA
CREATE TABLE fathor_2019_2.sala(
numero INT NOT NULL,
ala varchar (1) NOT NULL,
lugares INT NOT NULL,
PRIMARY KEY (numero)
);
-- CRIAR A TABELA DICIPLINA
CREATE TABLE fathor_2019_2.disciplina(
codigo INT NOT NULL,
descricao VARCHAR(45) NOT NULL,
c_sala INT NOT NULL,
ha INT NOT NULL,
PRIMARY KEY (codigo)
);
-- ALTERAR TABELA DICIPLINA COMO CHAVE estrangeira
ALTER TABLE fathor_2019_2.disciplina
-- adicionando restrinção, nome nao importa
ADD CONSTRAINT fk_disciplina_sala
-- dentro da tabela a coluna que esta ligndo a outra omo chave estrangeira
FOREIGN KEY (c_sala)
-- ela vai se conectar ao campo numero
REFERENCES fathor_2019_2.sala (numero);

-- CRIAR A TABELA ALUNO_DISCIPLINA
CREATE table fathor_2019_2.aluno_disciplina(
cpf INT NOT NULL,
codigo INT NOT NULL,
nota DECIMAL (2) NULL,
-- chave primaria ligada as cpf e codgo
primary key (cpf, codigo),
-- index para os indices individuais para chaves multiplas finalidade de achar o dado mais rapido na tabela
INDEX idx_aluno_disciplina_codigo (codigo ASC),
INDEX idx_aluno_disciplina_cpf (cpf ASC),
-- criando a restrição/ criando a chave secundaria/ referenciando a chave de outra tabela
CONSTRAINT fk_aluno_disciplina_aluno
    FOREIGN KEY (cpf)
    REFERENCES fathor_2019_2.aluno(cpf),
CONSTRAINT fk_aluno_disciplina_disciplina
    FOREIGN KEY (codigo)
    REFERENCES fathor_2019_2.disciplina (codigo)
    );
    
-- apaga a tabela disciplina do banco de dados fathor_2019_2
-- deve ser apagado pela ordem contraria de criação de acordo com seus dependentes
-- DROP TABLE fathor_2019_2.aluno_disciplina;
-- DROP TABLE fathor_2019_2.disciplina;
-- DROP TABLE fathor_2019_2.sala;    
-- DROP TABLE fathor_2019_2.aluno;
-- DROP DATABASE fathor_2019_2;

    
    
