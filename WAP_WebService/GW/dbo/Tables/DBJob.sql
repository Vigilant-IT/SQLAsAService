CREATE TABLE [dbo].[DBJob]
(
	[Id] INT identity(1,1) NOT NULL PRIMARY KEY, 
    [Notes] VARCHAR(MAX) NOT NULL, 
    [logged time] DATETIME NOT NULL, 
    [DbaseId] INT NOT NULL
)
