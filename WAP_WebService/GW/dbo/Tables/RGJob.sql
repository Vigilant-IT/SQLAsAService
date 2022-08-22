CREATE TABLE [dbo].[RGJob]
(
	[JobID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    [RGID] INT NOT NULL, 
    [SvrID] INT NOT NULL, 
    [MDFPath] VARCHAR(MAX) NULL, 
    [MDFLun] VARCHAR(MAX) NULL, 
    [MDFBus] VARCHAR(MAX) NULL, 
    [LDFPath] VARCHAR(MAX) NULL, 
    [LDFLun] VARCHAR(MAX) NULL, 
    [LDFBus] VARCHAR(MAX) NULL, 
    [StartCore] VARCHAR(MAX) NULL, 
    [EndCore] VARCHAR(MAX) NULL, 
    [PlanShortName] VARCHAR(MAX) NULL, 
    [VHDXAllocated] VARCHAR(MAX) NULL, 
    [RGAllocated] VARCHAR(MAX) NULL, 
    [WAPUserAllocated] VARCHAR(MAX) NULL, 
    [WAPPlanAllocated] VARCHAR(MAX) NULL, 
    [WAPSubAllocated] VARCHAR(MAX) NULL, 
    [Notes] VARCHAR(MAX) NULL

)
