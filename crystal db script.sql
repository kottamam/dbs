USE [master]
GO
/****** Object:  Database [Crystal]    Script Date: 12/12/2017 2:14:23 PM ******/
CREATE DATABASE [Crystal]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Crystal', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\Crystal.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Crystal_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\Crystal_log.ldf' , SIZE = 4096KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Crystal] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Crystal].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Crystal] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Crystal] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Crystal] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Crystal] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Crystal] SET ARITHABORT OFF 
GO
ALTER DATABASE [Crystal] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Crystal] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Crystal] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Crystal] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Crystal] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Crystal] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Crystal] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Crystal] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Crystal] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Crystal] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Crystal] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Crystal] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Crystal] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Crystal] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Crystal] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Crystal] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Crystal] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Crystal] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Crystal] SET  MULTI_USER 
GO
ALTER DATABASE [Crystal] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Crystal] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Crystal] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Crystal] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Crystal] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Crystal] SET QUERY_STORE = OFF
GO
USE [Crystal]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [Crystal]
GO
/****** Object:  UserDefinedFunction [dbo].[cmsFnGetGeneralSettingsIntValue]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Noble
-- Create date: 13/07/2015
-- Description:	To get general settings vaule of the given settings
-- =============================================
CREATE FUNCTION [dbo].[cmsFnGetGeneralSettingsIntValue]
(
	@Settings	VARCHAR(50)
)
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Value	INT

	SET @Value = (SELECT CAST (Value AS INT) FROM cmsGeneralSettings WHERE Settings = @Settings)

	-- Return the result of the function
	RETURN ISNULL(@Value,0)

END
GO
/****** Object:  Table [dbo].[cmsApplicationModules]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsApplicationModules](
	[ModuleID] [tinyint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ModuleName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_cmsApplicationModules] PRIMARY KEY CLUSTERED 
(
	[ModuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cmsApplicationRelease]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsApplicationRelease](
	[ReleaseID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ReleaseDate] [smalldatetime] NOT NULL,
	[MajorVersion] [int] NOT NULL,
	[MinorVersion] [int] NOT NULL,
	[Build] [int] NOT NULL,
	[RevisionVersion] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_cmsApplicationRelease] PRIMARY KEY CLUSTERED 
(
	[ReleaseID] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cmsApplicationReleaseDetails]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsApplicationReleaseDetails](
	[ReleaseID] [int] NOT NULL,
	[SequenceNo] [smallint] NOT NULL,
	[ReleaseDescription] [varchar](500) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cmsCounter]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsCounter](
	[CounterID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CounterName] [varchar](50) NOT NULL,
	[DisplayName] [varchar](50) NOT NULL,
	[PrinterName] [varchar](50) NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [smalldatetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedOn] [smalldatetime] NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeletedBy] [int] NOT NULL,
	[DeletedOn] [smalldatetime] NULL,
 CONSTRAINT [PK_cmsCounter] PRIMARY KEY CLUSTERED 
(
	[CounterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cmsCustomer]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsCustomer](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [varchar](50) NULL,
	[VehicleNo] [varchar](15) NULL,
	[Address1] [varchar](50) NULL,
	[Address2] [varchar](50) NULL,
	[Phone] [varchar](12) NULL,
	[Mobile] [varchar](10) NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeletedBy] [int] NULL,
	[DeletedOn] [smalldatetime] NULL,
 CONSTRAINT [PK_cmsCustomer] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cmsEventLog]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsEventLog](
	[EventID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[EventDate] [datetime] NOT NULL,
	[EventDescription] [varchar](500) NOT NULL,
	[EventTypeID] [int] NOT NULL,
	[EventMode] [tinyint] NOT NULL,
	[UserID] [int] NOT NULL,
	[CounterID] [int] NOT NULL,
	[Extra1] [int] NULL,
 CONSTRAINT [PK_cmsEventLog] PRIMARY KEY CLUSTERED 
(
	[EventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cmsFinancialYear]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsFinancialYear](
	[FYearID] [tinyint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[FYearStart] [date] NOT NULL,
	[FYearClose] [date] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [smalldatetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_cmsFinancialYear] PRIMARY KEY CLUSTERED 
(
	[FYearID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cmsGeneralSettings]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsGeneralSettings](
	[SettingsID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SequenceNo] [int] NOT NULL,
	[Settings] [varchar](50) NOT NULL,
	[Value] [varchar](50) NOT NULL,
 CONSTRAINT [PK_cmsGeneralSettings] PRIMARY KEY CLUSTERED 
(
	[SettingsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cmsIndicationEventLogType]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsIndicationEventLogType](
	[EventLogTypeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[EventLogType] [varchar](50) NOT NULL,
 CONSTRAINT [PK_cmsIndicationEventLogType] PRIMARY KEY CLUSTERED 
(
	[EventLogTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cmsIndicationMenuShortcutKeyModifier]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsIndicationMenuShortcutKeyModifier](
	[MenuShortcutKeyModifierID] [tinyint] IDENTITY(0,1) NOT FOR REPLICATION NOT NULL,
	[MenuShortcutKeyModifier] [varchar](10) NOT NULL,
 CONSTRAINT [PK_cmsIndicationMenuShortcutKeyModifier] PRIMARY KEY CLUSTERED 
(
	[MenuShortcutKeyModifierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cmsMenuItem]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsMenuItem](
	[MenuID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[MenuParent] [int] NOT NULL,
	[MenuName] [varchar](50) NOT NULL,
	[MenuUrl] [varchar](50) NOT NULL,
	[ModuleID] [tinyint] NOT NULL,
	[MenuDisplayOrder] [smallint] NOT NULL,
	[MenuShortcutKeyModifierID] [tinyint] NOT NULL,
	[MenuShortcutKey] [varchar](10) NULL,
	[UserAccessRightSettingsApplicable] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [smalldatetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedOn] [smalldatetime] NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeletedBy] [int] NOT NULL,
	[DeletedOn] [smalldatetime] NULL,
 CONSTRAINT [PK_cmsMenuItem] PRIMARY KEY CLUSTERED 
(
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cmsProductModel]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsProductModel](
	[ModelID] [int] IDENTITY(1,1) NOT NULL,
	[ModelName] [varchar](50) NOT NULL,
	[Description] [varchar](50) NULL,
	[Rate] [money] NOT NULL,
 CONSTRAINT [PK_cmsProductModel] PRIMARY KEY CLUSTERED 
(
	[ModelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cmsSalesVoucher]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsSalesVoucher](
	[SalesID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[ModelId] [int] NOT NULL,
	[SalesDate] [smalldatetime] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Rate] [money] NOT NULL,
	[Discount] [money] NOT NULL,
	[NetAmount] [money] NOT NULL,
	[SettledAmount] [money] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [smalldatetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeletedBy] [int] NULL,
	[DeletedOn] [smalldatetime] NULL,
 CONSTRAINT [PK_cmsSalesVoucher] PRIMARY KEY CLUSTERED 
(
	[SalesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cmsUser]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsUser](
	[UserID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[FullName] [varchar](50) NOT NULL,
	[Password] [varbinary](50) NULL,
	[RoleID] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [smalldatetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedOn] [smalldatetime] NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeletedBy] [int] NOT NULL,
	[DeletedOn] [smalldatetime] NULL,
 CONSTRAINT [PK_cmsUser] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cmsUserAccessRightPermissions]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsUserAccessRightPermissions](
	[RoleID] [int] NOT NULL,
	[UserAccessSettingsID] [int] NOT NULL,
	[PermissionStatus] [bit] NOT NULL,
 CONSTRAINT [PK_cmsUserAccessRightPermissions] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC,
	[UserAccessSettingsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cmsUserAccessRights]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsUserAccessRights](
	[AccessRightID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[AccessRight] [varchar](50) NOT NULL,
	[Description] [varchar](100) NULL,
	[DefaultValue] [bit] NOT NULL,
 CONSTRAINT [PK_cmsUserAccessRights] PRIMARY KEY CLUSTERED 
(
	[AccessRightID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cmsUserAccessRightSettings]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsUserAccessRightSettings](
	[UserAccessSettingsID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SequenceNo] [smallint] NOT NULL,
	[MenuID] [int] NOT NULL,
	[AccessRightID] [int] NOT NULL,
 CONSTRAINT [PK_cmsUserAccessRightSettings] PRIMARY KEY CLUSTERED 
(
	[UserAccessSettingsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cmsUserRole]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsUserRole](
	[RoleID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
	[RoleType] [tinyint] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [smalldatetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeletedBy] [nchar](10) NOT NULL,
	[DeletedOn] [smalldatetime] NULL,
 CONSTRAINT [PK_cmsUserRole] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cmsUserRolePermissions]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsUserRolePermissions](
	[RoleID] [int] NOT NULL,
	[MenuID] [int] NOT NULL,
 CONSTRAINT [PK_cmsUserRolePermissions] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC,
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[cmsApplicationModules] ON 
GO
INSERT [dbo].[cmsApplicationModules] ([ModuleID], [ModuleName]) VALUES (1, N'Stock Management')
GO
SET IDENTITY_INSERT [dbo].[cmsApplicationModules] OFF
GO
SET IDENTITY_INSERT [dbo].[cmsApplicationRelease] ON 
GO
INSERT [dbo].[cmsApplicationRelease] ([ReleaseID], [ReleaseDate], [MajorVersion], [MinorVersion], [Build], [RevisionVersion], [CreatedBy], [CreatedOn]) VALUES (1, CAST(N'2017-11-23T19:14:00' AS SmallDateTime), 1, 0, 0, 0, 0, CAST(N'2017-11-23T19:14:00' AS SmallDateTime))
GO
SET IDENTITY_INSERT [dbo].[cmsApplicationRelease] OFF
GO
INSERT [dbo].[cmsApplicationReleaseDetails] ([ReleaseID], [SequenceNo], [ReleaseDescription]) VALUES (1, 1, N'Installation')
GO
SET IDENTITY_INSERT [dbo].[cmsCounter] ON 
GO
INSERT [dbo].[cmsCounter] ([CounterID], [CounterName], [DisplayName], [PrinterName], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [IsDeleted], [DeletedBy], [DeletedOn]) VALUES (1, N'INNCREWIN44-PC', N'INNCREWIN44-PC', NULL, 0, CAST(N'2017-11-23T19:12:00' AS SmallDateTime), 0, NULL, 0, 0, NULL)
GO
SET IDENTITY_INSERT [dbo].[cmsCounter] OFF
GO
SET IDENTITY_INSERT [dbo].[cmsCustomer] ON 
GO
INSERT [dbo].[cmsCustomer] ([CustomerID], [CustomerName], [VehicleNo], [Address1], [Address2], [Phone], [Mobile], [IsDeleted], [DeletedBy], [DeletedOn]) VALUES (2, N'Noble', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL)
GO
INSERT [dbo].[cmsCustomer] ([CustomerID], [CustomerName], [VehicleNo], [Address1], [Address2], [Phone], [Mobile], [IsDeleted], [DeletedBy], [DeletedOn]) VALUES (5, NULL, N'KL-63 A 8289', NULL, NULL, NULL, NULL, 0, NULL, NULL)
GO
INSERT [dbo].[cmsCustomer] ([CustomerID], [CustomerName], [VehicleNo], [Address1], [Address2], [Phone], [Mobile], [IsDeleted], [DeletedBy], [DeletedOn]) VALUES (7, NULL, N'KL-63 A 8288', NULL, NULL, NULL, NULL, 0, NULL, NULL)
GO
INSERT [dbo].[cmsCustomer] ([CustomerID], [CustomerName], [VehicleNo], [Address1], [Address2], [Phone], [Mobile], [IsDeleted], [DeletedBy], [DeletedOn]) VALUES (8, N'Siril', N'', N'', N'', N'', N'', 1, 1, CAST(N'2017-12-02T15:18:00' AS SmallDateTime))
GO
INSERT [dbo].[cmsCustomer] ([CustomerID], [CustomerName], [VehicleNo], [Address1], [Address2], [Phone], [Mobile], [IsDeleted], [DeletedBy], [DeletedOn]) VALUES (9, N'', N'KL-63 A 8290', N'', N'', N'', N'', 0, NULL, NULL)
GO
INSERT [dbo].[cmsCustomer] ([CustomerID], [CustomerName], [VehicleNo], [Address1], [Address2], [Phone], [Mobile], [IsDeleted], [DeletedBy], [DeletedOn]) VALUES (10, N'TEST1', N'KL63 A 8291', N'Address1', N'Address2', N'04842460000', N'9447595959', 1, 1, CAST(N'2017-12-02T15:16:00' AS SmallDateTime))
GO
INSERT [dbo].[cmsCustomer] ([CustomerID], [CustomerName], [VehicleNo], [Address1], [Address2], [Phone], [Mobile], [IsDeleted], [DeletedBy], [DeletedOn]) VALUES (11, N'WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW', N'VVVVVVVVVVVVVVV', N'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', N'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb', N'000000000000', N'9999999999', 1, 1, CAST(N'2017-12-02T15:10:00' AS SmallDateTime))
GO
SET IDENTITY_INSERT [dbo].[cmsCustomer] OFF
GO
SET IDENTITY_INSERT [dbo].[cmsEventLog] ON 
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (5, CAST(N'2017-11-25T14:12:31.593' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (6, CAST(N'2017-11-25T14:15:22.600' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (7, CAST(N'2017-11-25T14:23:56.810' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (8, CAST(N'2017-11-25T14:24:26.397' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (9, CAST(N'2017-11-25T14:25:19.403' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (10, CAST(N'2017-11-25T14:26:45.700' AS DateTime), N'Invalid login attempt with the username Crystal.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (11, CAST(N'2017-11-25T14:26:49.607' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (12, CAST(N'2017-11-25T19:51:37.740' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (13, CAST(N'2017-11-25T19:53:14.697' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (14, CAST(N'2017-11-25T19:55:38.903' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (15, CAST(N'2017-11-25T19:58:50.213' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (16, CAST(N'2017-11-25T20:02:54.737' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (17, CAST(N'2017-11-25T20:05:09.503' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (18, CAST(N'2017-11-25T20:53:46.900' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (19, CAST(N'2017-11-25T21:32:23.027' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (20, CAST(N'2017-11-25T21:35:18.503' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (21, CAST(N'2017-11-25T21:37:12.527' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (22, CAST(N'2017-11-25T21:37:45.357' AS DateTime), N'Application closed.', 1, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (23, CAST(N'2017-11-25T21:38:59.660' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (24, CAST(N'2017-11-25T21:39:09.457' AS DateTime), N'Application closed.', 1, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (25, CAST(N'2017-11-25T21:43:05.337' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (26, CAST(N'2017-11-25T21:44:45.060' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (27, CAST(N'2017-11-25T21:46:02.800' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (28, CAST(N'2017-11-25T21:47:44.880' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (29, CAST(N'2017-11-25T22:01:38.310' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (30, CAST(N'2017-11-25T22:04:09.157' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (31, CAST(N'2017-11-25T22:04:20.623' AS DateTime), N'Application closed.', 1, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (32, CAST(N'2017-11-25T22:05:14.720' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (33, CAST(N'2017-11-25T22:05:24.827' AS DateTime), N'Application closed.', 1, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (34, CAST(N'2017-11-25T22:06:13.957' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (35, CAST(N'2017-11-25T22:06:31.440' AS DateTime), N'Application closed.', 1, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (36, CAST(N'2017-11-25T22:08:56.087' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (37, CAST(N'2017-11-25T22:10:50.403' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (38, CAST(N'2017-11-25T22:11:04.370' AS DateTime), N'Application closed.', 1, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (39, CAST(N'2017-11-25T22:11:36.553' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (40, CAST(N'2017-11-25T22:11:57.750' AS DateTime), N'Application closed.', 1, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (41, CAST(N'2017-11-25T22:12:29.560' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (42, CAST(N'2017-11-25T22:12:51.610' AS DateTime), N'Application closed.', 1, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (43, CAST(N'2017-11-25T22:14:02.387' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (44, CAST(N'2017-11-25T22:14:49.243' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (45, CAST(N'2017-11-25T22:17:04.500' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (46, CAST(N'2017-11-25T22:18:18.530' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (47, CAST(N'2017-11-25T22:18:54.910' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (48, CAST(N'2017-11-25T22:19:34.510' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (49, CAST(N'2017-11-25T22:20:07.683' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (50, CAST(N'2017-11-25T22:20:28.107' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (51, CAST(N'2017-11-25T22:21:39.077' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (52, CAST(N'2017-11-25T22:22:25.960' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (53, CAST(N'2017-11-25T22:22:51.090' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (54, CAST(N'2017-11-25T22:26:20.893' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (55, CAST(N'2017-11-25T22:56:10.880' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (56, CAST(N'2017-11-26T11:08:42.983' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (57, CAST(N'2017-11-26T11:09:42.463' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (58, CAST(N'2017-11-26T11:12:40.183' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (59, CAST(N'2017-11-26T11:13:57.980' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (60, CAST(N'2017-11-26T11:14:28.557' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (61, CAST(N'2017-11-26T11:14:52.493' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (62, CAST(N'2017-11-26T11:19:22.537' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (63, CAST(N'2017-11-26T11:19:54.587' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (64, CAST(N'2017-11-26T11:20:01.737' AS DateTime), N'Application closed.', 1, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (65, CAST(N'2017-11-26T11:20:42.623' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (66, CAST(N'2017-11-26T11:20:52.777' AS DateTime), N'Application closed.', 1, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (67, CAST(N'2017-11-26T11:25:55.630' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (68, CAST(N'2017-11-26T11:26:33.223' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (69, CAST(N'2017-11-26T11:26:43.543' AS DateTime), N'Application closed.', 1, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (70, CAST(N'2017-11-26T11:27:16.603' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (71, CAST(N'2017-11-27T10:43:41.653' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (72, CAST(N'2017-11-27T10:44:14.117' AS DateTime), N'Application closed.', 1, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (73, CAST(N'2017-12-02T10:57:59.607' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (74, CAST(N'2017-12-02T11:05:23.100' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (75, CAST(N'2017-12-02T11:07:42.637' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (76, CAST(N'2017-12-02T11:08:13.393' AS DateTime), N'Application closed.', 1, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (77, CAST(N'2017-12-02T13:56:44.800' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (78, CAST(N'2017-12-02T13:57:11.090' AS DateTime), N'New customer [Siril] created.', 3, 1, 1, 1, 8)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (79, CAST(N'2017-12-02T13:58:43.370' AS DateTime), N'New customer [KL-63 A 8290] created.', 3, 1, 1, 1, 9)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (80, CAST(N'2017-12-02T14:40:40.413' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (81, CAST(N'2017-12-02T14:43:31.423' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (82, CAST(N'2017-12-02T14:48:55.290' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (83, CAST(N'2017-12-02T14:49:21.107' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (84, CAST(N'2017-12-02T14:50:17.287' AS DateTime), N'New customer [TEST1] created.', 3, 1, 1, 1, 10)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (85, CAST(N'2017-12-02T14:51:11.413' AS DateTime), N'New customer [WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW] created.', 3, 1, 1, 1, 11)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (86, CAST(N'2017-12-02T15:10:01.713' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (87, CAST(N'2017-12-02T15:10:18.563' AS DateTime), N'Customer [WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW] deleted.', 3, 3, 1, 1, 11)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (88, CAST(N'2017-12-02T15:15:54.390' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (89, CAST(N'2017-12-02T15:16:00.447' AS DateTime), N'Customer [TEST1] deleted.', 3, 3, 1, 1, 10)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (90, CAST(N'2017-12-02T15:17:28.853' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (91, CAST(N'2017-12-02T15:17:36.150' AS DateTime), N'Customer [SIRIL] deleted.', 3, 3, 1, 1, 8)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (92, CAST(N'2017-12-02T17:48:58.970' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (93, CAST(N'2017-12-02T18:14:54.923' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (94, CAST(N'2017-12-02T18:15:05.990' AS DateTime), N'Application closed.', 1, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (95, CAST(N'2017-12-02T18:17:05.083' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (96, CAST(N'2017-12-02T18:17:21.887' AS DateTime), N'Application closed.', 1, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (97, CAST(N'2017-12-02T18:18:27.280' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (98, CAST(N'2017-12-02T18:19:03.393' AS DateTime), N'Application closed.', 1, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (99, CAST(N'2017-12-02T18:19:12.700' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (100, CAST(N'2017-12-02T19:09:59.160' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (101, CAST(N'2017-12-02T19:10:13.600' AS DateTime), N'Product: Procedure or function ''cmsUpdateProductModelRate'' expects parameter ''@Rate'', which was not supplied.', 1, 4, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (102, CAST(N'2017-12-02T19:11:22.597' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (104, CAST(N'2017-12-02T19:11:32.490' AS DateTime), N'Product: The INSERT statement conflicted with the FOREIGN KEY constraint "FK_cmsEventLog_cmsIndicationEventLogType". The conflict occurred in database "Crystal", table "dbo.cmsIndicationEventLogType", column ''EventLogTypeID''.
The statement has been terminated.', 1, 4, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (105, CAST(N'2017-12-02T19:12:51.993' AS DateTime), N'Product [1/4 INCH] rate updated to 150.00.', 4, 2, 1, 1, 1)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (106, CAST(N'2017-12-02T19:13:12.333' AS DateTime), N'Product [3/4 INCH] rate updated to 1000.00.', 4, 2, 1, 1, 2)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (107, CAST(N'2017-12-02T19:13:25.433' AS DateTime), N'Product [1 1/2 INCH] rate updated to 1300.00.', 4, 2, 1, 1, 3)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (108, CAST(N'2017-12-09T11:20:55.840' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (109, CAST(N'2017-12-09T11:37:23.790' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (110, CAST(N'2017-12-09T11:37:49.873' AS DateTime), N'Application closed.', 1, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (111, CAST(N'2017-12-09T11:59:05.817' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (112, CAST(N'2017-12-09T11:59:51.400' AS DateTime), N'Application closed.', 1, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (113, CAST(N'2017-12-09T12:10:01.570' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (114, CAST(N'2017-12-09T12:11:11.157' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (115, CAST(N'2017-12-09T12:29:35.640' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (116, CAST(N'2017-12-09T12:32:01.080' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (117, CAST(N'2017-12-09T12:39:18.343' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (118, CAST(N'2017-12-09T12:40:14.157' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (119, CAST(N'2017-12-09T12:42:50.503' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (120, CAST(N'2017-12-09T14:44:47.197' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (121, CAST(N'2017-12-09T14:55:20.073' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (122, CAST(N'2017-12-09T16:53:43.230' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (123, CAST(N'2017-12-09T17:18:54.070' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (124, CAST(N'2017-12-09T17:20:40.420' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (125, CAST(N'2017-12-09T17:37:58.300' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (126, CAST(N'2017-12-09T17:39:48.817' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (1108, CAST(N'2017-12-09T20:33:48.650' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (2108, CAST(N'2017-12-12T11:19:26.333' AS DateTime), N'Invalid login attempt with the username Admin.', 2, 0, 0, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (2109, CAST(N'2017-12-12T11:19:37.370' AS DateTime), N'Successfull Login -  UserName : Crystal Password:  ********.', 2, 0, 1, 1, NULL)
GO
INSERT [dbo].[cmsEventLog] ([EventID], [EventDate], [EventDescription], [EventTypeID], [EventMode], [UserID], [CounterID], [Extra1]) VALUES (2110, CAST(N'2017-12-12T11:20:04.747' AS DateTime), N'Application closed.', 1, 0, 1, 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[cmsEventLog] OFF
GO
SET IDENTITY_INSERT [dbo].[cmsFinancialYear] ON 
GO
INSERT [dbo].[cmsFinancialYear] ([FYearID], [FYearStart], [FYearClose], [CreatedBy], [CreatedOn], [IsDeleted]) VALUES (1, CAST(N'2017-04-01' AS Date), CAST(N'2018-03-31' AS Date), 0, CAST(N'2017-11-23T19:13:00' AS SmallDateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[cmsFinancialYear] OFF
GO
SET IDENTITY_INSERT [dbo].[cmsGeneralSettings] ON 
GO
INSERT [dbo].[cmsGeneralSettings] ([SettingsID], [SequenceNo], [Settings], [Value]) VALUES (1, 1, N'CompanyID', N'1')
GO
INSERT [dbo].[cmsGeneralSettings] ([SettingsID], [SequenceNo], [Settings], [Value]) VALUES (2, 2, N'CompanyName', N'Company Name')
GO
INSERT [dbo].[cmsGeneralSettings] ([SettingsID], [SequenceNo], [Settings], [Value]) VALUES (3, 3, N'CompanyNameForPrint', N'Company Name')
GO
INSERT [dbo].[cmsGeneralSettings] ([SettingsID], [SequenceNo], [Settings], [Value]) VALUES (4, 4, N'CompanyAddress1', N'Address1')
GO
INSERT [dbo].[cmsGeneralSettings] ([SettingsID], [SequenceNo], [Settings], [Value]) VALUES (5, 5, N'CompanyAddress2', N'Address2')
GO
INSERT [dbo].[cmsGeneralSettings] ([SettingsID], [SequenceNo], [Settings], [Value]) VALUES (6, 6, N'CompanyAddress3', N'Address3')
GO
INSERT [dbo].[cmsGeneralSettings] ([SettingsID], [SequenceNo], [Settings], [Value]) VALUES (7, 7, N'CompanyPhone', N'Ph: 0484 - 2466514')
GO
INSERT [dbo].[cmsGeneralSettings] ([SettingsID], [SequenceNo], [Settings], [Value]) VALUES (8, 8, N'CompanyEmail', N'Company@gmail.com')
GO
INSERT [dbo].[cmsGeneralSettings] ([SettingsID], [SequenceNo], [Settings], [Value]) VALUES (9, 9, N'CurrencyNoOfDecimalPlaces', N'2')
GO
SET IDENTITY_INSERT [dbo].[cmsGeneralSettings] OFF
GO
SET IDENTITY_INSERT [dbo].[cmsIndicationEventLogType] ON 
GO
INSERT [dbo].[cmsIndicationEventLogType] ([EventLogTypeID], [EventLogType]) VALUES (1, N'Application')
GO
INSERT [dbo].[cmsIndicationEventLogType] ([EventLogTypeID], [EventLogType]) VALUES (2, N'Login')
GO
INSERT [dbo].[cmsIndicationEventLogType] ([EventLogTypeID], [EventLogType]) VALUES (3, N'Customer')
GO
INSERT [dbo].[cmsIndicationEventLogType] ([EventLogTypeID], [EventLogType]) VALUES (4, N'Product')
GO
SET IDENTITY_INSERT [dbo].[cmsIndicationEventLogType] OFF
GO
SET IDENTITY_INSERT [dbo].[cmsIndicationMenuShortcutKeyModifier] ON 
GO
INSERT [dbo].[cmsIndicationMenuShortcutKeyModifier] ([MenuShortcutKeyModifierID], [MenuShortcutKeyModifier]) VALUES (0, N'None')
GO
INSERT [dbo].[cmsIndicationMenuShortcutKeyModifier] ([MenuShortcutKeyModifierID], [MenuShortcutKeyModifier]) VALUES (1, N'Alt')
GO
INSERT [dbo].[cmsIndicationMenuShortcutKeyModifier] ([MenuShortcutKeyModifierID], [MenuShortcutKeyModifier]) VALUES (2, N'Control')
GO
INSERT [dbo].[cmsIndicationMenuShortcutKeyModifier] ([MenuShortcutKeyModifierID], [MenuShortcutKeyModifier]) VALUES (3, N'Shift')
GO
SET IDENTITY_INSERT [dbo].[cmsIndicationMenuShortcutKeyModifier] OFF
GO
SET IDENTITY_INSERT [dbo].[cmsMenuItem] ON 
GO
INSERT [dbo].[cmsMenuItem] ([MenuID], [MenuParent], [MenuName], [MenuUrl], [ModuleID], [MenuDisplayOrder], [MenuShortcutKeyModifierID], [MenuShortcutKey], [UserAccessRightSettingsApplicable], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [IsDeleted], [DeletedBy], [DeletedOn]) VALUES (1, 0, N'&Entries', N'#', 1, 1, 0, NULL, 0, 0, CAST(N'2017-11-25T14:04:00' AS SmallDateTime), 0, NULL, 0, 0, NULL)
GO
INSERT [dbo].[cmsMenuItem] ([MenuID], [MenuParent], [MenuName], [MenuUrl], [ModuleID], [MenuDisplayOrder], [MenuShortcutKeyModifierID], [MenuShortcutKey], [UserAccessRightSettingsApplicable], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [IsDeleted], [DeletedBy], [DeletedOn]) VALUES (2, 0, N'&Reports', N'#', 1, 2, 0, NULL, 0, 0, CAST(N'2017-11-25T14:04:00' AS SmallDateTime), 0, NULL, 0, 0, NULL)
GO
INSERT [dbo].[cmsMenuItem] ([MenuID], [MenuParent], [MenuName], [MenuUrl], [ModuleID], [MenuDisplayOrder], [MenuShortcutKeyModifierID], [MenuShortcutKey], [UserAccessRightSettingsApplicable], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [IsDeleted], [DeletedBy], [DeletedOn]) VALUES (3, 0, N'&Setup', N'#', 1, 3, 0, NULL, 0, 0, CAST(N'2017-11-25T14:04:00' AS SmallDateTime), 0, NULL, 0, 0, NULL)
GO
INSERT [dbo].[cmsMenuItem] ([MenuID], [MenuParent], [MenuName], [MenuUrl], [ModuleID], [MenuDisplayOrder], [MenuShortcutKeyModifierID], [MenuShortcutKey], [UserAccessRightSettingsApplicable], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [IsDeleted], [DeletedBy], [DeletedOn]) VALUES (4, 0, N'&Tools', N'#', 1, 4, 0, NULL, 0, 0, CAST(N'2017-11-25T14:04:00' AS SmallDateTime), 0, NULL, 0, 0, NULL)
GO
INSERT [dbo].[cmsMenuItem] ([MenuID], [MenuParent], [MenuName], [MenuUrl], [ModuleID], [MenuDisplayOrder], [MenuShortcutKeyModifierID], [MenuShortcutKey], [UserAccessRightSettingsApplicable], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [IsDeleted], [DeletedBy], [DeletedOn]) VALUES (5, 0, N'&Windows', N'#', 1, 5, 0, NULL, 0, 0, CAST(N'2017-11-25T14:04:00' AS SmallDateTime), 0, NULL, 0, 0, NULL)
GO
INSERT [dbo].[cmsMenuItem] ([MenuID], [MenuParent], [MenuName], [MenuUrl], [ModuleID], [MenuDisplayOrder], [MenuShortcutKeyModifierID], [MenuShortcutKey], [UserAccessRightSettingsApplicable], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [IsDeleted], [DeletedBy], [DeletedOn]) VALUES (6, 1, N'', N'separator', 1, 9998, 0, NULL, 0, 0, CAST(N'2017-11-25T14:04:00' AS SmallDateTime), 0, NULL, 0, 0, NULL)
GO
INSERT [dbo].[cmsMenuItem] ([MenuID], [MenuParent], [MenuName], [MenuUrl], [ModuleID], [MenuDisplayOrder], [MenuShortcutKeyModifierID], [MenuShortcutKey], [UserAccessRightSettingsApplicable], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [IsDeleted], [DeletedBy], [DeletedOn]) VALUES (7, 1, N'&Exit', N'Exit', 1, 9999, 0, NULL, 0, 0, CAST(N'2017-11-25T14:04:00' AS SmallDateTime), 0, NULL, 0, 0, NULL)
GO
INSERT [dbo].[cmsMenuItem] ([MenuID], [MenuParent], [MenuName], [MenuUrl], [ModuleID], [MenuDisplayOrder], [MenuShortcutKeyModifierID], [MenuShortcutKey], [UserAccessRightSettingsApplicable], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [IsDeleted], [DeletedBy], [DeletedOn]) VALUES (8, 3, N'&Customer', N'frmCustomer', 1, 1, 0, NULL, 0, 0, CAST(N'2017-11-25T19:42:00' AS SmallDateTime), 0, NULL, 0, 0, NULL)
GO
INSERT [dbo].[cmsMenuItem] ([MenuID], [MenuParent], [MenuName], [MenuUrl], [ModuleID], [MenuDisplayOrder], [MenuShortcutKeyModifierID], [MenuShortcutKey], [UserAccessRightSettingsApplicable], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [IsDeleted], [DeletedBy], [DeletedOn]) VALUES (9, 3, N'&Product', N'frmProduct', 1, 2, 0, NULL, 0, 0, CAST(N'2017-12-02T17:48:00' AS SmallDateTime), 0, NULL, 0, 0, NULL)
GO
INSERT [dbo].[cmsMenuItem] ([MenuID], [MenuParent], [MenuName], [MenuUrl], [ModuleID], [MenuDisplayOrder], [MenuShortcutKeyModifierID], [MenuShortcutKey], [UserAccessRightSettingsApplicable], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [IsDeleted], [DeletedBy], [DeletedOn]) VALUES (10, 1, N'&Sales Voucher', N'frmSalesVoucher', 1, 1, 0, NULL, 0, 0, CAST(N'2017-12-09T11:36:00' AS SmallDateTime), 0, NULL, 0, 0, NULL)
GO
SET IDENTITY_INSERT [dbo].[cmsMenuItem] OFF
GO
SET IDENTITY_INSERT [dbo].[cmsProductModel] ON 
GO
INSERT [dbo].[cmsProductModel] ([ModelID], [ModelName], [Description], [Rate]) VALUES (1, N'1/4 inch', NULL, 150.0000)
GO
INSERT [dbo].[cmsProductModel] ([ModelID], [ModelName], [Description], [Rate]) VALUES (2, N'3/4 inch', NULL, 1000.0000)
GO
INSERT [dbo].[cmsProductModel] ([ModelID], [ModelName], [Description], [Rate]) VALUES (3, N'1 1/2 inch', NULL, 1300.0000)
GO
SET IDENTITY_INSERT [dbo].[cmsProductModel] OFF
GO
SET IDENTITY_INSERT [dbo].[cmsUser] ON 
GO
INSERT [dbo].[cmsUser] ([UserID], [UserName], [FullName], [Password], [RoleID], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [IsDeleted], [DeletedBy], [DeletedOn]) VALUES (1, N'crystal', N'Crystal', 0xC4CA4238A0B923820DCC509A6F75849B, 1, 0, CAST(N'2017-11-25T13:22:00' AS SmallDateTime), 0, NULL, 0, 0, NULL)
GO
SET IDENTITY_INSERT [dbo].[cmsUser] OFF
GO
SET IDENTITY_INSERT [dbo].[cmsUserRole] ON 
GO
INSERT [dbo].[cmsUserRole] ([RoleID], [RoleName], [RoleType], [CreatedBy], [CreatedOn], [IsDeleted], [DeletedBy], [DeletedOn]) VALUES (1, N'infoSoft', 2, 0, CAST(N'2017-11-25T13:18:00' AS SmallDateTime), 0, N'0         ', NULL)
GO
SET IDENTITY_INSERT [dbo].[cmsUserRole] OFF
GO
INSERT [dbo].[cmsUserRolePermissions] ([RoleID], [MenuID]) VALUES (1, 1)
GO
INSERT [dbo].[cmsUserRolePermissions] ([RoleID], [MenuID]) VALUES (1, 2)
GO
INSERT [dbo].[cmsUserRolePermissions] ([RoleID], [MenuID]) VALUES (1, 3)
GO
INSERT [dbo].[cmsUserRolePermissions] ([RoleID], [MenuID]) VALUES (1, 4)
GO
INSERT [dbo].[cmsUserRolePermissions] ([RoleID], [MenuID]) VALUES (1, 5)
GO
INSERT [dbo].[cmsUserRolePermissions] ([RoleID], [MenuID]) VALUES (1, 6)
GO
INSERT [dbo].[cmsUserRolePermissions] ([RoleID], [MenuID]) VALUES (1, 7)
GO
INSERT [dbo].[cmsUserRolePermissions] ([RoleID], [MenuID]) VALUES (1, 8)
GO
INSERT [dbo].[cmsUserRolePermissions] ([RoleID], [MenuID]) VALUES (1, 9)
GO
INSERT [dbo].[cmsUserRolePermissions] ([RoleID], [MenuID]) VALUES (1, 10)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_cmsCustomer]    Script Date: 12/12/2017 2:14:24 PM ******/
ALTER TABLE [dbo].[cmsCustomer] ADD  CONSTRAINT [IX_cmsCustomer] UNIQUE NONCLUSTERED 
(
	[VehicleNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cmsApplicationModules] ADD  CONSTRAINT [DF_cmsApplicationModules_ModuleName]  DEFAULT ('') FOR [ModuleName]
GO
ALTER TABLE [dbo].[cmsApplicationRelease] ADD  CONSTRAINT [DF_cmsApplicationRelease_ReleaseDate]  DEFAULT (getdate()) FOR [ReleaseDate]
GO
ALTER TABLE [dbo].[cmsApplicationRelease] ADD  CONSTRAINT [DF_cmsApplicationRelease_MajorVersion]  DEFAULT ((0)) FOR [MajorVersion]
GO
ALTER TABLE [dbo].[cmsApplicationRelease] ADD  CONSTRAINT [DF_cmsApplicationRelease_MinorVersion]  DEFAULT ((0)) FOR [MinorVersion]
GO
ALTER TABLE [dbo].[cmsApplicationRelease] ADD  CONSTRAINT [DF_cmsApplicationRelease_Build]  DEFAULT ((0)) FOR [Build]
GO
ALTER TABLE [dbo].[cmsApplicationRelease] ADD  CONSTRAINT [DF_cmsApplicationRelease_RevisionVersion]  DEFAULT ((0)) FOR [RevisionVersion]
GO
ALTER TABLE [dbo].[cmsApplicationRelease] ADD  CONSTRAINT [DF_cmsApplicationRelease_CreatedBy]  DEFAULT ((0)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[cmsApplicationRelease] ADD  CONSTRAINT [DF_cmsApplicationRelease_CreatedDateAndTime]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[cmsApplicationReleaseDetails] ADD  CONSTRAINT [DF_cmsApplicationReleaseDetails_ReleaseID]  DEFAULT ((0)) FOR [ReleaseID]
GO
ALTER TABLE [dbo].[cmsApplicationReleaseDetails] ADD  CONSTRAINT [DF_cmsApplicationReleaseDetails_SequenceNo]  DEFAULT ((0)) FOR [SequenceNo]
GO
ALTER TABLE [dbo].[cmsApplicationReleaseDetails] ADD  CONSTRAINT [DF_cmsApplicationReleaseDetails_ReleaseDescription]  DEFAULT ('') FOR [ReleaseDescription]
GO
ALTER TABLE [dbo].[cmsCounter] ADD  CONSTRAINT [DF_cmsCounter_CounterName]  DEFAULT ('') FOR [CounterName]
GO
ALTER TABLE [dbo].[cmsCounter] ADD  CONSTRAINT [DF_cmsCounter_DisplayName]  DEFAULT ('') FOR [DisplayName]
GO
ALTER TABLE [dbo].[cmsCounter] ADD  CONSTRAINT [DF_cmsCounter_CreatedBy]  DEFAULT ((0)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[cmsCounter] ADD  CONSTRAINT [DF_cmsCounter_CreatedDateAndTime]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[cmsCounter] ADD  CONSTRAINT [DF_cmsCounter_ModifiedBy]  DEFAULT ((0)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[cmsCounter] ADD  CONSTRAINT [DF_cmsCounter_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[cmsCounter] ADD  CONSTRAINT [DF_cmsCounter_DeletedBy]  DEFAULT ((0)) FOR [DeletedBy]
GO
ALTER TABLE [dbo].[cmsCustomer] ADD  CONSTRAINT [DF_cmsCustomer_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[cmsEventLog] ADD  CONSTRAINT [DF_cmsEventLog_EventDate]  DEFAULT (getdate()) FOR [EventDate]
GO
ALTER TABLE [dbo].[cmsEventLog] ADD  CONSTRAINT [DF_cmsEventLog_EventDescription]  DEFAULT ('') FOR [EventDescription]
GO
ALTER TABLE [dbo].[cmsEventLog] ADD  CONSTRAINT [DF_cmsEventLog_EventLogTypeID]  DEFAULT ((0)) FOR [EventTypeID]
GO
ALTER TABLE [dbo].[cmsEventLog] ADD  CONSTRAINT [DF_cmsEventLog_EventMode]  DEFAULT ((0)) FOR [EventMode]
GO
ALTER TABLE [dbo].[cmsEventLog] ADD  CONSTRAINT [DF_cmsEventLog_UserID]  DEFAULT ((0)) FOR [UserID]
GO
ALTER TABLE [dbo].[cmsEventLog] ADD  CONSTRAINT [DF_cmsEventLog_CounterID]  DEFAULT ((0)) FOR [CounterID]
GO
ALTER TABLE [dbo].[cmsFinancialYear] ADD  CONSTRAINT [DF_cmsFinancialYear_FYearStart]  DEFAULT (getdate()) FOR [FYearStart]
GO
ALTER TABLE [dbo].[cmsFinancialYear] ADD  CONSTRAINT [DF_cmsFinancialYear_FYearClose]  DEFAULT (getdate()) FOR [FYearClose]
GO
ALTER TABLE [dbo].[cmsFinancialYear] ADD  CONSTRAINT [DF_cmsFinancialYear_CreatedBy]  DEFAULT ((0)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[cmsFinancialYear] ADD  CONSTRAINT [DF_cmsFinancialYear_CreatedDateAndTime]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[cmsFinancialYear] ADD  CONSTRAINT [DF_cmsFinancialYear_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[cmsGeneralSettings] ADD  CONSTRAINT [DF_cmsGeneralSettings_SequenceNo]  DEFAULT ((0)) FOR [SequenceNo]
GO
ALTER TABLE [dbo].[cmsGeneralSettings] ADD  CONSTRAINT [DF_cmsGeneralSettings_Settings]  DEFAULT ('') FOR [Settings]
GO
ALTER TABLE [dbo].[cmsGeneralSettings] ADD  CONSTRAINT [DF_cmsGeneralSettings_Value]  DEFAULT ('') FOR [Value]
GO
ALTER TABLE [dbo].[cmsIndicationEventLogType] ADD  CONSTRAINT [DF_cmsIndicationEventLogType_EventLogType]  DEFAULT ('') FOR [EventLogType]
GO
ALTER TABLE [dbo].[cmsIndicationMenuShortcutKeyModifier] ADD  CONSTRAINT [DF_cmsIndicationMenuShortcutKeyModifier_MenuShortcutKeyModifier]  DEFAULT ('') FOR [MenuShortcutKeyModifier]
GO
ALTER TABLE [dbo].[cmsMenuItem] ADD  CONSTRAINT [DF_cmsMenuItem_MenuParent]  DEFAULT ((0)) FOR [MenuParent]
GO
ALTER TABLE [dbo].[cmsMenuItem] ADD  CONSTRAINT [DF_cmsMenuItem_MenuName]  DEFAULT ('') FOR [MenuName]
GO
ALTER TABLE [dbo].[cmsMenuItem] ADD  CONSTRAINT [DF_cmsMenuItem_MenuUrl]  DEFAULT ('') FOR [MenuUrl]
GO
ALTER TABLE [dbo].[cmsMenuItem] ADD  CONSTRAINT [DF_cmsMenuItem_ModuleID]  DEFAULT ((0)) FOR [ModuleID]
GO
ALTER TABLE [dbo].[cmsMenuItem] ADD  CONSTRAINT [DF_cmsMenuItem_MenuDisplayOrder]  DEFAULT ((0)) FOR [MenuDisplayOrder]
GO
ALTER TABLE [dbo].[cmsMenuItem] ADD  CONSTRAINT [DF_cmsMenuItem_MenuShortcutKeyModifierID]  DEFAULT ((0)) FOR [MenuShortcutKeyModifierID]
GO
ALTER TABLE [dbo].[cmsMenuItem] ADD  CONSTRAINT [DF_cmsMenuItem_UserAccessRightSettingsApplicable]  DEFAULT ((0)) FOR [UserAccessRightSettingsApplicable]
GO
ALTER TABLE [dbo].[cmsMenuItem] ADD  CONSTRAINT [DF_cmsMenuItem_CreatedBy]  DEFAULT ((0)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[cmsMenuItem] ADD  CONSTRAINT [DF_cmsMenuItem_CreatedDateAndTime]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[cmsMenuItem] ADD  CONSTRAINT [DF_cmsMenuItem_ModifiedBy]  DEFAULT ((0)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[cmsMenuItem] ADD  CONSTRAINT [DF_cmsMenuItem_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[cmsMenuItem] ADD  CONSTRAINT [DF_cmsMenuItem_DeletedBy]  DEFAULT ((0)) FOR [DeletedBy]
GO
ALTER TABLE [dbo].[cmsProductModel] ADD  CONSTRAINT [DF_cmsProductModel_ModelName]  DEFAULT ('') FOR [ModelName]
GO
ALTER TABLE [dbo].[cmsProductModel] ADD  CONSTRAINT [DF_cmsProductModel_Rate]  DEFAULT ((0)) FOR [Rate]
GO
ALTER TABLE [dbo].[cmsSalesVoucher] ADD  CONSTRAINT [DF_Table_1_SaleDate]  DEFAULT (getdate()) FOR [SalesDate]
GO
ALTER TABLE [dbo].[cmsSalesVoucher] ADD  CONSTRAINT [DF_cmsSalesVoucher_Quantity]  DEFAULT ((0)) FOR [Quantity]
GO
ALTER TABLE [dbo].[cmsSalesVoucher] ADD  CONSTRAINT [DF_cmsSalesVoucher_Rate]  DEFAULT ((0)) FOR [Rate]
GO
ALTER TABLE [dbo].[cmsSalesVoucher] ADD  CONSTRAINT [DF_cmsSalesVoucher_Discount]  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [dbo].[cmsSalesVoucher] ADD  CONSTRAINT [DF_cmsSalesVoucher_NetAmount]  DEFAULT ((0)) FOR [NetAmount]
GO
ALTER TABLE [dbo].[cmsSalesVoucher] ADD  CONSTRAINT [DF_cmsSalesVoucher_CreatedBy]  DEFAULT ((0)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[cmsSalesVoucher] ADD  CONSTRAINT [DF_cmsSalesVoucher_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[cmsSalesVoucher] ADD  CONSTRAINT [DF_cmsSalesVoucher_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[cmsUser] ADD  CONSTRAINT [DF_cmsUser_UserName]  DEFAULT ('') FOR [UserName]
GO
ALTER TABLE [dbo].[cmsUser] ADD  CONSTRAINT [DF_cmsUser_FullName]  DEFAULT ('') FOR [FullName]
GO
ALTER TABLE [dbo].[cmsUser] ADD  CONSTRAINT [DF_cmsUser_RoleID]  DEFAULT ((0)) FOR [RoleID]
GO
ALTER TABLE [dbo].[cmsUser] ADD  CONSTRAINT [DF_cmsUser_CreatedBy]  DEFAULT ((0)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[cmsUser] ADD  CONSTRAINT [DF_cmsUser_CreatedDateAndTime]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[cmsUser] ADD  CONSTRAINT [DF_cmsUser_ModifiedBy]  DEFAULT ((0)) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[cmsUser] ADD  CONSTRAINT [DF_cmsUser_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[cmsUser] ADD  CONSTRAINT [DF_cmsUser_DeletedBy]  DEFAULT ((0)) FOR [DeletedBy]
GO
ALTER TABLE [dbo].[cmsUserAccessRightPermissions] ADD  CONSTRAINT [DF_cmsUserAccessRightPermissions_RoleID]  DEFAULT ((0)) FOR [RoleID]
GO
ALTER TABLE [dbo].[cmsUserAccessRightPermissions] ADD  CONSTRAINT [DF_cmsUserAccessRightPermissions_UserAccessSettingsID]  DEFAULT ((0)) FOR [UserAccessSettingsID]
GO
ALTER TABLE [dbo].[cmsUserAccessRightPermissions] ADD  CONSTRAINT [DF_cmsUserAccessRightPermissions_PermissionStatus]  DEFAULT ((0)) FOR [PermissionStatus]
GO
ALTER TABLE [dbo].[cmsUserAccessRights] ADD  CONSTRAINT [DF_cmsUserAccessRights_AccessRight]  DEFAULT ('') FOR [AccessRight]
GO
ALTER TABLE [dbo].[cmsUserAccessRights] ADD  CONSTRAINT [DF_cmsUserAccessRights_DefaultValue]  DEFAULT ((0)) FOR [DefaultValue]
GO
ALTER TABLE [dbo].[cmsUserAccessRightSettings] ADD  CONSTRAINT [DF_cmsUserAccessRightSettings_SequenceNo]  DEFAULT ((0)) FOR [SequenceNo]
GO
ALTER TABLE [dbo].[cmsUserAccessRightSettings] ADD  CONSTRAINT [DF_cmsUserAccessRightSettings_MenuID]  DEFAULT ((0)) FOR [MenuID]
GO
ALTER TABLE [dbo].[cmsUserAccessRightSettings] ADD  CONSTRAINT [DF_cmsUserAccessRightSettings_AccessRightID]  DEFAULT ((0)) FOR [AccessRightID]
GO
ALTER TABLE [dbo].[cmsUserRole] ADD  CONSTRAINT [DF_cmsUserRole_RoleName]  DEFAULT ('') FOR [RoleName]
GO
ALTER TABLE [dbo].[cmsUserRole] ADD  CONSTRAINT [DF_cmsUserRole_RoleType]  DEFAULT ((0)) FOR [RoleType]
GO
ALTER TABLE [dbo].[cmsUserRole] ADD  CONSTRAINT [DF_cmsUserRole_CreatedBy]  DEFAULT ((0)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[cmsUserRole] ADD  CONSTRAINT [DF_cmsUserRole_CreatedDateAndTime]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[cmsUserRole] ADD  CONSTRAINT [DF_cmsUserRole_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[cmsUserRole] ADD  CONSTRAINT [DF_cmsUserRole_DeletedBy]  DEFAULT ((0)) FOR [DeletedBy]
GO
ALTER TABLE [dbo].[cmsUserRolePermissions] ADD  CONSTRAINT [DF_cmsUserRolePermissions_RoleID]  DEFAULT ((0)) FOR [RoleID]
GO
ALTER TABLE [dbo].[cmsUserRolePermissions] ADD  CONSTRAINT [DF_cmsUserRolePermissions_MenuID]  DEFAULT ((0)) FOR [MenuID]
GO
ALTER TABLE [dbo].[cmsApplicationReleaseDetails]  WITH CHECK ADD  CONSTRAINT [FK_cmsApplicationReleaseDetails_cmsApplicationRelease] FOREIGN KEY([ReleaseID])
REFERENCES [dbo].[cmsApplicationRelease] ([ReleaseID])
GO
ALTER TABLE [dbo].[cmsApplicationReleaseDetails] CHECK CONSTRAINT [FK_cmsApplicationReleaseDetails_cmsApplicationRelease]
GO
ALTER TABLE [dbo].[cmsEventLog]  WITH CHECK ADD  CONSTRAINT [FK_cmsEventLog_cmsCounter] FOREIGN KEY([CounterID])
REFERENCES [dbo].[cmsCounter] ([CounterID])
GO
ALTER TABLE [dbo].[cmsEventLog] CHECK CONSTRAINT [FK_cmsEventLog_cmsCounter]
GO
ALTER TABLE [dbo].[cmsEventLog]  WITH CHECK ADD  CONSTRAINT [FK_cmsEventLog_cmsIndicationEventLogType] FOREIGN KEY([EventTypeID])
REFERENCES [dbo].[cmsIndicationEventLogType] ([EventLogTypeID])
GO
ALTER TABLE [dbo].[cmsEventLog] CHECK CONSTRAINT [FK_cmsEventLog_cmsIndicationEventLogType]
GO
ALTER TABLE [dbo].[cmsMenuItem]  WITH CHECK ADD  CONSTRAINT [FK_cmsMenuItem_cmsApplicationModules] FOREIGN KEY([ModuleID])
REFERENCES [dbo].[cmsApplicationModules] ([ModuleID])
GO
ALTER TABLE [dbo].[cmsMenuItem] CHECK CONSTRAINT [FK_cmsMenuItem_cmsApplicationModules]
GO
ALTER TABLE [dbo].[cmsMenuItem]  WITH CHECK ADD  CONSTRAINT [FK_cmsMenuItem_cmsIndicationMenuShortcutKeyModifier] FOREIGN KEY([MenuShortcutKeyModifierID])
REFERENCES [dbo].[cmsIndicationMenuShortcutKeyModifier] ([MenuShortcutKeyModifierID])
GO
ALTER TABLE [dbo].[cmsMenuItem] CHECK CONSTRAINT [FK_cmsMenuItem_cmsIndicationMenuShortcutKeyModifier]
GO
ALTER TABLE [dbo].[cmsMenuItem]  WITH NOCHECK ADD  CONSTRAINT [FK_cmsMenuItem_cmsMenuItem] FOREIGN KEY([MenuParent])
REFERENCES [dbo].[cmsMenuItem] ([MenuID])
GO
ALTER TABLE [dbo].[cmsMenuItem] CHECK CONSTRAINT [FK_cmsMenuItem_cmsMenuItem]
GO
ALTER TABLE [dbo].[cmsSalesVoucher]  WITH CHECK ADD  CONSTRAINT [FK_cmsSalesVoucher_cmsCustomer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[cmsCustomer] ([CustomerID])
GO
ALTER TABLE [dbo].[cmsSalesVoucher] CHECK CONSTRAINT [FK_cmsSalesVoucher_cmsCustomer]
GO
ALTER TABLE [dbo].[cmsSalesVoucher]  WITH CHECK ADD  CONSTRAINT [FK_cmsSalesVoucher_cmsProductModel] FOREIGN KEY([ModelId])
REFERENCES [dbo].[cmsProductModel] ([ModelID])
GO
ALTER TABLE [dbo].[cmsSalesVoucher] CHECK CONSTRAINT [FK_cmsSalesVoucher_cmsProductModel]
GO
ALTER TABLE [dbo].[cmsSalesVoucher]  WITH CHECK ADD  CONSTRAINT [FK_cmsSalesVoucher_cmsUser] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[cmsUser] ([UserID])
GO
ALTER TABLE [dbo].[cmsSalesVoucher] CHECK CONSTRAINT [FK_cmsSalesVoucher_cmsUser]
GO
ALTER TABLE [dbo].[cmsUser]  WITH CHECK ADD  CONSTRAINT [FK_cmsUser_cmsUserRole] FOREIGN KEY([RoleID])
REFERENCES [dbo].[cmsUserRole] ([RoleID])
GO
ALTER TABLE [dbo].[cmsUser] CHECK CONSTRAINT [FK_cmsUser_cmsUserRole]
GO
ALTER TABLE [dbo].[cmsUserAccessRightPermissions]  WITH CHECK ADD  CONSTRAINT [FK_cmsUserAccessRightPermissions_cmsUserAccessRightSettings] FOREIGN KEY([UserAccessSettingsID])
REFERENCES [dbo].[cmsUserAccessRightSettings] ([UserAccessSettingsID])
GO
ALTER TABLE [dbo].[cmsUserAccessRightPermissions] CHECK CONSTRAINT [FK_cmsUserAccessRightPermissions_cmsUserAccessRightSettings]
GO
ALTER TABLE [dbo].[cmsUserAccessRightPermissions]  WITH CHECK ADD  CONSTRAINT [FK_cmsUserAccessRightPermissions_cmsUserRole] FOREIGN KEY([RoleID])
REFERENCES [dbo].[cmsUserRole] ([RoleID])
GO
ALTER TABLE [dbo].[cmsUserAccessRightPermissions] CHECK CONSTRAINT [FK_cmsUserAccessRightPermissions_cmsUserRole]
GO
ALTER TABLE [dbo].[cmsUserAccessRightSettings]  WITH CHECK ADD  CONSTRAINT [FK_cmsUserAccessRightSettings_cmsMenuItem] FOREIGN KEY([MenuID])
REFERENCES [dbo].[cmsMenuItem] ([MenuID])
GO
ALTER TABLE [dbo].[cmsUserAccessRightSettings] CHECK CONSTRAINT [FK_cmsUserAccessRightSettings_cmsMenuItem]
GO
ALTER TABLE [dbo].[cmsUserAccessRightSettings]  WITH CHECK ADD  CONSTRAINT [FK_cmsUserAccessRightSettings_cmsUserAccessRights] FOREIGN KEY([AccessRightID])
REFERENCES [dbo].[cmsUserAccessRights] ([AccessRightID])
GO
ALTER TABLE [dbo].[cmsUserAccessRightSettings] CHECK CONSTRAINT [FK_cmsUserAccessRightSettings_cmsUserAccessRights]
GO
ALTER TABLE [dbo].[cmsUserRolePermissions]  WITH CHECK ADD  CONSTRAINT [FK_cmsUserRolePermissions_cmsMenuItem] FOREIGN KEY([MenuID])
REFERENCES [dbo].[cmsMenuItem] ([MenuID])
GO
ALTER TABLE [dbo].[cmsUserRolePermissions] CHECK CONSTRAINT [FK_cmsUserRolePermissions_cmsMenuItem]
GO
ALTER TABLE [dbo].[cmsUserRolePermissions]  WITH CHECK ADD  CONSTRAINT [FK_cmsUserRolePermissions_cmsUserRole] FOREIGN KEY([RoleID])
REFERENCES [dbo].[cmsUserRole] ([RoleID])
GO
ALTER TABLE [dbo].[cmsUserRolePermissions] CHECK CONSTRAINT [FK_cmsUserRolePermissions_cmsUserRole]
GO
ALTER TABLE [dbo].[cmsCustomer]  WITH CHECK ADD  CONSTRAINT [CK_cmsCustomer] CHECK  (([CustomerName] IS NOT NULL OR [VehicleNo] IS NOT NULL))
GO
ALTER TABLE [dbo].[cmsCustomer] CHECK CONSTRAINT [CK_cmsCustomer]
GO
/****** Object:  StoredProcedure [dbo].[cmsAuthenticateLogin]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Noble
-- Create date: 14.06.2015
-- Description:	To check login authentication
-- =============================================
CREATE PROCEDURE [dbo].[cmsAuthenticateLogin]
(
	@Username Varchar(50)	--Username
	,@Password Varchar(50)	--Password
)
AS
BEGIN

	SET NOCOUNT ON;

    SELECT 
		UserID  
        ,UserName
        ,FullName
        ,RoleID  
        ,CASE WHEN HASHBYTES('MD5',@Password) = Password THEN 1 ELSE 0 END AS Validity
	FROM 
		cmsUser
	WHERE 
		UserName = @UserName	
		AND IsDeleted <> 1
END
GO
/****** Object:  StoredProcedure [dbo].[cmsCheckDuplicateCustomerName]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Noble
-- Create date: 02.12.2017
-- Description:	To check duplicate customer name
-- =============================================
CREATE PROCEDURE [dbo].[cmsCheckDuplicateCustomerName]
(
	@CustomerID		INT
	,@CustomerName	VARCHAR(50)
)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT 
		COUNT(CustomerID) AS CustomerCount
	FROM 
		cmsCustomer
	WHERE
		CustomerID <> @CustomerID
		AND CustomerName = @CustomerName
		AND IsDeleted = 0
END
GO
/****** Object:  StoredProcedure [dbo].[cmsCheckDuplicateVehicleNo]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Noble
-- Create date: 02.12.2017
-- Description:	To check duplicate vehicle number
-- =============================================
CREATE PROCEDURE [dbo].[cmsCheckDuplicateVehicleNo]
(
	@CustomerID		INT
	,@VehicleNo	VARCHAR(15)
)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT 
		COUNT(CustomerID) AS CustomerCount
	FROM 
		cmsCustomer
	WHERE
		CustomerID <> @CustomerID
		AND VehicleNo = @VehicleNo
		AND IsDeleted = 0
END
GO
/****** Object:  StoredProcedure [dbo].[cmsDeleteCustomer]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Noble
-- Create date: 25/11/2017
-- Description:	Delete customer
-- =============================================
CREATE PROCEDURE [dbo].[cmsDeleteCustomer]
(
	@CustomerID	INT
	,@UserID	INT
)
AS
BEGIN

	SET NOCOUNT ON;

    UPDATE [dbo].[cmsCustomer]
	SET
		[IsDeleted] = 1
		,[DeletedBy] = @UserID
		,[DeletedOn] = GETDATE()
	WHERE
		[CustomerID] = @CustomerID
END
GO
/****** Object:  StoredProcedure [dbo].[cmsGetApplicationVersion]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Noble
-- Create date: 14.06.2015
-- Description:	To get current application version
-- =============================================
CREATE PROCEDURE [dbo].[cmsGetApplicationVersion]
AS
BEGIN

	SET NOCOUNT ON;

    SELECT TOP 1 ReleaseID
		  ,MajorVersion
		  ,MinorVersion
		  ,Build
		  ,RevisionVersion
	FROM cmsApplicationRelease
	ORDER BY ReleaseID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[cmsGetCounterDetails]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Noble
-- Create date: 13.06.2015
-- Description:	To get counter details
-- =============================================
CREATE PROCEDURE [dbo].[cmsGetCounterDetails]
AS
BEGIN

	SET NOCOUNT ON;

    SELECT 
		[CounterID]
		,[CounterName]
		,[DisplayName]
		,[PrinterName]
	FROM [dbo].[cmsCounter]
	WHERE 
		UPPER(LTRIM(RTRIM(CounterName))) = UPPER(LTRIM(RTRIM(HOST_NAME())))
		AND IsDeleted = 0
END
GO
/****** Object:  StoredProcedure [dbo].[cmsGetCurrentFinancialYearDetails]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Noble
-- Create date: 14.06.2015
-- Description:	To get current financial year details
-- =============================================
CREATE PROCEDURE [dbo].[cmsGetCurrentFinancialYearDetails]
AS
BEGIN

	SET NOCOUNT ON;

    SELECT 
		[FYearID]
		,[FYearStart]
		,[FYearClose]
	FROM 
		[dbo].[cmsFinancialYear]
	WHERE
		CAST(GETDATE() AS DATE) BETWEEN FyearStart AND FyearClose
END
GO
/****** Object:  StoredProcedure [dbo].[cmsGetCustomerDetails]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Noble
-- Create date: 25/11/2017
-- Description:	To get customer details
-- =============================================
CREATE PROCEDURE [dbo].[cmsGetCustomerDetails]
(
	@CustomerID	INT
)
AS
BEGIN

	SET NOCOUNT ON;	

	SELECT [CustomerID]
      ,ISNULL([CustomerName], '') AS CustomerName
      ,ISNULL([VehicleNo], '') AS VehicleNo
      ,ISNULL([Address1], '') AS Address1
      ,ISNULL([Address2], '') AS Address2
      ,ISNULL([Phone], '') AS Phone
      ,ISNULL([Mobile], '') AS Mobile
	FROM [dbo].[cmsCustomer]
	WHERE 
		[CustomerID] = @CustomerID
		AND [IsDeleted] = 0
END
GO
/****** Object:  StoredProcedure [dbo].[cmsGetCustomerList]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Noble
-- Create date: 25/11/2017
-- Description:	To get all customer list
-- =============================================
CREATE PROCEDURE [dbo].[cmsGetCustomerList]
AS
BEGIN

	SET NOCOUNT ON;

	SELECT [CustomerID]
	  ,CASE WHEN LEN(LTRIM(RTRIM(ISNULL([CustomerName], '')))) = 0 THEN ISNULL([VehicleNo], '') ELSE ISNULL([CustomerName], '') END AS Customer
	FROM [dbo].[cmsCustomer]
	WHERE [IsDeleted] = 0
	ORDER BY 
		CASE WHEN LEN(LTRIM(RTRIM(ISNULL([CustomerName], '')))) = 0 THEN ISNULL([VehicleNo], '') ELSE ISNULL([CustomerName], '') END

END
GO
/****** Object:  StoredProcedure [dbo].[cmsGetCustomerPendingAmountUsingName]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Noble
-- Create date: 09.12.2017
-- Description:	To get the pending amount of customer using name
-- =============================================
CREATE PROCEDURE [dbo].[cmsGetCustomerPendingAmountUsingName]
(
	@CustomerName	VARCHAR(50)
)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT 
		Customer.CustomerID
		, Customer.CustomerName
		, Customer.VehicleNo
		, SUM(ISNULL(Sales.NetAmount, 0)) - SUM(ISNULL(Sales.SettledAmount, 0)) AS PendingAmount
	FROM
		cmsCustomer Customer
		LEFT JOIN cmsSalesVoucher Sales ON Customer.CustomerID = Sales.CustomerId
	WHERE
		Customer.CustomerName = @CustomerName
		AND Customer.IsDeleted = 0
		AND ISNULL(Sales.IsDeleted, 0) = 0
	GROUP BY
		Customer.CustomerID
		, Customer.CustomerName
		, Customer.VehicleNo
END
GO
/****** Object:  StoredProcedure [dbo].[cmsGetCustomerPendingAmountUsingVehicleNo]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Noble
-- Create date: 09.12.2017
-- Description:	To get the pending amount of customer using vehicle number
-- =============================================
CREATE PROCEDURE [dbo].[cmsGetCustomerPendingAmountUsingVehicleNo]
(
	@VehicleNo	VARCHAR(15)
)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT 
		Customer.CustomerID
		, Customer.CustomerName
		, Customer.VehicleNo
		, SUM(ISNULL(Sales.NetAmount, 0)) - SUM(ISNULL(Sales.SettledAmount, 0)) AS PendingAmount
	FROM
		cmsCustomer Customer
		LEFT JOIN cmsSalesVoucher Sales ON Customer.CustomerID = Sales.CustomerId
	WHERE
		Customer.VehicleNo = @VehicleNo
		AND Customer.IsDeleted = 0
		AND ISNULL(Sales.IsDeleted, 0) = 0
	GROUP BY
		Customer.CustomerID
		, Customer.CustomerName
		, Customer.VehicleNo
END
GO
/****** Object:  StoredProcedure [dbo].[cmsGetGeneralSettings]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Noble
-- Create date: 16.06.2015
-- Description:	To get general settings details in tabular mode
-- =============================================
CREATE PROCEDURE [dbo].[cmsGetGeneralSettings]
AS
BEGIN

	SET NOCOUNT ON;

    DECLARE @DynamicPivotQuery AS NVARCHAR(MAX)
	DECLARE @ColumnName AS NVARCHAR(MAX)
	DECLARE @ColumnNameForSelect AS NVARCHAR(MAX)

	--Get distinct values of the PIVOT Column 
	SELECT @ColumnName= ISNULL(@ColumnName + ',','') 
		   + QUOTENAME(Settings)
	FROM cmsGeneralSettings ORDER BY SequenceNo 

	--Get distinct values of the PIVOT Column 
	SELECT @ColumnNameForSelect = ISNULL(+@ColumnNameForSelect + ',','') 
		   + 'MAX(' + QUOTENAME(Settings) + ') AS ' + QUOTENAME(Settings)
	FROM cmsGeneralSettings ORDER BY SequenceNo 

	--Prepare the PIVOT query using the dynamic 
	SET @DynamicPivotQuery = 
	  N'SELECT ' + @ColumnNameForSelect + '
		FROM cmsGeneralSettings
		PIVOT(MAX(Value) 
			  FOR Settings IN (' + @ColumnName + ')) AS PVTTable'

	--Execute the Dynamic Pivot Query
	EXEC sp_executesql @DynamicPivotQuery
END
GO
/****** Object:  StoredProcedure [dbo].[cmsGetProductModelDetails]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Noble
-- Create date: 02.12.2017
-- Description:	To get product model details
-- =============================================
CREATE PROCEDURE [dbo].[cmsGetProductModelDetails]
(
	@ModelID	INT
)
AS
BEGIN

	SET NOCOUNT ON;

    SELECT 
		ModelID
		, ModelName
		, ISNULL(Description, '') AS Description
		, Rate
	FROM
		cmsProductModel
	WHERE
		ModelID = @ModelID
END
GO
/****** Object:  StoredProcedure [dbo].[cmsGetProductModelList]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Noble
-- Create date: 02.12.2017
-- Description:	To get product model list
-- =============================================
CREATE PROCEDURE [dbo].[cmsGetProductModelList] 
AS
BEGIN

	SET NOCOUNT ON;

    SELECT 
		ModelID
		, ModelName
	FROM
		cmsProductModel
END
GO
/****** Object:  StoredProcedure [dbo].[cmsGetProductModelRate]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Noble
-- Create date: 09.12.2017
-- Description:	To get product model rate
-- =============================================
CREATE PROCEDURE [dbo].[cmsGetProductModelRate]
(
	@ModelID	INT
)
AS
BEGIN

	SET NOCOUNT ON;

    SELECT 
		Rate
	FROM
		cmsProductModel
	WHERE
		ModelID = @ModelID
END
GO
/****** Object:  StoredProcedure [dbo].[cmsGetServerDateAndTime]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Noble
-- Create date: 14.06.2015
-- Description:	To get server date and time
-- =============================================
CREATE PROCEDURE [dbo].[cmsGetServerDateAndTime]
AS
BEGIN

	SET NOCOUNT ON;

    SELECT GETDATE()
END
GO
/****** Object:  StoredProcedure [dbo].[cmsGetUserAccessRightsByMenuID]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Noble
-- Create date: 23.07.2015
-- Description:	To get the user access rights of a menu id
-- =============================================
CREATE PROCEDURE [dbo].[cmsGetUserAccessRightsByMenuID]
(
	@MenuID		INT
	,@RoleID	INT
)
AS
BEGIN

	SET NOCOUNT ON;

    SELECT 
		 MenuID
		 ,Settings.AccessRightID
		 ,SequenceNo
		 ,AccessRight
		 ,Rights.Description
		 ,ISNULL(UserPermissions.UserAccessSettingsID, 0) AS UserAccessSettingsID
		 ,ISNULL(PermissionStatus, DefaultValue) AS PermissionStatus
	 FROM [dbo].[cmsUserAccessRightSettings] Settings
		INNER JOIN [dbo].[cmsUserAccessRights] Rights ON Rights.AccessRightID = Settings.AccessRightID
		LEFT JOIN [dbo].[cmsUserAccessRightPermissions] UserPermissions ON UserPermissions.UserAccessSettingsID = Settings.UserAccessSettingsID
	 WHERE
		(RoleID = @RoleID OR RoleID IS NULL) AND MenuID = @MenuID
END
GO
/****** Object:  StoredProcedure [dbo].[cmsGetUserRoleMenuItemPermissions]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Noble
-- Create date: 15.06.2015
-- Description:	To get menu items which have permissions for the user
-- =============================================
CREATE PROCEDURE [dbo].[cmsGetUserRoleMenuItemPermissions]
(
	@RoleID		Int		-- Role identification
	,@ModuleID	Int		-- Module identification
)
AS
BEGIN

	SET NOCOUNT ON;

    SELECT 
		MenuItems.MenuID
	    ,MenuItems.MenuName
	    ,MenuItems.MenuURL
	    ,MenuItems.ModuleID
	    ,MenuItems.MenuParent
		,KeyModifier.MenuShortcutKeyModifier
		,MenuItems.MenuShortcutKey
	FROM 
		cmsMenuItem MenuItems
		INNER JOIN cmsUserRolePermissions UserRolePermissions ON MenuItems.MenuID = UserRolePermissions.MenuID
		INNER JOIN cmsUserRole UserRoles ON UserRolePermissions.RoleID = UserRoles.RoleID
		INNER JOIN cmsIndicationMenuShortcutKeyModifier KeyModifier ON MenuItems.MenuShortcutKeyModifierID = KeyModifier.MenuShortcutKeyModifierID
	WHERE 
		UserRoles.RoleID = @RoleID
		AND MenuItems.ModuleID IN (@ModuleID, 0)
		AND UserRoles.IsDeleted = 0
		AND MenuItems.IsDeleted = 0
	ORDER BY 
		MenuItems.MenuDisplayOrder
END
GO
/****** Object:  StoredProcedure [dbo].[cmsInsertEventLog]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Noble
-- Create date: 14.06.2015
-- Description:	To insert event log details
-- =============================================
CREATE PROCEDURE [dbo].[cmsInsertEventLog]
(
	@EventID			INT				-- Event identification
	,@EventDescription	VARCHAR(500)	-- EventDescription 
	,@EventTypeID		INT				-- Event type indication
	,@EventMode			TINYINT			-- Event mode
	,@UserID			INT				-- User identification
	,@CounterID			INT				-- Counter identification
	,@Extra1			INT
 )
AS
BEGIN

	SET NOCOUNT ON;

    INSERT INTO cmsEventLog
	   (
		 EventDate
		,EventDescription
		,EventTypeID
		,EventMode
		,UserID
		,CounterID
		,Extra1
	   )
	VALUES
	  (
		GETDATE()
		 ,@EventDescription	
		 ,@EventTypeID	
		 ,@EventMode		
		 ,@UserID
		 ,@CounterID
		 ,@Extra1	
	  )
END
GO
/****** Object:  StoredProcedure [dbo].[cmsInsertUpdateCustomer]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Noble
-- Create date: 25/11/2017
-- Description:	To insert/update customer 
-- =============================================
CREATE PROCEDURE [dbo].[cmsInsertUpdateCustomer]
(
	@CustomerID			INT			OUT
	,@CustomerName		VARCHAR(50)
    ,@VehicleNo			VARCHAR(15)
    ,@Address1			VARCHAR(50)
    ,@Address2			VARCHAR(50)
    ,@Phone				VARCHAR(12)
    ,@Mobile			VARCHAR(10)
	,@IsInsertUpdateDelete	TINYINT
)
AS
BEGIN

	SET NOCOUNT ON;
	
	IF(@IsInsertUpdateDelete = 0)
	BEGIN
		INSERT INTO [dbo].[cmsCustomer]
			   ([CustomerName]
			   ,[VehicleNo]
			   ,[Address1]
			   ,[Address2]
			   ,[Phone]
			   ,[Mobile])
		 VALUES
			   (@CustomerName
			   ,@VehicleNo
			   ,@Address1
			   ,@Address2
			   ,@Phone
			   ,@Mobile)

		SET @CustomerID = SCOPE_IDENTITY()
	END
	ELSE
	BEGIN
		UPDATE [dbo].[cmsCustomer]
		SET
			[CustomerName] = @CustomerName
			,[VehicleNo] = @VehicleNo
			,[Address1] = @Address1
			,[Address2] = @Address2
			,[Phone] = @Phone
			,[Mobile] = @Mobile
	END
END
GO
/****** Object:  StoredProcedure [dbo].[cmsUpdateProductModelRate]    Script Date: 12/12/2017 2:14:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Noble
-- Create date: 02.12.2017
-- Description:	To update product model rate
-- =============================================
CREATE PROCEDURE [dbo].[cmsUpdateProductModelRate]
(
	@ModelID	INT
	, @Rate		MONEY
)
AS
BEGIN

	SET NOCOUNT ON;

    UPDATE
		cmsProductModel
	SET
		Rate = @Rate
	WHERE
		ModelID = @ModelID
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'To check have value either in customer name or in vehicle number' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'cmsCustomer', @level2type=N'CONSTRAINT',@level2name=N'CK_cmsCustomer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 : Default; 1 : Insert; 2 : Update; 3 : Delete; 4: Error' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'cmsEventLog', @level2type=N'COLUMN',@level2name=N'EventMode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quantity will be entered in the unit of feet.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'cmsSalesVoucher', @level2type=N'COLUMN',@level2name=N'Quantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 - End User; 1 - End User Admin; 2 - Technovilla Admin' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'cmsUserRole', @level2type=N'COLUMN',@level2name=N'RoleType'
GO
USE [master]
GO
ALTER DATABASE [Crystal] SET  READ_WRITE 
GO
