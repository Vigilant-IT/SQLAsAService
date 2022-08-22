CREATE TABLE [dbo].[VMSpec](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SCVMM] [nvarchar](128) NULL,
	[PMName] [nvarchar](128) NULL,
	[VMName] [nvarchar](128) NULL,
	[VMNameClusterPartner] [nvarchar](128) NULL,
	[DC] [nvarchar](128) NULL,
	[Env] [nvarchar](128) NULL,
	[Zone] [nvarchar](128) NULL,
	[Avail] [nvarchar](128) NULL,
	[MSSQL] [nvarchar](128) NULL,
	[VOverCore] [int] NULL,
	[VCore] [int] NULL,
	[RAM] [int] NULL,
	[Expire] [datetime] NULL,
	[TDE] [nchar](10) NULL CONSTRAINT [DF_VMSpec_TDE]  DEFAULT (N'NO'),
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]