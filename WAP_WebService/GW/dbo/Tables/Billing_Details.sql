CREATE TABLE [dbo].[Billing_Details](
	[Tran_Date] [varchar](8) NULL,
	[Company] [varchar](3) NOT NULL,
	[RU_Code] [varchar](8) NULL,
	[BUDI] [nvarchar](50) NULL,
	[Site_ID] [varchar](1) NOT NULL,
	[Project] [varchar](1) NOT NULL,
	[Host_ID] [nvarchar](50) NULL,
	[Type] [varchar](58) NULL,
	[Volume] [float] NULL
) ON [PRIMARY]