CREATE TABLE departamento(
depart_cod number(4) CONSTRAINT pk_departamento_cod PRIMARY KEY,
depart_nome varchar2(30) NOT NULL,
depart_data_inicial date
);

CREATE TABLE localizacao(
depart_cod number(4),
local_depart varchar2(252),
CONSTRAINT fk_local_depart_cod FOREIGN KEY(depart_cod) REFERENCES departamento(depart_cod),
CONSTRAINT pk_local_comp PRIMARY KEY(depart_cod, local_depart)
);

CREATE TABLE funcionario(
func_cod number(4),
func_nome varchar2(100) NOT NULL,
func_cpf varchar2(15) CONSTRAINT uk_funcionario_cpf UNIQUE,
func_salario number(8,2) CONSTRAINT ck_func_salario CHECK(func_salario >= 1000),
func_endereco varchar2(252),
func_sexo char(1) CONSTRAINT ck_func_sexo CHECK(func_sexo in ('M', 'F')),
func_cod_super number(4),
depart_cod number(4) NOT NULL,
CONSTRAINT pk_funcionario_cod PRIMARY KEY(func_cod),
CONSTRAINT fk_func_cod_super FOREIGN KEY(func_cod_super) references funcionario(func_cod),
CONSTRAINT fk_func_depart_cod FOREIGN KEY(depart_cod) references departamento(depart_cod)
); 

CREATE TABLE dependente(
func_cod number(4),
dependente_seq number(4),
dependente_nome varchar2(100) NOT NULL,
dependente_parentesco varchar2(30) NOT NULL, 
dependente_data_nasc date,
CONSTRAINT ck_depend_parent CHECK(dependente_parentesco in('PAI', 'MÃE', 'IRMAOS', 'FILHOS')),
CONSTRAINT fk_dependente_func_cod FOREIGN KEY(func_cod) REFERENCES funcionario(func_cod),
CONSTRAINT pk_dependente_comp PRIMARY KEY (func_cod, dependente_seq)
);

CREATE TABLE projeto(
proj_cod number(4),
depart_cod number(4),
proj_titulo varchar2(150) NOT NULL,
proj_data_cad date default SYSDATE,
CONSTRAINT pk_projeto_cod PRIMARY KEY(proj_cod),
CONSTRAINT fk_projeto_depart_cod FOREIGN KEY(depart_cod) REFERENCES departamento(depart_cod)
);

CREATE TABLE participa(
func_cod number(4),
proj_cod number(4),
horas varchar2(50),
CONSTRAINT fk_participa_func_cod FOREIGN KEY (func_cod) REFERENCES funcionario(func_cod),
CONSTRAINT fk_participa_proj_cod FOREIGN KEY (proj_cod) REFERENCES projeto(proj_cod),
CONSTRAINT pk_participa_comp PRIMARY KEY (func_cod, proj_cod)
);







