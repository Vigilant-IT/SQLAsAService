CREATE TABLE [dbo].[StorUsed](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DBName] [nvarchar](50) NULL,
	[DataLog] [nvarchar](50) NULL,
	[Used] [float] NULL,
	[Date] [datetime] NULL
) ON [PRIMARY]