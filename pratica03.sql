-- Criador do documento Johnatan Coelho de Jesus Souza e Victor Miguel de Oliveira Rodriguez 3BD

-- Questão 1 - Listar o nome da pessoa do emprèstimo de número 1
SELECT p.pes_nome
FROM EMPRESTIMO e
INNER JOIN PESSOA p 
ON e.emp_cod = 1 AND p.pes_cod = e.pes_cod;

-- Questão 2 - Listar todas as editoras ordenadas por ordem alfabética
SELECT edi_descricao FROM EDITORA
ORDER BY edi_descricao;

-- Questão 3 - Listar os títulos dos livros que começam com a letra A - Não tem nenhum livro com a letra A
SELECT l.liv_titulo 
FROM LIVRO l
WHERE l.liv_titulo LIKE 'A%';

-- Questão 4 - Exibir os títulos dos livros que começam com a letra A e que tenham o ano de publicação maior que 2013
SELECT l.liv_titulo, l.anopublicacao
FROM LIVRO l
WHERE l.liv_titulo LIKE 'A%'
AND l.anopublicacao > 2013;

-- Questão 5 - Exibir a quantidade de telefones que possuem DDD igual a 12
SELECT COUNT(t.tel_ddd)
FROM TELEFONE t
WHERE t.tel_ddd = 12;

--- Questão 6 - Listar a quantidade de empréstimo por aluno 
SELECT p.pes_cod, p.pes_nome, al.pes_nro_matricula, count(e.emp_cod) as quantidade_emprestimo
FROM Pessoa p
INNER JOIN Emprestimo e
ON p.pes_cod = e.pes_cod
INNER JOIN Aluno al
ON p.pes_cod = al.pes_cod
GROUP BY p.pes_cod, p.pes_nome, al.pes_nro_matricula;

-- Questão 7 - Listar as editoras e os seus livros
SELECT e.edi_cod, e.edi_descricao, l.liv_cod
FROM Livro l
INNER JOIN Editora e
ON e.edi_cod = l.edi_cod;

-- Questão 8 - Listar os códigos dos exemplares (exe_cod), a descricao (exe_descricao)...
SELECT e.exe_cod, e.exe_descricao, ep.emp_data_emprestimo
FROM Emprestimo ep
INNER JOIN Item_emprestimo ie
ON ep.emp_cod = ie.emp_cod
INNER JOIN Exemplar e
ON e.exe_cod = ie.exe_cod;

-- Questão 9 - Listar os livros que possuam mais de 3 exemplares
SELECT l.liv_cod, l.liv_titulo, COUNT(e.liv_cod) as quantidade_exemplar
FROM Livro l
INNER JOIN Exemplar e
ON l.liv_cod = e.liv_cod
GROUP BY l.liv_cod, l.liv_titulo
HAVING COUNT (e.liv_cod) > 3;

-- Questão 10 - Listar os professores com os telefones
-- ANSI
SELECT pf.pes_cod, pf.titulacao, t.tel_ddd, t.tel_numero
FROM Pessoa p
INNER JOIN Telefone t
ON p.pes_cod = t.pes_cod
RIGHT JOIN Professor pf
ON pf.pes_cod = p.pes_cod;

-- Oracle
SELECT pf.pes_cod, pf.titulacao, t.tel_ddd, t.tel_numero
FROM Pessoa p, Telefone t,  Professor pf
WHERE p.pes_cod = t.pes_cod(+)
and pf.pes_cod = p.pes_cod;

-- Questão 11 - Listar o livro (liv_titulo) mais antigo da biblioteca
SELECT l.liv_titulo
FROM Livro l
WHERE l.anopublicacao = (
    SELECT MIN(l2.anopublicacao) FROM Livro l2
);

-- Questão 12 - Exibir o nome da pessoa que mais emprestou livro na biblioteca
SELECT p.pes_nome, COUNT(emp.emp_cod) as quantidade_emprestimo
FROM Pessoa p
INNER JOIN Emprestimo emp
ON p.pes_cod = emp.pes_cod
GROUP BY p.pes_nome
ORDER BY quantidade_emprestimo DESC
FETCH FIRST 1 ROWS ONLY;

