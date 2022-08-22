CREATE TABLE [dbo].[RgVhdx]
(
	[DiskId] INT identity(1,1) NOT NULL PRIMARY KEY, 
    [RgId] INT NOT NULL, 
    [SvrId] INT NOT NULL, 
    [VhdxPath] VARCHAR(MAX) NOT NULL, 
    [VhdxLunId] INT NOT NULL, 
    [VhdxBusId] INT NOT NULL, 
    [Purpose] VARCHAR(MAX) NOT NULL, 
    [VhdxSetNum] INT NOT NULL, 
    [CurrentPrimary] INT NOT NULL, 
    [LocalPath] VARCHAR(MAX) NOT NULL
)
