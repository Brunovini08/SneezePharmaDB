USE SneezePharma

CREATE TYPE TYPESalesItems AS TABLE(
	CDB VARCHAR(13) NOT NULL,
	Quantidade INT NOT NULL
)
GO

CREATE TYPE TYPEProduceItems AS TABLE(
    IDIngrediente INT NOT NULL,
    QuantidadePrincipio NUMERIC NOT NULL
)
GO

CREATE TYPE TYPEPurchaseItems AS TABLE(
    IDIngrediente INT NOT NULL,
    Quantidade INT NOT NULL,
    ValorUnitario DECIMAL NOT NULL
)
GO

CREATE OR ALTER PROCEDURE sp_Sales
@idCustomer INT,
@Items TYPESalesItems READONLY
AS
BEGIN
 SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @idSale INT;

        INSERT INTO Sales(IDCliente, DataVenda)
        VALUES(@idCustomer, GETDATE());

        SET @idSale = SCOPE_IDENTITY();

        INSERT INTO SalesItems(IDVenda, CDB, Quantidade)
        SELECT @idSale, CDB, Quantidade 
        FROM @Items;

        COMMIT TRANSACTION;
        SELECT @idSale AS IdVenda;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW
    END CATCH
END;
GO

DECLARE @Items TYPESalesItems;

INSERT INTO @Items(CDB, Quantidade) 
VALUES
('7891000055123', 10),
('7891234567895', 10)

EXEC sp_Sales @idCustomer = 5, @Items = @Items

SELECT * FROM Sales
SELECT * FROM SalesItems
GO

CREATE OR ALTER PROCEDURE sp_Produce
@CDB VARCHAR(13),
@Quantidade INT,
@Items TYPEProduceItems READONLY
AS
BEGIN
 SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @idProduce INT;

        INSERT INTO Produce(CDB, DataProducao, Quantidade)
        VALUES(@CDB, GETDATE(), @Quantidade);

        SET @idProduce = SCOPE_IDENTITY();

        INSERT INTO ProduceItem(IDProducao, IDIngrediente, QuantidadePrincipio)
        SELECT @idProduce, IDIngrediente, QuantidadePrincipio
        FROM @Items;

        COMMIT TRANSACTION;
        SELECT @idProduce AS IDProducao;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW
    END CATCH
END
GO

DECLARE @Items TYPEProduceItems;

INSERT INTO @Items(IDIngrediente, QuantidadePrincipio) 
VALUES
(2, 10),
(1, 10)

EXEC sp_Produce @CDB = "7891910000197", @Quantidade = 10, @Items = @Items

SELECT * FROM Ingredients
SELECT * FROM Produce
SELECT * FROM ProduceItem
GO

CREATE OR ALTER PROCEDURE sp_Purchase
@IDFornecedor INT,
@Items TYPEPurchaseItems READONLY
AS
BEGIN
 SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @idPurchase INT;

        INSERT INTO Purchases(IDFornecedor, DataCompra)
        VALUES(@IDFornecedor, GETDATE());

        SET @idPurchase = SCOPE_IDENTITY();

        INSERT INTO PurchaseItem(IDCompra, IDIngrediente, Quantidade, ValorUnitario)
        SELECT @idPurchase, IDIngrediente, Quantidade, ValorUnitario
        FROM @Items;

        COMMIT TRANSACTION;
        SELECT @idPurchase AS IDVenda;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW
    END CATCH
END
GO


DECLARE @Items TYPEPurchaseItems;

INSERT INTO @Items(IDIngrediente, Quantidade, ValorUnitario) 
VALUES
(2, 10, 10),
(1, 10, 20)

EXEC sp_Purchase  @IDFornecedor = 1, @Items = @Items

SELECT * FROM Ingredients
SELECT * FROM Purchases
SELECT * FROM PurchaseItem
GO

