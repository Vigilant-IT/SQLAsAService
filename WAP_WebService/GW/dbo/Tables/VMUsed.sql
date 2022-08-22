CREATE TABLE [dbo].[VMUsed](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[VMName] [nvarchar](50) NULL,
	[DBName] [nvarchar](50) NULL,
	[Used] [int] NULL,
	[Expire] [datetime] NULL
) ON [PRIMARY]