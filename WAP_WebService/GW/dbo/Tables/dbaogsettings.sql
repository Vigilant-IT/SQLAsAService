CREATE TABLE [dbo].[dbaogsettings](
	[serverid] [varchar](256) NOT NULL,
	[dbname] [varchar](256) NULL,
	[dns] [varchar](256) NULL,
	[ipaddress] [varchar](256) NULL,
	[ipmask] [varchar](256) NULL,
	[name] [varchar](256) NULL,
	[port] [varchar](256) NULL,
	[timestamp] [datetime] NOT NULL
) ON [PRIMARY]