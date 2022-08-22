CREATE TABLE [dbo].[NameUsed](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ServiceName] [nvarchar](50) NULL,
	[DB] [nvarchar](50) NULL,
	[Expire] [datetime] NULL
) ON [PRIMARY]