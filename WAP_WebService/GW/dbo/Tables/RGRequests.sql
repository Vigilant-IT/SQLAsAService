CREATE TABLE [dbo].[RGRequests]
(
	[ReqId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    [RgName] VARCHAR(MAX) NOT NULL, 
    [Zone] varchar(MAX) NOT NULL, 
    [Avail] varchar(MAX) NOT NULL, 
    [SqlVer] varchar(MAX) NOT NULL, 
    [DC] varchar(MAX) NOT NULL, 
    [ENV] varchar(MAX) NOT NULL, 
    [TDE] varchar(MAX) NOT NULL, 
    [SkuName] varchar(MAX) NOT NULL, 
    [Notes] varchar(MAX) NOT NULL, 
    [Email] varchar(MAX) NOT NULL, 
    [RgPassPhrase] varchar(MAX) NOT NULL, 
    [ReqTime] DATETIME NOT NULL
)
