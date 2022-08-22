CREATE TABLE [dbo].[subsettings](
	[serverid] [varchar](256) NOT NULL,
	[name] [varchar](256) NULL,
	[state] [varchar](256) NULL,
	[planid] [varchar](256) NULL,
	[subid] [varchar](256) NULL,
	[timestamp] [datetime] NOT NULL
) ON [PRIMARY]