-- Questão 13 - Listar a quantidadde de exemplar por livro
SELECT l.liv_titulo, COUNT(ex.exe_cod) as quantidade_exemplar 
FROM Livro l
INNER JOIN Exemplar ex
ON l.liv_cod = ex.liv_cod
GROUP BY liv_titulo;

-- Questão 14 - Listar os livros (liv_titulo) que começam com A e possuem ano de publicação maior que 2011
SELECT l.liv_titulo, l.anopublicacao
FROM Livro l
WHERE l.liv_titulo LIKE 'A%'
AND l.anopublicacao > 2011;

-- Questão 15 - Listar livros emprestados pela pessoa de código 1 (Listar liv_titulo)
SELECT p.pes_cod, p.pes_nome, l.liv_titulo 
FROM Pessoa p 
INNER JOIN Emprestimo emt
ON p.pes_cod = emt.pes_cod
INNER JOIN Item_emprestimo ie
ON ie.emp_cod = emt.emp_cod
INNER JOIN Exemplar ex
ON ex.exe_cod = ie.exe_cod
INNER JOIN Livro l
ON l.liv_cod = ex.liv_cod
WHERE p.pes_cod = 1
GROUP BY p.pes_cod, p.pes_nome, l.liv_titulo;

-- Questão 16 - Criar mais 7 consultas (Perguntas e Respostas), seguindo as sintaxes apresentadas na imagem a 
--seguir e o modelo lógico da Biblioteca. 

-- Left Join - Liste todas as pessoas cadastradas(Mesmo que não tenha feito emprestimo) 
-- com a data de emprestimo.
SELECT p.pes_nome, e.emp_data_emprestimo
FROM Pessoa p
LEFT JOIN Emprestimo e
ON p.pes_cod = e.pes_cod
GROUP BY p.pes_nome, e.emp_data_emprestimo;

-- Right Join - Liste todos os empréstimos cadastrados e também a data de devolução.
-- Mesmo que não haja a data de devolução
SELECT ep.emp_cod, ep.emp_data_emprestimo, dev.data_dev
FROM Devolucao dev
RIGHT JOIN Emprestimo ep
ON ep.emp_cod = dev.emp_cod
INNER JOIN Item_emprestimo ip
ON ip.emp_cod = ep.emp_cod
GROUP BY ep.emp_cod, ep.emp_data_emprestimo, dev.data_dev;

-- INNER JOIN - Listar todos as pessoas que são alunos e que tenha telefone
SELECT p.pes_nome, al.pes_nro_matricula, t.tel_numero
FROM Aluno al
INNER JOIN Pessoa p
ON al.pes_cod = p.pes_cod
INNER JOIN Telefone t
ON t.pes_cod = p.pes_cod;

-- LEFT JOIN B IS NULL - Listar as pessoas que não são professores
SELECT p.pes_cod, p.pes_nome 
FROM Pessoa p
LEFT JOIN Professor pf
ON p.pes_cod = pf.pes_cod
WHERE pf.pes_cod IS NULL;

-- RIGHT JOIN A IS NULL - Listar os livros que não tem exemplar
SELECT l.liv_cod, l.liv_titulo
FROM Exemplar ex
RIGHT JOIN Livro l
ON l.liv_cod = ex.liv_cod
WHERE ex.liv_cod IS NULL;

-- FULL OUTER JOIN - Listar todos os livros com suas editoras, mesmo que a editora 
-- não tenha livros e os livros não tenha a editora
SELECT l.liv_titulo, edt.edi_descricao
FROM Livro l
FULL OUTER JOIN Editora edt
ON edt.edi_cod = l.edi_cod;

-- FULL OUTER JOIN A e B IS NULL - Listar as pessoas que não são professores
-- e não são alunos
SELECT p.pes_nome, pf.titulacao, al.pes_nro_matricula
FROM Pessoa p
FULL OUTER JOIN Professor pf
ON p.pes_cod = pf.pes_cod
FULL OUTER JOIN Aluno al
ON al.pes_cod = p.pes_cod
WHERE al.pes_cod IS NULL
AND pf.pes_cod IS NULL;

