﻿CREATE TABLE [dbo].[DBSettings](
	[DBID] [varchar](50) NOT NULL,
	[AlwaysOnGroup] [varchar](50) NULL,
	[Datacentre] [varchar](50) NOT NULL,
	[IPAddress] [varchar](50) NULL,
	[ListenerName] [varchar](50) NULL,
	[LunDB] [varchar](50) NULL,
	[LunDBCP] [varchar](50) NULL,
	[LunLog] [varchar](50) NULL,
	[LunLogCP] [varchar](50) NULL,
	[PlanShortName] [varchar](50) NULL,
	[Host] [varchar](50) NULL,
	[VMM] [varchar](50) NULL,
	[DNS] [varchar](50) NULL,
	[VM] [varchar](50) NULL,
	[PlanID] [varchar](50) NULL,
	[SubID] [varchar](50) NULL,
	[SQLUser] [varchar](50) NULL,
	[ConnString] [varchar](500) NULL,
	[SwitchBC] [varchar](50) NULL,
	[VMCP] [varchar](50) NULL,
	[VMMCP] [varchar](50) NULL
) ON [PRIMARY]