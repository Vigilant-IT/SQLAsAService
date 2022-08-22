CREATE TABLE [dbo].[plansettings](
	[serverid] [varchar](256) NOT NULL,
	[planid] [varchar](256) NULL,
	[displayname] [varchar](256) NULL,
	[state] [varchar](256) NULL,
	[subcount] [varchar](256) NULL,
	[timestamp] [datetime] NULL
) ON [PRIMARY]