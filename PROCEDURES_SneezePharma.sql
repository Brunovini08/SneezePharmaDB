USE SneezePharma
GO

CREATE PROCEDURE CriarTriggerBloqueioDelete
    @NomeTabela SYSNAME
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);
    DECLARE @TriggerName SYSNAME = 'trg_NoDelete_' + @NomeTabela;

    SET @SQL = '
    CREATE TRIGGER ' + QUOTENAME(@TriggerName) + '
    ON ' + QUOTENAME(@NomeTabela) + '
    INSTEAD OF DELETE
    AS
    BEGIN
        RAISERROR (''Não é permitido excluir registros da tabela ' + @NomeTabela + '.'' , 16, 1);
    END;
    ';

    EXEC sp_executesql @SQL;
END;
GO

EXEC CriarTriggerBloqueioDelete 'Category'
EXEC CriarTriggerBloqueioDelete 'Customers'
EXEC CriarTriggerBloqueioDelete 'Ingredients'
EXEC CriarTriggerBloqueioDelete 'Medicine'
EXEC CriarTriggerBloqueioDelete 'Phones'
EXEC CriarTriggerBloqueioDelete 'Produce'
EXEC CriarTriggerBloqueioDelete 'ProduceItem'
EXEC CriarTriggerBloqueioDelete 'PurchaseItem'
EXEC CriarTriggerBloqueioDelete 'Purchases'
EXEC CriarTriggerBloqueioDelete 'Sales'
EXEC CriarTriggerBloqueioDelete 'SalesItems'
EXEC CriarTriggerBloqueioDelete 'Situation'
EXEC CriarTriggerBloqueioDelete 'Suppliers'