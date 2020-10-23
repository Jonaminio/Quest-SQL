CREATE SCHEMA EMPRESA;
-- criando tabelas
use empresa;
CREATE TABLE EMPRESA.DEPARTAMENTO(
numero int NOT NULL,
nome varchar(15) NOT NULL,
cpf_gerente CHAR (11),
PRIMARY KEY (numero)
);
CREATE TABLE EMPRESA.FUNCIONARIO(
cpf char(11) NOT NULL,
nome varchar(15) NOT NULL,
sobrenome VARCHAR(15) NOT NULL,
salario decimal (10,2) NOT NULL,
PRIMARY KEY (cpf)
);
CREATE TABLE EMPRESA.TRABALHA(
cpf char(11) NOT NULL,
numero int NOT NULL,
horas int NOT NULL,
PRIMARY KEY (cpf, numero),
INDEX idx_cpf (cpf ASC),
INDEX idx_numero (numero ASC),

CONSTRAINT fk_trabalha_funcionario
    FOREIGN KEY (cpf)
    REFERENCES empresa.funcionario(cpf),
CONSTRAINT fk_trabalha_departamento
    FOREIGN KEY (numero)
    REFERENCES empresa.departamento (numero)
);
CREATE TABLE EMPRESA.DEPENDENTES(
cpf_funcionario char(11) NOT NULL,
nome varchar(15) NOT NULL,
sobrenome VARCHAR(15) NOT NULL,

CONSTRAINT fk_Funcionario_dependentes
    FOREIGN KEY (cpf_funcionario)
    REFERENCES empresa.funcionario(cpf)
);
 commit;
 use empresa;
-- inserindo valores a departamento
 INSERT INTO departamento VALUES (1,'Diretoria', 44455566677 );
 INSERT INTO departamento VALUES (2,'Administração', 22233344455 );
 INSERT INTO departamento VALUES (3,'Produção', 55566677788 );
 
 SELECT * FROM empresa.departamento;
 commit;
-- inserindo valores a funcionario
INSERT INTO funcionario VALUES (11122233344,'João','Silva', 3000.00 );
INSERT INTO funcionario VALUES (22233344455,'Fernando','Almeida', 3500.00 );
INSERT INTO funcionario VALUES (33344455566,'Alice','Machado', 2500.00 );
INSERT INTO funcionario VALUES (44455566677,'Jennifer','Souza', 4500.00 );
INSERT INTO funcionario VALUES (55566677788,'Ronaldo','Lima', 3500.00 );
INSERT INTO funcionario VALUES (66677788899,'Joice','Leite', 1300.00 );
INSERT INTO funcionario VALUES (77788899900,'André','Pereira', 2000.00 );
INSERT INTO funcionario VALUES (88899900011,'Jorge','Brito', 1500.00 );

 SELECT * FROM empresa.funcionario;
 commit;
-- inserindo valores a trabalha
INSERT INTO trabalha VALUES (11122233344,2,8);
INSERT INTO trabalha VALUES (22233344455,2,8);
INSERT INTO trabalha VALUES (33344455566,3,8);
INSERT INTO trabalha VALUES (44455566677,1,8);
INSERT INTO trabalha VALUES (55566677788,3,8);
INSERT INTO trabalha VALUES (66677788899,3,8);
INSERT INTO trabalha VALUES (77788899900,2,8);
INSERT INTO trabalha VALUES (88899900011,3,8);

SELECT * FROM empresa.trabalha;
 commit;
-- inserindo valores a dependentes
INSERT INTO dependentes VALUES (44455566677, 'Alicia', 'Souza');
INSERT INTO dependentes VALUES (33344455566, 'Tiago','Machado');
INSERT INTO dependentes VALUES (88899900011, 'Jamile', 'Brito');
INSERT INTO dependentes VALUES (22233344455, 'Antônio', 'Almeida');
INSERT INTO dependentes VALUES (11122233344, 'Michael', 'Silva');
INSERT INTO dependentes VALUES (44455566677, 'Alice', 'Souza');

SELECT * FROM empresa.dependentes;
 commit;
 
 -- c) Liste os funcionários com salário entre 1.000 e 3.000; 
SELECT * FROM FUNCIONARIO WHERE salario >= 1000 AND salario <= 3000;

-- d) Aplique um aumento de 10% aos funcionários que ganham abaixo de 2.000 e liste-os;
Select cpf, nome, sobrenome, salario, (salario + (salario * 0.1)) as salario_aumento From funcionario WHERE salario < 2000;
UPDATE empresa.funcionario SET salario = ((salario * 0,1 ) + salario) WHERE salario < 2000;

-- e) Liste o nome, sobrenome, salário e nome do departamento de cada funcionário;
SELECT funcionario.nome, sobrenome, salario , departamento.nome
FROM empresa.funcionario,
	 empresa.departamento,
     empresa.trabalha
WHERE funcionario.cpf = trabalha.cpf
  AND departamento.numero = trabalha.numero;
  
-- f) Liste nome e sobrenome dos funcionários e dos seus dependentes;
SELECT funcionario.nome, funcionario.sobrenome, dependentes.nome as Dependentes_Nome, dependentes.sobrenome as Dependentes_Sobrenome
FROM empresa.funcionario,
     empresa.dependentes
WHERE funcionario.cpf = dependentes.cpf_funcionario
order by nome;
-- join
SELECT funcionario.nome, funcionario.sobrenome, dependentes.nome as Dependentes_Nome, dependentes.sobrenome as Dependentes_Sobrenome
FROM empresa.funcionario
join empresa.dependentes
on funcionario.cpf = dependentes.cpf_funcionario
order by nome;

-- g) Liste nome e sobrenome dos funcionários e dos dependentes, tantos os que possuem quanto os que não possuem dependentes, ordenados pelo nome do funcionário;
SELECT funcionario.nome, funcionario.sobrenome, dependentes.nome as Dependentes_Nome, dependentes.sobrenome as Dependentes_Sobrenome
FROM empresa.funcionario
     LEFT OUTER JOIN
     empresa.dependentes ON funcionario.cpf = dependentes.cpf_funcionario
     order by funcionario.nome;
     
-- h) Liste o nome, sobrenome, salário, nome do departamento e nome do gerente de cada funcionário;
SELECT funcionario.nome, sobrenome, salario , departamento.nome as Departamento, cpf_gerente,funcionario.nome as Gerente
FROM empresa.funcionario,
	 empresa.departamento,
     empresa.trabalha
  where departamento.numero = trabalha.numero
  and funcionario.cpf = trabalha.cpf;
  

