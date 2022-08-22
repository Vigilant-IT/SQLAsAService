CREATE TABLE [dbo].[dbresgovsettings](
	[serverid] [varchar](256) NOT NULL,
	[capcpu] [varchar](256) NULL,
	[maxcpu] [varchar](256) NULL,
	[maxmem] [varchar](256) NULL,
	[maxmempool] [varchar](256) NULL,
	[minmempool] [varchar](256) NULL,
	[name] [varchar](256) NULL,
	[timestamp] [datetime] NOT NULL
) ON [PRIMARY]