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
(59756175000151, 'Zilfarma', 'Brasil', '2010-03-20', 1)

--Inserindo Registros de Fornecedores Restritos

INSERT INTO RestrictedSuppliers VALUES
(4),
(5)

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

-- Inserindo Produção

INSERT INTO Produce (CDB, Quantidade) VALUES
('7891000055123', 10)

INSERT INTO Produce (CDB, Quantidade) VALUES
('7891234567895', 60)

INSERT INTO Produce (CDB, Quantidade) VALUES
('7891910000197', 50)

INSERT INTO Produce (CDB, Quantidade) VALUES
('7894900011517', 70)

INSERT INTO Produce (CDB, Quantidade) VALUES
('7896004000406', 98)

-- Inserindo Item da Produção

INSERT INTO ProduceItem (IDProducao, IDIngrediente, QuantidadePrincipio) VALUES
( 1, 1, 33)

INSERT INTO ProduceItem (IDProducao, IDIngrediente, QuantidadePrincipio) VALUES
( 2, 2, 100)

INSERT INTO ProduceItem (IDProducao, IDIngrediente, QuantidadePrincipio) VALUES
( 3, 3, 47)

INSERT INTO ProduceItem (IDProducao, IDIngrediente, QuantidadePrincipio) VALUES
( 4, 4, 63)

INSERT INTO ProduceItem (IDProducao, IDIngrediente, QuantidadePrincipio) VALUES
( 5, 5, 72)

-- Inserindo Venda

INSERT INTO Sales (IDCliente) VALUES
(1)

INSERT INTO Sales (IDCliente) VALUES
(2)

INSERT INTO Sales (IDCliente) VALUES
(5)

INSERT INTO Sales (IDCliente) VALUES
(2)

INSERT INTO Sales (IDCliente) VALUES
(5)

-- Inserindo Item da Venda

SELECT * FROM Sales
SELECT * FROM SalesItems

INSERT INTO SalesItems(IDVenda, CDB, Quantidade) VALUES
(1, '7891000055123', 1)

INSERT INTO SalesItems(IDVenda, CDB, Quantidade) VALUES
(2, '7891234567895', 2)

INSERT INTO SalesItems(IDVenda, CDB, Quantidade) VALUES
(3, '7891910000197', 5)

INSERT INTO SalesItems(IDVenda, CDB, Quantidade) VALUES
(4, '7894900011517', 7)

INSERT INTO SalesItems(IDVenda, CDB, Quantidade) VALUES
(4, '7894900011517', 7)

INSERT INTO SalesItems(IDVenda, CDB, Quantidade) VALUES
(5, '7896004000406', 11)

INSERT INTO SalesItems(IDVenda, CDB, Quantidade) VALUES
(5, '7894900011517', 1)

INSERT INTO SalesItems(IDVenda, CDB, Quantidade) VALUES
(5, '7891910000197', 1)

INSERT INTO SalesItems(IDVenda, CDB, Quantidade) VALUES
(5, '7891234567895', 1)

-- Inserindo Compra

INSERT INTO Purchases (IDFornecedor) VALUES
(1)

INSERT INTO Purchases (IDFornecedor) VALUES
(2)

INSERT INTO Purchases (IDFornecedor) VALUES
(3)

INSERT INTO Purchases (IDFornecedor) VALUES
(2)

INSERT INTO Purchases (IDFornecedor) VALUES
(3)

-- Inserindo Item Compra

INSERT INTO PurchaseItem (IDCompra, IDIngrediente, Quantidade, ValorUnitario) VALUES
(1, 1, 50, 10)

INSERT INTO PurchaseItem (IDCompra, IDIngrediente, Quantidade, ValorUnitario) VALUES
(1, 3, 70, 10)

INSERT INTO PurchaseItem (IDCompra, IDIngrediente, Quantidade, ValorUnitario) VALUES
(1, 4, 60, 10)

INSERT INTO PurchaseItem (IDCompra, IDIngrediente, Quantidade, ValorUnitario) VALUES
(2, 4, 40, 10)

INSERT INTO PurchaseItem (IDCompra, IDIngrediente, Quantidade, ValorUnitario) VALUES
(4, 3, 55, 10)