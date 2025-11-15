USE SneezePharma
GO

CREATE OR ALTER TRIGGER trg_Sales_Insert
on Sales
AFTER INSERT
AS
BEGIN
 IF EXISTS (
        SELECT 1
        FROM RestrictedCustomers rc
        JOIN inserted i ON rc.IDCliente = i.IDCliente
    )
    BEGIN
        ROLLBACK TRANSACTION;

        THROW 50001, 'Você não pode realizar a inserção de uma venda para um cliente restrito', 1;
    END
END
GO

CREATE OR ALTER TRIGGER trg_SalesItem_Insert
ON SalesItems
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM Medicine me
        JOIN inserted i ON me.CDB = i.CDB
        WHERE me.IDSituacao <> 1
    )
    BEGIN
        RAISERROR('O medicamento deve estar ativo', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
    IF EXISTS (
        SELECT 1
        FROM (
            SELECT si.IDVenda, COUNT(*) AS total_itens
            FROM SalesItems si
            WHERE si.IDVenda IN (SELECT IDVenda FROM inserted)
            GROUP BY si.IDVenda
        ) t
        WHERE t.total_itens > 3
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50002, 'O limite máximo de itens por venda é 3', 1;
    END;
END;
GO

CREATE OR ALTER TRIGGER trg_Pucharse_Insert
on Purchases
AFTER INSERT
AS
IF EXISTS (SELECT 1 FROM RestrictedSuppliers rs JOIN inserted i ON rs.IDFornecedor = i.IDFornecedor)
	BEGIN
		RAISERROR('Você não pode realizar a inserção de uma compra para um fornecedor restrito', 1,1)
        ROLLBACK TRANSACTION
	END
GO

CREATE OR ALTER TRIGGER trg_PurchaseItem_Insert
ON PurchaseItem
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM Ingredients ing
        JOIN inserted i ON ing.IDIngrediente = i.IDIngrediente
        WHERE ing.IDSituacao <> 1
    )
    BEGIN
        RAISERROR('O ingrediente deve estar ativo', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
    IF EXISTS (
       SELECT 1
        FROM (
            SELECT pui.IDCompra, COUNT(*) AS total_itens
            FROM PurchaseItem pui
            WHERE pui.IDCompra IN (SELECT IDCompra FROM inserted)
            GROUP BY pui.IDCompra
        ) t
        WHERE t.total_itens > 3
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50002, 'O limite máximo de itens por compra é 3', 1;
    END;
END;
GO

CREATE OR ALTER TRIGGER trg_Produce_Insert
ON Produce
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
IF EXISTS (SELECT 1 FROM Medicine me JOIN inserted i ON me.CDB = i.CDB AND me.IDSituacao <> 1)
    BEGIN
        RAISERROR('O medicamento deve estar ativo', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
END
GO

CREATE OR ALTER TRIGGER trg_ProduceItem_Insert
ON ProduceItem
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM Ingredients ing JOIN inserted i ON ing.IDIngrediente = i.IDIngrediente AND ing.IDSituacao <> 1)
      BEGIN
        RAISERROR('O ingrediente deve estar ativo', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
END
GO



CREATE OR ALTER TRIGGER trg_SalesItems_TotalItem
ON SalesItems
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE SalesItems

    SET
        TotalItem = inserted.Quantidade * Medicine.ValorVenda
    FROM SalesItems
    INNER JOIN inserted ON SalesItems.IDItemVenda = inserted.IDItemVenda
    INNER JOIN Medicine ON inserted.CDB = Medicine.CDB
END
GO

CREATE OR ALTER TRIGGER trg_PurchaseItem_TotalItem
ON PurchaseItem
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE PurchaseItem

    SET
        TotalItem = inserted.Quantidade * inserted.ValorUnitario
    FROM PurchaseItem
    INNER JOIN inserted ON PurchaseItem.IDItemCompra = inserted.IDItemCompra
END
GO

CREATE OR ALTER TRIGGER trg_SalesItems_Sales
ON SalesItems
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE s
    SET s.ValorTotal = si.TotalPorVenda
    FROM Sales s
    INNER JOIN (
        SELECT IDVenda, SUM(TotalItem) AS TotalPorVenda
        FROM SalesItems
        GROUP BY IDVenda
    ) AS si ON s.IDVenda = si.IDVenda
    JOIN (SELECT DISTINCT IDVenda FROM inserted) AS i ON s.IDVenda = i.IDVenda;
END;
GO

CREATE OR ALTER TRIGGER trg_PurchaseItem_Purchases
ON PurchaseItem
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE p
    SET p.ValorTotal = (
        SELECT SUM(pui.TotalItem)
        FROM PurchaseItem pui
        WHERE pui.IDCompra = p.IDCompra
    )
    FROM Purchases p
    INNER JOIN (SELECT DISTINCT IDCompra FROM inserted) AS i
        ON p.IDCompra = i.IDCompra;
END;
GO

CREATE OR ALTER TRIGGER trg_SalesItems_Customers_Medicine
ON SalesItems
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON

    UPDATE c
    SET c.UltimaCompra = s.DataVenda
    FROM Customers c
    JOIN Sales s ON c.IDCliente = s.IDCliente
    JOIN inserted i ON s.IDVenda = i.IDVenda

    UPDATE m
    SET m.UltimaVenda = s.DataVenda
    FROM Medicine m
    JOIN inserted i ON m.CDB = i.CDB
    JOIN Sales s ON s.IDVenda = i.IDVenda
END
GO



CREATE OR ALTER  TRIGGER trg_Purchases_Suppliers_Ingredients
ON PurchaseItem
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON

    UPDATE s
    SET s.UltimoFornecimento = p.DataCompra
    FROM Suppliers s
    JOIN Purchases p ON s.IDFornecedor = p.IDFornecedor
    JOIN inserted i ON p.IDCompra = i.IDCompra

    UPDATE ing
    SET ing.UltimaCompra = p.DataCompra
    FROM Ingredients ing
    JOIN inserted i ON ing.IDIngrediente = i.IDIngrediente
    JOIN Purchases p ON p.IDCompra = i.IDCompra
END
GO

CREATE OR ALTER TRIGGER trg_Verificar_Idade
ON Sales
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Customers c ON i.IDCliente = c.IDCliente
        WHERE DATEDIFF(YEAR, c.DataNascimento, GETDATE()) 
              - CASE 
                    WHEN DATEADD(YEAR, DATEDIFF(YEAR, c.DataNascimento, GETDATE()), c.DataNascimento) > GETDATE() 
                    THEN 1 ELSE 0 
                END < 18
    )
    BEGIN
        RAISERROR('A pessoa deve ter pelo menos 18 anos para ser cadastrada.', 16, 1);
        ROLLBACK TRANSACTION
    END
END;
GO

CREATE OR ALTER TRIGGER trg_Verificar_Idade_Fornecedor
ON Purchases
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Suppliers s ON i.IDFornecedor = s.IDFornecedor
        WHERE DATEDIFF(YEAR, s.DataAbertura, GETDATE()) 
              - CASE 
                    WHEN DATEADD(YEAR, DATEDIFF(YEAR, s.DataAbertura, GETDATE()), s.DataAbertura) > GETDATE() 
                    THEN 1 ELSE 0 
                END < 2
    )
    BEGIN
        RAISERROR('O fornecedor deve ter mais de dois anos de criação de CNPJ', 16, 1);
        ROLLBACK TRANSACTION
    END
END;
GO
