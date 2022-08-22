CREATE TABLE [dbo].[SKUConfig]
(
	[SKUID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    [Name] VARCHAR(MAX) NOT NULL, 
    [Memory] VARCHAR(MAX) NOT NULL, 
    [Cores] VARCHAR(MAX) NOT NULL, 
    [Checksum] VARCHAR(MAX) NOT NULL, 
    [Visible] INT NOT NULL, 
    [MicroDB] INT NOT NULL, 
    [ElasticDB] INT NOT NULL
)
