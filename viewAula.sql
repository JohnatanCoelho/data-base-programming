CREATE TABLE medico(
med_codigo number PRIMARY KEY,
med_nome varchar2(30),
med_salario number(10,2)
);

CREATE VIEW MEDICO_view 
AS SELECT med_codigo, med_nome FROM medico;

SELECT view_name,text FROM user_views --- VISUALIZA TODAS AS VIEWS COM MEDICO_VIEW
WHERE view_name = 'MEDICO_view';

CREATE OR REPLACE VIEW MEDICO_view (CODIGO,MEDICO) -- REPARA A ESTRUTURA DA VIEW - COMO ELA IRÁ APARECER
AS SELECT med_codigo, med_nome FROM medico;

SELECT * FROM Medico;

INSERT INTO MEDICO values(1, 'Maria', 5000.00);
INSERT INTO MEDICO values(2, 'João', 3500.00);
INSERT INTO MEDICO values(3, 'Maria José', 0.0);

DROP VIEW MEDICO_view;


--- SEQUENCIAS

CREATE SEQUENCE dep_id_seq
INCREMENT BY 10
START WITH 120
MAXVALUE 9999

SELECT sequence_name, min_value, max_value, increment_by, last_number
FROM user_sequences
WHERE sequence_name='DEP_ID_SEQ';

INSERT INTO departamento(dep_id, dep_descricao) values(dep_id_seq.nextval, 'Vendas');
INSERT INTO departamento(dep_id, dep_descricao) values(dep_id_seq.nextval, 'Contabilidade');

SELECT * FROM departamento;

SELECT dep_id_seq.currval from dual; --> dual é uma tabela ficticia para realizar testes

ALTER SEQUENCE dep_id_seq
INCREMENT BY 1
MAXVALUE 99999;

INSERT INTO departamento(dep_id, dep_descricao) values(dep_id_seq.nextval, 'Departamento de Recorte');


DROP SEQUENCE S;


CREATE SEQUENCE s
MAXVALUE 6
MINVALUE 3


