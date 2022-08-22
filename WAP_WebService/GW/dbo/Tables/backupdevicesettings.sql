CREATE TABLE [dbo].[backupdevicesettings](
	[serverid] [varchar](256) NOT NULL,
	[name] [varchar](256) NULL,
	[path] [varchar](256) NULL,
	[timestamp] [datetime] NOT NULL
) ON [PRIMARY]