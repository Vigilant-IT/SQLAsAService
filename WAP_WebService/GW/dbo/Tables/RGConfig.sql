CREATE TABLE [dbo].[RGConfig]
(
	[RGID] int NOT NULL PRIMARY KEY, 
    [RGName] VARCHAR(MAX) NOT NULL, 
    [ServerID] INT NOT NULL, 
    [SKUID] INT NOT NULL, 
    [Passphrase] VARCHAR(MAX) NOT NULL, 
    [SubID] VARCHAR(MAX) NULL, 
    [PlanID] VARCHAR(MAX) NULL, 
    [StartCore] INT NULL, 
    [EndCore] INT NULL, 
    [VHDXSetNum] INT NULL
)
