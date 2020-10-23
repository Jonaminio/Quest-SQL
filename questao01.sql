-- ---------------- AULA 1 -----------------------
-- ##APAGA O BANCO DE DADOS SE ELE EXISTIR:
 DROP DATABASE IF EXISTS fathor_2019_2;
 DROP DATABASE fathor_2019_2;

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

-- ----------------------AULA 3 ------------------------------

use fathor_2019_2;
SELECT * FROM fathor_2019_2.aluno;

INSERT INTO fathor_2019_2.aluno VALUES (111222333, 'Fulano', 'Silva', NULL);
INSERT INTO fathor_2019_2.aluno VALUES (222333444, 'Sicrano', 'Lima', 33334444);
INSERT INTO fathor_2019_2.aluno VALUES (333444555, 'Beltrano', 'Costa', 44445555);
SELECT * FROM fathor_2019_2.aluno;

-- atualizando e adicionando o telefone pelo cpf 111222333 chave primaria
UPDATE fathor_2019_2.aluno SET telefone = 22223333 where cpf = 111222333;

SELECT * FROM fathor_2019_2.aluno WHERE cpf = 111222333;
SELECT * FROM fathor_2019_2.aluno;

UPDATE fathor_2019_2.aluno SET telefone = 33334444;
SELECT * FROM fathor_2019_2.aluno;
-- ROLLBACK; -- VOLTAR DADOS ANTERIORES

-- INSERINDO DADOS NA TABELA SALA modo 01
INSERT INTO fathor_2019_2.sala (numero, ala, lugares) VALUES (308, 'A', 50);
INSERT INTO fathor_2019_2.sala (numero, ala, lugares) VALUES (309, 'B', 50);
INSERT INTO fathor_2019_2.sala (numero, ala, lugares) VALUES (310, 'C', 50);
SELECT * FROM fathor_2019_2.sala;
COMMIT;

-- INSERINDO DADOS NA TABELA DISCIPLINA
INSERT INTO disciplina (codigo, descricao, c_sala, ha) VALUES (10, 'S.I.', 308, 80);
INSERT INTO disciplina (codigo, descricao, c_sala, ha) VALUES (11, 'Redes', 309, 80);
INSERT INTO disciplina (codigo, descricao, c_sala, ha) VALUES (12, 'B.D.', 310, 80);
COMMIT;
SELECT * FROM fathor_2019_2.disciplina;

INSERT INTO aluno_disciplina VALUES (111222333, 10, NULL);
INSERT INTO aluno_disciplina VALUES (111222333, 11, NULL);
INSERT INTO aluno_disciplina VALUES (111222333, 12, NULL);
INSERT INTO aluno_disciplina VALUES (222333444, 10, NULL);
INSERT INTO aluno_disciplina VALUES (222333444, 11, NULL);
INSERT INTO aluno_disciplina VALUES (222333444, 12, NULL);
INSERT INTO aluno_disciplina VALUES (333444555, 10, NULL);
INSERT INTO aluno_disciplina VALUES (333444555, 11, NULL);
INSERT INTO aluno_disciplina VALUES (333444555, 12, NULL, NULL);
SELECT * FROM aluno_disciplina;
COMMIT;

-- ------------------------- AULA 04 -----------------------
DELETE FROM aluno_disciplina WHERE cpf = 333444555 and codigo = 12;
SELECT * FROM aluno_disciplina;

SELECT * FROM aluno;
SELECT cpf, nome, sobrenome, telefone FROM aluno;
SELECT cpf, sobrenome, nome FROM aluno;
SELECT cpf, nome FROM aluno;
SELECT * FROM aluno WHERE cpf = 111222333;
SELECT * FROM aluno WHERE nome = 'Sicrano' AND sobrenome = 'Lima';
SELECT * FROM aluno WHERE nome = 'Sicrano' OR sobrenome = 'Silva';
SELECT * FROM aluno WHERE cpf = '111222333' OR cpf = '333444555';
SELECT * FROM aluno ORDER BY nome;
SELECT * FROM aluno ORDER BY nome ASC;
SELECT * FROM aluno ORDER BY nome DESC;

