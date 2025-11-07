CREATE DATABASE SneezePharma
USE SneezePharma

CREATE TABLE Situation(
	IDSituacao int IDENTITY(1,1),
	TipoSituacao VARCHAR(50)
)

CREATE TABLE Customers(
	IDCliente INT IDENTITY(1,1),
	CPF NUMERIC NOT NULL UNIQUE,
	Nome VARCHAR(50) NOT NULL,
	DataNascimento DATE NOT NULL,
	UltimaCompra DATE,
	DataCadastro TIMESTAMP NOT NULL,
	IDSituacao INT NOT NULL
)

CREATE TABLE RestrictedCustomers(
	IDClienteRestrito INT IDENTITY(1,1),
	IDCliente INT NOT NULL
)

CREATE TABLE Phones(
	IDTelefone INT IDENTITY(1,1),
	CodPais NUMERIC NOT NULL,
	DDD NUMERIC NOT NULL,
	Numero NUMERIC NOT NULL,
	IDCliente INT NOT NULL
)

CREATE TABLE Suppliers(
	IDFornecedor INT IDENTITY(1,1),
	CNPJ VARCHAR(14) NOT NULL,
	RazaoSocial VARCHAR(50) NOT NULL,
	Pais VARCHAR(40) NOT NULL,
	DataAbertura DATE NOT NULL,
	UltimoFornecimento DATETIME,
	DataCadastro TIMESTAMP NOT NULL
)

CREATE TABLE RestrictedSuppliers(
	IDFornecedorRestrito INT IDENTITY(1,1),
	IDFornecedor INT NOT NULL
)
