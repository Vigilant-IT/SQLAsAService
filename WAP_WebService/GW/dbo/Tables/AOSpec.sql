CREATE TABLE [dbo].[AOSpec](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ListenerName] [nvarchar](50) NULL,
	[ListenerPort] [nvarchar](50) NULL,
	[ListenerIP] [nvarchar](50) NULL,
	[UNCPath] [nvarchar](255) NULL
) ON [PRIMARY]