SELECT * FROM aluno WHERE telefone IS NULL;
SELECT * FROM aluno WHERE nome LIKE 'Ful%';
SELECT * FROM aluno WHERE nome LIKE '%ano';
SELECT * FROM aluno WHERE nome LIKE '%ula%';
SELECT * FROM aluno WHERE nome LIKE '_ula%';

SELECT * FROM aluno WHERE cpf = 111222333;
SELECT * FROM aluno WHERE cpf > 111222333;
SELECT * FROM aluno WHERE cpf >= 111222333;
SELECT * FROM aluno WHERE cpf < 333444555;
SELECT * FROM aluno WHERE cpf <= 333444555;
SELECT * FROM aluno WHERE cpf <> 333444555;
SELECT * FROM aluno WHERE cpf <> 333444555 AND cpf <> 11122233;

ALTER TABLE aluno_disciplina CHANGE COLUMN nota nota_p1 DOUBLE;
ALTER TABLE aluno_disciplina ADD COLUMN nota_p2 DOUBLE NULL DEFAULT NULL AFTER nota_p1;

-- atualzando e botando dados na aluno_diciplina
UPDATE aluno_disciplina SET nota_p1=10.0, nota_p2=9.0 WHERE cpf=111222333 and codigo=10;
UPDATE aluno_disciplina SET nota_p1=9.5, nota_p2=8.0 WHERE cpf=111222333 and codigo=11;
UPDATE aluno_disciplina SET nota_p1=7.0, nota_p2=6.5 WHERE cpf=111222333 and codigo=12;
UPDATE aluno_disciplina SET nota_p1=5.0, nota_p2=4.6 WHERE cpf=222333444 and codigo=10;
UPDATE aluno_disciplina SET nota_p1=3.5, nota_p2=4.0 WHERE cpf=222333444 and codigo=11;
UPDATE aluno_disciplina SET nota_p1=4.0, nota_p2=4.2 WHERE cpf=222333444 and codigo=12;
UPDATE aluno_disciplina SET nota_p1=8.2, nota_p2=7.6 WHERE cpf=333444555 and codigo=10;
UPDATE aluno_disciplina SET nota_p1=7.5, nota_p2=8.0 WHERE cpf=333444555 and codigo=11;
UPDATE aluno_disciplina SET nota_p1=3.8, nota_p2=6.5 WHERE cpf=333444555 and codigo=12;
COMMIT;
SELECT * FROM aluno_disciplina;

-- condiçoes de mostragem de notas
SELECT * FROM aluno_disciplina WHERE nota_p1 < 7;
SELECT * FROM aluno_disciplina WHERE nota_p1 < 7 AND nota_p2 < 7;
SELECT * FROM aluno_disciplina WHERE nota_p1 < 7 OR nota_p2 < 7;
SELECT * FROM aluno_disciplina WHERE nota_p1 <= 4;
SELECT * FROM aluno_disciplina WHERE nota_p1 <= 4 AND nota_p2 <=4;
SELECT * FROM aluno_disciplina WHERE nota_p1 <= 4 OR nota_p2 <= 4;
SELECT * FROM aluno_disciplina WHERE nota_p1 BETWEEN 0 AND 4.0;
SELECT * FROM aluno_disciplina WHERE nota_p1 BETWEEN 0 AND 4.0 OR nota_p2 BETWEEN 0 AND 4.0;
-- ----------------------- AULA 5--------------------------------
 -- juntando duas tabelas aluno e aluno disciplina e mostrando
 SELECT aluno.cpf, nome, sobrenome, nota_p1, nota_p2, codigo
 FROM fathor_2019_2.aluno, fathor_2019_2.aluno_disciplina
 WHERE aluno.cpf = aluno_disciplina.cpf; 
 
-- pegando a relação (nota_p1 >= 4 OR nota_p2 >=4)
SELECT aluno.cpf, nome, sobrenome, nota_p1, nota_p2, codigo
from fathor_2019_2.aluno, fathor_2019_2.aluno_disciplina
WHERE aluno.cpf = aluno_disciplina.cpf
  AND (nota_p1 >= 4 OR nota_p2 >=4)
