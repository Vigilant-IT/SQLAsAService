CREATE TABLE [dbo].[DBRequests]
(
	[Id] INT identity(1,1) NOT NULL PRIMARY KEY, 
    [RGID] INT NOT NULL, 
    [DBName] VARCHAR(MAX) NOT NULL, 
    [Collation] VARCHAR(MAX) NOT NULL, 
    [ListenerName] VARCHAR(MAX) NOT NULL, 
    [DBOGrp] VARCHAR(MAX) NOT NULL, 
    [PwrGrp] VARCHAR(MAX) NULL, 
    [StdGrp] VARCHAR(MAX) NULL, 
    [Size] INT NOT NULL, 
    [AOGName] VARCHAR(MAX) NOT NULL, 
    [IP] VARCHAR(MAX) NOT NULL,

)
