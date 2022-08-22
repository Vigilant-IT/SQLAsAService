USE master
IF EXISTS(select * from sys.databases where name='GW')
DROP DATABASE [GW]
GO

CREATE DATABASE [GW]
GO

ALTER DATABASE [GW] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GW].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GW] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GW] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GW] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GW] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GW] SET ARITHABORT OFF 
GO
ALTER DATABASE [GW] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GW] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [GW] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GW] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GW] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GW] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GW] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GW] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GW] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GW] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GW] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GW] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GW] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GW] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GW] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GW] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GW] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GW] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GW] SET RECOVERY FULL 
GO
ALTER DATABASE [GW] SET  MULTI_USER 
GO
ALTER DATABASE [GW] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GW] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GW] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GW] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'GW', N'ON'
GO
USE [GW]
GO
/****** Object:  Table [dbo].[AOSpec]    Script Date: 19/05/2016 10:14:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AOSpec](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ListenerName] [nvarchar](50) NULL,
	[ListenerPort] [nvarchar](50) NULL,
	[ListenerIP] [nvarchar](50) NULL,
	[UNCPath] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Audit]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Audit](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[State] [nvarchar](50) NULL,
	[DC] [nvarchar](50) NULL,
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
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[backupdevicesettings]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[backupdevicesettings](
	[serverid] [varchar](256) NOT NULL,
	[name] [varchar](256) NULL,
	[path] [varchar](256) NULL,
	[timestamp] [datetime] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Billing_Details]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Billing_Schedule]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Billing_Schedule](
	[bill_schedule_id] [int] IDENTITY(1,1) NOT NULL,
	[bill_schedule_date] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Codes]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Codes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Value] [nvarchar](256) NOT NULL,
	[Notes] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Codes_Old]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Codes_Old](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Value] [nvarchar](50) NOT NULL,
	[Notes] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dbaogsettings]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dbfilesettings]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dbfilesettings](
	[ServerID] [varchar](50) NOT NULL,
	[dbname] [varchar](256) NULL,
	[name] [varchar](256) NULL,
	[path] [varchar](256) NULL,
	[size] [varchar](256) NULL,
	[timestamp] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dbresgovsettings]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DBSettings]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DBSettings](
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
	[DNS] [varchar](128) NULL,
	[VM] [varchar](50) NULL,
	[PlanID] [varchar](50) NULL,
	[SubID] [varchar](50) NULL,
	[SQLUser] [varchar](50) NULL,
	[ConnString] [varchar](500) NULL,
	[SwitchBC] [varchar](50) NULL,
	[VMCP] [varchar](50) NULL,
	[VMMCP] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DBSettings_Old]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DBSettings_Old](
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

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[mountpointsettings]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mountpointsettings](
	[serverid] [varchar](256) NOT NULL,
	[name] [varchar](256) NULL,
	[path] [varchar](256) NULL,
	[timestamp] [datetime] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NameSpec]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NameSpec](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[VMNameBur] [nvarchar](50) NULL,
	[ServiceName] [nvarchar](50) NULL,
	[IPAddr] [nvarchar](50) NULL,
	[Expire] [datetime] NULL,
	[VMNameNor] [nvarchar](50) NULL,
	[ServiceNameType] [nvarchar](50) NULL,
	[ListenerName] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NameSpec_Old]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NameSpec_Old](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[VMNameBur] [nvarchar](50) NULL,
	[ServiceName] [nvarchar](50) NULL,
	[IPAddr] [nvarchar](50) NULL,
	[Expire] [datetime] NULL,
	[VMNameNor] [nvarchar](50) NULL,
	[ServiceNameType] [nvarchar](50) NULL,
	[ListenerName] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NameUsed]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NameUsed](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ServiceName] [nvarchar](50) NULL,
	[DB] [nvarchar](50) NULL,
	[Expire] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[plansettings]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[plansettings](
	[serverid] [varchar](256) NOT NULL,
	[planid] [varchar](256) NULL,
	[displayname] [varchar](256) NULL,
	[state] [varchar](256) NULL,
	[subcount] [varchar](256) NULL,
	[timestamp] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StorSpec_Old]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[StorUsed]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StorUsed](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DBName] [nvarchar](50) NULL,
	[DataLog] [nvarchar](50) NULL,
	[Used] [float] NULL,
	[Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StorUsed_Old]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StorUsed_Old](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DBName] [nvarchar](50) NULL,
	[DataLog] [nvarchar](50) NULL,
	[LUN] [nvarchar](50) NULL,
	[Used] [int] NULL,
	[Allocated] [int] NULL,
	[Expire] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[subsettings]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[subsettings](
	[serverid] [varchar](256) NOT NULL,
	[name] [varchar](256) NULL,
	[state] [varchar](256) NULL,
	[planid] [varchar](256) NULL,
	[subid] [varchar](256) NULL,
	[timestamp] [datetime] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[vhdxsettings]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[vhdxsettings](
	[serverid] [varchar](256) NOT NULL,
	[name] [varchar](256) NULL,
	[size] [varchar](256) NULL,
	[host] [varchar](256) NULL,
	[path] [varchar](256) NULL,
	[timestamp] [datetime] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[vmmdisksettings]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[vmmdisksettings](
	[serverid] [varchar](256) NOT NULL,
	[diskname] [varchar](256) NULL,
	[size] [varchar](256) NULL,
	[timestamp] [datetime] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VMSpec]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[VMUsed]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VMUsed](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[VMName] [nvarchar](50) NULL,
	[DBName] [nvarchar](50) NULL,
	[Used] [int] NULL,
	[Expire] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[view_Audit]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_Audit]
AS
	SELECT	ID, State, DBName AS 'Database Name', SQLVer AS 'SQL Version', InitialSizeMB AS 'Initial Size in MB', 
			DC AS 'Site', Network AS 'Prod\Test', Availability, Zone, SKU, Recovery, Colation, TDE, 
			StorPerfData AS 'Data file Storage Type', StorPerfLogs AS 'Log file Storage type', Retention, 
			BUDI, DBoGroup AS 'Database Owner', PwrUGroup AS 'Power Users', StdUGroup AS 'Standard Users', Connection
	FROM	dbo.Audit
	WHERE	(State NOT LIKE 'completed %')

GO
/****** Object:  View [dbo].[view_DBNames]    Script Date: 19/05/2016 10:14:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_DBNames]
AS
	SELECT	DBName AS 'Database Name'
	FROM	dbo.Audit
	WHERE	(State = 'completed')

GO
USE [master]
GO
ALTER DATABASE [GW] SET  READ_WRITE 
GO


USE [GW]
GO

INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('State', 'New', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('State', 'Exists', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('DataCentre', 'Default', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('DataCentre', 'Burwood', 'BW');
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('DataCentre', 'Norwest', 'NW');
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('SQLVersion', '2012', '12');
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Environment', 'NonProd', 'NP');
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Environment', 'Prod', 'PR');
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Availability', 'Standard', 'ST');
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Availability', 'BusinessCritical', 'BC');
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Zone', 'Controlled', 'ZC');
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Zone', 'Restricted', 'ZR');
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Zone', 'Secure', 'ZS');
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Compute', 'Small', 'Core=1;RAM=1');
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Compute', 'Medium', 'Core=2;RAM=2');
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Compute', 'Large', 'Core=4;RAM=4');
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Compute', 'ExtraLarge', 'Core=8;RAM=8');
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Compute', 'ExtraLargeHiMem', 'Core=8;RAM=16');
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Compute', 'Custom', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Storage', 'Standard', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Storage', 'HighPerformance', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('TDE', 'No', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('TDE', 'Yes', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('TDE', 'Yes(HSM)', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Recovery', 'Full', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Recovery', 'Simple', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Recovery', 'BulkLogged', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Retention', '0', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Retention', '3', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Retention', '5', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Retention', '12', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Retention', '60', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Retention', '84', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('SQLVersion', '2008R2', '08');
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Albanian_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Arabic_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Assamese_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Cyrillic_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Azeri_Latin_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bashkir_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bengali_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Cyrillic_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Bosnian_Latin_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Breton_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Hong_Kong_Stroke_90_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_90_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_PRC_Stroke_90_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Pinyin_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Simplified_Stroke_Order_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Bopomofo_90_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Taiwan_Stroke_90_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Bopomofo_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Pinyin_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Count_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Chinese_Traditional_Stroke_Order_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Corsican_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Croatian_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Cyrillic_General_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Czech_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Greenlandic_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Norwegian_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Norwegian_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Norwegian_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Norwegian_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Norwegian_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Norwegian_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Norwegian_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Norwegian_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Norwegian_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Norwegian_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Norwegian_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Norwegian_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Norwegian_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Norwegian_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Norwegian_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Norwegian_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Norwegian_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Danish_Norwegian_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Dari_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_90_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Divehi_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Estonian_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Finnish_Swedish_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'French_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Frisian_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Georgian_Modern_Sort_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'German_PhoneBook_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Greek_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hebrew_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Hungarian_Technical_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Icelandic_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_90_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Indic_General_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_90_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Bushu_Kakusu_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Unicode_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Unicode_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Unicode_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Unicode_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Unicode_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Unicode_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Unicode_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Unicode_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Unicode_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Unicode_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Unicode_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Unicode_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Unicode_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Unicode_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Unicode_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Unicode_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Unicode_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_Unicode_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Japanese_XJIS_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_90_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Kazakh_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Khmer_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_90_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_Wansung_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_Wansung_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_Wansung_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_Wansung_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_Wansung_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_Wansung_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_Wansung_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_Wansung_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_Wansung_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_Wansung_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_Wansung_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_Wansung_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_Wansung_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_Wansung_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_Wansung_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_Wansung_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_Wansung_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Korean_Wansung_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lao_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latin1_General_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Latvian_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Lithuanian_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_90_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Macedonian_FYROM_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maltese_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Maori_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mapudungan_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Modern_Spanish_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Mohawk_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Nepali_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Norwegian_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Pashto_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Persian_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Polish_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romanian_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Romansh_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Norway_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Sami_Sweden_Finland_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Cyrillic_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Serbian_Latin_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovak_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Slovenian_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_90_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Syriac_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tamazight_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_90_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tatar_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Thai_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Tibetan_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Traditional_Spanish_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkish_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Turkmen_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uighur_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Ukrainian_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Upper_Sorbian_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Urdu_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_90_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Uzbek_Latin_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Vietnamese_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Welsh_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CI_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CI_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CI_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CI_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CI_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CI_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CS_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CS_AI_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CS_AI_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CS_AI_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CS_AS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CS_AS_KS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CS_AS_KS_WS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CI_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CI_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CI_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CI_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CI_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CI_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CI_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CI_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CS_AI_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CS_AI_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CS_AI_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CS_AI_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CS_AS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CS_AS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CS_AS_KS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'Yakut_100_CS_AS_KS_WS_SC', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_1xCompat_CP850_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_AltDiction_CP850_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_AltDiction_CP850_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_AltDiction_CP850_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_AltDiction_Pref_CP850_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_AltDiction2_CP1253_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Croatian_CP1250_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Croatian_CP1250_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Czech_CP1250_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Czech_CP1250_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Danish_Pref_CP1_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_EBCDIC037_CP1_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_EBCDIC273_CP1_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_EBCDIC277_CP1_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_EBCDIC278_CP1_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_EBCDIC280_CP1_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_EBCDIC284_CP1_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_EBCDIC285_CP1_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_EBCDIC297_CP1_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Estonian_CP1257_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Estonian_CP1257_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Hungarian_CP1250_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Hungarian_CP1250_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Icelandic_Pref_CP1_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP1_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP1_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP1_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP1250_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP1250_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP1251_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP1251_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP1253_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP1253_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP1253_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP1254_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP1254_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP1255_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP1255_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP1256_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP1256_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP1257_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP1257_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP437_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP437_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP437_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP437_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP437_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP850_BIN', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP850_BIN2', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP850_CI_AI', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP850_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_CP850_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_Pref_CP1_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_Pref_CP437_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latin1_General_Pref_CP850_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latvian_CP1257_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Latvian_CP1257_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Lithuanian_CP1257_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Lithuanian_CP1257_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_MixDiction_CP1253_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Polish_CP1250_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Polish_CP1250_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Romanian_CP1250_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Romanian_CP1250_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Scandinavian_CP850_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Scandinavian_CP850_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Scandinavian_Pref_CP850_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Slovak_CP1250_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Slovak_CP1250_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Slovenian_CP1250_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Slovenian_CP1250_CS_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_SwedishPhone_Pref_CP1_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_SwedishStd_Pref_CP1_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Ukrainian_CP1251_CI_AS', null);
INSERT INTO [dbo].[Codes](Code, Value, Notes) VALUES ('Colation', 'SQL_Ukrainian_CP1251_CS_AS', null);