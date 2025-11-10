USE SneezePharma
GO

-- LISTAR SITUACAO

SELECT * FROM Situation;

-- LISTAR CLIENTES

SELECT * FROM Customers;

-- LISTAR CLIENTES RESTRITOS

SELECT * FROM RestrictedCustomers;

-- LISTAR TELEFONES

SELECT * FROM Phones;

-- LISTAR FORNECEDORES

SELECT * FROM Suppliers;

-- LISTAR FORNECEDORES BLOQUEADOR

SELECT * FROM RestrictedSuppliers;

-- LISTAR VENDAS

SELECT * FROM Sales;

-- LISTAR ITENS DA VENDA

SELECT * FROM SalesItems;

-- LISTAR COMPRAS

SELECT * FROM Purchases;

-- LISTAR ITENS DA COMPRA

SELECT * FROM PurchaseItem;

-- LISTAR PRINCIPIOS ATIVOS

SELECT * FROM Ingredients;

-- LISTAR MEDICAMENTOS

SELECT * FROM Medicine;

-- LISTAR PRODUCAO

SELECT * FROM Produce;

-- LISTAR ITEM DA PRODUCAO

SELECT * FROM ProduceItem;

-- LISTAR CATEGORIAS

SELECT * FROM Category;


-- Listar Clientes - Vendas

SELECT 
    c.Nome, 
    c.CPF, 
    COUNT(s.IDVenda) AS TotalVendas,
    SUM(s.ValorTotal) AS ValorTotalCompras
FROM Customers c
LEFT JOIN Sales s ON c.IDCliente = s.IDCliente
GROUP BY c.Nome, c.CPF
ORDER BY ValorTotalCompras DESC;


-- Listar Fornecedores - Compras

SELECT 
    s.RazaoSocial, 
    s.CNPJ, 
    s.Pais,
    COUNT(p.IDCompra) AS TotalCompras,
    SUM(p.ValorTotal) AS ValorTotalComprado
FROM Suppliers s
LEFT JOIN Purchases p ON s.IDFornecedor = p.IDFornecedor
GROUP BY s.RazaoSocial, s.CNPJ, s.Pais
ORDER BY ValorTotalComprado DESC;


-- Listar Produções - Medicamentos

SELECT 
    me.Nome, 
    SUM(p.Quantidade) AS QuantidadeTotalProduzida
FROM Produce p
INNER JOIN Medicine me ON p.CDB = me.CDB
GROUP BY me.Nome
ORDER BY QuantidadeTotalProduzida DESC;


-- Listar Quantidade Total de Produções - Medicamentos

SELECT me.Nome, SUM(p.Quantidade) AS QuantidadeTotalProduzida FROM Produce p
INNER JOIN Medicine me
ON p.CDB = me.CDB GROUP BY me.Nome, p.Quantidade

-- Listar Clientes Restritos - Clientes

SELECT 
    c.Nome, 
    c.CPF, 
    s.TipoSituacao
FROM RestrictedCustomers rc
INNER JOIN Customers c ON rc.IDCliente = c.IDCliente
INNER JOIN Situation s ON c.IDSituacao = s.IDSituacao
ORDER BY c.Nome;


-- Listar Fornecedores Restritos - Fornecedores

SELECT s.RazaoSocial, s.CNPJ, s.Pais, si.TipoSituacao FROM RestrictedSuppliers rs
INNER JOIN Suppliers s
ON rs.IDFornecedor = s.IDFornecedor
INNER JOIN Situation si
ON si.IDSituacao = s.IDSituacao

-- Relatorio de Fornecedores que mais venderam

SELECT 
    s.RazaoSocial,
    s.Pais,
    SUM(p.ValorTotal) AS TotalFornecido,
    MAX(s.UltimoFornecimento) AS UltimoFornecimento
FROM Suppliers s
INNER JOIN Purchases p ON s.IDFornecedor = p.IDFornecedor
GROUP BY s.RazaoSocial, s.Pais
ORDER BY TotalFornecido DESC;


-- Relatório de Medicamentos mais vendidos

SELECT 
    me.Nome AS Produto,
    SUM(si.Quantidade) AS QuantidadeVendidaTotal,
    me.ValorVenda AS ValorUnitario,
    SUM(si.TotalItem) AS ValorVendidoTotal
FROM SalesItems si
INNER JOIN Sales s ON si.IDVenda = s.IDVenda
INNER JOIN Medicine me ON si.CDB = me.CDB
GROUP BY me.Nome, me.ValorVenda
ORDER BY QuantidadeVendidaTotal DESC;


-- Relatório de vendas por Período

SELECT 
    c.Nome,
    COUNT(s.IDVenda) AS TotalVendas,
    SUM(s.ValorTotal) AS TotalVendido
FROM Customers c
INNER JOIN Sales s ON c.IDCliente = s.IDCliente
WHERE s.DataVenda BETWEEN '2025-01-01' AND '2025-12-31'
GROUP BY c.Nome
ORDER BY TotalVendido DESC;

