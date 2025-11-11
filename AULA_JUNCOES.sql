--- Listar os produtos
SELECT * FROM PRODUTO;

--- Listar a descrição do produto, o valor e o seu valor acrescido de 10%
SELECT PROD_DESCRICAO, PRO_VALOR_UNIDADE,  PRO_VALOR_UNIDADE + (0.10*PRO_VALOR_UNIDADE) AS VALOR FROM PRODUTO;

--- Listar pedidos que foram realizados em '12/04/11'
SELECT * FROM PEDIDO WHERE PED_DATA = '12/04/11';

--- Listar cliente
SELECT * FROM CLIENTE;

--- Retorna a quantidade de clientes
SELECT COUNT(*) FROM CLIENTE; 

--- Produto Cartesiano 10 x 13 -- SEM JUNÇÃO - PODE TRAZER ERRO
SELECT cli_nome, ped_data FROM pedido, cliente;

--- Realizando a junção do erro a cima 
SELECT cli_nome, ped_data FROM pedido, cliente WHERE cliente.cli_codigo = pedido.cli_codigo;

--- Colocando apelidos
SELECT c.cli_nome, p.ped_data 
FROM pedido p, cliente c 
WHERE p.cli_codigo = c.cli_codigo;

--- Realizando com Inner Join
SELECT c.cli_nome, p.ped_data 
FROM pedido p INNER JOIN cliente c 
ON p.cli_codigo = c.cli_codigo; 

--- Listar os pedidos (Numero do pedido e nome do cliente, nome do vendedor)
SELECT 
    p.ped_numero, 
    c.cli_nome, 
    v.ven_nome
FROM pedido p
INNER JOIN cliente c
    ON p.cli_codigo = c.cli_codigo
INNER JOIN vendedor v
    ON p.ven_codigo = v.ven_codigo;
    
--- Listar os pedidos efetuados pelo vendedor Josias(ped_numero, ped_data, pro_descricao)

SELECT p.ped_numero, p.ped_data, prod_descricao
FROM pedido p
INNER JOIN vendedor v 
    ON p.ven_codigo = v.ven_codigo 
INNER JOIN item_do_pedido ip
    ON p.ped_numero = ip.ped_numero
INNER JOIN produto pr
    ON ip.pro_codigo = pr.pro_codigo
WHERE v.ven_nome = 'Josias';

--- VERSÃO PROFESSORA SOBRE O DESAFIO
SELECT p.ped_numero, p.ped_data, pr.prod_descricao
FROM pedido p, item_do_pedido i, produto pr, vendedor v
WHERE p.ven_codigo = v.ven_codigo 
      AND p.ped_numero = i.ped_numero
      AND i.pro_codigo = pr.pro_codigo
      AND v.ven_nome = 'Josias';

SELECT p.ped_numero, p.ped_data, pr.prod_descricao
FROM pedido p 
INNER JOIN item_do_pedido i
    ON p.ped_numero = i.ped_numero
INNER JOIN vendedor v
    ON p.ven_codigo = v.ven_codigo
INNER JOIN produto pr
    ON pr.pro_codigo = i.pro_codigo
AND
    v.ven_nome = 'Josias';
    
    
--- Listar Telefones

SELECT * FROM telefone;

--- Listar s nomes e os telefones do clientes
SELECT c.cli_codigo, c.cli_nome, t.tel_numero
FROM cliente c,
    telefone t
WHERE c.cli_codigo = t.cli_codigo(+);

SELECT c.cli_codigo, c.cli_nome, t.tel_numero
FROM cliente c,
    telefone t
WHERE c.cli_codigo = t.cli_codigo(+); -- > Apresenta todos os clientes mesmo que não tenha telefone


-- LEFT OUTER JOIN traga tudo da esquerda

SELECT c.cli_codigo, c.cli_nome, t.tel_numero
FROM cliente c LEFT OUTER JOIN telefone t
ON c.cli_codigo = t.cli_codigo;

--- RIGHT OUTER JOIN traga tudo da direita

SELECT c.cli_codigo, c.cli_nome, t.tel_numero
FROM telefone t RIGHT OUTER JOIN cliente c
ON c.cli_codigo = t.cli_codigo;


--- Colocado novas tabelas DEPARTAMENTO, FUNCIONARIO, TELEFONE2 

SELECT * FROM funcionario;

SELECT * FROM departamento;

--INTERSECÇÃO 
SELECT f.func_nome, d.dep_descricao
FROM funcionario f
INNER JOIN departamento d 
    ON f.dep_id = d.dep_id;
    
-- Trazer todos do lado esquerdo mesmo que não tenha todos os departamentos 
SELECT f.func_nome, d.dep_descricao
FROM funcionario f
LEFT OUTER JOIN departamento d 
    ON f.dep_id = d.dep_id;
    
    
SELECT f.func_nome, d.dep_descricao
FROM funcionario f
RIGHT OUTER JOIN departamento d 
    ON f.dep_id = d.dep_id;
    
    
SELECT f.func_nome, d.dep_descricao
FROM funcionario f
LEFT OUTER JOIN departamento d 
    ON f.dep_id = d.dep_id
WHERE d.dep_id IS NULL;


SELECT f.func_nome, d.dep_descricao
FROM funcionario f
RIGHT OUTER JOIN departamento d
ON f.dep_id = d.dep_id
WHERE f.dep_id is null;


SELECT f.func_nome, d.dep_descricao
FROM funcionario f
FULL OUTER JOIN departamento d
ON f.dep_id = d.dep_id;


SELECT f.func_nome, d.dep_descricao
FROM funcionario f
FULL OUTER JOIN departamento d
ON f.dep_id = d.dep_id
WHERE f.dep_id IS NULL 
OR d.dep_id IS NULL;


SELECT f.func_nome, d.dep_descricao
FROM funcionario f, departamento d
WHERE f.dep_id(+) = d.dep_id;


SELECT f.func_cod,
        f.func_nome,
        d.dep_descricao,
        t.tel_numero
FROM departamento d LEFT OUTER JOIN funcionario f
ON f.dep_id = d.dep_id
LEFT OUTER JOIN telefone2 t
ON t.func_cod = f.func_cod
ORDER BY f.func_nome, d.dep_descricao



