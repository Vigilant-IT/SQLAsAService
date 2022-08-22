CREATE TABLE [dbo].[dbfilesettings](
	[ServerID] [varchar](50) NOT NULL,
	[dbname] [varchar](256) NULL,
	[name] [varchar](256) NULL,
	[path] [varchar](256) NULL,
	[size] [varchar](256) NULL,
	[timestamp] [datetime] NULL
) ON [PRIMARY]