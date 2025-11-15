USE SneezePharma

CREATE TYPE TYPESalesItems AS TABLE(
	CDB VARCHAR(13) NOT NULL,
	Quantidade INT NOT NULL
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

EXEC sp_Sales 5, @Items



