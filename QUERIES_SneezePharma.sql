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

SELECT c.Nome, c.CPF, s.ValorTotal FROM Customers c
INNER JOIN Sales s 
ON c.IDCliente = s.IDCliente

-- Listar Fornecedores - Compras

SELECT * FROM Suppliers s
INNER JOIN Purchases p
ON s.IDFornecedor = p.IDFornecedor

-- Listar Produções - Medicamentos

SELECT me.Nome, p.Quantidade, p.DataProducao FROM Produce p
INNER JOIN Medicine me 
ON p.CDB = me.CDB 


-- Listar Quantidade Total de Produções - Medicamentos

SELECT me.Nome, SUM(p.Quantidade) AS QuantidadeTotalProduzida FROM Produce p
INNER JOIN Medicine me
ON p.CDB = me.CDB GROUP BY me.Nome, p.Quantidade

-- Listar Clientes Restritos - Clientes

SELECT c.Nome, c.CPF, s.TipoSituacao FROM RestrictedCustomers rc
INNER JOIN Customers c
ON rc.IDCliente = c.IDCliente
INNER JOIN Situation s
ON s.IDSituacao = c.IDSituacao

-- Listar Fornecedores Restritos - Fornecedores

SELECT s.RazaoSocial, s.CNPJ, s.Pais, si.TipoSituacao FROM RestrictedSuppliers rs
INNER JOIN Suppliers s
ON rs.IDFornecedor = s.IDFornecedor
INNER JOIN Situation si
ON si.IDSituacao = s.IDSituacao

-- Relatorio de Fornecedores que mais venderam

SELECT s.RazaoSocial, s.Pais, p.ValorTotal, s.UltimoFornecimento FROM Suppliers s
INNER JOIN Purchases p
ON s.IDFornecedor = p.IDFornecedor
GROUP BY s.CNPJ, p.ValorTotal ORDER BY p.ValorTotal 

-- Relatório de Medicamentos mais vendidos

SELECT me.Nome as Produto,
	   SUM(si.Quantidade) AS QuantidadeVendidaTotal,
	   me.ValorVenda AS ValorUnitario,
	   SUM(si.TotalItem) AS ValorVendidoTotal
FROM Sales s
INNER JOIN SalesItems si
ON s.IDVenda = si.IDVenda
INNER JOIN Medicine me
ON si.CDB = me.CDB
GROUP BY me.Nome, me.ValorVenda
ORDER BY QuantidadeVendidaTotal DESC

-- Relatório de vendas por Período

SELECT c.Nome, c.UltimaCompra, s.ValorTotal FROM Customers c
INNER JOIN Sales s
ON c.IDCliente = s.IDCliente
WHERE s.DataVenda BETWEEN '2025-01-01' AND '2025-12-31'