order by nome;

-- juntando 3 ou mais tabelas
SELECT aluno.cpf, nome, sobrenome, nota_p1, nota_p2, disciplina.codigo, descricao
from fathor_2019_2.aluno,
     fathor_2019_2.aluno_disciplina,
	 fathor_2019_2.disciplina
WHERE aluno.cpf = aluno_disciplina.cpf
  AND disciplina.codigo = aluno_disciplina.codigo; 
  
-- adicionndo apelidos para facilitar a costrução do cod. 
SELECT al.cpf, al.nome, al.sobrenome, 
	   ad.nota_p1 as p1, ad.nota_p2 as p2, 
       ds.codigo, ds.descricao
from fathor_2019_2.aluno AL,
     fathor_2019_2.aluno_disciplina AD,
	 fathor_2019_2.disciplina DS
WHERE al.cpf = ad.cpf
  AND ds.codigo = ad.codigo; 
  
 -- --------------------- AULA 06 ----------------------------------
 INSERT INTO fathor_2019_2.aluno
     VALUES (444555666, 'Margarida', 'Branca', 55556666);
     SELECT * FROM fathor_2019_2.aluno;
     COMMIT;
   
 INSERT INTO fathor_2019_2.disciplina
     VALUES (13, 'Algoritimo', 310, 80);
     SELECT * FROM fathor_2019_2.disciplina;
     COMMIT;
     
  INSERT INTO fathor_2019_2.sala
     VALUES (311, 'D', 50);
     SELECT * FROM fathor_2019_2.sala;
     COMMIT;    
     
 -- cros join
 SELECT *
 FROM fathor_2019_2.aluno, fathor_2019_2.aluno_disciplina;
 -- 02
 SELECT *
 FROM fathor_2019_2.aluno 
       CROSS JOIN fathor_2019_2.aluno_disciplina;
-- inner join 
SELECT *
FROM fathor_2019_2.aluno, fathor_2019_2.aluno_disciplina
WHERE aluno.cpf = aluno_disciplina.cpf;
-- 02
SELECT cpf
FROM fathor_2019_2.aluno
	NATURAL JOIN fathor_2019_2.aluno_disciplina;
-- 03
SELECT *
FROM fathor_2019_2.aluno
	JOIN fathor_2019_2.aluno_disciplina USING (cpf);
-- 04
SELECT *
FROM fathor_2019_2.aluno
	JOIN fathor_2019_2.aluno_disciplina
    ON aluno.cpf = aluno_disciplina.cpf;
    
-- OUTER JOIN, QUANDO QUERO O DADOS A DIREITA OU ESQUERDA OU TODOS
SELECT * 
FROM fathor_2019_2.aluno
     LEFT OUTER JOIN
     fathor_2019_2.aluno_disciplina ON aluno.cpf = aluno_disciplina.cpf;
     
SELECT * 
FROM fathor_2019_2.aluno
     LEFT OUTER JOIN
     fathor_2019_2.aluno_disciplina ON aluno.cpf = aluno_disciplina.cpf 
     LEFT OUTER JOIN
     fathor_2019_2.disciplina ON aluno_disciplina.codigo = disciplina.codigo;
-- direita para aparecer a disciplina
SELECT * 
FROM fathor_2019_2.aluno
     RIGHT OUTER JOIN
     fathor_2019_2.aluno_disciplina ON aluno.cpf = aluno_disciplina.cpf;
     
SELECT * 
FROM fathor_2019_2.aluno
     RIGHT OUTER JOIN
     fathor_2019_2.aluno_disciplina ON aluno.cpf = aluno_disciplina.cpf 
     RIGHT OUTER JOIN
     fathor_2019_2.disciplina ON aluno_disciplina.codigo = disciplina.codigo;

-- FULL JOIN
(SELECT *
FROM fathor_2019_2.aluno LEFT OUTER JOIN
     fathor_2019_2.aluno_disciplina ON aluno.cpf = aluno_disciplina.cpf
     LEFT OUTER JOIN 
     fathor_2019_2.disciplina ON aluno_disciplina.codigo = disciplina.codigo)
