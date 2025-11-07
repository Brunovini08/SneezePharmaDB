CREATE TRIGGER trg_Sales_Insert
on Sales
INSTEAD OF INSERT
AS

IF EXISTS (SELECT 1 FROM RestrictedCustomers rc JOIN inserted i ON rc.IDCliente = i.IDCliente)
	BEGIN
		RAISERROR('Você não pode realizar a inserção de uma venda para um cliente restrito', 1,1)
	END

ELSE 
	BEGIN
		INSERT INTO Sales (DataVenda, IDCliente, ValorTotal)
		SELECT DataVenda, IDCliente, ValorTotal FROM inserted
	END