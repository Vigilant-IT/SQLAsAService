CREATE TABLE [dbo].[NameSpec](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[VMNameBur] [nvarchar](50) NULL,
	[ServiceName] [nvarchar](50) NULL,
	[IPAddr] [nvarchar](50) NULL,
	[Expire] [datetime] NULL,
	[VMNameNor] [nvarchar](50) NULL,
	[ServiceNameType] [nvarchar](50) NULL,
	[ListenerName] [nvarchar](50) NULL
) ON [PRIMARY]