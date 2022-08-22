CREATE TABLE [dbo].[Audit](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[State] [nvarchar](50) NULL,
	[DC] [nvarchar](MAX) NULL,
	[Username] [nvarchar](50) NULL,
	[DBName] [nvarchar](50) NULL,
	[SQLVer] [nvarchar](50) NULL,
	[InitialSizeMB] [nvarchar](50) NULL,
	[Colation] [nvarchar](50) NULL,
	[Network] [nvarchar](50) NULL,
	[Availability] [nvarchar](50) NULL,
	[Zone] [nvarchar](50) NULL,
	[SKU] [nvarchar](50) NULL,
	[StorPerfData] [nvarchar](50) NULL,
	[StorPerfLogs] [nvarchar](50) NULL,
	[Retention] [nvarchar](50) NULL,
	[BUDI] [nvarchar](50) NULL,
	[DBoGroup] [nvarchar](50) NULL,
	[Recovery] [nvarchar](50) NULL,
	[TDE] [nvarchar](50) NULL,
	[Connection] [nvarchar](max) NULL,
	[Notes] [nvarchar](max) NULL,
	[Logged] [datetime] NULL,
	[Expire] [datetime] NULL,
	[PwrUGroup] [nvarchar](50) NULL,
	[StdUGroup] [nvarchar](50) NULL,
	[RequestITID] [nvarchar](max) NULL,
[ResGov] NVARCHAR(MAX) NULL, 
    PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]