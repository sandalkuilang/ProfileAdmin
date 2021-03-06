USE [master]
GO
/****** Object:  Database [WebTemplate]    Script Date: 09/06/2016 22.36.40 ******/
CREATE DATABASE [WebTemplate]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MVCTemplate', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\MVCTemplate.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MVCTemplate_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\MVCTemplate_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [WebTemplate] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WebTemplate].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WebTemplate] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WebTemplate] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WebTemplate] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WebTemplate] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WebTemplate] SET ARITHABORT OFF 
GO
ALTER DATABASE [WebTemplate] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WebTemplate] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WebTemplate] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WebTemplate] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WebTemplate] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WebTemplate] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WebTemplate] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WebTemplate] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WebTemplate] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WebTemplate] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WebTemplate] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WebTemplate] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WebTemplate] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WebTemplate] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WebTemplate] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WebTemplate] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WebTemplate] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WebTemplate] SET RECOVERY FULL 
GO
ALTER DATABASE [WebTemplate] SET  MULTI_USER 
GO
ALTER DATABASE [WebTemplate] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WebTemplate] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WebTemplate] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WebTemplate] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [WebTemplate] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'WebTemplate', N'ON'
GO
USE [WebTemplate]
GO
/****** Object:  UserDefinedFunction [dbo].[convert_date_to_normal]    Script Date: 09/06/2016 22.36.40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[convert_date_to_normal] (@julian int)  
RETURNS [datetime] AS  
BEGIN
 
DECLARE @Gregorian datetime

	set @Gregorian = NULL

	IF @julian >0 
	BEGIN
		DECLARE @year int, @day int, @base datetime
		SET @year = (@julian/1000 - 100) 
		SET @day = (@julian % 1000) 
		SET @base = '12-31-1999'
		set @Gregorian= DATEADD(dy, @day, DATEADD(yyyy, @year, @base))
	END

	RETURN @Gregorian

END


GO
/****** Object:  UserDefinedFunction [dbo].[FUNCT_AR]    Script Date: 09/06/2016 22.36.40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		AZSG
-- Create date: 23-09-2015
-- Description:	Function for query report AR Overrun 
-- Example for calling this function:
-- select * from dbo.[FUNCT_AR]('2015','7','','','','','','','','','PO')
-- 22/10/2015 (HPFR) replace SUM(C.OVERUNDERACTUAL) OverUnder into SUM(C.OVERUNDERPOTENTIAL) OverUnder
-- =============================================
CREATE FUNCTION [dbo].[FUNCT_AR] (
	@Year INT
	,@Month INT
	,@CompanyCode VARCHAR(15)
	,@OPG VARCHAR(10)
	,@Division VARCHAR(10)
	,@subDivision VARCHAR(10)
	,@Department VARCHAR(10)
	,@cc VARCHAR(10)
	,@wipa VARCHAR(10)
	,@pm VARCHAR(10)
	,@type VARCHAR(2)
	)
RETURNS @data TABLE (
	Company [varchar](100)
	,GOIARId [varchar](20)
	,GOIAR [varchar](20)
	,GOIARDesc [varchar](200)
	,YEAR [varchar](4)
	,MONTH [varchar](2)
	,PMBADGE [varchar](100)
	,PM [varchar](1000)
	,Budget FLOAT
	,CummExpend FLOAT
	,EAC FLOAT
	,OverUnder FLOAT
	,CloseOut FLOAT
	,Balance FLOAT
	,Pct FLOAT
	,VOWD FLOAT
	)
AS
BEGIN
	DECLARE @Company [varchar] (100)
		,@GOIARId [varchar] (20)
		,@GOIAR [varchar] (20)
		,@GOIARDesc [varchar] (200)
		,@YEAR1 [varchar] (4)
		,@MONTH1 [varchar] (2)
		,@PMBADGE [varchar] (100)
		,@PM1 [varchar] (100)
		,@Budget FLOAT
		,@CummExpend FLOAT
		,@EAC FLOAT
		,@OverUnder FLOAT
		,@CloseOut FLOAT
		,@Balance FLOAT
		,@Pct FLOAT
		,@VOWD FLOAT
		,@PMGab VARCHAR(1000)
		,@PMBADGEGab VARCHAR(200)
		,@PMGabLen INT

	DECLARE data_cursor CURSOR
	FOR
	SELECT *
	FROM (
		SELECT A1.*
			,SUM(C.BUDGET) Budget
			,SUM(C.CUMMULATIVEEXPENDITURE) CummExpend
			,SUM(C.EAC) EAC
			,CASE 
				WHEN MAX(c.CUMMULATIVEEXPENDITURE) > MAX(c.VOWD)
					THEN 
						SUM(c.CUMMULATIVEEXPENDITURE) - SUM(c.BUDGET) 
				ELSE
					CASE WHEN SUM(c.BUDGET) = 0
						THEN 0
						ELSE SUM(c.VOWD) - SUM(c.BUDGET)	
					END 
			END OverUnder 
			,SUM(C.CLOSEOUT) CloseOut
			,SUM(C.BALANCE) Balance
			,SUM(C.EXPENDED) Pct
			,SUM(C.VoWD) VOWD
		FROM (
			SELECT DISTINCT Y.COMPANYNAME Company
				,A.AR_ID GOIARId
				,B.AR_Number GOIAR
				,B.AR_DESCRIPTION GOIARDesc
				,A.YEARV
				,A.MONTHV
			FROM [MARS].[dbo].[AR_EXCEPTIONREPORT] A
			INNER JOIN AR_AFE_MASTER B ON A.AR_ID = B.AR_ID
			INNER JOIN AFE_AR_LOCAL_MAP D ON D.AR_ID = A.AR_ID
			INNER JOIN LOCAL_AFE_ORG Y ON Y.LOCAL_AFE_ID = D.Local_AFE_ID
			INNER JOIN V_MAP_ORG Z ON Z.LOCAL_AFE_ID = D.Local_AFE_ID
				AND A.EXCEPTIONREPORTTYPE = CASE 
					WHEN @type = 'PO'
						THEN '10'
					ELSE '12'
					END
			WHERE A.YEARV = @Year
				AND A.MONTHV = @Month
				--and Y.COMPANYCODE =@CompanyCode 
				AND (
					ISNULL(@CompanyCode, '') = ''
					OR (
						ISNULL(@CompanyCode, '') <> ''
						AND Y.companycode = @CompanyCode
						)
					)
				--AND Y.OPG=@OPG 
				AND (
					ISNULL(@OPG, '') = ''
					OR (
						ISNULL(@OPG, '') <> ''
						AND Y.OPG = @OPG
						)
					)
				--AND Y.DIVISION=@Division
				AND (
					ISNULL(@Division, '') = ''
					OR (
						ISNULL(@Division, '') <> ''
						AND Y.DIVISION = @Division
						)
					)
				--AND Y.SUBDIVISION=@subDivision 
				AND (
					ISNULL(@subDivision, '') = ''
					OR (
						ISNULL(@subDivision, '') <> ''
						AND Y.SUBDIVISION = @subDivision
						)
					)
				--AND Y.DEPARTMENT=@Department  
				AND (
					ISNULL(@Department, '') = ''
					OR (
						ISNULL(@Department, '') <> ''
						AND Y.DEPARTMENT = @Department
						)
					)
				--AND Z.CCBADGE=ISNULL(@cc,Z.CCBADGE) -- cc
				AND (
					ISNULL(@cc, '') = ''
					OR (
						ISNULL(@cc, '') <> ''
						AND Z.CCBADGE = @cc
						)
					)
				--AND Z.WIPABADGE=ISNULL(@wipa,Z.WIPABADGE) -- wipa
				AND (
					ISNULL(@wipa, '') = ''
					OR (
						ISNULL(@wipa, '') <> ''
						AND Z.WIPABADGE = @wipa
						)
					)
				--AND Z.PMBADGE=ISNULL(@pm,Z.PMBADGE) -- PM
				AND (
					ISNULL(@pm, '') = ''
					OR (
						ISNULL(@pm, '') <> ''
						AND Z.PMBADGE = @pm
						)
					)
				--GROUP BY Y.COMPANYNAME ,A.AR_ID , B.AR_Number ,B.AR_DESCRIPTION 
			) A1
		INNER JOIN AR_MONTHLYSTATUS C ON A1.GOIARId = C.AR_ID
			AND A1.YEARV = C.YEAR
			AND A1.MONTHV = C.MONTH
		GROUP BY A1.Company
			,A1.GOIARId
			,A1.GOIAR
			,A1.GOIARDesc
			,A1.YEARV
			,A1.MONTHV
		) AA
	ORDER BY AA.Pct DESC

	OPEN data_cursor

	FETCH NEXT
	FROM data_cursor
	INTO @Company
		,@GOIARId
		,@GOIAR
		,@GOIARDesc
		,@YEAR1
		,@MONTH1
		,@Budget
		,@CummExpend
		,@EAC
		,@OverUnder
		,@CloseOut
		,@Balance
		,@Pct
		,@VOWD

	SET @PMBADGEGab = ''
	SET @PMGab = ''

	WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE pm_cursor CURSOR
		FOR
		SELECT DISTINCT PMBADGE
			,(
				SELECT TOP 1 NAME
				FROM USER_PROFILE
				WHERE BADGE = B.PMBADGE
				) PM
		FROM AFE_AR_LOCAL_MAP A
		INNER JOIN V_MAP_ORG B ON A.LOCAL_AFE_ID = B.Local_AFE_ID
		WHERE A.AR_ID = @GOIARId

		SET @PMBADGEGab = ''
		SET @PMGab = ''

		OPEN pm_cursor

		FETCH NEXT
		FROM pm_cursor
		INTO @PMBADGE
			,@PM1

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @PMBADGEGab = @PMBADGEGab + ', ' + @PMBADGE
			SET @PMGab = @PMGab + ', ' + @PM1

			FETCH NEXT
			FROM pm_cursor
			INTO @PMBADGE
				,@PM1
		END

		CLOSE pm_cursor

		DEALLOCATE pm_cursor

		SET @PMGabLen = LEN(@PMGab)
		SET @PMGab = SUBSTRING(@PMGab, 3, @PMGabLen - 2)

		INSERT INTO @data
		VALUES (
			@Company
			,@GOIARId
			,@GOIAR
			,@GOIARDesc
			,@YEAR1
			,@MONTH1
			,SUBSTRING(@PMBADGEGab, 3, 100)
			,@PMGab
			,@Budget
			,@CummExpend
			,@EAC
			,@OverUnder
			,@CloseOut
			,@Balance
			,@Pct
			,@VOWD
			)

		FETCH NEXT
		FROM data_cursor
		INTO @Company
			,@GOIARId
			,@GOIAR
			,@GOIARDesc
			,@YEAR1
			,@MONTH1
			,@Budget
			,@CummExpend
			,@EAC
			,@OverUnder
			,@CloseOut
			,@Balance
			,@Pct
			,@VOWD
	END

	CLOSE data_cursor

	DEALLOCATE data_cursor

	RETURN
END


GO
/****** Object:  UserDefinedFunction [dbo].[FUNCT_GOI]    Script Date: 09/06/2016 22.36.40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		AZSG
-- Create date: 23-09-2015
-- Description:	Function for query report GOI Overrun (Potential/ Actual)
-- Example for calling this function:
-- select * from dbo.[FUNCT_GOI]('2015','7','','','','','','','','','AO')
-- 22/10/2015 (HPFR) add SELECT DISTINCT(Y.COMPANYNAME) Company
-- =============================================
CREATE FUNCTION [dbo].[FUNCT_GOI] (
	@Year INT
	,@Month INT
	,@CompanyCode VARCHAR(15)
	,@OPG VARCHAR(10)
	,@Division VARCHAR(10)
	,@subDivision VARCHAR(10)
	,@Department VARCHAR(10)
	,@cc VARCHAR(10)
	,@wipa VARCHAR(10)
	,@pm VARCHAR(10)
	,@type VARCHAR(2)
	)
RETURNS @data TABLE (
	Company [varchar](100)
	,GOIARId [varchar](20)
	,GOIAR [varchar](20)
	,GOIARDesc [varchar](200)
	,YEAR [varchar](4)
	,MONTH [varchar](2)
	,PMBADGE [varchar](100)
	,PM [varchar](1000)
	,Budget FLOAT
	,CummExpend FLOAT
	,EAC FLOAT
	,OverUnder FLOAT
	,CloseOut FLOAT
	,Balance FLOAT
	,Pct FLOAT
	,VOWD FLOAT
	)
AS
BEGIN
	DECLARE @Company [varchar] (100)
		,@GOIARId [varchar] (20)
		,@GOIAR [varchar] (20)
		,@GOIARDesc [varchar] (200)
		,@YEAR1 [varchar] (4)
		,@MONTH1 [varchar] (2)
		,@PMBADGE [varchar] (100)
		,@PM1 [varchar] (100)
		,@Budget FLOAT
		,@CummExpend FLOAT
		,@EAC FLOAT
		,@OverUnder FLOAT
		,@CloseOut FLOAT
		,@Balance FLOAT
		,@Pct FLOAT
		,@VOWD FLOAT
		,@PMGab VARCHAR(1000)
		,@PMBADGEGab VARCHAR(200)
		,@PMGabLen INT

	DECLARE data_cursor CURSOR
	FOR
	SELECT *
	FROM (
		SELECT A1.*
			,SUM(C.BUDGET) Budget
			,SUM(C.CUMMULATIVEEXPENDITURE) CummExpend
			,SUM(C.EAC) EAC
			,CASE 
				WHEN MAX(c.CUMMULATIVEEXPENDITURE) > MAX(c.VOWD)
					THEN 
						SUM(c.CUMMULATIVEEXPENDITURE) - SUM(c.BUDGET) 
				ELSE
					CASE WHEN SUM(c.BUDGET) = 0
						THEN 0
						ELSE SUM(c.VOWD) - SUM(c.BUDGET)	
					END 
			END OverUnder 
			,SUM(C.CLOSEOUT) CloseOut
			,SUM(C.BALANCE) Balance
			,SUM(C.EXPENDED) Pct
			,SUM(C.VoWD) VOWD
		FROM (
			SELECT DISTINCT(Y.COMPANYNAME) Company
				,A.GOI_ID GOIARId
				,D.GOI_NUMBER GOIAR
				,D.GOI_DESCRIPTION GOIARDesc
				,A.YEAR
				,A.MONTH
			FROM [MARS].[dbo].[GOI_EXCEPTIONREPORT] A
			INNER JOIN AFE_GOI_LOCAL_MAP B ON A.GOI_ID = B.GOI_ID
			INNER JOIN GOI_AFE_MASTER D ON D.GOI_ID = A.GOI_ID
			INNER JOIN LOCAL_AFE_ORG Y ON Y.LOCAL_AFE_ID = B.LOCAL_AFE_ID
			INNER JOIN V_MAP_ORG Z ON Z.LOCAL_AFE_ID = B.LOCAL_AFE_ID
				AND A.EXCEPTIONREPORTTYPE = CASE 
					WHEN @type = 'PO'
						THEN '6'
					ELSE '8'
					END
			WHERE A.YEAR = @Year
				AND A.MONTH = @Month
				--and Y.COMPANYCODE =@CompanyCode 
				AND (
					ISNULL(@CompanyCode, '') = ''
					OR (
						ISNULL(@CompanyCode, '') <> ''
						AND Y.companycode = @CompanyCode
						)
					)
				--AND Y.OPG=@OPG 
				AND (
					ISNULL(@OPG, '') = ''
					OR (
						ISNULL(@OPG, '') <> ''
						AND Y.OPG = @OPG
						)
					)
				--AND Y.DIVISION=@Division
				AND (
					ISNULL(@Division, '') = ''
					OR (
						ISNULL(@Division, '') <> ''
						AND Y.DIVISION = @Division
						)
					)
				--AND Y.SUBDIVISION=@subDivision 
				AND (
					ISNULL(@subDivision, '') = ''
					OR (
						ISNULL(@subDivision, '') <> ''
						AND Y.SUBDIVISION = @subDivision
						)
					)
				--AND Y.DEPARTMENT=@Department  
				AND (
					ISNULL(@Department, '') = ''
					OR (
						ISNULL(@Department, '') <> ''
						AND Y.DEPARTMENT = @Department
						)
					)
				--AND Z.CCBADGE=ISNULL(@cc,Z.CCBADGE) -- cc
				AND (
					ISNULL(@cc, '') = ''
					OR (
						ISNULL(@cc, '') <> ''
						AND Z.CCBADGE = @cc
						)
					)
				--AND Z.WIPABADGE=ISNULL(@wipa,Z.WIPABADGE) -- wipa
				AND (
					ISNULL(@wipa, '') = ''
					OR (
						ISNULL(@wipa, '') <> ''
						AND Z.WIPABADGE = @wipa
						)
					)
				--AND Z.PMBADGE=ISNULL(@pm,Z.PMBADGE) -- PM
				AND (
					ISNULL(@pm, '') = ''
					OR (
						ISNULL(@pm, '') <> ''
						AND Z.PMBADGE = @pm
						)
					) 
			) A1
		INNER JOIN GOI_MONTHLYSTATUS C ON A1.GOIARId = C.GOI_ID
			AND A1.YEAR = C.YEAR
			AND A1.MONTH = C.MONTH
		GROUP BY A1.Company
			,A1.GOIARId
			,A1.GOIAR
			,A1.GOIARDesc
			,A1.YEAR
			,A1.MONTH
		) AA
	ORDER BY AA.Pct DESC

	OPEN data_cursor

	FETCH NEXT
	FROM data_cursor
	INTO @Company
		,@GOIARId
		,@GOIAR
		,@GOIARDesc
		,@YEAR1
		,@MONTH1
		,@Budget
		,@CummExpend
		,@EAC
		,@OverUnder
		,@CloseOut
		,@Balance
		,@Pct
		,@VOWD

	SET @PMBADGEGab = ''
	SET @PMGab = ''

	WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE pm_cursor CURSOR
		FOR
		SELECT DISTINCT PMBADGE
			,(
				SELECT TOP 1 NAME
				FROM USER_PROFILE
				WHERE BADGE = B.PMBADGE
				) PM
		FROM AFE_GOI_LOCAL_MAP A
		INNER JOIN V_MAP_ORG B ON A.LOCAL_AFE_ID = B.Local_AFE_ID
		WHERE A.GOI_ID = @GOIARId

		SET @PMBADGEGab = ''
		SET @PMGab = ''

		OPEN pm_cursor

		FETCH NEXT
		FROM pm_cursor
		INTO @PMBADGE
			,@PM1

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @PMBADGEGab = @PMBADGEGab + ', ' + @PMBADGE
			SET @PMGab = @PMGab + ', ' + @PM1

			FETCH NEXT
			FROM pm_cursor
			INTO @PMBADGE
				,@PM1
		END

		CLOSE pm_cursor

		DEALLOCATE pm_cursor

		SET @PMGabLen = LEN(@PMGab)
		SET @PMGab = SUBSTRING(@PMGab, 3, @PMGabLen - 2)

		INSERT INTO @data
		VALUES (
			@Company
			,@GOIARId
			,@GOIAR
			,@GOIARDesc
			,@YEAR1
			,@MONTH1
			,SUBSTRING(@PMBADGEGab, 3, 100)
			,@PMGab
			,@Budget
			,@CummExpend
			,@EAC
			,@OverUnder
			,@CloseOut
			,@Balance
			,@Pct
			,@VOWD
			)

		FETCH NEXT
		FROM data_cursor
		INTO @Company
			,@GOIARId
			,@GOIAR
			,@GOIARDesc
			,@YEAR1
			,@MONTH1
			,@Budget
			,@CummExpend
			,@EAC
			,@OverUnder
			,@CloseOut
			,@Balance
			,@Pct
			,@VOWD
	END

	CLOSE data_cursor

	DEALLOCATE data_cursor

	RETURN
END


GO
/****** Object:  UserDefinedFunction [dbo].[SplitString]    Script Date: 09/06/2016 22.36.40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		HPFR
-- Create date: 2015-07-29
-- Description:	Split a string by delimeter char
-- =============================================
CREATE FUNCTION [dbo].[SplitString]
(    
      @Input NVARCHAR(MAX),
      @Character CHAR(1)
)
RETURNS @Output TABLE (
      Item NVARCHAR(1000)
)
AS
BEGIN
      DECLARE @StartIndex INT, @EndIndex INT
 
      SET @StartIndex = 1
      IF SUBSTRING(@Input, LEN(@Input) - 1, LEN(@Input)) <> @Character
      BEGIN
            SET @Input = @Input + @Character
      END
 
      WHILE CHARINDEX(@Character, @Input) > 0
      BEGIN
            SET @EndIndex = CHARINDEX(@Character, @Input)
           
            INSERT INTO @Output(Item)
            SELECT SUBSTRING(@Input, @StartIndex, @EndIndex - 1)
           
            SET @Input = SUBSTRING(@Input, @EndIndex + 1, LEN(@Input))
      END
 
      RETURN
END


GO
/****** Object:  Table [dbo].[APPLICATION]    Script Date: 09/06/2016 22.36.40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[APPLICATION](
	[ID] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](3000) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CONFIG_TABLE]    Script Date: 09/06/2016 22.36.40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CONFIG_TABLE](
	[CONFIGID] [int] NOT NULL,
	[PARAMETERNAME] [varchar](100) NULL,
	[TYPEV] [varchar](100) NULL,
	[VALUE] [varchar](2000) NULL,
	[ADDITIONAL_VALUE] [varchar](max) NULL,
 CONSTRAINT [PK__CONFIG_T__C1DFC8E41A14E395] PRIMARY KEY CLUSTERED 
(
	[CONFIGID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CONTENT]    Script Date: 09/06/2016 22.36.40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CONTENT](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ContentSection] [char](10) NULL,
	[ContentTitle] [varchar](200) NULL,
	[ContentText] [varchar](max) NULL,
	[CreateBy] [varchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[ModifyBy] [varchar](50) NULL,
	[ModifyDate] [datetime] NULL,
 CONSTRAINT [PK_CONTENT] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FEATURE]    Script Date: 09/06/2016 22.36.40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FEATURE](
	[ID] [int] NOT NULL,
	[KEY] [varchar](100) NOT NULL,
	[QUALIFIER] [varchar](100) NOT NULL,
 CONSTRAINT [PK_FEATURE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MENU]    Script Date: 09/06/2016 22.36.40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MENU](
	[ID] [int] NOT NULL,
	[NAME] [varchar](50) NULL,
	[DESCRIPTION] [nvarchar](500) NULL,
	[APPLICATION] [int] NOT NULL,
	[REMARK] [nvarchar](50) NULL,
	[PARENT_ID] [int] NOT NULL,
	[URL] [nvarchar](100) NULL,
	[LASTUPDATE] [datetime] NULL,
	[UPDATEBY] [varchar](50) NULL,
 CONSTRAINT [PK_MENU] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[APPLICATION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ROLE]    Script Date: 09/06/2016 22.36.40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ROLE](
	[ID] [int] NOT NULL,
	[APPLICATION] [int] NOT NULL,
	[NAME] [varchar](50) NOT NULL,
	[DESCRIPTION] [varchar](100) NULL,
 CONSTRAINT [PK_ROLE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[APPLICATION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ROLE_FUNCTION]    Script Date: 09/06/2016 22.36.40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ROLE_FUNCTION](
	[ROLE_ID] [int] NOT NULL,
	[FUNCTION_ID] [int] NOT NULL,
	[FEATURE_ID] [int] NOT NULL,
	[APPLICATION] [int] NOT NULL,
	[DISPLAY] [int] NOT NULL,
	[CREATED_BY] [varchar](15) NOT NULL,
	[CREATED_DATE] [datetime] NOT NULL,
	[MODIFIED_BY] [varchar](15) NULL,
	[MODIFIED_DATE] [datetime] NULL,
 CONSTRAINT [PK_ROLE_FUNCTION] PRIMARY KEY CLUSTERED 
(
	[ROLE_ID] ASC,
	[FUNCTION_ID] ASC,
	[FEATURE_ID] ASC,
	[APPLICATION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ROLE_MENU]    Script Date: 09/06/2016 22.36.40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ROLE_MENU](
	[ROLE_ID] [int] NOT NULL,
	[MENU_ID] [int] NOT NULL,
	[APPLICATION] [int] NOT NULL,
	[MODIFIED_BY] [varchar](15) NOT NULL,
	[MODIFIED_DATE] [datetime] NOT NULL,
 CONSTRAINT [pk_ROLE_MENU] PRIMARY KEY CLUSTERED 
(
	[ROLE_ID] ASC,
	[MENU_ID] ASC,
	[APPLICATION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[USER_BACKUP]    Script Date: 09/06/2016 22.36.40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[USER_BACKUP](
	[BACKUP_ID] [int] NULL,
	[NETWORKID] [varchar](30) NOT NULL,
	[BACKUP_NETWORKID] [varchar](30) NOT NULL,
	[ISACTIVE] [int] NULL,
	[MODIFIEDDATE] [date] NULL,
	[MODIFIEDBY] [varchar](30) NULL,
 CONSTRAINT [PK_USER_BACKUP] PRIMARY KEY CLUSTERED 
(
	[NETWORKID] ASC,
	[BACKUP_NETWORKID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[USER_PROFILE]    Script Date: 09/06/2016 22.36.40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[USER_PROFILE](
	[NETWORK_ID] [varchar](30) NOT NULL,
	[APPLICATION] [int] NOT NULL,
	[BADGE] [varchar](15) NOT NULL,
	[DIRECT_REPORT] [varchar](15) NULL,
	[CAI_ID] [varchar](10) NOT NULL,
	[NAME] [varchar](300) NOT NULL,
	[EMAIL] [varchar](300) NOT NULL,
	[STATUS] [int] NULL,
	[ISBACKUP] [int] NOT NULL,
	[COMPANY] [int] NULL,
	[OPG] [varchar](40) NULL,
	[DIVISION] [varchar](300) NULL,
	[SUBDIVISION] [varchar](300) NULL,
	[DEPARTMENT] [varchar](300) NULL,
	[SUBDEPARTMENT] [varchar](300) NULL,
	[ISACTIVE] [int] NOT NULL,
	[MODIFIEDDATE] [date] NOT NULL,
	[MODIFIEDBY] [varchar](100) NOT NULL,
 CONSTRAINT [PK_USER_PROFILE] PRIMARY KEY CLUSTERED 
(
	[NETWORK_ID] ASC,
	[APPLICATION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[USER_ROLE]    Script Date: 09/06/2016 22.36.40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[USER_ROLE](
	[NETWORK_ID] [varchar](30) NOT NULL,
	[APPLICATION] [int] NOT NULL,
	[ROLE_ID] [int] NOT NULL,
	[MODIFIED_BY] [varchar](30) NOT NULL,
	[MODIFIED_DATE] [datetime] NOT NULL,
 CONSTRAINT [PK_USER_ROLE_1] PRIMARY KEY CLUSTERED 
(
	[NETWORK_ID] ASC,
	[APPLICATION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
USE [master]
GO
ALTER DATABASE [WebTemplate] SET  READ_WRITE 
GO
