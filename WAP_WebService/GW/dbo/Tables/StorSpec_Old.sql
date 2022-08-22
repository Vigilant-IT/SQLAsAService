CREATE TABLE [dbo].[StorSpec_Old](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SCVMM] [nvarchar](50) NULL,
	[PMName] [nvarchar](50) NULL,
	[LUN] [nvarchar](50) NULL,
	[Zone] [nvarchar](50) NULL,
	[Performance] [nvarchar](50) NULL,
	[Capacity] [int] NOT NULL,
	[Expire] [datetime] NULL
) ON [PRIMARY]