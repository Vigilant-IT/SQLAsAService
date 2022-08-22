CREATE TABLE [dbo].[StorUsed_Old](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DBName] [nvarchar](50) NULL,
	[DataLog] [nvarchar](50) NULL,
	[LUN] [nvarchar](50) NULL,
	[Used] [int] NULL,
	[Allocated] [int] NULL,
	[Expire] [datetime] NULL
) ON [PRIMARY]