union 
(SELECT *
FROM fathor_2019_2.aluno RIGHT OUTER JOIN
     fathor_2019_2.aluno_disciplina ON aluno.cpf = aluno_disciplina.cpf
     RIGHT OUTER JOIN 
     fathor_2019_2.disciplina ON aluno_disciplina.codigo = disciplina.codigo);    
    
-- operações instruções de consulta (agregaçõ e agrupamento)
SELECT COUNT(nota_p1), SUM(nota_p1), MAX(nota_p1), MIN(nota_p1), AVG(nota_p1)
FROM fathor_2019_2.aluno_disciplina;

SELECT COUNT(*) FROM fathor_2019_2.aluno;

SELECT COUNT(nome) FROM fathor_2019_2.aluno;

SELECT cpf, COUNT(nota_p1), SUM(nota_p1), MAX(nota_p1),MIN(nota_p1),Avg(nota_p1)
FROM fathor_2019_2.aluno_disciplina
GROUP BY cpf;
-- por cod.
SELECT codigo, COUNT(nota_p1), SUM(nota_p1), MAX(nota_p1),MIN(nota_p1),Avg(nota_p1)
FROM fathor_2019_2.aluno_disciplina
GROUP BY codigo;

SELECT codigo, COUNT(nota_p1), SUM(nota_p1), MAX(nota_p1),MIN(nota_p1),Avg(nota_p1)
FROM fathor_2019_2.aluno_disciplina
WHERE nota_p1 >6
GROUP BY codigo
HAVING AVG(nota_p1) >6;

-- aula 07
-- conultas alinhadas

SELECT nome, sobrenome
FROM fathor_2019_2.aluno
WHERE cpf IN(
	SELECT cpf
    from fathor_2019_2.aluno_disciplina
    WHERE (nota_p1 <= 4 or nota_p2 <= 4)
    );

-- clasula IN e NOt In
SELECT nome, sobrenome
FROM fathor_2019_2.aluno
WHERE cpf NOT IN (222333444, 333444555);   

SELECT *
FROM fathor_2019_2.aluno_disciplina
WHERE (cpf, codigo) IN ((222333444, 10), (33344555, 11));

SELECT nome, sobrenome FROM fathor_2019_2.aluno WHERE cpf NOT IN (
 SELECT cpf FROM fathor_2019_2.aluno_disciplina WHERE (cpf, codigo) IN( 
  SELECT cpf, codigo FROM fathor_2019_2.aluno_disciplina WHERE (nota_p1 >= 4 or nota_p2 >= 4) and codigo = 10
  ));

-- consulta correlaciondada
SELECT nome, sobrenome , nota_p1
FROM fathor.aluno, fathor_2019_2.aluno_disciplina
WHERE aluno.cpf;;;
-- continua

-- clasula EXIST e NOT EXIST

SELECT cpf, nome, sobrenome
FROM fathor_2019_2.aluno
WHERE EXISTS (SELECT * FROM fathor_2019_2.aluno_disciplina
		      WHERE aluno.cpf = aluno_disciplina.cpf);

SELECT cpf, nome, sobrenome
FROM fathor_2019_2.aluno
WHERE NOT EXISTS (SELECT * FROM fathor_2019_2.aluno_disciplina
		      WHERE aluno.cpf = aluno_disciplina.cpf);
              
-- aula 08
-- criar ususario fathor
CREATE USER fathor@localhost IDENTIFIED BY '123456';
-- vendo os usuarios 
SELECT * FROM mysql.user;
-- dand permi de selects
GRANT SELECT ON fathor_2019_2 .* TO fathor@localhost;
GRANT ALL ON fathor_2019_2 .* TO fathor@localhost;
-- AO CRIAR O USUARIO A PERMI DE USAR garant USED JA É ALOCADA
-- mostrar as permissoes
SHOW GRANTS FOR root@localhost;
SHOW GRANTS FOR fathor@localhost;
-- remever privilegios nessa caso removendo o select
REVOKE SELECT ON fathor_2019_2.* FROM fathor@localhost;
-- deletar usuariao
DELETE FROM mysql.user WHERE user = 'fathor';

