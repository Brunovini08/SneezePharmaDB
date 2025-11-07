USE SneezePharma

--Inserindo Situações

INSERT INTO Situation VALUES
('ATIVO'),
('INATIVO')

--Inserindo Categoria

INSERT INTO Category VALUES
('Genéricos'),
('Manipulados'),
('Homeopáticos')

--Inserindo Princípio Ativos

INSERT INTO Ingredients (Nome, IDSituacao) VALUES
('Colecalciferol', 1)

INSERT INTO Ingredients (Nome, IDSituacao) VALUES
('Povidona', 1)

INSERT INTO Ingredients (Nome, IDSituacao) VALUES
('Talco', 1)

INSERT INTO Ingredients (Nome, IDSituacao) VALUES
('Crospovidona', 1)

INSERT INTO Ingredients (Nome, IDSituacao) VALUES
('Carboximetilcelulose', 1)

--Inserindo Clientes

INSERT INTO Customers(CPF, Nome, DataNascimento, IDSituacao) VALUES
(00057459002, 'José Aldo', '1995-10-04', 1)

INSERT INTO Customers(CPF, Nome, DataNascimento, IDSituacao) VALUES
(20793716063, 'Guilherme', '2000-11-01', 1)

INSERT INTO Customers(CPF, Nome, DataNascimento, IDSituacao) VALUES
(17654772041, 'Gustavo', '2001-04-13', 1)

INSERT INTO Customers(CPF, Nome, DataNascimento, IDSituacao) VALUES
(47998764813, 'Bruno Vinícius', '2005-11-08', 1)

INSERT INTO Customers(CPF, Nome, DataNascimento, IDSituacao) VALUES
(94603488076, 'Jefferson Nascimento', '1997-03-10', 1)

SELECT * FROM Customers

-- Inserindo Registros de Clientes Restritos

INSERT INTO  RestrictedCustomers VALUES
(3),
(4)

--Inserindo Telefones

INSERT INTO Phones(CodPais, DDD, Numero, IDCliente) VALUES
(55, 16, 6837746226, 1),
(55, 16, 9525739018, 2),
(55, 16, 2721191588, 3),
(55, 16, 4623633674, 4),
(55, 16, 6835717443, 5)

--Inserindo Fornecedores

INSERT INTO Suppliers(CNPJ, RazaoSocial, Pais, DataAbertura, IDSituacao) VALUES
(63504773000125, 'Nortec Química', 'Brasil', '1980-01-14', 1)

INSERT INTO Suppliers(CNPJ, RazaoSocial, Pais, DataAbertura, IDSituacao) VALUES
(10728943000199, 'Cristália', 'Brasil', '2000-10-03', 1)

INSERT INTO Suppliers(CNPJ, RazaoSocial, Pais, DataAbertura, IDSituacao) VALUES
(97971620000100, 'Sigma-Aldrich', 'Arábia Saudita', '1970-05-24', 1)

INSERT INTO Suppliers(CNPJ, RazaoSocial, Pais, DataAbertura, IDSituacao) VALUES
(59755175000151, 'Metallchemie', 'Estados Unidos', '1950-01-29', 1)

INSERT INTO Suppliers(CNPJ, RazaoSocial, Pais, DataAbertura, IDSituacao) VALUES
(59755175000151, 'Zilfarma', 'Brasil', '2010-03-20', 1)

--Inserindo Registros de Fornecedores Restritos

INSERT INTO RestrictedSuppliers VALUES
(5),
(6)

-- Inserindo Registro de Remedios

INSERT INTO Medicine(CDB, Nome, ValorVenda, IDSituacao, IDCategoria) VALUES
('7891234567895', 'Ibuprofeno', 20, 1, 1)

INSERT INTO Medicine(CDB, Nome, ValorVenda, IDSituacao, IDCategoria) VALUES
('7894900011517', 'Carbamazepina', 20, 1, 2)

INSERT INTO Medicine(CDB, Nome, ValorVenda, IDSituacao, IDCategoria) VALUES
('7891000055123', 'Dorflex', 20, 1, 3)

INSERT INTO Medicine(CDB, Nome, ValorVenda, IDSituacao, IDCategoria) VALUES
('7891910000197', 'Neusa', 20, 1, 1)

INSERT INTO Medicine(CDB, Nome, ValorVenda, IDSituacao, IDCategoria) VALUES
('7896004000406', 'Dipirona', 20, 1, 2)

