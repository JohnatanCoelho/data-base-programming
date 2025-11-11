create table departamento
(dep_id number(6) primary key,
 dep_descricao varchar2(30));

create table funcionario
(func_cod number(6) primary key,
 func_nome varchar2(20),
 func_sal number(10,2),
 dep_id number(6) references departamento (dep_id));

create table telefone2
(tel_codigo number(4) primary key,
 func_cod number(6) references funcionario(func_cod),
 tel_numero number(15) );
 
 
 create table faixa_salarial(
 fa_cod varchar2(1) CONSTRAINT fs_Pk PRIMARY KEY,
 fa_menor number(6,2),
 fa_maior number(6,2)
 );

insert into departamento values (1,'RH');
insert into departamento values (2,'Vendas');
insert into departamento values (3,'Inform�tica');
insert into departamento values (4,'Compras');

insert into funcionario values (1,'Paulo',4000.00,1);
insert into funcionario values (2,'Maria',1500.00,2);
insert into funcionario values (3,'Jo�o',4000.00,1);
insert into funcionario values (4,'Laura',5000.00,2);
insert into funcionario values (5,'Ana',6000.00,3);
insert into funcionario values (6,'Maria',null,null);


insert into telefone2 values (1,1,39231546);
insert into telefone2 values (2,2,97858999);

INSERT INTO faixa_salarial values ('A', 1000.00, 2999.00);
INSERT INTO faixa_salarial values ('B', 3000.00, 5999.00);
INSERT INTO faixa_salarial values ('C', 6000.00, 9999.00);


SELECT f.func_cod,
f.func_nome,
f.func_sal,
fa.fa_cod
FROM funcionario f, 
    faixa_salarial fa
WHERE f.func_sal between fa.fa_menor and fa.fa_maior; /* Entre a faixa salarial verifica se o salário está entre a faixa salarial maior ou menor */

ALTER TABLE funcionario add gerente_cod number(6)
REFERENCES funcionario(func_cod);

UPDATE funcionario SET gerente_cod = 5 WHERE func_cod in (1,2,3,4);

--- Busca o usuario e o gerente do mesmo 
SELECT f.func_nome, g.func_nome Gerente
FROM funcionario f, funcionario g
WHERE f.gerente_cod = g.func_cod;


-- AVG E SUM
SELECT AVG(func_sal) Média_Departamento_1 from funcionario where dep_id = 1; -- Calcula a média avg

SELECT SUM(func_sal) Soma_salário_dep_2 FROM funcionario where dep_id = 2; -- Soma dos salários SUM

SELECT AVG(func_sal), SUM(func_sal) FROM funcionario;

-- MAX E MIN 
SELECT MIN(func_sal), MAX(func_sal) FROM funcionario;


--- Função Count

SELECT COUNT(*) FROM funcionario where dep_id = 2;


SELECT COUNT(dep_id) FROM funcionario;


SELECT COUNT(DISTINCT dep_id) FROM funcionario; --- Trouxe o que não repetem

-- FUNÇÃO DE GRUPO E VALORES NULOS 
UPDATE funcionario set func_sal = NULL WHERE func_cod= 2

select * from FUNCIONARIO; 

SELECT AVG(func_sal) 
FROM funcionario;

SELECT AVG(NVL(func_sal, 0)) -- NVL todo o nulo será considerado 0, mesmo nulo
FROM funcionario;

--- Group By
UPDATE funcionario set func_sal = NULL WHERE func_cod= 2

SELECT dep_id, AVG(func_sal)
FROM funcionario 
GROUP BY dep_id

--- Having reestringe o grupo 

SELECT dep_id, AVG(func_sal)
FROM funcionario
GROUP BY dep_id
HAVING AVG(func_sal) > 4000;






