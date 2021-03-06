USE [AchieveDB]
GO
/****** Object:  UserDefinedFunction [dbo].[func_SplitStrToTable]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[func_SplitStrToTable]
(
	@str VARCHAR(8000)
)
RETURNS @tableName TABLE
        (str2table VARCHAR(100))
AS
	--该函数用于把一个用逗号分隔的多个数据字符串变成一个表的一列，例如字符串'1,2,3,4,5' 将转换成一个表
BEGIN
	SET @str = @str + ','
	DECLARE @insertStr VARCHAR(100) --截取后的第一个字符串
	DECLARE @newstr VARCHAR(8000) --截取第一个字符串后剩余的字符串
	
	SET @insertStr = LEFT(@str, CHARINDEX(',', @str) -1)
	
	SET @newstr = STUFF(@str, 1, CHARINDEX(',', @str), '')
	
	INSERT @tableName
	VALUES
	(
		@insertStr
	)
	
	WHILE (LEN(@newstr) > 0)
	BEGIN
	    SET @insertStr = LEFT(@newstr, CHARINDEX(',', @newstr) -1)
	    
	    INSERT @tableName
	    VALUES
	    (
	    	@insertStr
	    )
	    
	    SET @newstr = STUFF(@newstr, 1, CHARINDEX(',', @newstr), '')
	END
	
	RETURN
END

GO
/****** Object:  Table [dbo].[Article]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Article](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](200) NULL,
	[Content] [varchar](8000) NULL,
	[FilePath] [nvarchar](200) NULL,
 CONSTRAINT [PK_Info] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_Test]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Test](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreateTime] [datetime] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateBy] [nvarchar](50) NULL,
	[FName] [nvarchar](50) NULL,
	[FSex] [nvarchar](50) NULL,
	[FAge] [int] NULL,
 CONSTRAINT [PK_tb_Test] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Test1]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Test1](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreateTime] [datetime] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tb_Test1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbButton]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbButton](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Code] [varchar](50) NULL,
	[Icon] [varchar](50) NULL,
	[Sort] [int] NULL,
	[Description] [varchar](100) NULL,
	[CreateTime] [datetime] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbButton] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbDataType]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbDataType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DataType] [nvarchar](50) NOT NULL,
	[DataTypeName] [nvarchar](50) NOT NULL,
	[Sort] [int] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateBy] [nvarchar](50) NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbDataType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbDepartment]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbDepartment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [varchar](50) NULL,
	[ParentId] [int] NULL,
	[Sort] [int] NULL,
	[CreateTime] [datetime] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbDepartment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbFields]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbFields](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TabId] [int] NOT NULL,
	[FieldName] [nvarchar](50) NULL,
	[FieldViewName] [nvarchar](50) NOT NULL,
	[FieldDataTypeId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsSearch] [bit] NULL,
	[Sort] [int] NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateBy] [nvarchar](50) NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbFields] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbHtmlType]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbHtmlType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[HtmlTypeName] [nvarchar](50) NOT NULL,
	[Sort] [int] NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateBy] [nvarchar](50) NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbHtmlType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbIcons]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbIcons](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IconName] [nvarchar](100) NOT NULL,
	[IconCssInfo] [nvarchar](2000) NOT NULL,
	[CreateTime] [datetime] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbIcons] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbMenu]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbMenu](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[ParentId] [int] NULL,
	[Code] [varchar](50) NULL,
	[LinkAddress] [varchar](100) NULL,
	[Icon] [varchar](50) NULL,
	[Sort] [int] NULL,
	[CreateTime] [datetime] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbMenu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbMenuButton]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbMenuButton](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MenuId] [int] NULL,
	[ButtonId] [int] NULL,
 CONSTRAINT [PK_tbMenuButton] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbNews]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbNews](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ftypeid] [int] NULL,
	[ftitle] [nvarchar](50) NULL,
	[fcontent] [text] NULL,
	[CreateTime] [datetime] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbNews] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbNewsType]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbNewsType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ftypename] [nvarchar](50) NULL,
	[fsort] [int] NULL,
	[CreateTime] [datetime] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbNewsType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbRequestion]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbRequestion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ftypeid] [int] NULL,
	[ftitle] [nvarchar](50) NULL,
	[fcontent] [text] NULL,
	[CreateTime] [datetime] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbRequestion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbRequestionType]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbRequestionType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ftypename] [nvarchar](50) NULL,
	[fsort] [int] NULL,
	[CreateTime] [datetime] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbRequestionType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbRole]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbRole](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NULL,
	[Description] [varchar](100) NULL,
	[CreateBy] [nvarchar](50) NULL,
	[CreateTime] [datetime] NULL,
	[UpdateBy] [nvarchar](50) NULL,
	[UpdateTime] [datetime] NULL,
 CONSTRAINT [PK_tbRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbRoleMenu]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbRoleMenu](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NULL,
	[MenuId] [int] NULL,
 CONSTRAINT [PK_tbRoleMenu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbRoleMenuButton]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbRoleMenuButton](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NULL,
	[MenuId] [int] NULL,
	[ButtonId] [int] NULL,
 CONSTRAINT [PK_tbRoleMenuButton] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbTable]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TabName] [nvarchar](50) NOT NULL,
	[TabViewName] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateBy] [nvarchar](50) NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbTable] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbUser]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbUser](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AccountName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[RealName] [nvarchar](50) NOT NULL,
	[MobilePhone] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[IsAble] [bit] NULL,
	[IfChangePwd] [bit] NULL,
	[Description] [nvarchar](max) NULL,
	[CreateBy] [nvarchar](50) NULL,
	[CreateTime] [datetime] NULL,
	[UpdateBy] [nvarchar](50) NULL,
	[UpdateTime] [datetime] NULL,
 CONSTRAINT [PK_tbUser] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

CREATE TABLE [dbo].[tbLoginIpLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IpAddress] [nvarchar](50) NULL,
	[CreateTime] [datetime] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbLoginIpLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[tbUserDepartment]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbUserDepartment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[DepartmentId] [int] NULL,
 CONSTRAINT [PK_tbUserDepartment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbUserRole]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbUserRole](
	[UserId] [int] NULL,
	[RoleId] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[test]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[test](
	[id] [int] NULL,
	[text] [nvarchar](200) NULL,
	[name] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[vw_Fields]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[vw_Fields]
AS
SELECT tf.Id,tf.TabId,tf.FieldName,tf.FieldViewName,tf.FieldDataTypeId,tf.IsSearch,tf.IsActive,tf.Sort,
	tf.CreateTime,tf.CreateBy,tf.UpdateTime,tf.UpdateBy,td.DataType,td.DataTypeName,tt.TabName,tt.TabViewName
FROM tbFields tf
INNER JOIN tbDataType td ON td.Id=tf.FieldDataTypeId
INNER JOIN tbTable AS tt ON tt.Id=tf.TabId





GO
/****** Object:  View [dbo].[vw_News]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_News]
AS
SELECT   tr.id, tr.ftypeid, tr.ftitle, tr.fcontent,  tr.CreateTime,tr.CreateBy,tr.UpdateTime,tr.UpdateBy, trt.ftypename, 
                trt.fsort
FROM      dbo.tbNews AS tr INNER JOIN
                dbo.tbNewsType AS trt ON trt.id = tr.ftypeid





GO
/****** Object:  View [dbo].[vw_requestion]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_requestion]
AS
SELECT   tr.id, tr.ftypeid, tr.ftitle, tr.fcontent, tr.CreateTime,tr.CreateBy,tr.UpdateTime,tr.UpdateBy, trt.ftypename, 
                trt.fsort
FROM      dbo.tbRequestion AS tr INNER JOIN
                dbo.tbRequestionType AS trt ON trt.id = tr.ftypeid




GO
SET IDENTITY_INSERT [dbo].[Article] ON 

GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (1, N'标题1', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (2, N'标题2', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (3, N'标题3', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (4, N'标题4', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (5, N'标题5', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (6, N'标题6', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (7, N'标题7', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (8, N'标题8', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (9, N'标题9', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (10, N'标题10', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (11, N'标题11', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (12, N'标题12', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (13, N'标题13', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (14, N'标题14', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (15, N'标题15', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (16, N'标题16', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (17, N'标题17', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (18, N'标题18', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (19, N'标题19', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (20, N'标题20', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (21, N'标题21', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (22, N'标题22', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (23, N'标题23', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (24, N'标题24', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (25, N'标题25', N'内容1', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (26, N'测试体贴26', N'内容26', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (27, N'测试体贴27', N'内容27', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (28, N'测试体贴28', N'内容28', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (29, N'测试体贴29', N'内容29', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (30, N'测试体贴30', N'内容30', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (31, N'测试体贴31', N'内容31', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (32, N'测试体贴32', N'内容32', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (33, N'测试体贴33', N'内容33', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (34, N'测试体贴34', N'内容34', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (35, N'测试体贴35', N'内容35', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (36, N'测试体贴36', N'内容36', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (37, N'测试体贴37', N'内容37', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (38, N'测试体贴38', N'内容38', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (39, N'测试体贴39', N'内容39', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (40, N'测试体贴40', N'内容40', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (41, N'测试体贴41', N'内容41', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (42, N'测试体贴42', N'内容42', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (43, N'测试体贴43', N'内容43', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (44, N'测试体贴44', N'内容44', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (45, N'测试体贴45', N'内容45', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (46, N'测试体贴46', N'内容46', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (47, N'测试体贴47', N'内容47', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (48, N'测试体贴48', N'内容48', NULL)
GO
INSERT [dbo].[Article] ([ID], [Title], [Content], [FilePath]) VALUES (49, N'测试体贴49', N'内容49', NULL)
GO
SET IDENTITY_INSERT [dbo].[Article] OFF
GO
SET IDENTITY_INSERT [dbo].[tb_Test] ON 

GO
INSERT [dbo].[tb_Test] ([Id], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy], [FName], [FSex], [FAge]) VALUES (1, CAST(N'2016-06-22 00:00:00.000' AS DateTime), N'admin', CAST(N'2016-06-22 00:00:00.000' AS DateTime), N'admin', N'测试', N'男', 18)
GO
SET IDENTITY_INSERT [dbo].[tb_Test] OFF
GO
SET IDENTITY_INSERT [dbo].[tbButton] ON 

GO
INSERT [dbo].[tbButton] ([Id], [Name], [Code], [Icon], [Sort], [Description], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1, N'查询', N'search', N'icon-eye', 1, NULL, CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-28 15:35:21.637' AS DateTime), N'admin')
GO
INSERT [dbo].[tbButton] ([Id], [Name], [Code], [Icon], [Sort], [Description], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (3, N'添加', N'add', N'icon-add', 3, NULL, CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin')
GO
INSERT [dbo].[tbButton] ([Id], [Name], [Code], [Icon], [Sort], [Description], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (4, N'修改', N'edit', N'icon-edit', 4, NULL, CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin')
GO
INSERT [dbo].[tbButton] ([Id], [Name], [Code], [Icon], [Sort], [Description], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (5, N'删除', N'delete', N'icon-delete', 5, NULL, CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin')
GO
INSERT [dbo].[tbButton] ([Id], [Name], [Code], [Icon], [Sort], [Description], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (6, N'导出', N'export', N'icon-page_excel', 6, NULL, CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin')
GO
INSERT [dbo].[tbButton] ([Id], [Name], [Code], [Icon], [Sort], [Description], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (7, N'部门设置', N'setuserdept', N'icon-group', 8, NULL, CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin')
GO
INSERT [dbo].[tbButton] ([Id], [Name], [Code], [Icon], [Sort], [Description], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (8, N'角色设置', N'setuserrole', N'icon-user_key', 7, NULL, CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin')
GO
INSERT [dbo].[tbButton] ([Id], [Name], [Code], [Icon], [Sort], [Description], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (9, N'角色授权', N'roleauthorize', N'icon-key', 9, NULL, CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin')
GO
INSERT [dbo].[tbButton] ([Id], [Name], [Code], [Icon], [Sort], [Description], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (10, N'分配按钮', N'setmenubutton', N'icon-link', 10, NULL, CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin')
GO
INSERT [dbo].[tbButton] ([Id], [Name], [Code], [Icon], [Sort], [Description], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (11, N'全部展开', N'expandall', N'icon-expand', 11, NULL, CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin')
GO
INSERT [dbo].[tbButton] ([Id], [Name], [Code], [Icon], [Sort], [Description], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (12, N'全部隐藏', N'collapseall', N'icon-collapse', 12, NULL, CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin')
GO
INSERT [dbo].[tbButton] ([Id], [Name], [Code], [Icon], [Sort], [Description], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (13, N'导入', N'import', N'icon-import', 6, NULL, CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin')
GO
INSERT [dbo].[tbButton] ([Id], [Name], [Code], [Icon], [Sort], [Description], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (16, N'表数据查询', N'seltabdata', N'icon-search', 13, NULL, CAST(N'2016-06-22 15:58:08.893' AS DateTime), N'admin', CAST(N'2016-06-22 15:59:37.950' AS DateTime), N'admin')
GO
SET IDENTITY_INSERT [dbo].[tbButton] OFF
GO
SET IDENTITY_INSERT [dbo].[tbDataType] ON 

GO
INSERT [dbo].[tbDataType] ([Id], [DataType], [DataTypeName], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1, N'int', N'整数', 1, CAST(N'2016-06-20 16:10:16.000' AS DateTime), N'admin', CAST(N'2016-06-20 16:12:38.033' AS DateTime), N'admin')
GO
INSERT [dbo].[tbDataType] ([Id], [DataType], [DataTypeName], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (2, N'nvarchar(50)', N'文本(50)', 2, CAST(N'2016-06-20 16:12:59.000' AS DateTime), N'admin', CAST(N'2016-06-20 16:13:20.537' AS DateTime), N'admin')
GO
INSERT [dbo].[tbDataType] ([Id], [DataType], [DataTypeName], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (3, N'decimal(18, 2)', N'金额(2位小数)', 3, CAST(N'2016-06-20 16:23:52.000' AS DateTime), N'admin', CAST(N'2016-06-20 16:24:18.320' AS DateTime), N'admin')
GO
INSERT [dbo].[tbDataType] ([Id], [DataType], [DataTypeName], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (4, N'float', N'浮点', 4, CAST(N'2016-06-22 14:43:53.407' AS DateTime), N'admin', CAST(N'2016-06-22 14:43:53.407' AS DateTime), N'admin')
GO
SET IDENTITY_INSERT [dbo].[tbDataType] OFF
GO
SET IDENTITY_INSERT [dbo].[tbDepartment] ON 

GO
INSERT [dbo].[tbDepartment] ([Id], [DepartmentName], [ParentId], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1, N'人事行政部', 0, 3, CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin', CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin')
GO
INSERT [dbo].[tbDepartment] ([Id], [DepartmentName], [ParentId], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (2, N'研发部', 0, 1, CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin', CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin')
GO
INSERT [dbo].[tbDepartment] ([Id], [DepartmentName], [ParentId], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (4, N'人事部', 1, 1, CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin', CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin')
GO
INSERT [dbo].[tbDepartment] ([Id], [DepartmentName], [ParentId], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (5, N'行政部', 1, 2, CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin', CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin')
GO
INSERT [dbo].[tbDepartment] ([Id], [DepartmentName], [ParentId], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (7, N'C#组', 2, 2, CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin', CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin')
GO
INSERT [dbo].[tbDepartment] ([Id], [DepartmentName], [ParentId], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (8, N'Java组', 2, 1, CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin', CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin')
GO
INSERT [dbo].[tbDepartment] ([Id], [DepartmentName], [ParentId], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (10, N'.Net组', 2, 4, CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin', CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin')
GO
INSERT [dbo].[tbDepartment] ([Id], [DepartmentName], [ParentId], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (41, N'销售部', 0, 4, CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin', CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin')
GO
INSERT [dbo].[tbDepartment] ([Id], [DepartmentName], [ParentId], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (43, N'销售1组', 41, 1, CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin', CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin')
GO
INSERT [dbo].[tbDepartment] ([Id], [DepartmentName], [ParentId], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (46, N'PHP组', 2, 3, CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin', CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin')
GO
INSERT [dbo].[tbDepartment] ([Id], [DepartmentName], [ParentId], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (47, N'销售2组', 41, 2, CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin', CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin')
GO
INSERT [dbo].[tbDepartment] ([Id], [DepartmentName], [ParentId], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (51, N'系统管理员', 0, 1, CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin', CAST(N'2016-06-20 12:00:12.673' AS DateTime), N'admin')
GO
SET IDENTITY_INSERT [dbo].[tbDepartment] OFF
GO
SET IDENTITY_INSERT [dbo].[tbFields] ON 

GO
INSERT [dbo].[tbFields] ([Id], [TabId], [FieldName], [FieldViewName], [FieldDataTypeId], [IsActive], [IsSearch], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (4, 7, N'FName', N'姓名', 2, 1, 1, 1, CAST(N'2016-06-21 17:56:40.000' AS DateTime), N'admin', CAST(N'2016-06-22 17:51:42.733' AS DateTime), N'admin')
GO
INSERT [dbo].[tbFields] ([Id], [TabId], [FieldName], [FieldViewName], [FieldDataTypeId], [IsActive], [IsSearch], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (5, 7, N'FSex', N'性别', 2, 1, 0, 2, CAST(N'2016-06-22 10:40:00.000' AS DateTime), N'admin', CAST(N'2016-06-22 15:39:12.790' AS DateTime), N'admin')
GO
INSERT [dbo].[tbFields] ([Id], [TabId], [FieldName], [FieldViewName], [FieldDataTypeId], [IsActive], [IsSearch], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (6, 7, N'FAge', N'年龄', 1, 1, 0, 3, CAST(N'2016-06-22 14:41:06.477' AS DateTime), N'admin', CAST(N'2016-06-22 14:41:06.477' AS DateTime), N'admin')
GO
SET IDENTITY_INSERT [dbo].[tbFields] OFF
GO
SET IDENTITY_INSERT [dbo].[tbHtmlType] ON 

GO
INSERT [dbo].[tbHtmlType] ([Id], [HtmlTypeName], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1, N'文本', 1, CAST(N'2016-06-20 16:22:49.000' AS DateTime), N'admin', CAST(N'2016-06-22 11:37:36.620' AS DateTime), N'admin')
GO
INSERT [dbo].[tbHtmlType] ([Id], [HtmlTypeName], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (2, N'单选', 2, CAST(N'2016-06-20 16:23:00.000' AS DateTime), N'admin', CAST(N'2016-06-22 11:38:50.213' AS DateTime), N'admin')
GO
INSERT [dbo].[tbHtmlType] ([Id], [HtmlTypeName], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (3, N'复选', 3, CAST(N'2016-06-20 16:23:08.000' AS DateTime), N'admin', CAST(N'2016-06-22 11:38:55.290' AS DateTime), N'admin')
GO
INSERT [dbo].[tbHtmlType] ([Id], [HtmlTypeName], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (4, N'下拉', 4, CAST(N'2016-06-20 16:23:17.000' AS DateTime), N'admin', CAST(N'2016-06-22 11:38:45.467' AS DateTime), N'admin')
GO
SET IDENTITY_INSERT [dbo].[tbHtmlType] OFF
GO
SET IDENTITY_INSERT [dbo].[tbIcons] ON 

GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1514, N'cog', N'icon-cog', CAST(N'2016-06-28 11:26:21.000' AS DateTime), N'admin', CAST(N'2016-06-28 11:57:42.753' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1515, N'world', N'icon-world', CAST(N'2016-06-28 11:26:39.000' AS DateTime), N'admin', CAST(N'2016-06-28 11:57:35.973' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1516, N'table', N'icon-table', CAST(N'2016-06-28 11:26:58.000' AS DateTime), N'admin', CAST(N'2016-06-28 11:57:30.213' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1517, N'tree', N'icon-tree', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1518, N'user_b', N'icon-user_b', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1519, N'group_key', N'icon-group_key', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1520, N'bug', N'icon-bug', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1521, N'bug_magnify', N'icon-bug_magnify', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1522, N'layers', N'icon-layers', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1523, N'group', N'icon-group', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1524, N'newspaper_link', N'icon-newspaper_link', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1525, N'newspaper', N'icon-newspaper', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1526, N'html', N'icon-html', CAST(N'2016-06-20 15:48:28.667' AS DateTime), N'admin', CAST(N'2016-06-21 17:38:47.780' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1527, N'database', N'icon-database', CAST(N'2016-06-20 15:49:11.890' AS DateTime), N'admin', CAST(N'2016-06-21 17:38:40.590' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1528, N'database_table', N'icon-database_table', CAST(N'2016-06-20 17:29:34.420' AS DateTime), N'admin', CAST(N'2016-06-20 17:29:41.677' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1529, N'style_edit', N'icon-style_edit', CAST(N'2016-06-21 16:53:12.610' AS DateTime), N'admin', CAST(N'2016-06-21 16:53:12.610' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1530, N'application_view_icons', N'icon-application_view_icons', CAST(N'2016-06-28 09:34:35.930' AS DateTime), N'admin', CAST(N'2016-06-28 09:34:35.930' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1531, N'eye', N'icon-eye', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1532, N'add', N'icon-add', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1533, N'edit', N'icon-edit', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1534, N'delete', N'icon-delete', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1535, N'page_excel', N'icon-page_excel', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1536, N'group', N'icon-group', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1537, N'user_key', N'icon-user_key', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1538, N'key', N'icon-key', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1539, N'link', N'icon-link', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1540, N'expand', N'icon-expand', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1541, N'collapse', N'icon-collapse', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1542, N'import', N'icon-import', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin', CAST(N'2016-06-20 14:04:54.837' AS DateTime), N'admin')
GO
INSERT [dbo].[tbIcons] ([Id], [IconName], [IconCssInfo], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1543, N'search', N'icon-search', CAST(N'2016-06-22 15:58:08.893' AS DateTime), N'admin', CAST(N'2016-06-22 15:59:37.950' AS DateTime), N'admin')
GO
SET IDENTITY_INSERT [dbo].[tbIcons] OFF
GO
SET IDENTITY_INSERT [dbo].[tbMenu] ON 

GO
INSERT [dbo].[tbMenu] ([Id], [Name], [ParentId], [Code], [LinkAddress], [Icon], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1, N'系统设置', 0, NULL, NULL, N'icon-cog', 1, CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin')
GO
INSERT [dbo].[tbMenu] ([Id], [Name], [ParentId], [Code], [LinkAddress], [Icon], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (3, N'菜单管理', 1, N'menu', N'/Menu/Index', N'icon-tree', 1, CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin')
GO
INSERT [dbo].[tbMenu] ([Id], [Name], [ParentId], [Code], [LinkAddress], [Icon], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (4, N'用户管理', 1, N'user', N'/User/Index', N'icon-user_b', 2, CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin')
GO
INSERT [dbo].[tbMenu] ([Id], [Name], [ParentId], [Code], [LinkAddress], [Icon], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (6, N'角色管理', 1, N'role', N'/Role/Index', N'icon-group_key', 3, CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin')
GO
INSERT [dbo].[tbMenu] ([Id], [Name], [ParentId], [Code], [LinkAddress], [Icon], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (14, N'网站管理', 0, NULL, NULL, N'icon-world', 2, CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin')
GO
INSERT [dbo].[tbMenu] ([Id], [Name], [ParentId], [Code], [LinkAddress], [Icon], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (17, N'问题分类管理', 14, N'RequestionType', N'/RequestionType/Index', N'icon-bug', 3, CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin')
GO
INSERT [dbo].[tbMenu] ([Id], [Name], [ParentId], [Code], [LinkAddress], [Icon], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (19, N'问题管理', 14, N'Requestion', N'/Requestion/Index', N'icon-bug_magnify', 4, CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin')
GO
INSERT [dbo].[tbMenu] ([Id], [Name], [ParentId], [Code], [LinkAddress], [Icon], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1023, N'按钮管理', 1, N'button', N'/Button/Index', N'icon-layers', 6, CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin', CAST(N'2016-06-28 15:39:48.437' AS DateTime), N'admin')
GO
INSERT [dbo].[tbMenu] ([Id], [Name], [ParentId], [Code], [LinkAddress], [Icon], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1024, N'部门管理', 1, N'department', N'/Department/Index', N'icon-group', 4, CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin')
GO
INSERT [dbo].[tbMenu] ([Id], [Name], [ParentId], [Code], [LinkAddress], [Icon], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1025, N'公告分类管理', 14, N'NewsType', N'/NewsType/Index', N'icon-newspaper_link', 1, CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin')
GO
INSERT [dbo].[tbMenu] ([Id], [Name], [ParentId], [Code], [LinkAddress], [Icon], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1026, N'公告管理', 14, N'News', N'/News/Index', N'icon-newspaper', 2, CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin', CAST(N'2016-06-20 10:48:44.757' AS DateTime), N'admin')
GO
INSERT [dbo].[tbMenu] ([Id], [Name], [ParentId], [Code], [LinkAddress], [Icon], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1028, N'控件类型管理', 1030, N'HtmlType', N'/HtmlType/Index', N'icon-html', 1, CAST(N'2016-06-20 15:48:28.667' AS DateTime), N'admin', CAST(N'2016-06-21 17:38:47.780' AS DateTime), N'admin')
GO
INSERT [dbo].[tbMenu] ([Id], [Name], [ParentId], [Code], [LinkAddress], [Icon], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1029, N'数据类型管理', 1030, N'DataType', N'/DataType/Index', N'icon-database', 2, CAST(N'2016-06-20 15:49:11.890' AS DateTime), N'admin', CAST(N'2016-06-21 17:38:40.590' AS DateTime), N'admin')
GO
INSERT [dbo].[tbMenu] ([Id], [Name], [ParentId], [Code], [LinkAddress], [Icon], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1030, N'自定义表', 0, NULL, NULL, N'icon-table', 3, CAST(N'2016-06-20 16:28:14.343' AS DateTime), N'admin', CAST(N'2016-06-28 11:54:01.157' AS DateTime), N'admin')
GO
INSERT [dbo].[tbMenu] ([Id], [Name], [ParentId], [Code], [LinkAddress], [Icon], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1031, N'数据表管理', 1030, N'Table', N'/Table/Index', N'icon-database_table', 3, CAST(N'2016-06-20 17:29:34.420' AS DateTime), N'admin', CAST(N'2016-06-20 17:29:41.677' AS DateTime), N'admin')
GO
INSERT [dbo].[tbMenu] ([Id], [Name], [ParentId], [Code], [LinkAddress], [Icon], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1032, N'字段管理', 1030, N'Fields', N'/Fields/Index', N'icon-style_edit', 4, CAST(N'2016-06-21 16:53:12.610' AS DateTime), N'admin', CAST(N'2016-06-21 16:53:12.610' AS DateTime), N'admin')
GO
INSERT [dbo].[tbMenu] ([Id], [Name], [ParentId], [Code], [LinkAddress], [Icon], [Sort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1038, N'图标管理', 1, N'Icons', N'/Icons/Index', N'icon-application_view_icons', 5, CAST(N'2016-06-28 09:34:35.930' AS DateTime), N'admin', CAST(N'2016-06-28 15:39:53.427' AS DateTime), N'admin')
GO
SET IDENTITY_INSERT [dbo].[tbMenu] OFF
GO
SET IDENTITY_INSERT [dbo].[tbMenuButton] ON 

GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (49, 4, 1)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (50, 4, 3)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (51, 4, 4)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (52, 4, 5)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (53, 4, 8)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (54, 4, 7)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (55, 6, 1)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (56, 6, 3)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (57, 6, 4)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (58, 6, 5)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (59, 6, 9)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (60, 1024, 1)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (61, 1024, 3)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (62, 1024, 4)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (63, 1024, 5)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (64, 1023, 1)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (65, 1023, 3)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (66, 1023, 4)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (67, 1023, 5)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (68, 17, 1)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (69, 17, 3)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (70, 17, 4)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (71, 17, 5)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (72, 19, 1)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (73, 19, 3)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (74, 19, 4)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (75, 19, 5)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (76, 1025, 1)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (77, 1025, 3)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (78, 1025, 4)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (79, 1025, 5)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (80, 1026, 1)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (81, 1026, 3)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (82, 1026, 4)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (83, 1026, 5)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (84, 3, 1)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (85, 3, 3)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (86, 3, 4)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (87, 3, 5)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (88, 3, 10)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (89, 1029, 1)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (90, 1029, 3)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (91, 1029, 4)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (92, 1029, 5)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (93, 1028, 1)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (94, 1028, 3)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (95, 1028, 4)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (96, 1028, 5)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (101, 1032, 1)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (102, 1032, 3)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (103, 1032, 4)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (104, 1032, 5)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (105, 1031, 1)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (106, 1031, 3)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (107, 1031, 4)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (108, 1031, 5)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (109, 1031, 16)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (110, 1036, 1)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (111, 1037, 1)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (112, 1038, 1)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (113, 1038, 3)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (114, 1038, 4)
GO
INSERT [dbo].[tbMenuButton] ([Id], [MenuId], [ButtonId]) VALUES (115, 1038, 5)
GO
SET IDENTITY_INSERT [dbo].[tbMenuButton] OFF
GO
SET IDENTITY_INSERT [dbo].[tbNews] ON 

GO
INSERT [dbo].[tbNews] ([id], [ftypeid], [ftitle], [fcontent], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1, 1, N'公告测试', N'<p>
	<strong>公告测试</strong>
</p>
<p>
	<img src="/attached/image/20160617/20160617145951_0943.jpg" width="500" height="41" alt="" />
</p>
<p>
	公告测试
</p>', CAST(N'2016-06-20 14:55:38.563' AS DateTime), N'admin', CAST(N'2016-06-20 14:55:38.563' AS DateTime), N'admin')
GO
SET IDENTITY_INSERT [dbo].[tbNews] OFF
GO
SET IDENTITY_INSERT [dbo].[tbNewsType] ON 

GO
INSERT [dbo].[tbNewsType] ([id], [ftypename], [fsort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1, N'公司公告', 1, CAST(N'2016-06-20 14:55:44.710' AS DateTime), N'admin', CAST(N'2016-06-20 14:55:44.710' AS DateTime), N'admin')
GO
INSERT [dbo].[tbNewsType] ([id], [ftypename], [fsort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (2, N'IT公告', 1, CAST(N'2016-06-20 14:55:44.710' AS DateTime), N'admin', CAST(N'2016-06-20 14:55:44.710' AS DateTime), N'admin')
GO
INSERT [dbo].[tbNewsType] ([id], [ftypename], [fsort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (3, N'行政公告', 1, CAST(N'2016-06-20 14:55:44.710' AS DateTime), N'admin', CAST(N'2016-06-20 14:55:44.710' AS DateTime), N'admin')
GO
SET IDENTITY_INSERT [dbo].[tbNewsType] OFF
GO
SET IDENTITY_INSERT [dbo].[tbRequestion] ON 

GO
INSERT [dbo].[tbRequestion] ([id], [ftypeid], [ftitle], [fcontent], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1014, 7, N'测试', N'<p>
	心灵鸡汤
</p>
<p>
	心灵鸡汤
</p>
<p>
	心灵鸡汤
</p>', CAST(N'2016-06-20 14:55:49.310' AS DateTime), N'admin', CAST(N'2016-06-20 14:55:49.310' AS DateTime), N'admin')
GO
INSERT [dbo].[tbRequestion] ([id], [ftypeid], [ftitle], [fcontent], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (1015, 7, N'测试2', N'<p>
	<strong>测试2</strong>
</p>
<p>
	<em><u>测试2</u></em><em><u></u></em>
</p>', CAST(N'2016-06-20 14:55:49.310' AS DateTime), N'admin', CAST(N'2016-06-20 14:55:49.310' AS DateTime), N'admin')
GO
SET IDENTITY_INSERT [dbo].[tbRequestion] OFF
GO
SET IDENTITY_INSERT [dbo].[tbRequestionType] ON 

GO
INSERT [dbo].[tbRequestionType] ([id], [ftypename], [fsort], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (7, N'测试', 5, CAST(N'2016-06-20 14:55:53.707' AS DateTime), N'admin', CAST(N'2016-06-20 14:55:53.707' AS DateTime), N'admin')
GO
SET IDENTITY_INSERT [dbo].[tbRequestionType] OFF
GO
SET IDENTITY_INSERT [dbo].[tbRole] ON 

GO
INSERT [dbo].[tbRole] ([Id], [RoleName], [Description], [CreateBy], [CreateTime], [UpdateBy], [UpdateTime]) VALUES (1, N'超级管理员', N'拥有所有增删改查权限', N'admin', CAST(N'2016-06-20 11:14:30.420' AS DateTime), N'admin', CAST(N'2016-06-20 11:14:30.420' AS DateTime))
GO
INSERT [dbo].[tbRole] ([Id], [RoleName], [Description], [CreateBy], [CreateTime], [UpdateBy], [UpdateTime]) VALUES (53, N'普通用户', NULL, N'admin', CAST(N'2016-06-20 11:14:30.420' AS DateTime), N'admin', CAST(N'2016-06-20 11:14:30.420' AS DateTime))
GO
INSERT [dbo].[tbRole] ([Id], [RoleName], [Description], [CreateBy], [CreateTime], [UpdateBy], [UpdateTime]) VALUES (54, N'技术人员', NULL, N'admin', CAST(N'2016-06-20 11:14:30.420' AS DateTime), N'admin', CAST(N'2016-06-20 11:14:30.420' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tbRole] OFF
GO
SET IDENTITY_INSERT [dbo].[tbRoleMenu] ON 

GO
INSERT [dbo].[tbRoleMenu] ([Id], [RoleId], [MenuId]) VALUES (75, 52, 14)
GO
INSERT [dbo].[tbRoleMenu] ([Id], [RoleId], [MenuId]) VALUES (1407, 54, 1)
GO
INSERT [dbo].[tbRoleMenu] ([Id], [RoleId], [MenuId]) VALUES (1408, 54, 3)
GO
INSERT [dbo].[tbRoleMenu] ([Id], [RoleId], [MenuId]) VALUES (1409, 54, 4)
GO
INSERT [dbo].[tbRoleMenu] ([Id], [RoleId], [MenuId]) VALUES (1410, 54, 6)
GO
INSERT [dbo].[tbRoleMenu] ([Id], [RoleId], [MenuId]) VALUES (1411, 54, 1024)
GO
INSERT [dbo].[tbRoleMenu] ([Id], [RoleId], [MenuId]) VALUES (1412, 54, 1023)
GO
INSERT [dbo].[tbRoleMenu] ([Id], [RoleId], [MenuId]) VALUES (1413, 54, 14)
GO
INSERT [dbo].[tbRoleMenu] ([Id], [RoleId], [MenuId]) VALUES (1414, 54, 17)
GO
INSERT [dbo].[tbRoleMenu] ([Id], [RoleId], [MenuId]) VALUES (1415, 54, 19)
GO
INSERT [dbo].[tbRoleMenu] ([Id], [RoleId], [MenuId]) VALUES (1424, 1, 1)
GO
INSERT [dbo].[tbRoleMenu] ([Id], [RoleId], [MenuId]) VALUES (1425, 1, 3)
GO
INSERT [dbo].[tbRoleMenu] ([Id], [RoleId], [MenuId]) VALUES (1426, 1, 4)
GO
INSERT [dbo].[tbRoleMenu] ([Id], [RoleId], [MenuId]) VALUES (1427, 1, 6)
GO
INSERT [dbo].[tbRoleMenu] ([Id], [RoleId], [MenuId]) VALUES (1428, 1, 1024)
GO
INSERT [dbo].[tbRoleMenu] ([Id], [RoleId], [MenuId]) VALUES (1429, 1, 1023)
GO
INSERT [dbo].[tbRoleMenu] ([Id], [RoleId], [MenuId]) VALUES (1430, 1, 14)
GO
INSERT [dbo].[tbRoleMenu] ([Id], [RoleId], [MenuId]) VALUES (1431, 1, 17)
GO
INSERT [dbo].[tbRoleMenu] ([Id], [RoleId], [MenuId]) VALUES (1432, 1, 19)
GO
SET IDENTITY_INSERT [dbo].[tbRoleMenu] OFF
GO
SET IDENTITY_INSERT [dbo].[tbRoleMenuButton] ON 

GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (127, 54, 3, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (128, 54, 3, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (129, 54, 17, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (130, 54, 1, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (131, 54, 6, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (132, 54, 3, 10)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (133, 54, 1023, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (134, 54, 1023, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (135, 54, 6, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (136, 54, 4, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (137, 54, 19, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (138, 54, 4, 8)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (139, 54, 17, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (140, 54, 19, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (141, 54, 6, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (142, 54, 1023, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (143, 54, 14, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (144, 54, 6, 9)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (145, 54, 19, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (146, 54, 4, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (147, 54, 1024, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (148, 54, 1024, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (149, 54, 6, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (150, 54, 17, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (151, 54, 4, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (152, 54, 1024, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (153, 54, 1024, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (154, 54, 3, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (155, 54, 1023, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (156, 54, 3, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (157, 54, 19, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (158, 54, 4, 7)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (159, 54, 17, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (160, 54, 4, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (295, 54, 1030, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (296, 54, 1031, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (297, 54, 1028, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (298, 54, 1031, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (299, 54, 1028, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (300, 54, 1028, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (301, 54, 1031, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (302, 54, 1029, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (303, 54, 1031, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (304, 54, 1028, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (305, 54, 1029, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (306, 54, 1032, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (307, 54, 1032, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (308, 54, 1032, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (309, 54, 1029, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (310, 54, 1031, 16)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (311, 54, 1029, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (312, 54, 1032, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (645, 53, 1028, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (646, 53, 1029, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (647, 53, 1029, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (648, 53, 1031, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (649, 53, 1031, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (650, 53, 1029, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (651, 53, 1031, 16)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (652, 53, 1031, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (653, 53, 1032, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (654, 53, 1032, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (655, 53, 1028, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (656, 53, 1032, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (657, 53, 1032, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (658, 53, 1031, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (659, 53, 1030, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (660, 53, 1028, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (661, 53, 1028, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (662, 53, 1029, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (663, 53, 1028, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (664, 53, 1032, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (665, 53, 1029, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (666, 53, 1031, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (667, 1, 4, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (668, 1, 14, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (669, 1, 3, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (670, 1, 1031, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (671, 1, 1038, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (672, 1, 6, 9)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (673, 1, 1032, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (674, 1, 1029, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (675, 1, 19, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (676, 1, 1032, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (677, 1, 1038, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (678, 1, 1023, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (679, 1, 17, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (680, 1, 1026, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (681, 1, 1026, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (682, 1, 6, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (683, 1, 6, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (684, 1, 17, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (685, 1, 1024, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (686, 1, 1030, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (687, 1, 1029, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (688, 1, 1024, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (689, 1, 1024, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (690, 1, 1029, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (691, 1, 4, 8)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (692, 1, 17, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (693, 1, 1038, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (694, 1, 1023, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (695, 1, 19, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (696, 1, 4, 7)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (697, 1, 4, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (698, 1, 19, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (699, 1, 1038, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (700, 1, 1, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (701, 1, 1026, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (702, 1, 4, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (703, 1, 1024, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (704, 1, 6, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (705, 1, 3, 10)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (706, 1, 3, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (707, 1, 1032, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (708, 1, 1023, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (709, 1, 1031, 16)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (710, 1, 4, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (711, 1, 1026, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (712, 1, 1028, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (713, 1, 1031, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (714, 1, 1023, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (715, 1, 1025, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (716, 1, 1025, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (717, 1, 1028, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (718, 1, 1024, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (719, 1, 19, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (720, 1, 1031, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (721, 1, 1028, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (722, 1, 6, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (723, 1, 1029, 5)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (724, 1, 1026, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (725, 1, 19, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (726, 1, 17, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (727, 1, 1032, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (728, 1, 3, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (729, 1, 1028, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (730, 1, 3, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (731, 1, 1031, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (732, 1, 4, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (733, 1, 1032, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (734, 1, 1025, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (735, 1, 1028, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (736, 1, 1025, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (737, 1, 1025, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (738, 1, 6, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (739, 1, 17, 4)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (740, 1, 1029, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (741, 1, 1031, 0)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (742, 1, 1038, 3)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (743, 1, 1023, 1)
GO
INSERT [dbo].[tbRoleMenuButton] ([Id], [RoleId], [MenuId], [ButtonId]) VALUES (744, 1, 3, 5)
GO
SET IDENTITY_INSERT [dbo].[tbRoleMenuButton] OFF
GO
SET IDENTITY_INSERT [dbo].[tbTable] ON 

GO
INSERT [dbo].[tbTable] ([Id], [TabName], [TabViewName], [IsActive], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (7, N'Test', N'测试', 1, CAST(N'2016-06-21 14:11:01.000' AS DateTime), N'admin', CAST(N'2016-06-21 14:21:25.750' AS DateTime), N'admin')
GO
INSERT [dbo].[tbTable] ([Id], [TabName], [TabViewName], [IsActive], [CreateTime], [CreateBy], [UpdateTime], [UpdateBy]) VALUES (14, N'Test1', N'测试1', 1, CAST(N'2016-06-21 18:09:06.917' AS DateTime), N'admin', CAST(N'2016-06-21 18:09:06.917' AS DateTime), N'admin')
GO
SET IDENTITY_INSERT [dbo].[tbTable] OFF
GO
SET IDENTITY_INSERT [dbo].[tbUser] ON 

GO
INSERT [dbo].[tbUser] ([ID], [AccountName], [Password], [RealName], [MobilePhone], [Email], [IsAble], [IfChangePwd], [Description], [CreateBy], [CreateTime], [UpdateBy], [UpdateTime]) VALUES (1, N'admin', N'21232F297A57A5A743894A0E4A801F', N'超级管理员', NULL, NULL, 1, 1, N'超级管理员', N'admin', CAST(N'2016-06-20 10:59:41.480' AS DateTime), N'admin', CAST(N'2016-06-20 10:59:41.480' AS DateTime))
GO
INSERT [dbo].[tbUser] ([ID], [AccountName], [Password], [RealName], [MobilePhone], [Email], [IsAble], [IfChangePwd], [Description], [CreateBy], [CreateTime], [UpdateBy], [UpdateTime]) VALUES (2, N'test001', N'E10ADC3949BA59ABBE56E057F20F88', N'测试', N'13588888888', N'test@qq.com', 1, 1, N'测试', N'admin', CAST(N'2016-06-20 10:59:41.480' AS DateTime), N'admin', CAST(N'2016-06-20 10:59:41.480' AS DateTime))
GO
INSERT [dbo].[tbUser] ([ID], [AccountName], [Password], [RealName], [MobilePhone], [Email], [IsAble], [IfChangePwd], [Description], [CreateBy], [CreateTime], [UpdateBy], [UpdateTime]) VALUES (3, N'lf123456', N'E10ADC3949BA59ABBE56E057F20F88', N'技术测试', NULL, NULL, 1, 1, NULL, N'admin', CAST(N'2016-06-20 10:59:41.480' AS DateTime), N'admin', CAST(N'2016-06-20 10:59:41.480' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tbUser] OFF
GO
SET IDENTITY_INSERT [dbo].[tbUserDepartment] ON 

GO
INSERT [dbo].[tbUserDepartment] ([Id], [UserId], [DepartmentId]) VALUES (3, 78, 43)
GO
INSERT [dbo].[tbUserDepartment] ([Id], [UserId], [DepartmentId]) VALUES (4, 77, 43)
GO
INSERT [dbo].[tbUserDepartment] ([Id], [UserId], [DepartmentId]) VALUES (10, 3, 51)
GO
INSERT [dbo].[tbUserDepartment] ([Id], [UserId], [DepartmentId]) VALUES (11, 1, 51)
GO
INSERT [dbo].[tbUserDepartment] ([Id], [UserId], [DepartmentId]) VALUES (12, 2, 43)
GO
SET IDENTITY_INSERT [dbo].[tbUserDepartment] OFF
GO
INSERT [dbo].[tbUserRole] ([UserId], [RoleId]) VALUES (1, 1)
GO
INSERT [dbo].[tbUserRole] ([UserId], [RoleId]) VALUES (3, 54)
GO
INSERT [dbo].[tbUserRole] ([UserId], [RoleId]) VALUES (2, 53)
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1, N'.pic {background-image: url("CSS Satyr.png"); display: block;}', N'.pic ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (2, N'.pic_892 {background-position: -785px -321px; width: 32px; height: 32px; }', N'.pic_892 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (3, N'.pic_900 {background-position: -739px -324px; width: 32px; height: 32px; }', N'.pic_900 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (4, N'.pic_703 {background-position: -298px -324px; width: 32px; height: 32px; }', N'.pic_703 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (5, N'.pic_1179 {background-position: -439px -320px; width: 32px; height: 32px; }', N'.pic_1179 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (6, N'.pic_1031 {background-position: -487px -322px; width: 32px; height: 32px; }', N'.pic_1031 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (7, N'.pic_1444 {background-position: -614px -322px; width: 32px; height: 32px; }', N'.pic_1444 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (8, N'.pic_1458 {background-position: -688px -323px; width: 32px; height: 32px; }', N'.pic_1458 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (9, N'.pic_1433 {background-position: -542px -322px; width: 32px; height: 32px; }', N'.pic_1433 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (10, N'.pic_1502 {background-position: -392px -322px; width: 32px; height: 32px; }', N'.pic_1502 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (11, N'.pic_1427 {background-position: -357px -323px; width: 32px; height: 32px; }', N'.pic_1427 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (12, N'.pic_1 {background-position: -0px -0px; width: 16px; height: 16px; }', N'.pic_1 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (13, N'.pic_2 {background-position: -16px -0px; width: 16px; height: 16px; }', N'.pic_2 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (14, N'.pic_3 {background-position: -32px -0px; width: 16px; height: 16px; }', N'.pic_3 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (15, N'.pic_4 {background-position: -48px -0px; width: 16px; height: 16px; }', N'.pic_4 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (16, N'.pic_5 {background-position: -64px -0px; width: 16px; height: 16px; }', N'.pic_5 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (17, N'.pic_6 {background-position: -80px -0px; width: 16px; height: 16px; }', N'.pic_6 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (18, N'.pic_7 {background-position: -96px -0px; width: 16px; height: 16px; }', N'.pic_7 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (19, N'.pic_8 {background-position: -112px -0px; width: 16px; height: 16px; }', N'.pic_8 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (20, N'.pic_9 {background-position: -128px -0px; width: 16px; height: 16px; }', N'.pic_9 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (21, N'.pic_10 {background-position: -144px -0px; width: 16px; height: 16px; }', N'.pic_10 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (22, N'.pic_11 {background-position: -160px -0px; width: 16px; height: 16px; }', N'.pic_11 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (23, N'.pic_12 {background-position: -176px -0px; width: 16px; height: 16px; }', N'.pic_12 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (24, N'.pic_13 {background-position: -192px -0px; width: 16px; height: 16px; }', N'.pic_13 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (25, N'.pic_14 {background-position: -208px -0px; width: 16px; height: 16px; }', N'.pic_14 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (26, N'.pic_15 {background-position: -224px -0px; width: 16px; height: 16px; }', N'.pic_15 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (27, N'.pic_16 {background-position: -240px -0px; width: 16px; height: 16px; }', N'.pic_16 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (28, N'.pic_17 {background-position: -256px -0px; width: 16px; height: 16px; }', N'.pic_17 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (29, N'.pic_18 {background-position: -272px -0px; width: 16px; height: 16px; }', N'.pic_18 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (30, N'.pic_19 {background-position: -288px -0px; width: 16px; height: 16px; }', N'.pic_19 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (31, N'.pic_20 {background-position: -304px -0px; width: 16px; height: 16px; }', N'.pic_20 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (32, N'.pic_21 {background-position: -320px -0px; width: 16px; height: 16px; }', N'.pic_21 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (33, N'.pic_22 {background-position: -336px -0px; width: 16px; height: 16px; }', N'.pic_22 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (34, N'.pic_23 {background-position: -352px -0px; width: 16px; height: 16px; }', N'.pic_23 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (35, N'.pic_24 {background-position: -368px -0px; width: 16px; height: 16px; }', N'.pic_24 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (36, N'.pic_25 {background-position: -384px -0px; width: 16px; height: 16px; }', N'.pic_25 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (37, N'.pic_26 {background-position: -400px -0px; width: 16px; height: 16px; }', N'.pic_26 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (38, N'.pic_27 {background-position: -416px -0px; width: 16px; height: 16px; }', N'.pic_27 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (39, N'.pic_28 {background-position: -432px -0px; width: 16px; height: 16px; }', N'.pic_28 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (40, N'.pic_29 {background-position: -448px -0px; width: 16px; height: 16px; }', N'.pic_29 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (41, N'.pic_30 {background-position: -464px -0px; width: 16px; height: 16px; }', N'.pic_30 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (42, N'.pic_31 {background-position: -480px -0px; width: 16px; height: 16px; }', N'.pic_31 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (43, N'.pic_32 {background-position: -496px -0px; width: 16px; height: 16px; }', N'.pic_32 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (44, N'.pic_33 {background-position: -512px -0px; width: 16px; height: 16px; }', N'.pic_33 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (45, N'.pic_34 {background-position: -528px -0px; width: 16px; height: 16px; }', N'.pic_34 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (46, N'.pic_35 {background-position: -544px -0px; width: 16px; height: 16px; }', N'.pic_35 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (47, N'.pic_36 {background-position: -560px -0px; width: 16px; height: 16px; }', N'.pic_36 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (48, N'.pic_37 {background-position: -576px -0px; width: 16px; height: 16px; }', N'.pic_37 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (49, N'.pic_38 {background-position: -592px -0px; width: 16px; height: 16px; }', N'.pic_38 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (50, N'.pic_39 {background-position: -608px -0px; width: 16px; height: 16px; }', N'.pic_39 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (51, N'.pic_40 {background-position: -624px -0px; width: 16px; height: 16px; }', N'.pic_40 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (52, N'.pic_41 {background-position: -640px -0px; width: 16px; height: 16px; }', N'.pic_41 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (53, N'.pic_42 {background-position: -656px -0px; width: 16px; height: 16px; }', N'.pic_42 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (54, N'.pic_43 {background-position: -672px -0px; width: 16px; height: 16px; }', N'.pic_43 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (55, N'.pic_44 {background-position: -688px -0px; width: 16px; height: 16px; }', N'.pic_44 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (56, N'.pic_45 {background-position: -704px -0px; width: 16px; height: 16px; }', N'.pic_45 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (57, N'.pic_46 {background-position: -720px -0px; width: 16px; height: 16px; }', N'.pic_46 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (58, N'.pic_47 {background-position: -736px -0px; width: 16px; height: 16px; }', N'.pic_47 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (59, N'.pic_48 {background-position: -752px -0px; width: 16px; height: 16px; }', N'.pic_48 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (60, N'.pic_49 {background-position: -768px -0px; width: 16px; height: 16px; }', N'.pic_49 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (61, N'.pic_50 {background-position: -784px -0px; width: 16px; height: 16px; }', N'.pic_50 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (62, N'.pic_51 {background-position: -800px -0px; width: 16px; height: 16px; }', N'.pic_51 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (63, N'.pic_52 {background-position: -816px -0px; width: 16px; height: 16px; }', N'.pic_52 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (64, N'.pic_53 {background-position: -832px -0px; width: 16px; height: 16px; }', N'.pic_53 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (65, N'.pic_54 {background-position: -848px -0px; width: 16px; height: 16px; }', N'.pic_54 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (66, N'.pic_55 {background-position: -864px -0px; width: 16px; height: 16px; }', N'.pic_55 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (67, N'.pic_56 {background-position: -880px -0px; width: 16px; height: 16px; }', N'.pic_56 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (68, N'.pic_57 {background-position: -896px -0px; width: 16px; height: 16px; }', N'.pic_57 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (69, N'.pic_58 {background-position: -912px -0px; width: 16px; height: 16px; }', N'.pic_58 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (70, N'.pic_59 {background-position: -928px -0px; width: 16px; height: 16px; }', N'.pic_59 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (71, N'.pic_60 {background-position: -944px -0px; width: 16px; height: 16px; }', N'.pic_60 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (72, N'.pic_61 {background-position: -960px -0px; width: 16px; height: 16px; }', N'.pic_61 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (73, N'.pic_62 {background-position: -976px -0px; width: 16px; height: 16px; }', N'.pic_62 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (74, N'.pic_63 {background-position: -992px -0px; width: 16px; height: 16px; }', N'.pic_63 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (75, N'.pic_64 {background-position: -1008px -0px; width: 16px; height: 16px; }', N'.pic_64 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (76, N'.pic_65 {background-position: -1024px -0px; width: 16px; height: 16px; }', N'.pic_65 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (77, N'.pic_66 {background-position: -1040px -0px; width: 16px; height: 16px; }', N'.pic_66 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (78, N'.pic_67 {background-position: -1056px -0px; width: 16px; height: 16px; }', N'.pic_67 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (79, N'.pic_68 {background-position: -1072px -0px; width: 16px; height: 16px; }', N'.pic_68 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (80, N'.pic_69 {background-position: -1088px -0px; width: 16px; height: 16px; }', N'.pic_69 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (81, N'.pic_70 {background-position: -1104px -0px; width: 16px; height: 16px; }', N'.pic_70 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (82, N'.pic_71 {background-position: -1120px -0px; width: 16px; height: 16px; }', N'.pic_71 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (83, N'.pic_72 {background-position: -1136px -0px; width: 16px; height: 16px; }', N'.pic_72 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (84, N'.pic_73 {background-position: -1152px -0px; width: 16px; height: 16px; }', N'.pic_73 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (85, N'.pic_74 {background-position: -1168px -0px; width: 16px; height: 16px; }', N'.pic_74 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (86, N'.pic_75 {background-position: -1184px -0px; width: 16px; height: 16px; }', N'.pic_75 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (87, N'.pic_76 {background-position: -1200px -0px; width: 16px; height: 16px; }', N'.pic_76 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (88, N'.pic_77 {background-position: -1216px -0px; width: 16px; height: 16px; }', N'.pic_77 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (89, N'.pic_78 {background-position: -1232px -0px; width: 16px; height: 16px; }', N'.pic_78 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (90, N'.pic_79 {background-position: -0px -16px; width: 16px; height: 16px; }', N'.pic_79 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (91, N'.pic_80 {background-position: -16px -16px; width: 16px; height: 16px; }', N'.pic_80 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (92, N'.pic_81 {background-position: -32px -16px; width: 16px; height: 16px; }', N'.pic_81 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (93, N'.pic_82 {background-position: -48px -16px; width: 16px; height: 16px; }', N'.pic_82 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (94, N'.pic_83 {background-position: -64px -16px; width: 16px; height: 16px; }', N'.pic_83 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (95, N'.pic_84 {background-position: -80px -16px; width: 16px; height: 16px; }', N'.pic_84 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (96, N'.pic_85 {background-position: -96px -16px; width: 16px; height: 16px; }', N'.pic_85 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (97, N'.pic_86 {background-position: -112px -16px; width: 16px; height: 16px; }', N'.pic_86 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (98, N'.pic_87 {background-position: -128px -16px; width: 16px; height: 16px; }', N'.pic_87 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (99, N'.pic_88 {background-position: -144px -16px; width: 16px; height: 16px; }', N'.pic_88 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (100, N'.pic_89 {background-position: -160px -16px; width: 16px; height: 16px; }', N'.pic_89 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (101, N'.pic_90 {background-position: -176px -16px; width: 16px; height: 16px; }', N'.pic_90 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (102, N'.pic_91 {background-position: -192px -16px; width: 16px; height: 16px; }', N'.pic_91 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (103, N'.pic_92 {background-position: -208px -16px; width: 16px; height: 16px; }', N'.pic_92 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (104, N'.pic_93 {background-position: -224px -16px; width: 16px; height: 16px; }', N'.pic_93 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (105, N'.pic_94 {background-position: -240px -16px; width: 16px; height: 16px; }', N'.pic_94 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (106, N'.pic_95 {background-position: -256px -16px; width: 16px; height: 16px; }', N'.pic_95 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (107, N'.pic_96 {background-position: -272px -16px; width: 16px; height: 16px; }', N'.pic_96 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (108, N'.pic_97 {background-position: -288px -16px; width: 16px; height: 16px; }', N'.pic_97 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (109, N'.pic_98 {background-position: -304px -16px; width: 16px; height: 16px; }', N'.pic_98 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (110, N'.pic_99 {background-position: -320px -16px; width: 16px; height: 16px; }', N'.pic_99 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (111, N'.pic_100 {background-position: -336px -16px; width: 16px; height: 16px; }', N'.pic_100 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (112, N'.pic_101 {background-position: -352px -16px; width: 16px; height: 16px; }', N'.pic_101 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (113, N'.pic_102 {background-position: -368px -16px; width: 16px; height: 16px; }', N'.pic_102 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (114, N'.pic_103 {background-position: -384px -16px; width: 16px; height: 16px; }', N'.pic_103 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (115, N'.pic_104 {background-position: -400px -16px; width: 16px; height: 16px; }', N'.pic_104 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (116, N'.pic_105 {background-position: -416px -16px; width: 16px; height: 16px; }', N'.pic_105 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (117, N'.pic_106 {background-position: -432px -16px; width: 16px; height: 16px; }', N'.pic_106 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (118, N'.pic_107 {background-position: -448px -16px; width: 16px; height: 16px; }', N'.pic_107 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (119, N'.pic_108 {background-position: -464px -16px; width: 16px; height: 16px; }', N'.pic_108 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (120, N'.pic_109 {background-position: -480px -16px; width: 16px; height: 16px; }', N'.pic_109 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (121, N'.pic_110 {background-position: -496px -16px; width: 16px; height: 16px; }', N'.pic_110 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (122, N'.pic_111 {background-position: -512px -16px; width: 16px; height: 16px; }', N'.pic_111 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (123, N'.pic_112 {background-position: -528px -16px; width: 16px; height: 16px; }', N'.pic_112 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (124, N'.pic_113 {background-position: -544px -16px; width: 16px; height: 16px; }', N'.pic_113 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (125, N'.pic_114 {background-position: -560px -16px; width: 16px; height: 16px; }', N'.pic_114 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (126, N'.pic_115 {background-position: -576px -16px; width: 16px; height: 16px; }', N'.pic_115 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (127, N'.pic_116 {background-position: -592px -16px; width: 16px; height: 16px; }', N'.pic_116 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (128, N'.pic_117 {background-position: -608px -16px; width: 16px; height: 16px; }', N'.pic_117 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (129, N'.pic_118 {background-position: -624px -16px; width: 16px; height: 16px; }', N'.pic_118 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (130, N'.pic_119 {background-position: -640px -16px; width: 16px; height: 16px; }', N'.pic_119 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (131, N'.pic_120 {background-position: -656px -16px; width: 16px; height: 16px; }', N'.pic_120 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (132, N'.pic_121 {background-position: -672px -16px; width: 16px; height: 16px; }', N'.pic_121 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (133, N'.pic_122 {background-position: -688px -16px; width: 16px; height: 16px; }', N'.pic_122 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (134, N'.pic_123 {background-position: -704px -16px; width: 16px; height: 16px; }', N'.pic_123 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (135, N'.pic_124 {background-position: -720px -16px; width: 16px; height: 16px; }', N'.pic_124 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (136, N'.pic_125 {background-position: -736px -16px; width: 16px; height: 16px; }', N'.pic_125 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (137, N'.pic_126 {background-position: -752px -16px; width: 16px; height: 16px; }', N'.pic_126 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (138, N'.pic_127 {background-position: -768px -16px; width: 16px; height: 16px; }', N'.pic_127 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (139, N'.pic_128 {background-position: -784px -16px; width: 16px; height: 16px; }', N'.pic_128 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (140, N'.pic_129 {background-position: -800px -16px; width: 16px; height: 16px; }', N'.pic_129 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (141, N'.pic_130 {background-position: -816px -16px; width: 16px; height: 16px; }', N'.pic_130 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (142, N'.pic_131 {background-position: -832px -16px; width: 16px; height: 16px; }', N'.pic_131 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (143, N'.pic_132 {background-position: -848px -16px; width: 16px; height: 16px; }', N'.pic_132 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (144, N'.pic_133 {background-position: -864px -16px; width: 16px; height: 16px; }', N'.pic_133 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (145, N'.pic_134 {background-position: -880px -16px; width: 16px; height: 16px; }', N'.pic_134 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (146, N'.pic_135 {background-position: -896px -16px; width: 16px; height: 16px; }', N'.pic_135 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (147, N'.pic_136 {background-position: -912px -16px; width: 16px; height: 16px; }', N'.pic_136 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (148, N'.pic_137 {background-position: -928px -16px; width: 16px; height: 16px; }', N'.pic_137 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (149, N'.pic_138 {background-position: -944px -16px; width: 16px; height: 16px; }', N'.pic_138 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (150, N'.pic_139 {background-position: -960px -16px; width: 16px; height: 16px; }', N'.pic_139 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (151, N'.pic_140 {background-position: -976px -16px; width: 16px; height: 16px; }', N'.pic_140 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (152, N'.pic_141 {background-position: -992px -16px; width: 16px; height: 16px; }', N'.pic_141 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (153, N'.pic_142 {background-position: -1008px -16px; width: 16px; height: 16px; }', N'.pic_142 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (154, N'.pic_143 {background-position: -1024px -16px; width: 16px; height: 16px; }', N'.pic_143 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (155, N'.pic_144 {background-position: -1040px -16px; width: 16px; height: 16px; }', N'.pic_144 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (156, N'.pic_145 {background-position: -1056px -16px; width: 16px; height: 16px; }', N'.pic_145 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (157, N'.pic_146 {background-position: -1072px -16px; width: 16px; height: 16px; }', N'.pic_146 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (158, N'.pic_147 {background-position: -1088px -16px; width: 16px; height: 16px; }', N'.pic_147 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (159, N'.pic_148 {background-position: -1104px -16px; width: 16px; height: 16px; }', N'.pic_148 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (160, N'.pic_149 {background-position: -1120px -16px; width: 16px; height: 16px; }', N'.pic_149 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (161, N'.pic_150 {background-position: -1136px -16px; width: 16px; height: 16px; }', N'.pic_150 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (162, N'.pic_151 {background-position: -1152px -16px; width: 16px; height: 16px; }', N'.pic_151 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (163, N'.pic_152 {background-position: -1168px -16px; width: 16px; height: 16px; }', N'.pic_152 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (164, N'.pic_153 {background-position: -1184px -16px; width: 16px; height: 16px; }', N'.pic_153 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (165, N'.pic_154 {background-position: -1200px -16px; width: 16px; height: 16px; }', N'.pic_154 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (166, N'.pic_155 {background-position: -1216px -16px; width: 16px; height: 16px; }', N'.pic_155 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (167, N'.pic_156 {background-position: -1232px -16px; width: 16px; height: 16px; }', N'.pic_156 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (168, N'.pic_157 {background-position: -0px -32px; width: 16px; height: 16px; }', N'.pic_157 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (169, N'.pic_158 {background-position: -16px -32px; width: 16px; height: 16px; }', N'.pic_158 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (170, N'.pic_159 {background-position: -32px -32px; width: 16px; height: 16px; }', N'.pic_159 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (171, N'.pic_160 {background-position: -48px -32px; width: 16px; height: 16px; }', N'.pic_160 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (172, N'.pic_161 {background-position: -64px -32px; width: 16px; height: 16px; }', N'.pic_161 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (173, N'.pic_162 {background-position: -80px -32px; width: 16px; height: 16px; }', N'.pic_162 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (174, N'.pic_163 {background-position: -96px -32px; width: 16px; height: 16px; }', N'.pic_163 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (175, N'.pic_164 {background-position: -112px -32px; width: 16px; height: 16px; }', N'.pic_164 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (176, N'.pic_165 {background-position: -128px -32px; width: 16px; height: 16px; }', N'.pic_165 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (177, N'.pic_166 {background-position: -144px -32px; width: 16px; height: 16px; }', N'.pic_166 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (178, N'.pic_167 {background-position: -160px -32px; width: 16px; height: 16px; }', N'.pic_167 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (179, N'.pic_168 {background-position: -176px -32px; width: 16px; height: 16px; }', N'.pic_168 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (180, N'.pic_169 {background-position: -192px -32px; width: 16px; height: 16px; }', N'.pic_169 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (181, N'.pic_170 {background-position: -208px -32px; width: 16px; height: 16px; }', N'.pic_170 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (182, N'.pic_171 {background-position: -224px -32px; width: 16px; height: 16px; }', N'.pic_171 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (183, N'.pic_172 {background-position: -240px -32px; width: 16px; height: 16px; }', N'.pic_172 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (184, N'.pic_173 {background-position: -256px -32px; width: 16px; height: 16px; }', N'.pic_173 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (185, N'.pic_174 {background-position: -272px -32px; width: 16px; height: 16px; }', N'.pic_174 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (186, N'.pic_175 {background-position: -288px -32px; width: 16px; height: 16px; }', N'.pic_175 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (187, N'.pic_176 {background-position: -304px -32px; width: 16px; height: 16px; }', N'.pic_176 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (188, N'.pic_177 {background-position: -320px -32px; width: 16px; height: 16px; }', N'.pic_177 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (189, N'.pic_178 {background-position: -336px -32px; width: 16px; height: 16px; }', N'.pic_178 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (190, N'.pic_179 {background-position: -352px -32px; width: 16px; height: 16px; }', N'.pic_179 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (191, N'.pic_180 {background-position: -368px -32px; width: 16px; height: 16px; }', N'.pic_180 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (192, N'.pic_181 {background-position: -384px -32px; width: 16px; height: 16px; }', N'.pic_181 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (193, N'.pic_182 {background-position: -400px -32px; width: 16px; height: 16px; }', N'.pic_182 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (194, N'.pic_183 {background-position: -416px -32px; width: 16px; height: 16px; }', N'.pic_183 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (195, N'.pic_184 {background-position: -432px -32px; width: 16px; height: 16px; }', N'.pic_184 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (196, N'.pic_185 {background-position: -448px -32px; width: 16px; height: 16px; }', N'.pic_185 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (197, N'.pic_186 {background-position: -464px -32px; width: 16px; height: 16px; }', N'.pic_186 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (198, N'.pic_187 {background-position: -480px -32px; width: 16px; height: 16px; }', N'.pic_187 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (199, N'.pic_188 {background-position: -496px -32px; width: 16px; height: 16px; }', N'.pic_188 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (200, N'.pic_189 {background-position: -512px -32px; width: 16px; height: 16px; }', N'.pic_189 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (201, N'.pic_190 {background-position: -528px -32px; width: 16px; height: 16px; }', N'.pic_190 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (202, N'.pic_191 {background-position: -544px -32px; width: 16px; height: 16px; }', N'.pic_191 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (203, N'.pic_192 {background-position: -560px -32px; width: 16px; height: 16px; }', N'.pic_192 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (204, N'.pic_193 {background-position: -576px -32px; width: 16px; height: 16px; }', N'.pic_193 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (205, N'.pic_194 {background-position: -592px -32px; width: 16px; height: 16px; }', N'.pic_194 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (206, N'.pic_195 {background-position: -608px -32px; width: 16px; height: 16px; }', N'.pic_195 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (207, N'.pic_196 {background-position: -624px -32px; width: 16px; height: 16px; }', N'.pic_196 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (208, N'.pic_197 {background-position: -640px -32px; width: 16px; height: 16px; }', N'.pic_197 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (209, N'.pic_198 {background-position: -656px -32px; width: 16px; height: 16px; }', N'.pic_198 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (210, N'.pic_199 {background-position: -672px -32px; width: 16px; height: 16px; }', N'.pic_199 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (211, N'.pic_200 {background-position: -688px -32px; width: 16px; height: 16px; }', N'.pic_200 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (212, N'.pic_201 {background-position: -704px -32px; width: 16px; height: 16px; }', N'.pic_201 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (213, N'.pic_202 {background-position: -720px -32px; width: 16px; height: 16px; }', N'.pic_202 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (214, N'.pic_203 {background-position: -736px -32px; width: 16px; height: 16px; }', N'.pic_203 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (215, N'.pic_204 {background-position: -752px -32px; width: 16px; height: 16px; }', N'.pic_204 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (216, N'.pic_205 {background-position: -768px -32px; width: 16px; height: 16px; }', N'.pic_205 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (217, N'.pic_206 {background-position: -784px -32px; width: 16px; height: 16px; }', N'.pic_206 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (218, N'.pic_207 {background-position: -800px -32px; width: 16px; height: 16px; }', N'.pic_207 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (219, N'.pic_208 {background-position: -816px -32px; width: 16px; height: 16px; }', N'.pic_208 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (220, N'.pic_209 {background-position: -832px -32px; width: 16px; height: 16px; }', N'.pic_209 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (221, N'.pic_210 {background-position: -848px -32px; width: 16px; height: 16px; }', N'.pic_210 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (222, N'.pic_211 {background-position: -864px -32px; width: 16px; height: 16px; }', N'.pic_211 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (223, N'.pic_212 {background-position: -880px -32px; width: 16px; height: 16px; }', N'.pic_212 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (224, N'.pic_213 {background-position: -896px -32px; width: 16px; height: 16px; }', N'.pic_213 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (225, N'.pic_214 {background-position: -912px -32px; width: 16px; height: 16px; }', N'.pic_214 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (226, N'.pic_215 {background-position: -928px -32px; width: 16px; height: 16px; }', N'.pic_215 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (227, N'.pic_216 {background-position: -944px -32px; width: 16px; height: 16px; }', N'.pic_216 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (228, N'.pic_217 {background-position: -960px -32px; width: 16px; height: 16px; }', N'.pic_217 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (229, N'.pic_218 {background-position: -976px -32px; width: 16px; height: 16px; }', N'.pic_218 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (230, N'.pic_219 {background-position: -992px -32px; width: 16px; height: 16px; }', N'.pic_219 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (231, N'.pic_220 {background-position: -1008px -32px; width: 16px; height: 16px; }', N'.pic_220 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (232, N'.pic_221 {background-position: -1024px -32px; width: 16px; height: 16px; }', N'.pic_221 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (233, N'.pic_222 {background-position: -1040px -32px; width: 16px; height: 16px; }', N'.pic_222 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (234, N'.pic_223 {background-position: -1056px -32px; width: 16px; height: 16px; }', N'.pic_223 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (235, N'.pic_224 {background-position: -1072px -32px; width: 16px; height: 16px; }', N'.pic_224 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (236, N'.pic_225 {background-position: -1088px -32px; width: 16px; height: 16px; }', N'.pic_225 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (237, N'.pic_226 {background-position: -1104px -32px; width: 16px; height: 16px; }', N'.pic_226 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (238, N'.pic_227 {background-position: -1120px -32px; width: 16px; height: 16px; }', N'.pic_227 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (239, N'.pic_228 {background-position: -1136px -32px; width: 16px; height: 16px; }', N'.pic_228 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (240, N'.pic_229 {background-position: -1152px -32px; width: 16px; height: 16px; }', N'.pic_229 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (241, N'.pic_230 {background-position: -1168px -32px; width: 16px; height: 16px; }', N'.pic_230 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (242, N'.pic_231 {background-position: -1184px -32px; width: 16px; height: 16px; }', N'.pic_231 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (243, N'.pic_232 {background-position: -1200px -32px; width: 16px; height: 16px; }', N'.pic_232 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (244, N'.pic_233 {background-position: -1216px -32px; width: 16px; height: 16px; }', N'.pic_233 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (245, N'.pic_234 {background-position: -1232px -32px; width: 16px; height: 16px; }', N'.pic_234 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (246, N'.pic_235 {background-position: -0px -48px; width: 16px; height: 16px; }', N'.pic_235 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (247, N'.pic_236 {background-position: -16px -48px; width: 16px; height: 16px; }', N'.pic_236 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (248, N'.pic_237 {background-position: -32px -48px; width: 16px; height: 16px; }', N'.pic_237 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (249, N'.pic_238 {background-position: -48px -48px; width: 16px; height: 16px; }', N'.pic_238 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (250, N'.pic_239 {background-position: -64px -48px; width: 16px; height: 16px; }', N'.pic_239 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (251, N'.pic_240 {background-position: -80px -48px; width: 16px; height: 16px; }', N'.pic_240 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (252, N'.pic_241 {background-position: -96px -48px; width: 16px; height: 16px; }', N'.pic_241 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (253, N'.pic_242 {background-position: -112px -48px; width: 16px; height: 16px; }', N'.pic_242 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (254, N'.pic_243 {background-position: -128px -48px; width: 16px; height: 16px; }', N'.pic_243 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (255, N'.pic_244 {background-position: -144px -48px; width: 16px; height: 16px; }', N'.pic_244 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (256, N'.pic_245 {background-position: -160px -48px; width: 16px; height: 16px; }', N'.pic_245 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (257, N'.pic_246 {background-position: -176px -48px; width: 16px; height: 16px; }', N'.pic_246 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (258, N'.pic_247 {background-position: -192px -48px; width: 16px; height: 16px; }', N'.pic_247 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (259, N'.pic_248 {background-position: -208px -48px; width: 16px; height: 16px; }', N'.pic_248 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (260, N'.pic_249 {background-position: -224px -48px; width: 16px; height: 16px; }', N'.pic_249 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (261, N'.pic_250 {background-position: -240px -48px; width: 16px; height: 16px; }', N'.pic_250 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (262, N'.pic_251 {background-position: -256px -48px; width: 16px; height: 16px; }', N'.pic_251 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (263, N'.pic_252 {background-position: -272px -48px; width: 16px; height: 16px; }', N'.pic_252 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (264, N'.pic_253 {background-position: -288px -48px; width: 16px; height: 16px; }', N'.pic_253 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (265, N'.pic_254 {background-position: -304px -48px; width: 16px; height: 16px; }', N'.pic_254 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (266, N'.pic_255 {background-position: -320px -48px; width: 16px; height: 16px; }', N'.pic_255 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (267, N'.pic_256 {background-position: -336px -48px; width: 16px; height: 16px; }', N'.pic_256 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (268, N'.pic_257 {background-position: -352px -48px; width: 16px; height: 16px; }', N'.pic_257 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (269, N'.pic_258 {background-position: -368px -48px; width: 16px; height: 16px; }', N'.pic_258 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (270, N'.pic_259 {background-position: -384px -48px; width: 16px; height: 16px; }', N'.pic_259 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (271, N'.pic_260 {background-position: -400px -48px; width: 16px; height: 16px; }', N'.pic_260 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (272, N'.pic_261 {background-position: -416px -48px; width: 16px; height: 16px; }', N'.pic_261 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (273, N'.pic_262 {background-position: -432px -48px; width: 16px; height: 16px; }', N'.pic_262 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (274, N'.pic_263 {background-position: -448px -48px; width: 16px; height: 16px; }', N'.pic_263 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (275, N'.pic_264 {background-position: -464px -48px; width: 16px; height: 16px; }', N'.pic_264 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (276, N'.pic_265 {background-position: -480px -48px; width: 16px; height: 16px; }', N'.pic_265 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (277, N'.pic_266 {background-position: -496px -48px; width: 16px; height: 16px; }', N'.pic_266 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (278, N'.pic_267 {background-position: -512px -48px; width: 16px; height: 16px; }', N'.pic_267 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (279, N'.pic_268 {background-position: -528px -48px; width: 16px; height: 16px; }', N'.pic_268 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (280, N'.pic_269 {background-position: -544px -48px; width: 16px; height: 16px; }', N'.pic_269 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (281, N'.pic_270 {background-position: -560px -48px; width: 16px; height: 16px; }', N'.pic_270 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (282, N'.pic_271 {background-position: -576px -48px; width: 16px; height: 16px; }', N'.pic_271 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (283, N'.pic_272 {background-position: -592px -48px; width: 16px; height: 16px; }', N'.pic_272 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (284, N'.pic_273 {background-position: -608px -48px; width: 16px; height: 16px; }', N'.pic_273 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (285, N'.pic_274 {background-position: -624px -48px; width: 16px; height: 16px; }', N'.pic_274 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (286, N'.pic_275 {background-position: -640px -48px; width: 16px; height: 16px; }', N'.pic_275 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (287, N'.pic_276 {background-position: -656px -48px; width: 16px; height: 16px; }', N'.pic_276 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (288, N'.pic_277 {background-position: -672px -48px; width: 16px; height: 16px; }', N'.pic_277 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (289, N'.pic_278 {background-position: -688px -48px; width: 16px; height: 16px; }', N'.pic_278 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (290, N'.pic_279 {background-position: -704px -48px; width: 16px; height: 16px; }', N'.pic_279 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (291, N'.pic_280 {background-position: -720px -48px; width: 16px; height: 16px; }', N'.pic_280 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (292, N'.pic_281 {background-position: -736px -48px; width: 16px; height: 16px; }', N'.pic_281 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (293, N'.pic_282 {background-position: -752px -48px; width: 16px; height: 16px; }', N'.pic_282 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (294, N'.pic_283 {background-position: -768px -48px; width: 16px; height: 16px; }', N'.pic_283 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (295, N'.pic_284 {background-position: -784px -48px; width: 16px; height: 16px; }', N'.pic_284 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (296, N'.pic_285 {background-position: -800px -48px; width: 16px; height: 16px; }', N'.pic_285 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (297, N'.pic_286 {background-position: -816px -48px; width: 16px; height: 16px; }', N'.pic_286 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (298, N'.pic_287 {background-position: -832px -48px; width: 16px; height: 16px; }', N'.pic_287 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (299, N'.pic_288 {background-position: -848px -48px; width: 16px; height: 16px; }', N'.pic_288 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (300, N'.pic_289 {background-position: -864px -48px; width: 16px; height: 16px; }', N'.pic_289 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (301, N'.pic_290 {background-position: -880px -48px; width: 16px; height: 16px; }', N'.pic_290 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (302, N'.pic_291 {background-position: -896px -48px; width: 16px; height: 16px; }', N'.pic_291 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (303, N'.pic_292 {background-position: -912px -48px; width: 16px; height: 16px; }', N'.pic_292 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (304, N'.pic_293 {background-position: -928px -48px; width: 16px; height: 16px; }', N'.pic_293 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (305, N'.pic_294 {background-position: -944px -48px; width: 16px; height: 16px; }', N'.pic_294 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (306, N'.pic_295 {background-position: -960px -48px; width: 16px; height: 16px; }', N'.pic_295 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (307, N'.pic_296 {background-position: -976px -48px; width: 16px; height: 16px; }', N'.pic_296 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (308, N'.pic_297 {background-position: -992px -48px; width: 16px; height: 16px; }', N'.pic_297 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (309, N'.pic_298 {background-position: -1008px -48px; width: 16px; height: 16px; }', N'.pic_298 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (310, N'.pic_299 {background-position: -1024px -48px; width: 16px; height: 16px; }', N'.pic_299 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (311, N'.pic_300 {background-position: -1040px -48px; width: 16px; height: 16px; }', N'.pic_300 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (312, N'.pic_301 {background-position: -1056px -48px; width: 16px; height: 16px; }', N'.pic_301 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (313, N'.pic_302 {background-position: -1072px -48px; width: 16px; height: 16px; }', N'.pic_302 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (314, N'.pic_303 {background-position: -1088px -48px; width: 16px; height: 16px; }', N'.pic_303 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (315, N'.pic_304 {background-position: -1104px -48px; width: 16px; height: 16px; }', N'.pic_304 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (316, N'.pic_305 {background-position: -1120px -48px; width: 16px; height: 16px; }', N'.pic_305 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (317, N'.pic_306 {background-position: -1136px -48px; width: 16px; height: 16px; }', N'.pic_306 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (318, N'.pic_307 {background-position: -1152px -48px; width: 16px; height: 16px; }', N'.pic_307 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (319, N'.pic_308 {background-position: -1168px -48px; width: 16px; height: 16px; }', N'.pic_308 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (320, N'.pic_309 {background-position: -1184px -48px; width: 16px; height: 16px; }', N'.pic_309 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (321, N'.pic_310 {background-position: -1200px -48px; width: 16px; height: 16px; }', N'.pic_310 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (322, N'.pic_311 {background-position: -1216px -48px; width: 16px; height: 16px; }', N'.pic_311 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (323, N'.pic_312 {background-position: -1232px -48px; width: 16px; height: 16px; }', N'.pic_312 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (324, N'.pic_313 {background-position: -0px -64px; width: 16px; height: 16px; }', N'.pic_313 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (325, N'.pic_314 {background-position: -16px -64px; width: 16px; height: 16px; }', N'.pic_314 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (326, N'.pic_315 {background-position: -32px -64px; width: 16px; height: 16px; }', N'.pic_315 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (327, N'.pic_316 {background-position: -48px -64px; width: 16px; height: 16px; }', N'.pic_316 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (328, N'.pic_317 {background-position: -64px -64px; width: 16px; height: 16px; }', N'.pic_317 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (329, N'.pic_318 {background-position: -80px -64px; width: 16px; height: 16px; }', N'.pic_318 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (330, N'.pic_319 {background-position: -96px -64px; width: 16px; height: 16px; }', N'.pic_319 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (331, N'.pic_320 {background-position: -112px -64px; width: 16px; height: 16px; }', N'.pic_320 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (332, N'.pic_321 {background-position: -128px -64px; width: 16px; height: 16px; }', N'.pic_321 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (333, N'.pic_322 {background-position: -144px -64px; width: 16px; height: 16px; }', N'.pic_322 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (334, N'.pic_323 {background-position: -160px -64px; width: 16px; height: 16px; }', N'.pic_323 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (335, N'.pic_324 {background-position: -176px -64px; width: 16px; height: 16px; }', N'.pic_324 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (336, N'.pic_325 {background-position: -192px -64px; width: 16px; height: 16px; }', N'.pic_325 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (337, N'.pic_326 {background-position: -208px -64px; width: 16px; height: 16px; }', N'.pic_326 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (338, N'.pic_327 {background-position: -224px -64px; width: 16px; height: 16px; }', N'.pic_327 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (339, N'.pic_328 {background-position: -240px -64px; width: 16px; height: 16px; }', N'.pic_328 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (340, N'.pic_329 {background-position: -256px -64px; width: 16px; height: 16px; }', N'.pic_329 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (341, N'.pic_330 {background-position: -272px -64px; width: 16px; height: 16px; }', N'.pic_330 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (342, N'.pic_331 {background-position: -288px -64px; width: 16px; height: 16px; }', N'.pic_331 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (343, N'.pic_332 {background-position: -304px -64px; width: 16px; height: 16px; }', N'.pic_332 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (344, N'.pic_333 {background-position: -320px -64px; width: 16px; height: 16px; }', N'.pic_333 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (345, N'.pic_334 {background-position: -336px -64px; width: 16px; height: 16px; }', N'.pic_334 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (346, N'.pic_335 {background-position: -352px -64px; width: 16px; height: 16px; }', N'.pic_335 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (347, N'.pic_336 {background-position: -368px -64px; width: 16px; height: 16px; }', N'.pic_336 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (348, N'.pic_337 {background-position: -384px -64px; width: 16px; height: 16px; }', N'.pic_337 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (349, N'.pic_338 {background-position: -400px -64px; width: 16px; height: 16px; }', N'.pic_338 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (350, N'.pic_339 {background-position: -416px -64px; width: 16px; height: 16px; }', N'.pic_339 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (351, N'.pic_340 {background-position: -432px -64px; width: 16px; height: 16px; }', N'.pic_340 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (352, N'.pic_341 {background-position: -448px -64px; width: 16px; height: 16px; }', N'.pic_341 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (353, N'.pic_342 {background-position: -464px -64px; width: 16px; height: 16px; }', N'.pic_342 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (354, N'.pic_343 {background-position: -480px -64px; width: 16px; height: 16px; }', N'.pic_343 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (355, N'.pic_344 {background-position: -496px -64px; width: 16px; height: 16px; }', N'.pic_344 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (356, N'.pic_345 {background-position: -512px -64px; width: 16px; height: 16px; }', N'.pic_345 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (357, N'.pic_346 {background-position: -528px -64px; width: 16px; height: 16px; }', N'.pic_346 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (358, N'.pic_347 {background-position: -544px -64px; width: 16px; height: 16px; }', N'.pic_347 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (359, N'.pic_348 {background-position: -560px -64px; width: 16px; height: 16px; }', N'.pic_348 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (360, N'.pic_349 {background-position: -576px -64px; width: 16px; height: 16px; }', N'.pic_349 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (361, N'.pic_350 {background-position: -592px -64px; width: 16px; height: 16px; }', N'.pic_350 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (362, N'.pic_351 {background-position: -608px -64px; width: 16px; height: 16px; }', N'.pic_351 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (363, N'.pic_352 {background-position: -624px -64px; width: 16px; height: 16px; }', N'.pic_352 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (364, N'.pic_353 {background-position: -640px -64px; width: 16px; height: 16px; }', N'.pic_353 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (365, N'.pic_354 {background-position: -656px -64px; width: 16px; height: 16px; }', N'.pic_354 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (366, N'.pic_355 {background-position: -672px -64px; width: 16px; height: 16px; }', N'.pic_355 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (367, N'.pic_356 {background-position: -688px -64px; width: 16px; height: 16px; }', N'.pic_356 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (368, N'.pic_357 {background-position: -704px -64px; width: 16px; height: 16px; }', N'.pic_357 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (369, N'.pic_358 {background-position: -720px -64px; width: 16px; height: 16px; }', N'.pic_358 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (370, N'.pic_359 {background-position: -736px -64px; width: 16px; height: 16px; }', N'.pic_359 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (371, N'.pic_360 {background-position: -752px -64px; width: 16px; height: 16px; }', N'.pic_360 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (372, N'.pic_361 {background-position: -768px -64px; width: 16px; height: 16px; }', N'.pic_361 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (373, N'.pic_362 {background-position: -784px -64px; width: 17px; height: 14px; }', N'.pic_362 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (374, N'.pic_363 {background-position: -801px -64px; width: 17px; height: 14px; }', N'.pic_363 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (375, N'.pic_364 {background-position: -818px -64px; width: 16px; height: 16px; }', N'.pic_364 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (376, N'.pic_365 {background-position: -834px -64px; width: 16px; height: 16px; }', N'.pic_365 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (377, N'.pic_366 {background-position: -850px -64px; width: 16px; height: 16px; }', N'.pic_366 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (378, N'.pic_367 {background-position: -866px -64px; width: 16px; height: 16px; }', N'.pic_367 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (379, N'.pic_368 {background-position: -882px -64px; width: 16px; height: 16px; }', N'.pic_368 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (380, N'.pic_369 {background-position: -898px -64px; width: 16px; height: 16px; }', N'.pic_369 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (381, N'.pic_370 {background-position: -914px -64px; width: 16px; height: 16px; }', N'.pic_370 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (382, N'.pic_371 {background-position: -930px -64px; width: 16px; height: 16px; }', N'.pic_371 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (383, N'.pic_372 {background-position: -946px -64px; width: 16px; height: 16px; }', N'.pic_372 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (384, N'.pic_373 {background-position: -962px -64px; width: 16px; height: 16px; }', N'.pic_373 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (385, N'.pic_374 {background-position: -978px -64px; width: 16px; height: 16px; }', N'.pic_374 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (386, N'.pic_375 {background-position: -994px -64px; width: 16px; height: 16px; }', N'.pic_375 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (387, N'.pic_376 {background-position: -1010px -64px; width: 16px; height: 16px; }', N'.pic_376 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (388, N'.pic_377 {background-position: -1026px -64px; width: 16px; height: 16px; }', N'.pic_377 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (389, N'.pic_378 {background-position: -1042px -64px; width: 16px; height: 16px; }', N'.pic_378 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (390, N'.pic_379 {background-position: -1058px -64px; width: 16px; height: 16px; }', N'.pic_379 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (391, N'.pic_380 {background-position: -1074px -64px; width: 16px; height: 16px; }', N'.pic_380 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (392, N'.pic_381 {background-position: -1090px -64px; width: 16px; height: 16px; }', N'.pic_381 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (393, N'.pic_382 {background-position: -1106px -64px; width: 16px; height: 16px; }', N'.pic_382 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (394, N'.pic_383 {background-position: -1122px -64px; width: 16px; height: 16px; }', N'.pic_383 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (395, N'.pic_384 {background-position: -1138px -64px; width: 16px; height: 16px; }', N'.pic_384 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (396, N'.pic_385 {background-position: -1154px -64px; width: 16px; height: 16px; }', N'.pic_385 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (397, N'.pic_386 {background-position: -1170px -64px; width: 16px; height: 16px; }', N'.pic_386 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (398, N'.pic_387 {background-position: -1186px -64px; width: 16px; height: 16px; }', N'.pic_387 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (399, N'.pic_388 {background-position: -1202px -64px; width: 16px; height: 16px; }', N'.pic_388 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (400, N'.pic_389 {background-position: -1218px -64px; width: 16px; height: 16px; }', N'.pic_389 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (401, N'.pic_390 {background-position: -1234px -64px; width: 16px; height: 15px; }', N'.pic_390 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (402, N'.pic_391 {background-position: -0px -79px; width: 16px; height: 16px; }', N'.pic_391 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (403, N'.pic_392 {background-position: -16px -79px; width: 16px; height: 16px; }', N'.pic_392 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (404, N'.pic_393 {background-position: -32px -79px; width: 16px; height: 16px; }', N'.pic_393 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (405, N'.pic_394 {background-position: -48px -79px; width: 16px; height: 16px; }', N'.pic_394 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (406, N'.pic_395 {background-position: -64px -79px; width: 16px; height: 16px; }', N'.pic_395 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (407, N'.pic_396 {background-position: -80px -79px; width: 16px; height: 16px; }', N'.pic_396 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (408, N'.pic_397 {background-position: -96px -79px; width: 16px; height: 16px; }', N'.pic_397 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (409, N'.pic_398 {background-position: -112px -79px; width: 16px; height: 16px; }', N'.pic_398 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (410, N'.pic_399 {background-position: -128px -79px; width: 16px; height: 16px; }', N'.pic_399 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (411, N'.pic_400 {background-position: -144px -79px; width: 16px; height: 16px; }', N'.pic_400 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (412, N'.pic_401 {background-position: -160px -79px; width: 16px; height: 16px; }', N'.pic_401 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (413, N'.pic_402 {background-position: -176px -79px; width: 16px; height: 16px; }', N'.pic_402 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (414, N'.pic_403 {background-position: -192px -79px; width: 16px; height: 16px; }', N'.pic_403 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (415, N'.pic_404 {background-position: -208px -79px; width: 16px; height: 16px; }', N'.pic_404 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (416, N'.pic_405 {background-position: -224px -79px; width: 16px; height: 16px; }', N'.pic_405 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (417, N'.pic_406 {background-position: -240px -79px; width: 16px; height: 16px; }', N'.pic_406 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (418, N'.pic_407 {background-position: -256px -79px; width: 16px; height: 16px; }', N'.pic_407 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (419, N'.pic_408 {background-position: -272px -79px; width: 16px; height: 16px; }', N'.pic_408 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (420, N'.pic_409 {background-position: -288px -79px; width: 16px; height: 16px; }', N'.pic_409 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (421, N'.pic_410 {background-position: -304px -79px; width: 16px; height: 16px; }', N'.pic_410 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (422, N'.pic_411 {background-position: -320px -79px; width: 16px; height: 16px; }', N'.pic_411 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (423, N'.pic_412 {background-position: -336px -79px; width: 16px; height: 16px; }', N'.pic_412 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (424, N'.pic_413 {background-position: -352px -79px; width: 16px; height: 16px; }', N'.pic_413 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (425, N'.pic_414 {background-position: -368px -79px; width: 16px; height: 16px; }', N'.pic_414 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (426, N'.pic_415 {background-position: -384px -79px; width: 16px; height: 16px; }', N'.pic_415 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (427, N'.pic_416 {background-position: -400px -79px; width: 16px; height: 16px; }', N'.pic_416 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (428, N'.pic_417 {background-position: -416px -79px; width: 16px; height: 16px; }', N'.pic_417 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (429, N'.pic_418 {background-position: -432px -79px; width: 16px; height: 16px; }', N'.pic_418 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (430, N'.pic_419 {background-position: -448px -79px; width: 16px; height: 16px; }', N'.pic_419 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (431, N'.pic_420 {background-position: -464px -79px; width: 16px; height: 16px; }', N'.pic_420 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (432, N'.pic_421 {background-position: -480px -79px; width: 16px; height: 16px; }', N'.pic_421 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (433, N'.pic_422 {background-position: -496px -79px; width: 16px; height: 16px; }', N'.pic_422 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (434, N'.pic_423 {background-position: -512px -79px; width: 16px; height: 16px; }', N'.pic_423 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (435, N'.pic_424 {background-position: -528px -79px; width: 16px; height: 16px; }', N'.pic_424 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (436, N'.pic_425 {background-position: -544px -79px; width: 16px; height: 16px; }', N'.pic_425 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (437, N'.pic_426 {background-position: -560px -79px; width: 16px; height: 16px; }', N'.pic_426 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (438, N'.pic_427 {background-position: -576px -79px; width: 16px; height: 16px; }', N'.pic_427 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (439, N'.pic_428 {background-position: -592px -79px; width: 16px; height: 16px; }', N'.pic_428 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (440, N'.pic_429 {background-position: -608px -79px; width: 16px; height: 16px; }', N'.pic_429 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (441, N'.pic_430 {background-position: -624px -79px; width: 16px; height: 16px; }', N'.pic_430 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (442, N'.pic_431 {background-position: -640px -79px; width: 16px; height: 16px; }', N'.pic_431 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (443, N'.pic_432 {background-position: -656px -79px; width: 16px; height: 16px; }', N'.pic_432 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (444, N'.pic_433 {background-position: -672px -79px; width: 16px; height: 16px; }', N'.pic_433 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (445, N'.pic_434 {background-position: -688px -79px; width: 16px; height: 16px; }', N'.pic_434 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (446, N'.pic_435 {background-position: -704px -79px; width: 16px; height: 16px; }', N'.pic_435 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (447, N'.pic_436 {background-position: -720px -79px; width: 16px; height: 16px; }', N'.pic_436 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (448, N'.pic_437 {background-position: -736px -79px; width: 16px; height: 16px; }', N'.pic_437 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (449, N'.pic_438 {background-position: -752px -79px; width: 16px; height: 16px; }', N'.pic_438 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (450, N'.pic_439 {background-position: -768px -79px; width: 16px; height: 16px; }', N'.pic_439 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (451, N'.pic_440 {background-position: -784px -79px; width: 16px; height: 16px; }', N'.pic_440 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (452, N'.pic_441 {background-position: -800px -79px; width: 16px; height: 16px; }', N'.pic_441 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (453, N'.pic_442 {background-position: -816px -79px; width: 16px; height: 16px; }', N'.pic_442 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (454, N'.pic_443 {background-position: -832px -79px; width: 16px; height: 16px; }', N'.pic_443 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (455, N'.pic_444 {background-position: -848px -79px; width: 16px; height: 16px; }', N'.pic_444 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (456, N'.pic_445 {background-position: -864px -79px; width: 16px; height: 16px; }', N'.pic_445 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (457, N'.pic_446 {background-position: -880px -79px; width: 16px; height: 16px; }', N'.pic_446 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (458, N'.pic_447 {background-position: -896px -79px; width: 16px; height: 16px; }', N'.pic_447 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (459, N'.pic_448 {background-position: -912px -79px; width: 16px; height: 16px; }', N'.pic_448 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (460, N'.pic_449 {background-position: -928px -79px; width: 16px; height: 16px; }', N'.pic_449 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (461, N'.pic_450 {background-position: -944px -79px; width: 16px; height: 16px; }', N'.pic_450 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (462, N'.pic_451 {background-position: -960px -79px; width: 16px; height: 16px; }', N'.pic_451 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (463, N'.pic_452 {background-position: -976px -79px; width: 16px; height: 16px; }', N'.pic_452 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (464, N'.pic_453 {background-position: -992px -79px; width: 16px; height: 16px; }', N'.pic_453 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (465, N'.pic_454 {background-position: -1008px -79px; width: 16px; height: 16px; }', N'.pic_454 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (466, N'.pic_455 {background-position: -1024px -79px; width: 16px; height: 16px; }', N'.pic_455 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (467, N'.pic_456 {background-position: -1040px -79px; width: 16px; height: 16px; }', N'.pic_456 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (468, N'.pic_457 {background-position: -1056px -79px; width: 16px; height: 16px; }', N'.pic_457 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (469, N'.pic_458 {background-position: -1072px -79px; width: 16px; height: 16px; }', N'.pic_458 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (470, N'.pic_459 {background-position: -1088px -79px; width: 16px; height: 16px; }', N'.pic_459 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (471, N'.pic_460 {background-position: -1104px -79px; width: 16px; height: 16px; }', N'.pic_460 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (472, N'.pic_461 {background-position: -1120px -79px; width: 16px; height: 16px; }', N'.pic_461 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (473, N'.pic_462 {background-position: -1136px -79px; width: 16px; height: 16px; }', N'.pic_462 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (474, N'.pic_463 {background-position: -1152px -79px; width: 16px; height: 16px; }', N'.pic_463 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (475, N'.pic_464 {background-position: -1168px -79px; width: 16px; height: 16px; }', N'.pic_464 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (476, N'.pic_465 {background-position: -1184px -79px; width: 16px; height: 16px; }', N'.pic_465 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (477, N'.pic_466 {background-position: -1200px -79px; width: 16px; height: 16px; }', N'.pic_466 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (478, N'.pic_467 {background-position: -1216px -79px; width: 16px; height: 16px; }', N'.pic_467 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (479, N'.pic_468 {background-position: -1232px -79px; width: 16px; height: 16px; }', N'.pic_468 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (480, N'.pic_469 {background-position: -0px -95px; width: 16px; height: 16px; }', N'.pic_469 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (481, N'.pic_470 {background-position: -16px -95px; width: 16px; height: 16px; }', N'.pic_470 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (482, N'.pic_471 {background-position: -32px -95px; width: 16px; height: 16px; }', N'.pic_471 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (483, N'.pic_472 {background-position: -48px -95px; width: 16px; height: 16px; }', N'.pic_472 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (484, N'.pic_473 {background-position: -64px -95px; width: 16px; height: 16px; }', N'.pic_473 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (485, N'.pic_474 {background-position: -80px -95px; width: 16px; height: 16px; }', N'.pic_474 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (486, N'.pic_475 {background-position: -96px -95px; width: 16px; height: 16px; }', N'.pic_475 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (487, N'.pic_476 {background-position: -112px -95px; width: 16px; height: 16px; }', N'.pic_476 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (488, N'.pic_477 {background-position: -128px -95px; width: 16px; height: 16px; }', N'.pic_477 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (489, N'.pic_478 {background-position: -144px -95px; width: 16px; height: 16px; }', N'.pic_478 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (490, N'.pic_479 {background-position: -160px -95px; width: 16px; height: 16px; }', N'.pic_479 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (491, N'.pic_480 {background-position: -176px -95px; width: 16px; height: 16px; }', N'.pic_480 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (492, N'.pic_481 {background-position: -192px -95px; width: 16px; height: 16px; }', N'.pic_481 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (493, N'.pic_482 {background-position: -208px -95px; width: 16px; height: 16px; }', N'.pic_482 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (494, N'.pic_483 {background-position: -224px -95px; width: 16px; height: 16px; }', N'.pic_483 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (495, N'.pic_484 {background-position: -240px -95px; width: 16px; height: 16px; }', N'.pic_484 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (496, N'.pic_485 {background-position: -256px -95px; width: 16px; height: 16px; }', N'.pic_485 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (497, N'.pic_486 {background-position: -272px -95px; width: 16px; height: 16px; }', N'.pic_486 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (498, N'.pic_487 {background-position: -288px -95px; width: 16px; height: 16px; }', N'.pic_487 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (499, N'.pic_488 {background-position: -304px -95px; width: 16px; height: 16px; }', N'.pic_488 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (500, N'.pic_489 {background-position: -320px -95px; width: 16px; height: 16px; }', N'.pic_489 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (501, N'.pic_490 {background-position: -336px -95px; width: 16px; height: 16px; }', N'.pic_490 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (502, N'.pic_491 {background-position: -352px -95px; width: 16px; height: 16px; }', N'.pic_491 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (503, N'.pic_492 {background-position: -368px -95px; width: 16px; height: 16px; }', N'.pic_492 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (504, N'.pic_493 {background-position: -384px -95px; width: 16px; height: 16px; }', N'.pic_493 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (505, N'.pic_494 {background-position: -400px -95px; width: 16px; height: 16px; }', N'.pic_494 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (506, N'.pic_495 {background-position: -416px -95px; width: 16px; height: 16px; }', N'.pic_495 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (507, N'.pic_496 {background-position: -432px -95px; width: 16px; height: 16px; }', N'.pic_496 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (508, N'.pic_497 {background-position: -448px -95px; width: 16px; height: 16px; }', N'.pic_497 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (509, N'.pic_498 {background-position: -464px -95px; width: 16px; height: 16px; }', N'.pic_498 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (510, N'.pic_499 {background-position: -480px -95px; width: 16px; height: 16px; }', N'.pic_499 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (511, N'.pic_500 {background-position: -496px -95px; width: 16px; height: 16px; }', N'.pic_500 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (512, N'.pic_501 {background-position: -512px -95px; width: 16px; height: 16px; }', N'.pic_501 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (513, N'.pic_502 {background-position: -528px -95px; width: 16px; height: 16px; }', N'.pic_502 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (514, N'.pic_503 {background-position: -544px -95px; width: 16px; height: 16px; }', N'.pic_503 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (515, N'.pic_504 {background-position: -560px -95px; width: 16px; height: 16px; }', N'.pic_504 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (516, N'.pic_505 {background-position: -576px -95px; width: 16px; height: 16px; }', N'.pic_505 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (517, N'.pic_506 {background-position: -592px -95px; width: 16px; height: 16px; }', N'.pic_506 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (518, N'.pic_507 {background-position: -608px -95px; width: 16px; height: 16px; }', N'.pic_507 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (519, N'.pic_508 {background-position: -624px -95px; width: 16px; height: 16px; }', N'.pic_508 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (520, N'.pic_509 {background-position: -640px -95px; width: 16px; height: 16px; }', N'.pic_509 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (521, N'.pic_510 {background-position: -656px -95px; width: 16px; height: 16px; }', N'.pic_510 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (522, N'.pic_511 {background-position: -672px -95px; width: 16px; height: 16px; }', N'.pic_511 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (523, N'.pic_512 {background-position: -688px -95px; width: 16px; height: 16px; }', N'.pic_512 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (524, N'.pic_513 {background-position: -704px -95px; width: 16px; height: 16px; }', N'.pic_513 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (525, N'.pic_514 {background-position: -720px -95px; width: 16px; height: 16px; }', N'.pic_514 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (526, N'.pic_515 {background-position: -736px -95px; width: 16px; height: 16px; }', N'.pic_515 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (527, N'.pic_516 {background-position: -752px -95px; width: 16px; height: 16px; }', N'.pic_516 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (528, N'.pic_517 {background-position: -768px -95px; width: 16px; height: 16px; }', N'.pic_517 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (529, N'.pic_518 {background-position: -784px -95px; width: 16px; height: 16px; }', N'.pic_518 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (530, N'.pic_519 {background-position: -800px -95px; width: 16px; height: 16px; }', N'.pic_519 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (531, N'.pic_520 {background-position: -816px -95px; width: 16px; height: 16px; }', N'.pic_520 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (532, N'.pic_521 {background-position: -832px -95px; width: 16px; height: 16px; }', N'.pic_521 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (533, N'.pic_522 {background-position: -848px -95px; width: 16px; height: 16px; }', N'.pic_522 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (534, N'.pic_523 {background-position: -864px -95px; width: 16px; height: 16px; }', N'.pic_523 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (535, N'.pic_524 {background-position: -880px -95px; width: 16px; height: 16px; }', N'.pic_524 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (536, N'.pic_525 {background-position: -896px -95px; width: 16px; height: 16px; }', N'.pic_525 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (537, N'.pic_526 {background-position: -912px -95px; width: 16px; height: 16px; }', N'.pic_526 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (538, N'.pic_527 {background-position: -928px -95px; width: 16px; height: 16px; }', N'.pic_527 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (539, N'.pic_528 {background-position: -944px -95px; width: 16px; height: 16px; }', N'.pic_528 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (540, N'.pic_529 {background-position: -960px -95px; width: 16px; height: 16px; }', N'.pic_529 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (541, N'.pic_530 {background-position: -976px -95px; width: 16px; height: 16px; }', N'.pic_530 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (542, N'.pic_531 {background-position: -992px -95px; width: 16px; height: 16px; }', N'.pic_531 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (543, N'.pic_532 {background-position: -1008px -95px; width: 16px; height: 16px; }', N'.pic_532 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (544, N'.pic_533 {background-position: -1024px -95px; width: 16px; height: 16px; }', N'.pic_533 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (545, N'.pic_534 {background-position: -1040px -95px; width: 16px; height: 16px; }', N'.pic_534 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (546, N'.pic_535 {background-position: -1056px -95px; width: 16px; height: 16px; }', N'.pic_535 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (547, N'.pic_536 {background-position: -1072px -95px; width: 14px; height: 14px; }', N'.pic_536 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (548, N'.pic_537 {background-position: -1086px -95px; width: 16px; height: 16px; }', N'.pic_537 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (549, N'.pic_538 {background-position: -1102px -95px; width: 16px; height: 16px; }', N'.pic_538 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (550, N'.pic_539 {background-position: -1118px -95px; width: 16px; height: 16px; }', N'.pic_539 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (551, N'.pic_540 {background-position: -1134px -95px; width: 16px; height: 16px; }', N'.pic_540 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (552, N'.pic_541 {background-position: -1150px -95px; width: 16px; height: 16px; }', N'.pic_541 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (553, N'.pic_542 {background-position: -1166px -95px; width: 16px; height: 16px; }', N'.pic_542 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (554, N'.pic_543 {background-position: -1182px -95px; width: 16px; height: 16px; }', N'.pic_543 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (555, N'.pic_544 {background-position: -1198px -95px; width: 16px; height: 16px; }', N'.pic_544 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (556, N'.pic_545 {background-position: -1214px -95px; width: 16px; height: 16px; }', N'.pic_545 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (557, N'.pic_546 {background-position: -1230px -95px; width: 16px; height: 16px; }', N'.pic_546 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (558, N'.pic_547 {background-position: -0px -111px; width: 16px; height: 16px; }', N'.pic_547 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (559, N'.pic_548 {background-position: -16px -111px; width: 16px; height: 16px; }', N'.pic_548 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (560, N'.pic_549 {background-position: -32px -111px; width: 16px; height: 16px; }', N'.pic_549 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (561, N'.pic_550 {background-position: -48px -111px; width: 16px; height: 16px; }', N'.pic_550 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (562, N'.pic_551 {background-position: -64px -111px; width: 16px; height: 16px; }', N'.pic_551 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (563, N'.pic_552 {background-position: -80px -111px; width: 16px; height: 16px; }', N'.pic_552 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (564, N'.pic_553 {background-position: -96px -111px; width: 16px; height: 16px; }', N'.pic_553 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (565, N'.pic_554 {background-position: -112px -111px; width: 16px; height: 16px; }', N'.pic_554 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (566, N'.pic_555 {background-position: -128px -111px; width: 16px; height: 16px; }', N'.pic_555 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (567, N'.pic_556 {background-position: -144px -111px; width: 16px; height: 16px; }', N'.pic_556 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (568, N'.pic_557 {background-position: -160px -111px; width: 16px; height: 16px; }', N'.pic_557 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (569, N'.pic_558 {background-position: -176px -111px; width: 16px; height: 16px; }', N'.pic_558 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (570, N'.pic_559 {background-position: -192px -111px; width: 16px; height: 16px; }', N'.pic_559 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (571, N'.pic_560 {background-position: -208px -111px; width: 16px; height: 16px; }', N'.pic_560 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (572, N'.pic_561 {background-position: -224px -111px; width: 16px; height: 16px; }', N'.pic_561 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (573, N'.pic_562 {background-position: -240px -111px; width: 16px; height: 16px; }', N'.pic_562 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (574, N'.pic_563 {background-position: -256px -111px; width: 16px; height: 16px; }', N'.pic_563 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (575, N'.pic_564 {background-position: -272px -111px; width: 16px; height: 16px; }', N'.pic_564 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (576, N'.pic_565 {background-position: -288px -111px; width: 16px; height: 16px; }', N'.pic_565 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (577, N'.pic_566 {background-position: -304px -111px; width: 16px; height: 16px; }', N'.pic_566 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (578, N'.pic_567 {background-position: -320px -111px; width: 16px; height: 16px; }', N'.pic_567 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (579, N'.pic_568 {background-position: -336px -111px; width: 16px; height: 16px; }', N'.pic_568 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (580, N'.pic_569 {background-position: -352px -111px; width: 16px; height: 16px; }', N'.pic_569 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (581, N'.pic_570 {background-position: -368px -111px; width: 16px; height: 16px; }', N'.pic_570 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (582, N'.pic_571 {background-position: -384px -111px; width: 16px; height: 16px; }', N'.pic_571 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (583, N'.pic_572 {background-position: -400px -111px; width: 16px; height: 16px; }', N'.pic_572 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (584, N'.pic_573 {background-position: -416px -111px; width: 16px; height: 16px; }', N'.pic_573 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (585, N'.pic_574 {background-position: -432px -111px; width: 16px; height: 16px; }', N'.pic_574 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (586, N'.pic_575 {background-position: -448px -111px; width: 16px; height: 16px; }', N'.pic_575 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (587, N'.pic_576 {background-position: -464px -111px; width: 16px; height: 16px; }', N'.pic_576 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (588, N'.pic_577 {background-position: -480px -111px; width: 16px; height: 16px; }', N'.pic_577 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (589, N'.pic_578 {background-position: -496px -111px; width: 16px; height: 16px; }', N'.pic_578 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (590, N'.pic_579 {background-position: -512px -111px; width: 16px; height: 16px; }', N'.pic_579 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (591, N'.pic_580 {background-position: -528px -111px; width: 16px; height: 16px; }', N'.pic_580 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (592, N'.pic_581 {background-position: -544px -111px; width: 16px; height: 16px; }', N'.pic_581 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (593, N'.pic_582 {background-position: -560px -111px; width: 16px; height: 16px; }', N'.pic_582 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (594, N'.pic_583 {background-position: -576px -111px; width: 16px; height: 16px; }', N'.pic_583 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (595, N'.pic_584 {background-position: -592px -111px; width: 16px; height: 16px; }', N'.pic_584 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (596, N'.pic_585 {background-position: -608px -111px; width: 16px; height: 16px; }', N'.pic_585 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (597, N'.pic_586 {background-position: -624px -111px; width: 16px; height: 16px; }', N'.pic_586 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (598, N'.pic_587 {background-position: -640px -111px; width: 16px; height: 16px; }', N'.pic_587 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (599, N'.pic_588 {background-position: -656px -111px; width: 16px; height: 16px; }', N'.pic_588 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (600, N'.pic_589 {background-position: -672px -111px; width: 16px; height: 16px; }', N'.pic_589 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (601, N'.pic_590 {background-position: -688px -111px; width: 16px; height: 16px; }', N'.pic_590 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (602, N'.pic_591 {background-position: -704px -111px; width: 16px; height: 16px; }', N'.pic_591 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (603, N'.pic_592 {background-position: -720px -111px; width: 16px; height: 16px; }', N'.pic_592 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (604, N'.pic_593 {background-position: -736px -111px; width: 16px; height: 16px; }', N'.pic_593 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (605, N'.pic_594 {background-position: -752px -111px; width: 16px; height: 16px; }', N'.pic_594 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (606, N'.pic_595 {background-position: -768px -111px; width: 16px; height: 16px; }', N'.pic_595 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (607, N'.pic_596 {background-position: -784px -111px; width: 16px; height: 16px; }', N'.pic_596 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (608, N'.pic_597 {background-position: -800px -111px; width: 16px; height: 16px; }', N'.pic_597 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (609, N'.pic_598 {background-position: -816px -111px; width: 16px; height: 16px; }', N'.pic_598 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (610, N'.pic_599 {background-position: -832px -111px; width: 16px; height: 16px; }', N'.pic_599 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (611, N'.pic_600 {background-position: -848px -111px; width: 16px; height: 16px; }', N'.pic_600 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (612, N'.pic_601 {background-position: -864px -111px; width: 16px; height: 16px; }', N'.pic_601 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (613, N'.pic_602 {background-position: -880px -111px; width: 16px; height: 16px; }', N'.pic_602 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (614, N'.pic_603 {background-position: -896px -111px; width: 16px; height: 16px; }', N'.pic_603 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (615, N'.pic_604 {background-position: -912px -111px; width: 16px; height: 16px; }', N'.pic_604 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (616, N'.pic_605 {background-position: -928px -111px; width: 16px; height: 16px; }', N'.pic_605 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (617, N'.pic_606 {background-position: -944px -111px; width: 16px; height: 16px; }', N'.pic_606 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (618, N'.pic_607 {background-position: -960px -111px; width: 16px; height: 16px; }', N'.pic_607 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (619, N'.pic_608 {background-position: -976px -111px; width: 16px; height: 16px; }', N'.pic_608 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (620, N'.pic_609 {background-position: -992px -111px; width: 16px; height: 16px; }', N'.pic_609 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (621, N'.pic_610 {background-position: -1008px -111px; width: 16px; height: 16px; }', N'.pic_610 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (622, N'.pic_611 {background-position: -1024px -111px; width: 16px; height: 16px; }', N'.pic_611 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (623, N'.pic_612 {background-position: -1040px -111px; width: 16px; height: 16px; }', N'.pic_612 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (624, N'.pic_613 {background-position: -1056px -111px; width: 16px; height: 16px; }', N'.pic_613 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (625, N'.pic_614 {background-position: -1072px -111px; width: 16px; height: 16px; }', N'.pic_614 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (626, N'.pic_615 {background-position: -1088px -111px; width: 16px; height: 16px; }', N'.pic_615 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (627, N'.pic_616 {background-position: -1104px -111px; width: 16px; height: 16px; }', N'.pic_616 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (628, N'.pic_617 {background-position: -1120px -111px; width: 16px; height: 16px; }', N'.pic_617 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (629, N'.pic_618 {background-position: -1136px -111px; width: 16px; height: 16px; }', N'.pic_618 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (630, N'.pic_619 {background-position: -1152px -111px; width: 16px; height: 16px; }', N'.pic_619 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (631, N'.pic_620 {background-position: -1168px -111px; width: 16px; height: 16px; }', N'.pic_620 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (632, N'.pic_621 {background-position: -1184px -111px; width: 16px; height: 16px; }', N'.pic_621 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (633, N'.pic_622 {background-position: -1200px -111px; width: 16px; height: 16px; }', N'.pic_622 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (634, N'.pic_623 {background-position: -1216px -111px; width: 16px; height: 16px; }', N'.pic_623 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (635, N'.pic_624 {background-position: -1232px -111px; width: 16px; height: 16px; }', N'.pic_624 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (636, N'.pic_625 {background-position: -0px -127px; width: 16px; height: 16px; }', N'.pic_625 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (637, N'.pic_626 {background-position: -16px -127px; width: 16px; height: 16px; }', N'.pic_626 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (638, N'.pic_627 {background-position: -32px -127px; width: 16px; height: 16px; }', N'.pic_627 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (639, N'.pic_628 {background-position: -48px -127px; width: 16px; height: 16px; }', N'.pic_628 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (640, N'.pic_629 {background-position: -64px -127px; width: 16px; height: 16px; }', N'.pic_629 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (641, N'.pic_630 {background-position: -80px -127px; width: 16px; height: 16px; }', N'.pic_630 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (642, N'.pic_631 {background-position: -96px -127px; width: 16px; height: 16px; }', N'.pic_631 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (643, N'.pic_632 {background-position: -112px -127px; width: 16px; height: 16px; }', N'.pic_632 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (644, N'.pic_633 {background-position: -128px -127px; width: 16px; height: 16px; }', N'.pic_633 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (645, N'.pic_634 {background-position: -144px -127px; width: 16px; height: 16px; }', N'.pic_634 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (646, N'.pic_635 {background-position: -160px -127px; width: 16px; height: 16px; }', N'.pic_635 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (647, N'.pic_636 {background-position: -176px -127px; width: 16px; height: 16px; }', N'.pic_636 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (648, N'.pic_637 {background-position: -192px -127px; width: 16px; height: 16px; }', N'.pic_637 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (649, N'.pic_638 {background-position: -208px -127px; width: 16px; height: 16px; }', N'.pic_638 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (650, N'.pic_639 {background-position: -224px -127px; width: 16px; height: 16px; }', N'.pic_639 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (651, N'.pic_640 {background-position: -240px -127px; width: 16px; height: 16px; }', N'.pic_640 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (652, N'.pic_641 {background-position: -256px -127px; width: 16px; height: 16px; }', N'.pic_641 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (653, N'.pic_642 {background-position: -272px -127px; width: 16px; height: 16px; }', N'.pic_642 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (654, N'.pic_643 {background-position: -288px -127px; width: 16px; height: 16px; }', N'.pic_643 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (655, N'.pic_644 {background-position: -304px -127px; width: 16px; height: 16px; }', N'.pic_644 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (656, N'.pic_645 {background-position: -320px -127px; width: 16px; height: 16px; }', N'.pic_645 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (657, N'.pic_646 {background-position: -336px -127px; width: 16px; height: 16px; }', N'.pic_646 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (658, N'.pic_647 {background-position: -352px -127px; width: 16px; height: 16px; }', N'.pic_647 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (659, N'.pic_648 {background-position: -368px -127px; width: 16px; height: 16px; }', N'.pic_648 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (660, N'.pic_649 {background-position: -384px -127px; width: 16px; height: 16px; }', N'.pic_649 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (661, N'.pic_650 {background-position: -400px -127px; width: 16px; height: 16px; }', N'.pic_650 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (662, N'.pic_651 {background-position: -416px -127px; width: 16px; height: 16px; }', N'.pic_651 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (663, N'.pic_652 {background-position: -432px -127px; width: 16px; height: 16px; }', N'.pic_652 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (664, N'.pic_653 {background-position: -448px -127px; width: 16px; height: 16px; }', N'.pic_653 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (665, N'.pic_654 {background-position: -464px -127px; width: 16px; height: 16px; }', N'.pic_654 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (666, N'.pic_655 {background-position: -480px -127px; width: 16px; height: 16px; }', N'.pic_655 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (667, N'.pic_656 {background-position: -496px -127px; width: 16px; height: 16px; }', N'.pic_656 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (668, N'.pic_657 {background-position: -512px -127px; width: 16px; height: 16px; }', N'.pic_657 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (669, N'.pic_658 {background-position: -528px -127px; width: 16px; height: 16px; }', N'.pic_658 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (670, N'.pic_659 {background-position: -544px -127px; width: 16px; height: 16px; }', N'.pic_659 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (671, N'.pic_660 {background-position: -560px -127px; width: 16px; height: 16px; }', N'.pic_660 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (672, N'.pic_661 {background-position: -576px -127px; width: 16px; height: 16px; }', N'.pic_661 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (673, N'.pic_662 {background-position: -592px -127px; width: 16px; height: 16px; }', N'.pic_662 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (674, N'.pic_663 {background-position: -608px -127px; width: 16px; height: 16px; }', N'.pic_663 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (675, N'.pic_664 {background-position: -624px -127px; width: 16px; height: 16px; }', N'.pic_664 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (676, N'.pic_665 {background-position: -640px -127px; width: 16px; height: 16px; }', N'.pic_665 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (677, N'.pic_666 {background-position: -656px -127px; width: 16px; height: 16px; }', N'.pic_666 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (678, N'.pic_667 {background-position: -672px -127px; width: 16px; height: 16px; }', N'.pic_667 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (679, N'.pic_668 {background-position: -688px -127px; width: 16px; height: 16px; }', N'.pic_668 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (680, N'.pic_669 {background-position: -704px -127px; width: 16px; height: 16px; }', N'.pic_669 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (681, N'.pic_670 {background-position: -720px -127px; width: 16px; height: 16px; }', N'.pic_670 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (682, N'.pic_671 {background-position: -736px -127px; width: 16px; height: 16px; }', N'.pic_671 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (683, N'.pic_672 {background-position: -752px -127px; width: 16px; height: 16px; }', N'.pic_672 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (684, N'.pic_673 {background-position: -768px -127px; width: 16px; height: 16px; }', N'.pic_673 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (685, N'.pic_674 {background-position: -784px -127px; width: 16px; height: 16px; }', N'.pic_674 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (686, N'.pic_675 {background-position: -800px -127px; width: 16px; height: 16px; }', N'.pic_675 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (687, N'.pic_676 {background-position: -816px -127px; width: 16px; height: 16px; }', N'.pic_676 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (688, N'.pic_677 {background-position: -832px -127px; width: 16px; height: 16px; }', N'.pic_677 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (689, N'.pic_678 {background-position: -848px -127px; width: 16px; height: 16px; }', N'.pic_678 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (690, N'.pic_679 {background-position: -864px -127px; width: 16px; height: 16px; }', N'.pic_679 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (691, N'.pic_680 {background-position: -880px -127px; width: 16px; height: 16px; }', N'.pic_680 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (692, N'.pic_681 {background-position: -896px -127px; width: 16px; height: 16px; }', N'.pic_681 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (693, N'.pic_682 {background-position: -912px -127px; width: 16px; height: 16px; }', N'.pic_682 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (694, N'.pic_683 {background-position: -928px -127px; width: 16px; height: 16px; }', N'.pic_683 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (695, N'.pic_684 {background-position: -944px -127px; width: 16px; height: 16px; }', N'.pic_684 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (696, N'.pic_685 {background-position: -960px -127px; width: 16px; height: 16px; }', N'.pic_685 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (697, N'.pic_686 {background-position: -976px -127px; width: 16px; height: 16px; }', N'.pic_686 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (698, N'.pic_687 {background-position: -992px -127px; width: 16px; height: 16px; }', N'.pic_687 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (699, N'.pic_688 {background-position: -1008px -127px; width: 16px; height: 16px; }', N'.pic_688 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (700, N'.pic_689 {background-position: -1024px -127px; width: 16px; height: 16px; }', N'.pic_689 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (701, N'.pic_690 {background-position: -1040px -127px; width: 16px; height: 16px; }', N'.pic_690 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (702, N'.pic_691 {background-position: -1056px -127px; width: 16px; height: 16px; }', N'.pic_691 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (703, N'.pic_692 {background-position: -1072px -127px; width: 16px; height: 16px; }', N'.pic_692 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (704, N'.pic_693 {background-position: -1088px -127px; width: 16px; height: 16px; }', N'.pic_693 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (705, N'.pic_694 {background-position: -1104px -127px; width: 16px; height: 16px; }', N'.pic_694 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (706, N'.pic_695 {background-position: -1120px -127px; width: 16px; height: 16px; }', N'.pic_695 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (707, N'.pic_696 {background-position: -1136px -127px; width: 16px; height: 16px; }', N'.pic_696 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (708, N'.pic_697 {background-position: -1152px -127px; width: 16px; height: 16px; }', N'.pic_697 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (709, N'.pic_698 {background-position: -1168px -127px; width: 16px; height: 16px; }', N'.pic_698 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (710, N'.pic_699 {background-position: -1184px -127px; width: 16px; height: 16px; }', N'.pic_699 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (711, N'.pic_700 {background-position: -1200px -127px; width: 16px; height: 16px; }', N'.pic_700 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (712, N'.pic_701 {background-position: -1216px -127px; width: 16px; height: 16px; }', N'.pic_701 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (713, N'.pic_702 {background-position: -1232px -127px; width: 16px; height: 16px; }', N'.pic_702 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (714, N'.pic_704 {background-position: -32px -143px; width: 16px; height: 16px; }', N'.pic_704 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (715, N'.pic_705 {background-position: -48px -143px; width: 16px; height: 16px; }', N'.pic_705 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (716, N'.pic_706 {background-position: -64px -143px; width: 16px; height: 16px; }', N'.pic_706 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (717, N'.pic_707 {background-position: -80px -143px; width: 16px; height: 16px; }', N'.pic_707 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (718, N'.pic_708 {background-position: -96px -143px; width: 16px; height: 16px; }', N'.pic_708 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (719, N'.pic_709 {background-position: -112px -143px; width: 16px; height: 16px; }', N'.pic_709 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (720, N'.pic_710 {background-position: -128px -143px; width: 16px; height: 16px; }', N'.pic_710 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (721, N'.pic_711 {background-position: -144px -143px; width: 16px; height: 16px; }', N'.pic_711 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (722, N'.pic_712 {background-position: -160px -143px; width: 16px; height: 16px; }', N'.pic_712 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (723, N'.pic_713 {background-position: -176px -143px; width: 16px; height: 16px; }', N'.pic_713 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (724, N'.pic_714 {background-position: -192px -143px; width: 16px; height: 16px; }', N'.pic_714 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (725, N'.pic_715 {background-position: -208px -143px; width: 16px; height: 16px; }', N'.pic_715 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (726, N'.pic_716 {background-position: -224px -143px; width: 16px; height: 16px; }', N'.pic_716 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (727, N'.pic_717 {background-position: -240px -143px; width: 16px; height: 16px; }', N'.pic_717 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (728, N'.pic_718 {background-position: -256px -143px; width: 16px; height: 16px; }', N'.pic_718 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (729, N'.pic_719 {background-position: -272px -143px; width: 16px; height: 16px; }', N'.pic_719 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (730, N'.pic_720 {background-position: -288px -143px; width: 16px; height: 16px; }', N'.pic_720 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (731, N'.pic_721 {background-position: -304px -143px; width: 16px; height: 16px; }', N'.pic_721 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (732, N'.pic_722 {background-position: -320px -143px; width: 16px; height: 16px; }', N'.pic_722 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (733, N'.pic_723 {background-position: -336px -143px; width: 16px; height: 16px; }', N'.pic_723 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (734, N'.pic_724 {background-position: -352px -143px; width: 16px; height: 16px; }', N'.pic_724 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (735, N'.pic_725 {background-position: -368px -143px; width: 16px; height: 16px; }', N'.pic_725 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (736, N'.pic_726 {background-position: -384px -143px; width: 16px; height: 16px; }', N'.pic_726 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (737, N'.pic_727 {background-position: -400px -143px; width: 16px; height: 16px; }', N'.pic_727 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (738, N'.pic_728 {background-position: -416px -143px; width: 16px; height: 16px; }', N'.pic_728 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (739, N'.pic_729 {background-position: -432px -143px; width: 16px; height: 16px; }', N'.pic_729 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (740, N'.pic_730 {background-position: -448px -143px; width: 16px; height: 16px; }', N'.pic_730 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (741, N'.pic_731 {background-position: -464px -143px; width: 16px; height: 16px; }', N'.pic_731 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (742, N'.pic_732 {background-position: -480px -143px; width: 16px; height: 16px; }', N'.pic_732 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (743, N'.pic_733 {background-position: -496px -143px; width: 16px; height: 16px; }', N'.pic_733 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (744, N'.pic_734 {background-position: -512px -143px; width: 16px; height: 16px; }', N'.pic_734 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (745, N'.pic_735 {background-position: -528px -143px; width: 16px; height: 16px; }', N'.pic_735 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (746, N'.pic_736 {background-position: -544px -143px; width: 16px; height: 16px; }', N'.pic_736 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (747, N'.pic_737 {background-position: -560px -143px; width: 16px; height: 16px; }', N'.pic_737 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (748, N'.pic_738 {background-position: -576px -143px; width: 16px; height: 16px; }', N'.pic_738 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (749, N'.pic_739 {background-position: -592px -143px; width: 16px; height: 16px; }', N'.pic_739 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (750, N'.pic_740 {background-position: -608px -143px; width: 16px; height: 16px; }', N'.pic_740 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (751, N'.pic_741 {background-position: -624px -143px; width: 16px; height: 16px; }', N'.pic_741 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (752, N'.pic_742 {background-position: -640px -143px; width: 16px; height: 16px; }', N'.pic_742 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (753, N'.pic_743 {background-position: -656px -143px; width: 16px; height: 16px; }', N'.pic_743 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (754, N'.pic_744 {background-position: -672px -143px; width: 16px; height: 16px; }', N'.pic_744 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (755, N'.pic_745 {background-position: -688px -143px; width: 16px; height: 16px; }', N'.pic_745 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (756, N'.pic_746 {background-position: -704px -143px; width: 16px; height: 16px; }', N'.pic_746 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (757, N'.pic_747 {background-position: -720px -143px; width: 16px; height: 16px; }', N'.pic_747 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (758, N'.pic_748 {background-position: -736px -143px; width: 16px; height: 16px; }', N'.pic_748 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (759, N'.pic_749 {background-position: -752px -143px; width: 16px; height: 16px; }', N'.pic_749 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (760, N'.pic_750 {background-position: -768px -143px; width: 16px; height: 16px; }', N'.pic_750 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (761, N'.pic_751 {background-position: -784px -143px; width: 16px; height: 16px; }', N'.pic_751 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (762, N'.pic_752 {background-position: -800px -143px; width: 16px; height: 16px; }', N'.pic_752 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (763, N'.pic_753 {background-position: -816px -143px; width: 16px; height: 16px; }', N'.pic_753 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (764, N'.pic_754 {background-position: -832px -143px; width: 16px; height: 16px; }', N'.pic_754 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (765, N'.pic_755 {background-position: -848px -143px; width: 16px; height: 16px; }', N'.pic_755 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (766, N'.pic_756 {background-position: -864px -143px; width: 16px; height: 16px; }', N'.pic_756 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (767, N'.pic_757 {background-position: -880px -143px; width: 16px; height: 16px; }', N'.pic_757 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (768, N'.pic_758 {background-position: -896px -143px; width: 16px; height: 16px; }', N'.pic_758 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (769, N'.pic_759 {background-position: -912px -143px; width: 16px; height: 16px; }', N'.pic_759 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (770, N'.pic_760 {background-position: -928px -143px; width: 16px; height: 16px; }', N'.pic_760 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (771, N'.pic_761 {background-position: -944px -143px; width: 16px; height: 16px; }', N'.pic_761 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (772, N'.pic_762 {background-position: -960px -143px; width: 16px; height: 16px; }', N'.pic_762 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (773, N'.pic_763 {background-position: -976px -143px; width: 16px; height: 16px; }', N'.pic_763 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (774, N'.pic_764 {background-position: -992px -143px; width: 16px; height: 16px; }', N'.pic_764 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (775, N'.pic_765 {background-position: -1008px -143px; width: 16px; height: 16px; }', N'.pic_765 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (776, N'.pic_766 {background-position: -1024px -143px; width: 16px; height: 16px; }', N'.pic_766 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (777, N'.pic_767 {background-position: -1040px -143px; width: 16px; height: 16px; }', N'.pic_767 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (778, N'.pic_768 {background-position: -1056px -143px; width: 16px; height: 16px; }', N'.pic_768 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (779, N'.pic_769 {background-position: -1072px -143px; width: 16px; height: 16px; }', N'.pic_769 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (780, N'.pic_770 {background-position: -1088px -143px; width: 16px; height: 16px; }', N'.pic_770 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (781, N'.pic_771 {background-position: -1104px -143px; width: 16px; height: 16px; }', N'.pic_771 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (782, N'.pic_772 {background-position: -1120px -143px; width: 16px; height: 16px; }', N'.pic_772 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (783, N'.pic_773 {background-position: -1136px -143px; width: 16px; height: 16px; }', N'.pic_773 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (784, N'.pic_774 {background-position: -1152px -143px; width: 16px; height: 16px; }', N'.pic_774 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (785, N'.pic_775 {background-position: -1168px -143px; width: 16px; height: 16px; }', N'.pic_775 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (786, N'.pic_776 {background-position: -1184px -143px; width: 16px; height: 16px; }', N'.pic_776 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (787, N'.pic_777 {background-position: -1200px -143px; width: 16px; height: 16px; }', N'.pic_777 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (788, N'.pic_778 {background-position: -1216px -143px; width: 16px; height: 16px; }', N'.pic_778 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (789, N'.pic_779 {background-position: -1232px -143px; width: 16px; height: 16px; }', N'.pic_779 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (790, N'.pic_780 {background-position: -0px -159px; width: 16px; height: 16px; }', N'.pic_780 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (791, N'.pic_781 {background-position: -16px -159px; width: 16px; height: 16px; }', N'.pic_781 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (792, N'.pic_782 {background-position: -32px -159px; width: 16px; height: 16px; }', N'.pic_782 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (793, N'.pic_783 {background-position: -48px -159px; width: 16px; height: 16px; }', N'.pic_783 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (794, N'.pic_784 {background-position: -64px -159px; width: 16px; height: 16px; }', N'.pic_784 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (795, N'.pic_785 {background-position: -80px -159px; width: 16px; height: 16px; }', N'.pic_785 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (796, N'.pic_786 {background-position: -96px -159px; width: 16px; height: 16px; }', N'.pic_786 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (797, N'.pic_787 {background-position: -112px -159px; width: 16px; height: 16px; }', N'.pic_787 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (798, N'.pic_788 {background-position: -128px -159px; width: 16px; height: 16px; }', N'.pic_788 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (799, N'.pic_789 {background-position: -144px -159px; width: 16px; height: 16px; }', N'.pic_789 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (800, N'.pic_790 {background-position: -160px -159px; width: 16px; height: 16px; }', N'.pic_790 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (801, N'.pic_791 {background-position: -176px -159px; width: 16px; height: 16px; }', N'.pic_791 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (802, N'.pic_792 {background-position: -192px -159px; width: 16px; height: 16px; }', N'.pic_792 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (803, N'.pic_793 {background-position: -208px -159px; width: 16px; height: 16px; }', N'.pic_793 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (804, N'.pic_794 {background-position: -224px -159px; width: 16px; height: 16px; }', N'.pic_794 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (805, N'.pic_795 {background-position: -240px -159px; width: 16px; height: 16px; }', N'.pic_795 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (806, N'.pic_796 {background-position: -256px -159px; width: 16px; height: 16px; }', N'.pic_796 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (807, N'.pic_797 {background-position: -272px -159px; width: 16px; height: 16px; }', N'.pic_797 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (808, N'.pic_798 {background-position: -288px -159px; width: 16px; height: 16px; }', N'.pic_798 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (809, N'.pic_799 {background-position: -304px -159px; width: 16px; height: 16px; }', N'.pic_799 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (810, N'.pic_800 {background-position: -320px -159px; width: 16px; height: 16px; }', N'.pic_800 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (811, N'.pic_801 {background-position: -336px -159px; width: 16px; height: 16px; }', N'.pic_801 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (812, N'.pic_802 {background-position: -352px -159px; width: 16px; height: 16px; }', N'.pic_802 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (813, N'.pic_803 {background-position: -368px -159px; width: 16px; height: 16px; }', N'.pic_803 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (814, N'.pic_804 {background-position: -384px -159px; width: 16px; height: 16px; }', N'.pic_804 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (815, N'.pic_805 {background-position: -400px -159px; width: 16px; height: 16px; }', N'.pic_805 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (816, N'.pic_806 {background-position: -416px -159px; width: 16px; height: 16px; }', N'.pic_806 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (817, N'.pic_807 {background-position: -432px -159px; width: 16px; height: 16px; }', N'.pic_807 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (818, N'.pic_808 {background-position: -448px -159px; width: 16px; height: 16px; }', N'.pic_808 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (819, N'.pic_809 {background-position: -464px -159px; width: 16px; height: 16px; }', N'.pic_809 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (820, N'.pic_810 {background-position: -480px -159px; width: 16px; height: 16px; }', N'.pic_810 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (821, N'.pic_811 {background-position: -496px -159px; width: 16px; height: 16px; }', N'.pic_811 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (822, N'.pic_812 {background-position: -512px -159px; width: 16px; height: 16px; }', N'.pic_812 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (823, N'.pic_813 {background-position: -528px -159px; width: 16px; height: 16px; }', N'.pic_813 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (824, N'.pic_814 {background-position: -544px -159px; width: 16px; height: 16px; }', N'.pic_814 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (825, N'.pic_815 {background-position: -560px -159px; width: 16px; height: 16px; }', N'.pic_815 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (826, N'.pic_816 {background-position: -576px -159px; width: 16px; height: 16px; }', N'.pic_816 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (827, N'.pic_817 {background-position: -592px -159px; width: 16px; height: 16px; }', N'.pic_817 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (828, N'.pic_818 {background-position: -608px -159px; width: 16px; height: 16px; }', N'.pic_818 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (829, N'.pic_819 {background-position: -624px -159px; width: 16px; height: 16px; }', N'.pic_819 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (830, N'.pic_820 {background-position: -640px -159px; width: 16px; height: 16px; }', N'.pic_820 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (831, N'.pic_821 {background-position: -656px -159px; width: 16px; height: 16px; }', N'.pic_821 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (832, N'.pic_822 {background-position: -672px -159px; width: 16px; height: 16px; }', N'.pic_822 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (833, N'.pic_823 {background-position: -688px -159px; width: 16px; height: 16px; }', N'.pic_823 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (834, N'.pic_824 {background-position: -704px -159px; width: 16px; height: 16px; }', N'.pic_824 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (835, N'.pic_825 {background-position: -720px -159px; width: 16px; height: 16px; }', N'.pic_825 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (836, N'.pic_826 {background-position: -736px -159px; width: 16px; height: 16px; }', N'.pic_826 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (837, N'.pic_827 {background-position: -752px -159px; width: 16px; height: 16px; }', N'.pic_827 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (838, N'.pic_828 {background-position: -768px -159px; width: 16px; height: 16px; }', N'.pic_828 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (839, N'.pic_829 {background-position: -784px -159px; width: 16px; height: 16px; }', N'.pic_829 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (840, N'.pic_830 {background-position: -800px -159px; width: 16px; height: 16px; }', N'.pic_830 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (841, N'.pic_831 {background-position: -816px -159px; width: 16px; height: 16px; }', N'.pic_831 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (842, N'.pic_832 {background-position: -832px -159px; width: 16px; height: 16px; }', N'.pic_832 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (843, N'.pic_833 {background-position: -848px -159px; width: 16px; height: 16px; }', N'.pic_833 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (844, N'.pic_834 {background-position: -864px -159px; width: 16px; height: 16px; }', N'.pic_834 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (845, N'.pic_835 {background-position: -880px -159px; width: 16px; height: 16px; }', N'.pic_835 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (846, N'.pic_836 {background-position: -896px -159px; width: 16px; height: 16px; }', N'.pic_836 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (847, N'.pic_837 {background-position: -912px -159px; width: 16px; height: 16px; }', N'.pic_837 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (848, N'.pic_838 {background-position: -928px -159px; width: 16px; height: 16px; }', N'.pic_838 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (849, N'.pic_839 {background-position: -944px -159px; width: 16px; height: 16px; }', N'.pic_839 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (850, N'.pic_840 {background-position: -960px -159px; width: 16px; height: 16px; }', N'.pic_840 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (851, N'.pic_841 {background-position: -976px -159px; width: 16px; height: 16px; }', N'.pic_841 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (852, N'.pic_842 {background-position: -992px -159px; width: 16px; height: 16px; }', N'.pic_842 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (853, N'.pic_843 {background-position: -1008px -159px; width: 16px; height: 16px; }', N'.pic_843 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (854, N'.pic_844 {background-position: -1024px -159px; width: 16px; height: 16px; }', N'.pic_844 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (855, N'.pic_845 {background-position: -1040px -159px; width: 16px; height: 16px; }', N'.pic_845 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (856, N'.pic_846 {background-position: -1056px -159px; width: 16px; height: 16px; }', N'.pic_846 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (857, N'.pic_847 {background-position: -1072px -159px; width: 16px; height: 16px; }', N'.pic_847 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (858, N'.pic_848 {background-position: -1088px -159px; width: 16px; height: 16px; }', N'.pic_848 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (859, N'.pic_849 {background-position: -1104px -159px; width: 16px; height: 16px; }', N'.pic_849 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (860, N'.pic_850 {background-position: -1120px -159px; width: 16px; height: 16px; }', N'.pic_850 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (861, N'.pic_851 {background-position: -1136px -159px; width: 16px; height: 16px; }', N'.pic_851 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (862, N'.pic_852 {background-position: -1152px -159px; width: 16px; height: 16px; }', N'.pic_852 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (863, N'.pic_853 {background-position: -1168px -159px; width: 12px; height: 7px; }', N'.pic_853 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (864, N'.pic_854 {background-position: -1180px -159px; width: 6px; height: 7px; }', N'.pic_854 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (865, N'.pic_855 {background-position: -1186px -159px; width: 16px; height: 16px; }', N'.pic_855 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (866, N'.pic_856 {background-position: -1202px -159px; width: 16px; height: 16px; }', N'.pic_856 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (867, N'.pic_857 {background-position: -1218px -159px; width: 16px; height: 16px; }', N'.pic_857 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (868, N'.pic_858 {background-position: -1234px -159px; width: 16px; height: 16px; }', N'.pic_858 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (869, N'.pic_859 {background-position: -0px -175px; width: 16px; height: 16px; }', N'.pic_859 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (870, N'.pic_860 {background-position: -16px -175px; width: 16px; height: 16px; }', N'.pic_860 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (871, N'.pic_861 {background-position: -32px -175px; width: 16px; height: 16px; }', N'.pic_861 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (872, N'.pic_862 {background-position: -48px -175px; width: 16px; height: 16px; }', N'.pic_862 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (873, N'.pic_863 {background-position: -64px -175px; width: 16px; height: 16px; }', N'.pic_863 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (874, N'.pic_864 {background-position: -80px -175px; width: 16px; height: 16px; }', N'.pic_864 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (875, N'.pic_865 {background-position: -96px -175px; width: 16px; height: 16px; }', N'.pic_865 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (876, N'.pic_866 {background-position: -112px -175px; width: 16px; height: 16px; }', N'.pic_866 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (877, N'.pic_867 {background-position: -128px -175px; width: 16px; height: 16px; }', N'.pic_867 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (878, N'.pic_868 {background-position: -144px -175px; width: 16px; height: 16px; }', N'.pic_868 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (879, N'.pic_869 {background-position: -160px -175px; width: 16px; height: 16px; }', N'.pic_869 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (880, N'.pic_870 {background-position: -176px -175px; width: 16px; height: 16px; }', N'.pic_870 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (881, N'.pic_871 {background-position: -192px -175px; width: 16px; height: 16px; }', N'.pic_871 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (882, N'.pic_872 {background-position: -208px -175px; width: 16px; height: 16px; }', N'.pic_872 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (883, N'.pic_873 {background-position: -224px -175px; width: 16px; height: 16px; }', N'.pic_873 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (884, N'.pic_874 {background-position: -240px -175px; width: 16px; height: 16px; }', N'.pic_874 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (885, N'.pic_875 {background-position: -256px -175px; width: 16px; height: 16px; }', N'.pic_875 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (886, N'.pic_876 {background-position: -272px -175px; width: 16px; height: 16px; }', N'.pic_876 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (887, N'.pic_877 {background-position: -288px -175px; width: 16px; height: 16px; }', N'.pic_877 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (888, N'.pic_878 {background-position: -304px -175px; width: 16px; height: 16px; }', N'.pic_878 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (889, N'.pic_879 {background-position: -320px -175px; width: 16px; height: 16px; }', N'.pic_879 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (890, N'.pic_880 {background-position: -336px -175px; width: 16px; height: 16px; }', N'.pic_880 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (891, N'.pic_881 {background-position: -352px -175px; width: 16px; height: 16px; }', N'.pic_881 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (892, N'.pic_882 {background-position: -368px -175px; width: 16px; height: 16px; }', N'.pic_882 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (893, N'.pic_883 {background-position: -384px -175px; width: 16px; height: 16px; }', N'.pic_883 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (894, N'.pic_884 {background-position: -400px -175px; width: 16px; height: 16px; }', N'.pic_884 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (895, N'.pic_885 {background-position: -416px -175px; width: 16px; height: 16px; }', N'.pic_885 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (896, N'.pic_886 {background-position: -432px -175px; width: 16px; height: 16px; }', N'.pic_886 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (897, N'.pic_887 {background-position: -448px -175px; width: 16px; height: 16px; }', N'.pic_887 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (898, N'.pic_888 {background-position: -464px -175px; width: 16px; height: 16px; }', N'.pic_888 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (899, N'.pic_889 {background-position: -480px -175px; width: 16px; height: 16px; }', N'.pic_889 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (900, N'.pic_890 {background-position: -496px -175px; width: 16px; height: 16px; }', N'.pic_890 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (901, N'.pic_891 {background-position: -512px -175px; width: 16px; height: 16px; }', N'.pic_891 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (902, N'.pic_893 {background-position: -560px -175px; width: 16px; height: 16px; }', N'.pic_893 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (903, N'.pic_894 {background-position: -576px -175px; width: 16px; height: 16px; }', N'.pic_894 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (904, N'.pic_895 {background-position: -592px -175px; width: 16px; height: 16px; }', N'.pic_895 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (905, N'.pic_896 {background-position: -608px -175px; width: 16px; height: 16px; }', N'.pic_896 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (906, N'.pic_897 {background-position: -624px -175px; width: 16px; height: 16px; }', N'.pic_897 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (907, N'.pic_898 {background-position: -640px -175px; width: 16px; height: 16px; }', N'.pic_898 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (908, N'.pic_899 {background-position: -656px -175px; width: 16px; height: 16px; }', N'.pic_899 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (909, N'.pic_901 {background-position: -704px -175px; width: 16px; height: 16px; }', N'.pic_901 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (910, N'.pic_902 {background-position: -720px -175px; width: 16px; height: 16px; }', N'.pic_902 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (911, N'.pic_903 {background-position: -736px -175px; width: 16px; height: 16px; }', N'.pic_903 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (912, N'.pic_904 {background-position: -752px -175px; width: 16px; height: 16px; }', N'.pic_904 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (913, N'.pic_905 {background-position: -768px -175px; width: 16px; height: 16px; }', N'.pic_905 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (914, N'.pic_906 {background-position: -784px -175px; width: 16px; height: 16px; }', N'.pic_906 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (915, N'.pic_907 {background-position: -800px -175px; width: 16px; height: 16px; }', N'.pic_907 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (916, N'.pic_908 {background-position: -816px -175px; width: 16px; height: 16px; }', N'.pic_908 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (917, N'.pic_909 {background-position: -832px -175px; width: 16px; height: 16px; }', N'.pic_909 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (918, N'.pic_910 {background-position: -848px -175px; width: 16px; height: 16px; }', N'.pic_910 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (919, N'.pic_911 {background-position: -864px -175px; width: 16px; height: 16px; }', N'.pic_911 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (920, N'.pic_912 {background-position: -880px -175px; width: 16px; height: 16px; }', N'.pic_912 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (921, N'.pic_913 {background-position: -896px -175px; width: 16px; height: 16px; }', N'.pic_913 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (922, N'.pic_914 {background-position: -912px -175px; width: 16px; height: 16px; }', N'.pic_914 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (923, N'.pic_915 {background-position: -928px -175px; width: 16px; height: 16px; }', N'.pic_915 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (924, N'.pic_916 {background-position: -944px -175px; width: 16px; height: 16px; }', N'.pic_916 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (925, N'.pic_917 {background-position: -960px -175px; width: 16px; height: 16px; }', N'.pic_917 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (926, N'.pic_918 {background-position: -976px -175px; width: 16px; height: 16px; }', N'.pic_918 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (927, N'.pic_919 {background-position: -992px -175px; width: 16px; height: 16px; }', N'.pic_919 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (928, N'.pic_920 {background-position: -1008px -175px; width: 16px; height: 16px; }', N'.pic_920 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (929, N'.pic_921 {background-position: -1024px -175px; width: 16px; height: 16px; }', N'.pic_921 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (930, N'.pic_922 {background-position: -1040px -175px; width: 16px; height: 16px; }', N'.pic_922 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (931, N'.pic_923 {background-position: -1056px -175px; width: 16px; height: 16px; }', N'.pic_923 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (932, N'.pic_924 {background-position: -1072px -175px; width: 16px; height: 16px; }', N'.pic_924 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (933, N'.pic_925 {background-position: -1088px -175px; width: 16px; height: 16px; }', N'.pic_925 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (934, N'.pic_926 {background-position: -1104px -175px; width: 16px; height: 16px; }', N'.pic_926 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (935, N'.pic_927 {background-position: -1120px -175px; width: 16px; height: 16px; }', N'.pic_927 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (936, N'.pic_928 {background-position: -1136px -175px; width: 16px; height: 16px; }', N'.pic_928 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (937, N'.pic_929 {background-position: -1152px -175px; width: 16px; height: 16px; }', N'.pic_929 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (938, N'.pic_930 {background-position: -1168px -175px; width: 16px; height: 16px; }', N'.pic_930 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (939, N'.pic_931 {background-position: -1184px -175px; width: 16px; height: 16px; }', N'.pic_931 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (940, N'.pic_932 {background-position: -1200px -175px; width: 16px; height: 16px; }', N'.pic_932 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (941, N'.pic_933 {background-position: -1216px -175px; width: 16px; height: 16px; }', N'.pic_933 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (942, N'.pic_934 {background-position: -1232px -175px; width: 16px; height: 16px; }', N'.pic_934 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (943, N'.pic_935 {background-position: -0px -191px; width: 16px; height: 16px; }', N'.pic_935 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (944, N'.pic_936 {background-position: -16px -191px; width: 16px; height: 16px; }', N'.pic_936 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (945, N'.pic_937 {background-position: -32px -191px; width: 16px; height: 16px; }', N'.pic_937 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (946, N'.pic_938 {background-position: -48px -191px; width: 16px; height: 16px; }', N'.pic_938 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (947, N'.pic_939 {background-position: -64px -191px; width: 16px; height: 16px; }', N'.pic_939 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (948, N'.pic_940 {background-position: -80px -191px; width: 16px; height: 16px; }', N'.pic_940 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (949, N'.pic_941 {background-position: -96px -191px; width: 16px; height: 16px; }', N'.pic_941 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (950, N'.pic_942 {background-position: -112px -191px; width: 16px; height: 16px; }', N'.pic_942 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (951, N'.pic_943 {background-position: -128px -191px; width: 16px; height: 16px; }', N'.pic_943 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (952, N'.pic_944 {background-position: -144px -191px; width: 16px; height: 16px; }', N'.pic_944 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (953, N'.pic_945 {background-position: -160px -191px; width: 16px; height: 16px; }', N'.pic_945 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (954, N'.pic_946 {background-position: -176px -191px; width: 16px; height: 16px; }', N'.pic_946 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (955, N'.pic_947 {background-position: -192px -191px; width: 16px; height: 16px; }', N'.pic_947 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (956, N'.pic_948 {background-position: -208px -191px; width: 16px; height: 16px; }', N'.pic_948 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (957, N'.pic_949 {background-position: -224px -191px; width: 16px; height: 16px; }', N'.pic_949 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (958, N'.pic_950 {background-position: -240px -191px; width: 16px; height: 16px; }', N'.pic_950 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (959, N'.pic_951 {background-position: -256px -191px; width: 16px; height: 16px; }', N'.pic_951 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (960, N'.pic_952 {background-position: -272px -191px; width: 16px; height: 16px; }', N'.pic_952 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (961, N'.pic_953 {background-position: -288px -191px; width: 16px; height: 16px; }', N'.pic_953 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (962, N'.pic_954 {background-position: -304px -191px; width: 16px; height: 16px; }', N'.pic_954 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (963, N'.pic_955 {background-position: -320px -191px; width: 16px; height: 16px; }', N'.pic_955 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (964, N'.pic_956 {background-position: -336px -191px; width: 16px; height: 16px; }', N'.pic_956 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (965, N'.pic_957 {background-position: -352px -191px; width: 16px; height: 16px; }', N'.pic_957 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (966, N'.pic_958 {background-position: -368px -191px; width: 16px; height: 16px; }', N'.pic_958 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (967, N'.pic_959 {background-position: -384px -191px; width: 16px; height: 16px; }', N'.pic_959 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (968, N'.pic_960 {background-position: -400px -191px; width: 16px; height: 16px; }', N'.pic_960 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (969, N'.pic_961 {background-position: -416px -191px; width: 16px; height: 16px; }', N'.pic_961 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (970, N'.pic_962 {background-position: -432px -191px; width: 16px; height: 16px; }', N'.pic_962 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (971, N'.pic_963 {background-position: -448px -191px; width: 16px; height: 16px; }', N'.pic_963 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (972, N'.pic_964 {background-position: -464px -191px; width: 16px; height: 16px; }', N'.pic_964 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (973, N'.pic_965 {background-position: -480px -191px; width: 16px; height: 16px; }', N'.pic_965 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (974, N'.pic_966 {background-position: -496px -191px; width: 16px; height: 16px; }', N'.pic_966 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (975, N'.pic_967 {background-position: -512px -191px; width: 16px; height: 16px; }', N'.pic_967 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (976, N'.pic_968 {background-position: -528px -191px; width: 16px; height: 16px; }', N'.pic_968 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (977, N'.pic_969 {background-position: -544px -191px; width: 16px; height: 16px; }', N'.pic_969 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (978, N'.pic_970 {background-position: -560px -191px; width: 16px; height: 16px; }', N'.pic_970 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (979, N'.pic_971 {background-position: -576px -191px; width: 16px; height: 16px; }', N'.pic_971 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (980, N'.pic_972 {background-position: -592px -191px; width: 16px; height: 16px; }', N'.pic_972 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (981, N'.pic_973 {background-position: -608px -191px; width: 16px; height: 16px; }', N'.pic_973 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (982, N'.pic_974 {background-position: -624px -191px; width: 16px; height: 16px; }', N'.pic_974 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (983, N'.pic_975 {background-position: -640px -191px; width: 16px; height: 16px; }', N'.pic_975 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (984, N'.pic_976 {background-position: -656px -191px; width: 16px; height: 16px; }', N'.pic_976 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (985, N'.pic_977 {background-position: -672px -191px; width: 16px; height: 16px; }', N'.pic_977 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (986, N'.pic_978 {background-position: -688px -191px; width: 16px; height: 16px; }', N'.pic_978 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (987, N'.pic_979 {background-position: -704px -191px; width: 16px; height: 16px; }', N'.pic_979 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (988, N'.pic_980 {background-position: -720px -191px; width: 16px; height: 16px; }', N'.pic_980 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (989, N'.pic_981 {background-position: -736px -191px; width: 16px; height: 16px; }', N'.pic_981 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (990, N'.pic_982 {background-position: -752px -191px; width: 16px; height: 16px; }', N'.pic_982 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (991, N'.pic_983 {background-position: -768px -191px; width: 16px; height: 16px; }', N'.pic_983 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (992, N'.pic_984 {background-position: -784px -191px; width: 16px; height: 16px; }', N'.pic_984 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (993, N'.pic_985 {background-position: -800px -191px; width: 16px; height: 16px; }', N'.pic_985 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (994, N'.pic_986 {background-position: -816px -191px; width: 16px; height: 16px; }', N'.pic_986 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (995, N'.pic_987 {background-position: -832px -191px; width: 16px; height: 16px; }', N'.pic_987 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (996, N'.pic_988 {background-position: -848px -191px; width: 16px; height: 16px; }', N'.pic_988 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (997, N'.pic_989 {background-position: -864px -191px; width: 16px; height: 16px; }', N'.pic_989 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (998, N'.pic_990 {background-position: -880px -191px; width: 16px; height: 16px; }', N'.pic_990 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (999, N'.pic_991 {background-position: -896px -191px; width: 16px; height: 16px; }', N'.pic_991 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1000, N'.pic_992 {background-position: -912px -191px; width: 16px; height: 16px; }', N'.pic_992 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1001, N'.pic_993 {background-position: -928px -191px; width: 16px; height: 16px; }', N'.pic_993 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1002, N'.pic_994 {background-position: -944px -191px; width: 16px; height: 16px; }', N'.pic_994 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1003, N'.pic_995 {background-position: -960px -191px; width: 16px; height: 16px; }', N'.pic_995 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1004, N'.pic_996 {background-position: -976px -191px; width: 16px; height: 16px; }', N'.pic_996 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1005, N'.pic_997 {background-position: -992px -191px; width: 16px; height: 16px; }', N'.pic_997 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1006, N'.pic_998 {background-position: -1008px -191px; width: 16px; height: 16px; }', N'.pic_998 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1007, N'.pic_999 {background-position: -1024px -191px; width: 16px; height: 16px; }', N'.pic_999 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1008, N'.pic_1000 {background-position: -1040px -191px; width: 16px; height: 16px; }', N'.pic_1000 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1009, N'.pic_1001 {background-position: -1056px -191px; width: 16px; height: 16px; }', N'.pic_1001 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1010, N'.pic_1002 {background-position: -1072px -191px; width: 16px; height: 16px; }', N'.pic_1002 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1011, N'.pic_1003 {background-position: -1088px -191px; width: 16px; height: 16px; }', N'.pic_1003 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1012, N'.pic_1004 {background-position: -1104px -191px; width: 16px; height: 16px; }', N'.pic_1004 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1013, N'.pic_1005 {background-position: -1120px -191px; width: 16px; height: 16px; }', N'.pic_1005 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1014, N'.pic_1006 {background-position: -1136px -191px; width: 16px; height: 16px; }', N'.pic_1006 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1015, N'.pic_1007 {background-position: -1152px -191px; width: 16px; height: 16px; }', N'.pic_1007 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1016, N'.pic_1008 {background-position: -1168px -191px; width: 16px; height: 16px; }', N'.pic_1008 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1017, N'.pic_1009 {background-position: -1184px -191px; width: 16px; height: 16px; }', N'.pic_1009 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1018, N'.pic_1010 {background-position: -1200px -191px; width: 16px; height: 16px; }', N'.pic_1010 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1019, N'.pic_1011 {background-position: -1216px -191px; width: 16px; height: 16px; }', N'.pic_1011 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1020, N'.pic_1012 {background-position: -1232px -191px; width: 16px; height: 16px; }', N'.pic_1012 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1021, N'.pic_1013 {background-position: -0px -207px; width: 16px; height: 16px; }', N'.pic_1013 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1022, N'.pic_1014 {background-position: -16px -207px; width: 16px; height: 16px; }', N'.pic_1014 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1023, N'.pic_1015 {background-position: -32px -207px; width: 16px; height: 16px; }', N'.pic_1015 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1024, N'.pic_1016 {background-position: -48px -207px; width: 16px; height: 16px; }', N'.pic_1016 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1025, N'.pic_1017 {background-position: -64px -207px; width: 16px; height: 16px; }', N'.pic_1017 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1026, N'.pic_1018 {background-position: -80px -207px; width: 16px; height: 16px; }', N'.pic_1018 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1027, N'.pic_1019 {background-position: -96px -207px; width: 16px; height: 16px; }', N'.pic_1019 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1028, N'.pic_1020 {background-position: -112px -207px; width: 16px; height: 16px; }', N'.pic_1020 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1029, N'.pic_1021 {background-position: -128px -207px; width: 16px; height: 16px; }', N'.pic_1021 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1030, N'.pic_1022 {background-position: -144px -207px; width: 16px; height: 16px; }', N'.pic_1022 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1031, N'.pic_1023 {background-position: -160px -207px; width: 16px; height: 16px; }', N'.pic_1023 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1032, N'.pic_1024 {background-position: -176px -207px; width: 16px; height: 16px; }', N'.pic_1024 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1033, N'.pic_1025 {background-position: -192px -207px; width: 16px; height: 16px; }', N'.pic_1025 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1034, N'.pic_1026 {background-position: -208px -207px; width: 16px; height: 16px; }', N'.pic_1026 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1035, N'.pic_1027 {background-position: -224px -207px; width: 16px; height: 16px; }', N'.pic_1027 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1036, N'.pic_1028 {background-position: -240px -207px; width: 16px; height: 16px; }', N'.pic_1028 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1037, N'.pic_1029 {background-position: -256px -207px; width: 16px; height: 16px; }', N'.pic_1029 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1038, N'.pic_1030 {background-position: -272px -207px; width: 16px; height: 16px; }', N'.pic_1030 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1039, N'.pic_1032 {background-position: -320px -207px; width: 16px; height: 16px; }', N'.pic_1032 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1040, N'.pic_1033 {background-position: -336px -207px; width: 16px; height: 16px; }', N'.pic_1033 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1041, N'.pic_1034 {background-position: -352px -207px; width: 16px; height: 16px; }', N'.pic_1034 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1042, N'.pic_1035 {background-position: -368px -207px; width: 16px; height: 16px; }', N'.pic_1035 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1043, N'.pic_1036 {background-position: -384px -207px; width: 16px; height: 16px; }', N'.pic_1036 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1044, N'.pic_1037 {background-position: -400px -207px; width: 16px; height: 16px; }', N'.pic_1037 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1045, N'.pic_1038 {background-position: -416px -207px; width: 16px; height: 16px; }', N'.pic_1038 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1046, N'.pic_1039 {background-position: -432px -207px; width: 16px; height: 16px; }', N'.pic_1039 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1047, N'.pic_1040 {background-position: -448px -207px; width: 16px; height: 16px; }', N'.pic_1040 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1048, N'.pic_1041 {background-position: -464px -207px; width: 16px; height: 16px; }', N'.pic_1041 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1049, N'.pic_1042 {background-position: -480px -207px; width: 16px; height: 16px; }', N'.pic_1042 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1050, N'.pic_1043 {background-position: -496px -207px; width: 16px; height: 16px; }', N'.pic_1043 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1051, N'.pic_1044 {background-position: -512px -207px; width: 16px; height: 16px; }', N'.pic_1044 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1052, N'.pic_1045 {background-position: -528px -207px; width: 16px; height: 16px; }', N'.pic_1045 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1053, N'.pic_1046 {background-position: -544px -207px; width: 16px; height: 16px; }', N'.pic_1046 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1054, N'.pic_1047 {background-position: -560px -207px; width: 16px; height: 16px; }', N'.pic_1047 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1055, N'.pic_1048 {background-position: -576px -207px; width: 16px; height: 16px; }', N'.pic_1048 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1056, N'.pic_1049 {background-position: -592px -207px; width: 16px; height: 16px; }', N'.pic_1049 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1057, N'.pic_1050 {background-position: -608px -207px; width: 16px; height: 16px; }', N'.pic_1050 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1058, N'.pic_1051 {background-position: -624px -207px; width: 16px; height: 16px; }', N'.pic_1051 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1059, N'.pic_1052 {background-position: -640px -207px; width: 16px; height: 16px; }', N'.pic_1052 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1060, N'.pic_1053 {background-position: -656px -207px; width: 16px; height: 16px; }', N'.pic_1053 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1061, N'.pic_1054 {background-position: -672px -207px; width: 16px; height: 16px; }', N'.pic_1054 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1062, N'.pic_1055 {background-position: -688px -207px; width: 16px; height: 16px; }', N'.pic_1055 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1063, N'.pic_1056 {background-position: -704px -207px; width: 16px; height: 16px; }', N'.pic_1056 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1064, N'.pic_1057 {background-position: -720px -207px; width: 16px; height: 16px; }', N'.pic_1057 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1065, N'.pic_1058 {background-position: -736px -207px; width: 16px; height: 16px; }', N'.pic_1058 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1066, N'.pic_1059 {background-position: -752px -207px; width: 16px; height: 16px; }', N'.pic_1059 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1067, N'.pic_1060 {background-position: -768px -207px; width: 16px; height: 16px; }', N'.pic_1060 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1068, N'.pic_1061 {background-position: -784px -207px; width: 16px; height: 16px; }', N'.pic_1061 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1069, N'.pic_1062 {background-position: -800px -207px; width: 16px; height: 16px; }', N'.pic_1062 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1070, N'.pic_1063 {background-position: -816px -207px; width: 16px; height: 16px; }', N'.pic_1063 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1071, N'.pic_1064 {background-position: -832px -207px; width: 16px; height: 16px; }', N'.pic_1064 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1072, N'.pic_1065 {background-position: -848px -207px; width: 16px; height: 16px; }', N'.pic_1065 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1073, N'.pic_1066 {background-position: -864px -207px; width: 16px; height: 16px; }', N'.pic_1066 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1074, N'.pic_1067 {background-position: -880px -207px; width: 16px; height: 16px; }', N'.pic_1067 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1075, N'.pic_1068 {background-position: -896px -207px; width: 16px; height: 16px; }', N'.pic_1068 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1076, N'.pic_1069 {background-position: -912px -207px; width: 16px; height: 16px; }', N'.pic_1069 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1077, N'.pic_1070 {background-position: -928px -207px; width: 16px; height: 16px; }', N'.pic_1070 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1078, N'.pic_1071 {background-position: -944px -207px; width: 16px; height: 16px; }', N'.pic_1071 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1079, N'.pic_1072 {background-position: -960px -207px; width: 16px; height: 16px; }', N'.pic_1072 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1080, N'.pic_1073 {background-position: -976px -207px; width: 16px; height: 16px; }', N'.pic_1073 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1081, N'.pic_1074 {background-position: -992px -207px; width: 16px; height: 16px; }', N'.pic_1074 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1082, N'.pic_1075 {background-position: -1008px -207px; width: 16px; height: 16px; }', N'.pic_1075 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1083, N'.pic_1076 {background-position: -1024px -207px; width: 16px; height: 16px; }', N'.pic_1076 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1084, N'.pic_1077 {background-position: -1040px -207px; width: 16px; height: 16px; }', N'.pic_1077 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1085, N'.pic_1078 {background-position: -1056px -207px; width: 16px; height: 16px; }', N'.pic_1078 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1086, N'.pic_1079 {background-position: -1072px -207px; width: 16px; height: 16px; }', N'.pic_1079 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1087, N'.pic_1080 {background-position: -1088px -207px; width: 16px; height: 16px; }', N'.pic_1080 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1088, N'.pic_1081 {background-position: -1104px -207px; width: 16px; height: 16px; }', N'.pic_1081 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1089, N'.pic_1082 {background-position: -1120px -207px; width: 16px; height: 16px; }', N'.pic_1082 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1090, N'.pic_1083 {background-position: -1136px -207px; width: 16px; height: 16px; }', N'.pic_1083 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1091, N'.pic_1084 {background-position: -1152px -207px; width: 16px; height: 16px; }', N'.pic_1084 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1092, N'.pic_1085 {background-position: -1168px -207px; width: 16px; height: 16px; }', N'.pic_1085 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1093, N'.pic_1086 {background-position: -1184px -207px; width: 16px; height: 16px; }', N'.pic_1086 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1094, N'.pic_1087 {background-position: -1200px -207px; width: 16px; height: 16px; }', N'.pic_1087 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1095, N'.pic_1088 {background-position: -1216px -207px; width: 16px; height: 16px; }', N'.pic_1088 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1096, N'.pic_1089 {background-position: -1232px -207px; width: 16px; height: 16px; }', N'.pic_1089 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1097, N'.pic_1090 {background-position: -0px -223px; width: 16px; height: 16px; }', N'.pic_1090 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1098, N'.pic_1091 {background-position: -16px -223px; width: 16px; height: 16px; }', N'.pic_1091 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1099, N'.pic_1092 {background-position: -32px -223px; width: 16px; height: 16px; }', N'.pic_1092 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1100, N'.pic_1093 {background-position: -48px -223px; width: 16px; height: 16px; }', N'.pic_1093 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1101, N'.pic_1094 {background-position: -64px -223px; width: 16px; height: 16px; }', N'.pic_1094 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1102, N'.pic_1095 {background-position: -80px -223px; width: 16px; height: 16px; }', N'.pic_1095 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1103, N'.pic_1096 {background-position: -96px -223px; width: 16px; height: 16px; }', N'.pic_1096 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1104, N'.pic_1097 {background-position: -112px -223px; width: 16px; height: 16px; }', N'.pic_1097 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1105, N'.pic_1098 {background-position: -128px -223px; width: 16px; height: 16px; }', N'.pic_1098 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1106, N'.pic_1099 {background-position: -144px -223px; width: 16px; height: 16px; }', N'.pic_1099 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1107, N'.pic_1100 {background-position: -160px -223px; width: 16px; height: 16px; }', N'.pic_1100 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1108, N'.pic_1101 {background-position: -176px -223px; width: 16px; height: 16px; }', N'.pic_1101 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1109, N'.pic_1102 {background-position: -192px -223px; width: 16px; height: 16px; }', N'.pic_1102 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1110, N'.pic_1103 {background-position: -208px -223px; width: 16px; height: 16px; }', N'.pic_1103 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1111, N'.pic_1104 {background-position: -224px -223px; width: 16px; height: 16px; }', N'.pic_1104 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1112, N'.pic_1105 {background-position: -240px -223px; width: 16px; height: 16px; }', N'.pic_1105 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1113, N'.pic_1106 {background-position: -256px -223px; width: 16px; height: 16px; }', N'.pic_1106 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1114, N'.pic_1107 {background-position: -272px -223px; width: 16px; height: 16px; }', N'.pic_1107 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1115, N'.pic_1108 {background-position: -288px -223px; width: 16px; height: 16px; }', N'.pic_1108 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1116, N'.pic_1109 {background-position: -304px -223px; width: 16px; height: 16px; }', N'.pic_1109 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1117, N'.pic_1110 {background-position: -320px -223px; width: 16px; height: 16px; }', N'.pic_1110 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1118, N'.pic_1111 {background-position: -336px -223px; width: 16px; height: 16px; }', N'.pic_1111 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1119, N'.pic_1112 {background-position: -352px -223px; width: 16px; height: 16px; }', N'.pic_1112 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1120, N'.pic_1113 {background-position: -368px -223px; width: 16px; height: 16px; }', N'.pic_1113 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1121, N'.pic_1114 {background-position: -384px -223px; width: 16px; height: 16px; }', N'.pic_1114 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1122, N'.pic_1115 {background-position: -400px -223px; width: 16px; height: 16px; }', N'.pic_1115 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1123, N'.pic_1116 {background-position: -416px -223px; width: 16px; height: 16px; }', N'.pic_1116 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1124, N'.pic_1117 {background-position: -432px -223px; width: 16px; height: 16px; }', N'.pic_1117 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1125, N'.pic_1118 {background-position: -448px -223px; width: 16px; height: 16px; }', N'.pic_1118 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1126, N'.pic_1119 {background-position: -464px -223px; width: 16px; height: 16px; }', N'.pic_1119 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1127, N'.pic_1120 {background-position: -480px -223px; width: 16px; height: 16px; }', N'.pic_1120 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1128, N'.pic_1121 {background-position: -496px -223px; width: 16px; height: 16px; }', N'.pic_1121 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1129, N'.pic_1122 {background-position: -512px -223px; width: 16px; height: 16px; }', N'.pic_1122 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1130, N'.pic_1123 {background-position: -528px -223px; width: 16px; height: 16px; }', N'.pic_1123 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1131, N'.pic_1124 {background-position: -544px -223px; width: 16px; height: 16px; }', N'.pic_1124 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1132, N'.pic_1125 {background-position: -560px -223px; width: 16px; height: 16px; }', N'.pic_1125 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1133, N'.pic_1126 {background-position: -576px -223px; width: 16px; height: 16px; }', N'.pic_1126 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1134, N'.pic_1127 {background-position: -592px -223px; width: 16px; height: 16px; }', N'.pic_1127 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1135, N'.pic_1128 {background-position: -608px -223px; width: 16px; height: 16px; }', N'.pic_1128 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1136, N'.pic_1129 {background-position: -624px -223px; width: 16px; height: 16px; }', N'.pic_1129 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1137, N'.pic_1130 {background-position: -640px -223px; width: 16px; height: 16px; }', N'.pic_1130 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1138, N'.pic_1131 {background-position: -656px -223px; width: 16px; height: 16px; }', N'.pic_1131 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1139, N'.pic_1132 {background-position: -672px -223px; width: 16px; height: 16px; }', N'.pic_1132 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1140, N'.pic_1133 {background-position: -688px -223px; width: 16px; height: 16px; }', N'.pic_1133 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1141, N'.pic_1134 {background-position: -704px -223px; width: 16px; height: 16px; }', N'.pic_1134 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1142, N'.pic_1135 {background-position: -720px -223px; width: 16px; height: 16px; }', N'.pic_1135 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1143, N'.pic_1136 {background-position: -736px -223px; width: 16px; height: 16px; }', N'.pic_1136 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1144, N'.pic_1137 {background-position: -752px -223px; width: 16px; height: 16px; }', N'.pic_1137 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1145, N'.pic_1138 {background-position: -768px -223px; width: 16px; height: 16px; }', N'.pic_1138 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1146, N'.pic_1139 {background-position: -784px -223px; width: 16px; height: 16px; }', N'.pic_1139 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1147, N'.pic_1140 {background-position: -800px -223px; width: 16px; height: 16px; }', N'.pic_1140 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1148, N'.pic_1141 {background-position: -816px -223px; width: 16px; height: 16px; }', N'.pic_1141 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1149, N'.pic_1142 {background-position: -832px -223px; width: 16px; height: 16px; }', N'.pic_1142 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1150, N'.pic_1143 {background-position: -848px -223px; width: 16px; height: 16px; }', N'.pic_1143 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1151, N'.pic_1144 {background-position: -864px -223px; width: 16px; height: 16px; }', N'.pic_1144 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1152, N'.pic_1145 {background-position: -880px -223px; width: 16px; height: 16px; }', N'.pic_1145 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1153, N'.pic_1146 {background-position: -896px -223px; width: 16px; height: 16px; }', N'.pic_1146 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1154, N'.pic_1147 {background-position: -912px -223px; width: 16px; height: 16px; }', N'.pic_1147 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1155, N'.pic_1148 {background-position: -928px -223px; width: 16px; height: 16px; }', N'.pic_1148 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1156, N'.pic_1149 {background-position: -944px -223px; width: 16px; height: 16px; }', N'.pic_1149 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1157, N'.pic_1150 {background-position: -960px -223px; width: 16px; height: 16px; }', N'.pic_1150 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1158, N'.pic_1151 {background-position: -976px -223px; width: 16px; height: 16px; }', N'.pic_1151 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1159, N'.pic_1152 {background-position: -992px -223px; width: 16px; height: 16px; }', N'.pic_1152 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1160, N'.pic_1153 {background-position: -1008px -223px; width: 16px; height: 16px; }', N'.pic_1153 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1161, N'.pic_1154 {background-position: -1024px -223px; width: 16px; height: 16px; }', N'.pic_1154 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1162, N'.pic_1155 {background-position: -1040px -223px; width: 16px; height: 16px; }', N'.pic_1155 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1163, N'.pic_1156 {background-position: -1056px -223px; width: 16px; height: 16px; }', N'.pic_1156 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1164, N'.pic_1157 {background-position: -1072px -223px; width: 16px; height: 16px; }', N'.pic_1157 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1165, N'.pic_1158 {background-position: -1088px -223px; width: 16px; height: 16px; }', N'.pic_1158 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1166, N'.pic_1159 {background-position: -1104px -223px; width: 16px; height: 16px; }', N'.pic_1159 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1167, N'.pic_1160 {background-position: -1120px -223px; width: 16px; height: 16px; }', N'.pic_1160 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1168, N'.pic_1161 {background-position: -1136px -223px; width: 16px; height: 16px; }', N'.pic_1161 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1169, N'.pic_1162 {background-position: -1152px -223px; width: 16px; height: 16px; }', N'.pic_1162 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1170, N'.pic_1163 {background-position: -1168px -223px; width: 16px; height: 16px; }', N'.pic_1163 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1171, N'.pic_1164 {background-position: -1184px -223px; width: 16px; height: 16px; }', N'.pic_1164 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1172, N'.pic_1165 {background-position: -1200px -223px; width: 16px; height: 16px; }', N'.pic_1165 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1173, N'.pic_1166 {background-position: -1216px -223px; width: 16px; height: 16px; }', N'.pic_1166 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1174, N'.pic_1167 {background-position: -1232px -223px; width: 16px; height: 16px; }', N'.pic_1167 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1175, N'.pic_1168 {background-position: -0px -239px; width: 16px; height: 16px; }', N'.pic_1168 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1176, N'.pic_1169 {background-position: -16px -239px; width: 16px; height: 16px; }', N'.pic_1169 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1177, N'.pic_1170 {background-position: -32px -239px; width: 16px; height: 16px; }', N'.pic_1170 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1178, N'.pic_1171 {background-position: -48px -239px; width: 16px; height: 16px; }', N'.pic_1171 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1179, N'.pic_1172 {background-position: -64px -239px; width: 16px; height: 16px; }', N'.pic_1172 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1180, N'.pic_1173 {background-position: -80px -239px; width: 16px; height: 16px; }', N'.pic_1173 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1181, N'.pic_1174 {background-position: -96px -239px; width: 16px; height: 16px; }', N'.pic_1174 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1182, N'.pic_1175 {background-position: -112px -239px; width: 16px; height: 16px; }', N'.pic_1175 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1183, N'.pic_1176 {background-position: -128px -239px; width: 16px; height: 16px; }', N'.pic_1176 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1184, N'.pic_1177 {background-position: -144px -239px; width: 16px; height: 16px; }', N'.pic_1177 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1185, N'.pic_1178 {background-position: -160px -239px; width: 16px; height: 16px; }', N'.pic_1178 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1186, N'.pic_1180 {background-position: -208px -239px; width: 16px; height: 16px; }', N'.pic_1180 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1187, N'.pic_1181 {background-position: -224px -239px; width: 16px; height: 16px; }', N'.pic_1181 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1188, N'.pic_1182 {background-position: -240px -239px; width: 16px; height: 16px; }', N'.pic_1182 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1189, N'.pic_1183 {background-position: -256px -239px; width: 16px; height: 16px; }', N'.pic_1183 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1190, N'.pic_1184 {background-position: -272px -239px; width: 16px; height: 16px; }', N'.pic_1184 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1191, N'.pic_1185 {background-position: -288px -239px; width: 16px; height: 16px; }', N'.pic_1185 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1192, N'.pic_1186 {background-position: -304px -239px; width: 16px; height: 16px; }', N'.pic_1186 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1193, N'.pic_1187 {background-position: -320px -239px; width: 16px; height: 16px; }', N'.pic_1187 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1194, N'.pic_1188 {background-position: -336px -239px; width: 16px; height: 16px; }', N'.pic_1188 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1195, N'.pic_1189 {background-position: -352px -239px; width: 16px; height: 16px; }', N'.pic_1189 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1196, N'.pic_1190 {background-position: -368px -239px; width: 16px; height: 16px; }', N'.pic_1190 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1197, N'.pic_1191 {background-position: -384px -239px; width: 16px; height: 16px; }', N'.pic_1191 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1198, N'.pic_1192 {background-position: -400px -239px; width: 16px; height: 16px; }', N'.pic_1192 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1199, N'.pic_1193 {background-position: -416px -239px; width: 16px; height: 16px; }', N'.pic_1193 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1200, N'.pic_1194 {background-position: -432px -239px; width: 16px; height: 16px; }', N'.pic_1194 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1201, N'.pic_1195 {background-position: -448px -239px; width: 16px; height: 16px; }', N'.pic_1195 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1202, N'.pic_1196 {background-position: -464px -239px; width: 16px; height: 16px; }', N'.pic_1196 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1203, N'.pic_1197 {background-position: -480px -239px; width: 16px; height: 16px; }', N'.pic_1197 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1204, N'.pic_1198 {background-position: -496px -239px; width: 16px; height: 16px; }', N'.pic_1198 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1205, N'.pic_1199 {background-position: -512px -239px; width: 16px; height: 16px; }', N'.pic_1199 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1206, N'.pic_1200 {background-position: -528px -239px; width: 16px; height: 16px; }', N'.pic_1200 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1207, N'.pic_1201 {background-position: -544px -239px; width: 16px; height: 16px; }', N'.pic_1201 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1208, N'.pic_1202 {background-position: -560px -239px; width: 16px; height: 16px; }', N'.pic_1202 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1209, N'.pic_1203 {background-position: -576px -239px; width: 16px; height: 16px; }', N'.pic_1203 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1210, N'.pic_1204 {background-position: -592px -239px; width: 16px; height: 16px; }', N'.pic_1204 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1211, N'.pic_1205 {background-position: -608px -239px; width: 16px; height: 16px; }', N'.pic_1205 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1212, N'.pic_1206 {background-position: -624px -239px; width: 16px; height: 16px; }', N'.pic_1206 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1213, N'.pic_1207 {background-position: -640px -239px; width: 16px; height: 16px; }', N'.pic_1207 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1214, N'.pic_1208 {background-position: -656px -239px; width: 16px; height: 16px; }', N'.pic_1208 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1215, N'.pic_1209 {background-position: -672px -239px; width: 16px; height: 16px; }', N'.pic_1209 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1216, N'.pic_1210 {background-position: -688px -239px; width: 16px; height: 16px; }', N'.pic_1210 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1217, N'.pic_1211 {background-position: -704px -239px; width: 16px; height: 16px; }', N'.pic_1211 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1218, N'.pic_1212 {background-position: -720px -239px; width: 16px; height: 16px; }', N'.pic_1212 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1219, N'.pic_1213 {background-position: -736px -239px; width: 16px; height: 16px; }', N'.pic_1213 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1220, N'.pic_1214 {background-position: -752px -239px; width: 16px; height: 16px; }', N'.pic_1214 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1221, N'.pic_1215 {background-position: -768px -239px; width: 16px; height: 16px; }', N'.pic_1215 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1222, N'.pic_1216 {background-position: -784px -239px; width: 16px; height: 16px; }', N'.pic_1216 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1223, N'.pic_1217 {background-position: -800px -239px; width: 16px; height: 16px; }', N'.pic_1217 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1224, N'.pic_1218 {background-position: -816px -239px; width: 16px; height: 16px; }', N'.pic_1218 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1225, N'.pic_1219 {background-position: -832px -239px; width: 16px; height: 16px; }', N'.pic_1219 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1226, N'.pic_1220 {background-position: -848px -239px; width: 16px; height: 16px; }', N'.pic_1220 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1227, N'.pic_1221 {background-position: -864px -239px; width: 16px; height: 16px; }', N'.pic_1221 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1228, N'.pic_1222 {background-position: -880px -239px; width: 16px; height: 16px; }', N'.pic_1222 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1229, N'.pic_1223 {background-position: -896px -239px; width: 16px; height: 16px; }', N'.pic_1223 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1230, N'.pic_1224 {background-position: -912px -239px; width: 16px; height: 16px; }', N'.pic_1224 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1231, N'.pic_1225 {background-position: -928px -239px; width: 16px; height: 16px; }', N'.pic_1225 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1232, N'.pic_1226 {background-position: -944px -239px; width: 16px; height: 16px; }', N'.pic_1226 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1233, N'.pic_1227 {background-position: -960px -239px; width: 16px; height: 16px; }', N'.pic_1227 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1234, N'.pic_1228 {background-position: -976px -239px; width: 16px; height: 16px; }', N'.pic_1228 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1235, N'.pic_1229 {background-position: -992px -239px; width: 16px; height: 16px; }', N'.pic_1229 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1236, N'.pic_1230 {background-position: -1008px -239px; width: 16px; height: 16px; }', N'.pic_1230 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1237, N'.pic_1231 {background-position: -1024px -239px; width: 16px; height: 16px; }', N'.pic_1231 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1238, N'.pic_1232 {background-position: -1040px -239px; width: 16px; height: 16px; }', N'.pic_1232 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1239, N'.pic_1233 {background-position: -1056px -239px; width: 16px; height: 16px; }', N'.pic_1233 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1240, N'.pic_1234 {background-position: -1072px -239px; width: 16px; height: 16px; }', N'.pic_1234 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1241, N'.pic_1235 {background-position: -1088px -239px; width: 16px; height: 16px; }', N'.pic_1235 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1242, N'.pic_1236 {background-position: -1104px -239px; width: 16px; height: 16px; }', N'.pic_1236 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1243, N'.pic_1237 {background-position: -1120px -239px; width: 16px; height: 16px; }', N'.pic_1237 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1244, N'.pic_1238 {background-position: -1136px -239px; width: 16px; height: 16px; }', N'.pic_1238 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1245, N'.pic_1239 {background-position: -1152px -239px; width: 16px; height: 16px; }', N'.pic_1239 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1246, N'.pic_1240 {background-position: -1168px -239px; width: 16px; height: 16px; }', N'.pic_1240 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1247, N'.pic_1241 {background-position: -1184px -239px; width: 16px; height: 16px; }', N'.pic_1241 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1248, N'.pic_1242 {background-position: -1200px -239px; width: 16px; height: 16px; }', N'.pic_1242 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1249, N'.pic_1243 {background-position: -1216px -239px; width: 16px; height: 16px; }', N'.pic_1243 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1250, N'.pic_1244 {background-position: -1232px -239px; width: 16px; height: 16px; }', N'.pic_1244 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1251, N'.pic_1245 {background-position: -0px -255px; width: 16px; height: 16px; }', N'.pic_1245 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1252, N'.pic_1246 {background-position: -16px -255px; width: 16px; height: 16px; }', N'.pic_1246 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1253, N'.pic_1247 {background-position: -32px -255px; width: 16px; height: 16px; }', N'.pic_1247 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1254, N'.pic_1248 {background-position: -48px -255px; width: 16px; height: 16px; }', N'.pic_1248 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1255, N'.pic_1249 {background-position: -64px -255px; width: 16px; height: 16px; }', N'.pic_1249 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1256, N'.pic_1250 {background-position: -80px -255px; width: 16px; height: 16px; }', N'.pic_1250 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1257, N'.pic_1251 {background-position: -96px -255px; width: 16px; height: 16px; }', N'.pic_1251 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1258, N'.pic_1252 {background-position: -112px -255px; width: 16px; height: 16px; }', N'.pic_1252 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1259, N'.pic_1253 {background-position: -128px -255px; width: 16px; height: 16px; }', N'.pic_1253 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1260, N'.pic_1254 {background-position: -144px -255px; width: 16px; height: 16px; }', N'.pic_1254 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1261, N'.pic_1255 {background-position: -160px -255px; width: 16px; height: 16px; }', N'.pic_1255 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1262, N'.pic_1256 {background-position: -176px -255px; width: 16px; height: 16px; }', N'.pic_1256 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1263, N'.pic_1257 {background-position: -192px -255px; width: 16px; height: 16px; }', N'.pic_1257 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1264, N'.pic_1258 {background-position: -208px -255px; width: 16px; height: 16px; }', N'.pic_1258 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1265, N'.pic_1259 {background-position: -224px -255px; width: 16px; height: 16px; }', N'.pic_1259 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1266, N'.pic_1260 {background-position: -240px -255px; width: 16px; height: 16px; }', N'.pic_1260 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1267, N'.pic_1261 {background-position: -256px -255px; width: 16px; height: 16px; }', N'.pic_1261 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1268, N'.pic_1262 {background-position: -272px -255px; width: 16px; height: 16px; }', N'.pic_1262 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1269, N'.pic_1263 {background-position: -288px -255px; width: 16px; height: 16px; }', N'.pic_1263 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1270, N'.pic_1264 {background-position: -304px -255px; width: 16px; height: 16px; }', N'.pic_1264 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1271, N'.pic_1265 {background-position: -320px -255px; width: 16px; height: 16px; }', N'.pic_1265 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1272, N'.pic_1266 {background-position: -336px -255px; width: 16px; height: 16px; }', N'.pic_1266 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1273, N'.pic_1267 {background-position: -352px -255px; width: 16px; height: 16px; }', N'.pic_1267 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1274, N'.pic_1268 {background-position: -368px -255px; width: 16px; height: 16px; }', N'.pic_1268 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1275, N'.pic_1269 {background-position: -384px -255px; width: 16px; height: 16px; }', N'.pic_1269 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1276, N'.pic_1270 {background-position: -400px -255px; width: 16px; height: 16px; }', N'.pic_1270 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1277, N'.pic_1271 {background-position: -416px -255px; width: 16px; height: 16px; }', N'.pic_1271 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1278, N'.pic_1272 {background-position: -432px -255px; width: 16px; height: 16px; }', N'.pic_1272 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1279, N'.pic_1273 {background-position: -448px -255px; width: 16px; height: 16px; }', N'.pic_1273 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1280, N'.pic_1274 {background-position: -464px -255px; width: 16px; height: 16px; }', N'.pic_1274 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1281, N'.pic_1275 {background-position: -480px -255px; width: 16px; height: 16px; }', N'.pic_1275 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1282, N'.pic_1276 {background-position: -496px -255px; width: 16px; height: 16px; }', N'.pic_1276 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1283, N'.pic_1277 {background-position: -512px -255px; width: 16px; height: 16px; }', N'.pic_1277 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1284, N'.pic_1278 {background-position: -528px -255px; width: 16px; height: 16px; }', N'.pic_1278 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1285, N'.pic_1279 {background-position: -544px -255px; width: 16px; height: 16px; }', N'.pic_1279 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1286, N'.pic_1280 {background-position: -560px -255px; width: 16px; height: 16px; }', N'.pic_1280 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1287, N'.pic_1281 {background-position: -576px -255px; width: 16px; height: 16px; }', N'.pic_1281 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1288, N'.pic_1282 {background-position: -592px -255px; width: 16px; height: 16px; }', N'.pic_1282 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1289, N'.pic_1283 {background-position: -608px -255px; width: 16px; height: 16px; }', N'.pic_1283 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1290, N'.pic_1284 {background-position: -624px -255px; width: 16px; height: 16px; }', N'.pic_1284 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1291, N'.pic_1285 {background-position: -640px -255px; width: 16px; height: 16px; }', N'.pic_1285 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1292, N'.pic_1286 {background-position: -656px -255px; width: 16px; height: 16px; }', N'.pic_1286 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1293, N'.pic_1287 {background-position: -672px -255px; width: 16px; height: 16px; }', N'.pic_1287 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1294, N'.pic_1288 {background-position: -688px -255px; width: 16px; height: 16px; }', N'.pic_1288 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1295, N'.pic_1289 {background-position: -704px -255px; width: 16px; height: 16px; }', N'.pic_1289 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1296, N'.pic_1290 {background-position: -720px -255px; width: 16px; height: 16px; }', N'.pic_1290 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1297, N'.pic_1291 {background-position: -736px -255px; width: 16px; height: 16px; }', N'.pic_1291 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1298, N'.pic_1292 {background-position: -752px -255px; width: 16px; height: 16px; }', N'.pic_1292 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1299, N'.pic_1293 {background-position: -768px -255px; width: 16px; height: 16px; }', N'.pic_1293 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1300, N'.pic_1294 {background-position: -784px -255px; width: 16px; height: 16px; }', N'.pic_1294 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1301, N'.pic_1295 {background-position: -800px -255px; width: 16px; height: 16px; }', N'.pic_1295 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1302, N'.pic_1296 {background-position: -816px -255px; width: 16px; height: 16px; }', N'.pic_1296 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1303, N'.pic_1297 {background-position: -832px -255px; width: 16px; height: 16px; }', N'.pic_1297 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1304, N'.pic_1298 {background-position: -848px -255px; width: 16px; height: 16px; }', N'.pic_1298 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1305, N'.pic_1299 {background-position: -864px -255px; width: 16px; height: 16px; }', N'.pic_1299 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1306, N'.pic_1300 {background-position: -880px -255px; width: 16px; height: 16px; }', N'.pic_1300 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1307, N'.pic_1301 {background-position: -896px -255px; width: 16px; height: 16px; }', N'.pic_1301 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1308, N'.pic_1302 {background-position: -912px -255px; width: 16px; height: 16px; }', N'.pic_1302 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1309, N'.pic_1303 {background-position: -928px -255px; width: 16px; height: 16px; }', N'.pic_1303 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1310, N'.pic_1304 {background-position: -944px -255px; width: 16px; height: 16px; }', N'.pic_1304 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1311, N'.pic_1305 {background-position: -960px -255px; width: 16px; height: 16px; }', N'.pic_1305 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1312, N'.pic_1306 {background-position: -976px -255px; width: 16px; height: 16px; }', N'.pic_1306 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1313, N'.pic_1307 {background-position: -992px -255px; width: 16px; height: 16px; }', N'.pic_1307 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1314, N'.pic_1308 {background-position: -1008px -255px; width: 16px; height: 16px; }', N'.pic_1308 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1315, N'.pic_1309 {background-position: -1024px -255px; width: 16px; height: 16px; }', N'.pic_1309 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1316, N'.pic_1310 {background-position: -1040px -255px; width: 16px; height: 16px; }', N'.pic_1310 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1317, N'.pic_1311 {background-position: -1056px -255px; width: 16px; height: 16px; }', N'.pic_1311 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1318, N'.pic_1312 {background-position: -1072px -255px; width: 16px; height: 16px; }', N'.pic_1312 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1319, N'.pic_1313 {background-position: -1088px -255px; width: 16px; height: 16px; }', N'.pic_1313 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1320, N'.pic_1314 {background-position: -1104px -255px; width: 16px; height: 16px; }', N'.pic_1314 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1321, N'.pic_1315 {background-position: -1120px -255px; width: 16px; height: 16px; }', N'.pic_1315 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1322, N'.pic_1316 {background-position: -1136px -255px; width: 16px; height: 16px; }', N'.pic_1316 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1323, N'.pic_1317 {background-position: -1152px -255px; width: 16px; height: 16px; }', N'.pic_1317 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1324, N'.pic_1318 {background-position: -1168px -255px; width: 16px; height: 16px; }', N'.pic_1318 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1325, N'.pic_1319 {background-position: -1184px -255px; width: 16px; height: 16px; }', N'.pic_1319 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1326, N'.pic_1320 {background-position: -1200px -255px; width: 16px; height: 16px; }', N'.pic_1320 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1327, N'.pic_1321 {background-position: -1216px -255px; width: 16px; height: 16px; }', N'.pic_1321 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1328, N'.pic_1322 {background-position: -1232px -255px; width: 16px; height: 16px; }', N'.pic_1322 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1329, N'.pic_1323 {background-position: -0px -271px; width: 16px; height: 16px; }', N'.pic_1323 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1330, N'.pic_1324 {background-position: -16px -271px; width: 16px; height: 16px; }', N'.pic_1324 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1331, N'.pic_1325 {background-position: -32px -271px; width: 16px; height: 16px; }', N'.pic_1325 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1332, N'.pic_1326 {background-position: -48px -271px; width: 16px; height: 16px; }', N'.pic_1326 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1333, N'.pic_1327 {background-position: -64px -271px; width: 16px; height: 16px; }', N'.pic_1327 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1334, N'.pic_1328 {background-position: -80px -271px; width: 16px; height: 16px; }', N'.pic_1328 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1335, N'.pic_1329 {background-position: -96px -271px; width: 16px; height: 16px; }', N'.pic_1329 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1336, N'.pic_1330 {background-position: -112px -271px; width: 16px; height: 16px; }', N'.pic_1330 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1337, N'.pic_1331 {background-position: -128px -271px; width: 16px; height: 16px; }', N'.pic_1331 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1338, N'.pic_1332 {background-position: -144px -271px; width: 16px; height: 16px; }', N'.pic_1332 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1339, N'.pic_1333 {background-position: -160px -271px; width: 16px; height: 16px; }', N'.pic_1333 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1340, N'.pic_1334 {background-position: -176px -271px; width: 16px; height: 16px; }', N'.pic_1334 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1341, N'.pic_1335 {background-position: -192px -271px; width: 16px; height: 16px; }', N'.pic_1335 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1342, N'.pic_1336 {background-position: -208px -271px; width: 16px; height: 16px; }', N'.pic_1336 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1343, N'.pic_1337 {background-position: -224px -271px; width: 16px; height: 16px; }', N'.pic_1337 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1344, N'.pic_1338 {background-position: -240px -271px; width: 16px; height: 16px; }', N'.pic_1338 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1345, N'.pic_1339 {background-position: -256px -271px; width: 16px; height: 16px; }', N'.pic_1339 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1346, N'.pic_1340 {background-position: -272px -271px; width: 16px; height: 16px; }', N'.pic_1340 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1347, N'.pic_1341 {background-position: -288px -271px; width: 16px; height: 16px; }', N'.pic_1341 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1348, N'.pic_1342 {background-position: -304px -271px; width: 16px; height: 16px; }', N'.pic_1342 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1349, N'.pic_1343 {background-position: -320px -271px; width: 16px; height: 16px; }', N'.pic_1343 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1350, N'.pic_1344 {background-position: -336px -271px; width: 16px; height: 16px; }', N'.pic_1344 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1351, N'.pic_1345 {background-position: -352px -271px; width: 16px; height: 16px; }', N'.pic_1345 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1352, N'.pic_1346 {background-position: -368px -271px; width: 16px; height: 16px; }', N'.pic_1346 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1353, N'.pic_1347 {background-position: -384px -271px; width: 16px; height: 16px; }', N'.pic_1347 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1354, N'.pic_1348 {background-position: -400px -271px; width: 16px; height: 16px; }', N'.pic_1348 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1355, N'.pic_1349 {background-position: -416px -271px; width: 16px; height: 16px; }', N'.pic_1349 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1356, N'.pic_1350 {background-position: -432px -271px; width: 16px; height: 16px; }', N'.pic_1350 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1357, N'.pic_1351 {background-position: -448px -271px; width: 16px; height: 16px; }', N'.pic_1351 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1358, N'.pic_1352 {background-position: -464px -271px; width: 16px; height: 16px; }', N'.pic_1352 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1359, N'.pic_1353 {background-position: -480px -271px; width: 16px; height: 16px; }', N'.pic_1353 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1360, N'.pic_1354 {background-position: -496px -271px; width: 16px; height: 16px; }', N'.pic_1354 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1361, N'.pic_1355 {background-position: -512px -271px; width: 16px; height: 16px; }', N'.pic_1355 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1362, N'.pic_1356 {background-position: -528px -271px; width: 16px; height: 16px; }', N'.pic_1356 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1363, N'.pic_1357 {background-position: -544px -271px; width: 16px; height: 16px; }', N'.pic_1357 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1364, N'.pic_1358 {background-position: -560px -271px; width: 16px; height: 16px; }', N'.pic_1358 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1365, N'.pic_1359 {background-position: -576px -271px; width: 16px; height: 16px; }', N'.pic_1359 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1366, N'.pic_1360 {background-position: -592px -271px; width: 16px; height: 16px; }', N'.pic_1360 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1367, N'.pic_1361 {background-position: -608px -271px; width: 16px; height: 16px; }', N'.pic_1361 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1368, N'.pic_1362 {background-position: -624px -271px; width: 16px; height: 16px; }', N'.pic_1362 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1369, N'.pic_1363 {background-position: -640px -271px; width: 16px; height: 16px; }', N'.pic_1363 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1370, N'.pic_1364 {background-position: -656px -271px; width: 16px; height: 16px; }', N'.pic_1364 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1371, N'.pic_1365 {background-position: -672px -271px; width: 16px; height: 16px; }', N'.pic_1365 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1372, N'.pic_1366 {background-position: -688px -271px; width: 16px; height: 16px; }', N'.pic_1366 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1373, N'.pic_1367 {background-position: -704px -271px; width: 16px; height: 16px; }', N'.pic_1367 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1374, N'.pic_1368 {background-position: -720px -271px; width: 16px; height: 16px; }', N'.pic_1368 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1375, N'.pic_1369 {background-position: -736px -271px; width: 16px; height: 16px; }', N'.pic_1369 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1376, N'.pic_1370 {background-position: -752px -271px; width: 16px; height: 16px; }', N'.pic_1370 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1377, N'.pic_1371 {background-position: -768px -271px; width: 16px; height: 16px; }', N'.pic_1371 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1378, N'.pic_1372 {background-position: -784px -271px; width: 16px; height: 16px; }', N'.pic_1372 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1379, N'.pic_1373 {background-position: -800px -271px; width: 16px; height: 16px; }', N'.pic_1373 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1380, N'.pic_1374 {background-position: -816px -271px; width: 16px; height: 16px; }', N'.pic_1374 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1381, N'.pic_1375 {background-position: -832px -271px; width: 16px; height: 16px; }', N'.pic_1375 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1382, N'.pic_1376 {background-position: -848px -271px; width: 16px; height: 16px; }', N'.pic_1376 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1383, N'.pic_1377 {background-position: -864px -271px; width: 16px; height: 16px; }', N'.pic_1377 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1384, N'.pic_1378 {background-position: -880px -271px; width: 16px; height: 16px; }', N'.pic_1378 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1385, N'.pic_1379 {background-position: -896px -271px; width: 16px; height: 16px; }', N'.pic_1379 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1386, N'.pic_1380 {background-position: -912px -271px; width: 16px; height: 16px; }', N'.pic_1380 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1387, N'.pic_1381 {background-position: -928px -271px; width: 16px; height: 16px; }', N'.pic_1381 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1388, N'.pic_1382 {background-position: -944px -271px; width: 16px; height: 16px; }', N'.pic_1382 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1389, N'.pic_1383 {background-position: -960px -271px; width: 16px; height: 16px; }', N'.pic_1383 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1390, N'.pic_1384 {background-position: -976px -271px; width: 16px; height: 16px; }', N'.pic_1384 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1391, N'.pic_1385 {background-position: -992px -271px; width: 16px; height: 16px; }', N'.pic_1385 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1392, N'.pic_1386 {background-position: -1008px -271px; width: 16px; height: 16px; }', N'.pic_1386 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1393, N'.pic_1387 {background-position: -1024px -271px; width: 16px; height: 16px; }', N'.pic_1387 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1394, N'.pic_1388 {background-position: -1040px -271px; width: 16px; height: 16px; }', N'.pic_1388 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1395, N'.pic_1389 {background-position: -1056px -271px; width: 16px; height: 16px; }', N'.pic_1389 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1396, N'.pic_1390 {background-position: -1072px -271px; width: 16px; height: 16px; }', N'.pic_1390 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1397, N'.pic_1391 {background-position: -1088px -271px; width: 16px; height: 16px; }', N'.pic_1391 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1398, N'.pic_1392 {background-position: -1104px -271px; width: 16px; height: 16px; }', N'.pic_1392 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1399, N'.pic_1393 {background-position: -1120px -271px; width: 16px; height: 16px; }', N'.pic_1393 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1400, N'.pic_1394 {background-position: -1136px -271px; width: 16px; height: 16px; }', N'.pic_1394 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1401, N'.pic_1395 {background-position: -1152px -271px; width: 16px; height: 16px; }', N'.pic_1395 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1402, N'.pic_1396 {background-position: -1168px -271px; width: 16px; height: 16px; }', N'.pic_1396 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1403, N'.pic_1397 {background-position: -1184px -271px; width: 16px; height: 16px; }', N'.pic_1397 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1404, N'.pic_1398 {background-position: -1200px -271px; width: 16px; height: 16px; }', N'.pic_1398 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1405, N'.pic_1399 {background-position: -1216px -271px; width: 16px; height: 16px; }', N'.pic_1399 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1406, N'.pic_1400 {background-position: -1232px -271px; width: 16px; height: 16px; }', N'.pic_1400 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1407, N'.pic_1401 {background-position: -0px -287px; width: 16px; height: 16px; }', N'.pic_1401 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1408, N'.pic_1402 {background-position: -16px -287px; width: 16px; height: 16px; }', N'.pic_1402 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1409, N'.pic_1403 {background-position: -32px -287px; width: 16px; height: 16px; }', N'.pic_1403 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1410, N'.pic_1404 {background-position: -48px -287px; width: 16px; height: 16px; }', N'.pic_1404 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1411, N'.pic_1405 {background-position: -64px -287px; width: 16px; height: 16px; }', N'.pic_1405 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1412, N'.pic_1406 {background-position: -80px -287px; width: 16px; height: 16px; }', N'.pic_1406 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1413, N'.pic_1407 {background-position: -96px -287px; width: 16px; height: 16px; }', N'.pic_1407 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1414, N'.pic_1408 {background-position: -112px -287px; width: 16px; height: 16px; }', N'.pic_1408 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1415, N'.pic_1409 {background-position: -128px -287px; width: 16px; height: 16px; }', N'.pic_1409 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1416, N'.pic_1410 {background-position: -144px -287px; width: 16px; height: 16px; }', N'.pic_1410 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1417, N'.pic_1411 {background-position: -160px -287px; width: 16px; height: 16px; }', N'.pic_1411 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1418, N'.pic_1412 {background-position: -176px -287px; width: 16px; height: 16px; }', N'.pic_1412 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1419, N'.pic_1413 {background-position: -192px -287px; width: 16px; height: 16px; }', N'.pic_1413 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1420, N'.pic_1414 {background-position: -208px -287px; width: 16px; height: 16px; }', N'.pic_1414 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1421, N'.pic_1415 {background-position: -224px -287px; width: 16px; height: 16px; }', N'.pic_1415 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1422, N'.pic_1416 {background-position: -240px -287px; width: 16px; height: 16px; }', N'.pic_1416 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1423, N'.pic_1417 {background-position: -256px -287px; width: 16px; height: 16px; }', N'.pic_1417 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1424, N'.pic_1418 {background-position: -272px -287px; width: 16px; height: 16px; }', N'.pic_1418 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1425, N'.pic_1419 {background-position: -288px -287px; width: 16px; height: 16px; }', N'.pic_1419 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1426, N'.pic_1420 {background-position: -304px -287px; width: 16px; height: 16px; }', N'.pic_1420 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1427, N'.pic_1421 {background-position: -320px -287px; width: 16px; height: 16px; }', N'.pic_1421 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1428, N'.pic_1422 {background-position: -336px -287px; width: 16px; height: 16px; }', N'.pic_1422 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1429, N'.pic_1423 {background-position: -352px -287px; width: 16px; height: 16px; }', N'.pic_1423 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1430, N'.pic_1424 {background-position: -368px -287px; width: 16px; height: 16px; }', N'.pic_1424 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1431, N'.pic_1425 {background-position: -384px -287px; width: 16px; height: 16px; }', N'.pic_1425 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1432, N'.pic_1426 {background-position: -400px -287px; width: 16px; height: 16px; }', N'.pic_1426 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1433, N'.pic_1428 {background-position: -448px -287px; width: 16px; height: 16px; }', N'.pic_1428 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1434, N'.pic_1429 {background-position: -464px -287px; width: 16px; height: 16px; }', N'.pic_1429 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1435, N'.pic_1430 {background-position: -480px -287px; width: 16px; height: 16px; }', N'.pic_1430 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1436, N'.pic_1431 {background-position: -496px -287px; width: 16px; height: 16px; }', N'.pic_1431 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1437, N'.pic_1432 {background-position: -512px -287px; width: 16px; height: 16px; }', N'.pic_1432 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1438, N'.pic_1434 {background-position: -560px -287px; width: 16px; height: 16px; }', N'.pic_1434 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1439, N'.pic_1435 {background-position: -576px -287px; width: 16px; height: 16px; }', N'.pic_1435 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1440, N'.pic_1436 {background-position: -592px -287px; width: 16px; height: 16px; }', N'.pic_1436 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1441, N'.pic_1437 {background-position: -608px -287px; width: 16px; height: 16px; }', N'.pic_1437 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1442, N'.pic_1438 {background-position: -624px -287px; width: 16px; height: 16px; }', N'.pic_1438 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1443, N'.pic_1439 {background-position: -640px -287px; width: 16px; height: 16px; }', N'.pic_1439 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1444, N'.pic_1440 {background-position: -656px -287px; width: 16px; height: 16px; }', N'.pic_1440 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1445, N'.pic_1441 {background-position: -672px -287px; width: 16px; height: 16px; }', N'.pic_1441 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1446, N'.pic_1442 {background-position: -688px -287px; width: 16px; height: 16px; }', N'.pic_1442 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1447, N'.pic_1443 {background-position: -704px -287px; width: 16px; height: 16px; }', N'.pic_1443 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1448, N'.pic_1445 {background-position: -752px -287px; width: 16px; height: 16px; }', N'.pic_1445 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1449, N'.pic_1446 {background-position: -768px -287px; width: 16px; height: 16px; }', N'.pic_1446 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1450, N'.pic_1447 {background-position: -784px -287px; width: 16px; height: 16px; }', N'.pic_1447 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1451, N'.pic_1448 {background-position: -800px -287px; width: 16px; height: 16px; }', N'.pic_1448 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1452, N'.pic_1449 {background-position: -816px -287px; width: 16px; height: 16px; }', N'.pic_1449 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1453, N'.pic_1450 {background-position: -832px -287px; width: 16px; height: 16px; }', N'.pic_1450 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1454, N'.pic_1451 {background-position: -848px -287px; width: 16px; height: 16px; }', N'.pic_1451 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1455, N'.pic_1452 {background-position: -864px -287px; width: 16px; height: 16px; }', N'.pic_1452 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1456, N'.pic_1453 {background-position: -880px -287px; width: 16px; height: 16px; }', N'.pic_1453 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1457, N'.pic_1454 {background-position: -896px -287px; width: 16px; height: 16px; }', N'.pic_1454 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1458, N'.pic_1455 {background-position: -912px -287px; width: 16px; height: 16px; }', N'.pic_1455 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1459, N'.pic_1456 {background-position: -928px -287px; width: 16px; height: 16px; }', N'.pic_1456 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1460, N'.pic_1457 {background-position: -944px -287px; width: 16px; height: 16px; }', N'.pic_1457 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1461, N'.pic_1459 {background-position: -992px -287px; width: 16px; height: 16px; }', N'.pic_1459 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1462, N'.pic_1460 {background-position: -1008px -287px; width: 16px; height: 16px; }', N'.pic_1460 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1463, N'.pic_1461 {background-position: -1024px -287px; width: 16px; height: 16px; }', N'.pic_1461 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1464, N'.pic_1462 {background-position: -1040px -287px; width: 16px; height: 16px; }', N'.pic_1462 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1465, N'.pic_1463 {background-position: -1056px -287px; width: 16px; height: 16px; }', N'.pic_1463 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1466, N'.pic_1464 {background-position: -1072px -287px; width: 16px; height: 16px; }', N'.pic_1464 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1467, N'.pic_1465 {background-position: -1088px -287px; width: 16px; height: 16px; }', N'.pic_1465 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1468, N'.pic_1466 {background-position: -1104px -287px; width: 16px; height: 16px; }', N'.pic_1466 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1469, N'.pic_1467 {background-position: -1120px -287px; width: 16px; height: 16px; }', N'.pic_1467 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1470, N'.pic_1468 {background-position: -1136px -287px; width: 16px; height: 16px; }', N'.pic_1468 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1471, N'.pic_1469 {background-position: -1152px -287px; width: 16px; height: 16px; }', N'.pic_1469 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1472, N'.pic_1470 {background-position: -1168px -287px; width: 16px; height: 16px; }', N'.pic_1470 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1473, N'.pic_1471 {background-position: -1184px -287px; width: 16px; height: 16px; }', N'.pic_1471 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1474, N'.pic_1472 {background-position: -1200px -287px; width: 16px; height: 16px; }', N'.pic_1472 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1475, N'.pic_1473 {background-position: -1216px -287px; width: 16px; height: 16px; }', N'.pic_1473 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1476, N'.pic_1474 {background-position: -1232px -287px; width: 16px; height: 16px; }', N'.pic_1474 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1477, N'.pic_1475 {background-position: -0px -303px; width: 16px; height: 16px; }', N'.pic_1475 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1478, N'.pic_1476 {background-position: -16px -303px; width: 16px; height: 16px; }', N'.pic_1476 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1479, N'.pic_1477 {background-position: -32px -303px; width: 16px; height: 16px; }', N'.pic_1477 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1480, N'.pic_1478 {background-position: -48px -303px; width: 16px; height: 16px; }', N'.pic_1478 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1481, N'.pic_1479 {background-position: -64px -303px; width: 16px; height: 16px; }', N'.pic_1479 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1482, N'.pic_1480 {background-position: -80px -303px; width: 16px; height: 16px; }', N'.pic_1480 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1483, N'.pic_1481 {background-position: -96px -303px; width: 16px; height: 16px; }', N'.pic_1481 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1484, N'.pic_1482 {background-position: -112px -303px; width: 16px; height: 16px; }', N'.pic_1482 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1485, N'.pic_1483 {background-position: -128px -303px; width: 16px; height: 16px; }', N'.pic_1483 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1486, N'.pic_1484 {background-position: -144px -303px; width: 16px; height: 16px; }', N'.pic_1484 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1487, N'.pic_1485 {background-position: -160px -303px; width: 16px; height: 16px; }', N'.pic_1485 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1488, N'.pic_1486 {background-position: -176px -303px; width: 16px; height: 16px; }', N'.pic_1486 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1489, N'.pic_1487 {background-position: -192px -303px; width: 16px; height: 16px; }', N'.pic_1487 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1490, N'.pic_1488 {background-position: -208px -303px; width: 16px; height: 16px; }', N'.pic_1488 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1491, N'.pic_1489 {background-position: -224px -303px; width: 16px; height: 16px; }', N'.pic_1489 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1492, N'.pic_1490 {background-position: -240px -303px; width: 16px; height: 16px; }', N'.pic_1490 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1493, N'.pic_1491 {background-position: -256px -303px; width: 16px; height: 16px; }', N'.pic_1491 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1494, N'.pic_1492 {background-position: -272px -303px; width: 16px; height: 16px; }', N'.pic_1492 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1495, N'.pic_1493 {background-position: -288px -303px; width: 16px; height: 16px; }', N'.pic_1493 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1496, N'.pic_1494 {background-position: -304px -303px; width: 16px; height: 16px; }', N'.pic_1494 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1497, N'.pic_1495 {background-position: -320px -303px; width: 16px; height: 16px; }', N'.pic_1495 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1498, N'.pic_1496 {background-position: -336px -303px; width: 16px; height: 16px; }', N'.pic_1496 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1499, N'.pic_1497 {background-position: -352px -303px; width: 16px; height: 16px; }', N'.pic_1497 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1500, N'.pic_1498 {background-position: -368px -303px; width: 16px; height: 16px; }', N'.pic_1498 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1501, N'.pic_1499 {background-position: -384px -303px; width: 16px; height: 16px; }', N'.pic_1499 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1502, N'.pic_1500 {background-position: -400px -303px; width: 16px; height: 16px; }', N'.pic_1500 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1503, N'.pic_1501 {background-position: -416px -303px; width: 16px; height: 16px; }', N'.pic_1501 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1504, N'.pic_1503 {background-position: -464px -303px; width: 16px; height: 16px; }', N'.pic_1503 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1505, N'.pic_1504 {background-position: -480px -303px; width: 16px; height: 16px; }', N'.pic_1504 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1506, N'.pic_1505 {background-position: -496px -303px; width: 16px; height: 16px; }', N'.pic_1505 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1507, N'.pic_1506 {background-position: -512px -303px; width: 16px; height: 16px; }', N'.pic_1506 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1508, N'.pic_1507 {background-position: -528px -303px; width: 16px; height: 16px; }', N'.pic_1507 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1509, N'.pic_1508 {background-position: -544px -303px; width: 16px; height: 16px; }', N'.pic_1508 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1510, N'.pic_1509 {background-position: -560px -303px; width: 16px; height: 16px; }', N'.pic_1509 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1511, N'.pic_1510 {background-position: -576px -303px; width: 16px; height: 16px; }', N'.pic_1510 ')
GO
INSERT [dbo].[test] ([id], [text], [name]) VALUES (1512, N'.pic_1511 {background-position: -592px -303px; width: 16px; height: 16px; }', N'.pic_1511 ')
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateTable]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CreateTable]
	@TabName NVARCHAR(50)
AS
BEGIN
	DECLARE @PKName NVARCHAR(200)  
	DECLARE @sql NVARCHAR(MAX)  
	SET NOCOUNT ON;
	
	SET @PKName = 'PK_' + @TabName
	
	SET @sql = 'CREATE TABLE ' + @TabName + 
	    '(
				[Id] [int] IDENTITY(1,1) NOT NULL,
				[CreateTime] [datetime] NULL,
				[CreateBy] [nvarchar](50) NULL,
				[UpdateTime] [datetime] NULL,
				[UpdateBy] [nvarchar](50) NULL,
			 CONSTRAINT '+@PKName+' PRIMARY KEY CLUSTERED 
			(
				[Id] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY] ';
	EXEC (@sql) 
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetAuthorityByUserId]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_GetAuthorityByUserId]  
@userId int  --用户主键id  
as    
declare @roleIds varchar(128)  --用户所有的角色集合  
declare @sql varchar(max)    
SELECT @roleIds=REPLACE(    
(select str(ur.RoleId)+',' from tbUser u    
join tbUserRole ur on u.Id = ur.UserId where u.Id = @userId  
for xml path('')),' ','')    
--print substring(@roleids,1,len(@roleids)-1)  --打印出用户所拥有的角色id  
set @sql=    
'select m.Id menuid,m.Name menuname,m.ParentId parentid,m.Icon menuicon,mb.ButtonId buttonid,b.Name buttonname,b.Icon buttonicon,rmb.RoleId roleid,  
case      
when isnull(rmb.ButtonId,0) = 0   
then ''false'' else ''true''    
end checked    
from tbMenu m  
left join tbMenuButton mb on m.Id=mb.MenuId  
left join tbButton b on mb.ButtonId=b.Id    
left join tbRoleMenuButton rmb on (mb.MenuId=rmb.MenuId and mb.ButtonId=rmb.ButtonId and rmb.RoleId in ('    
+    
isnull(substring(@roleIds,1,len(@roleIds)-1),0)    
+'))    
order by m.ParentId,m.Sort,b.Sort'  
--print @sql    
exec (@sql)



GO
/****** Object:  StoredProcedure [dbo].[sp_MvcPager]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_MvcPager]
	@PageSize INT, ----每页记录数
	@CurrentCount INT, ----当前记录数量（页码*每页记录数）
	@TableName NVARCHAR(200), ----表名称
	@Where NVARCHAR(800), ----查询条件
	@Order NVARCHAR(800),----排序条件
	@TotalCount INT OUTPUT ----记录总数
AS
	DECLARE @sqlSelect    NVARCHAR(2000) ----局部变量（sql语句），查询记录集
	DECLARE @sqlGetCount  NVARCHAR(2000) ----局部变量（sql语句），取出记录集总数
	
	
	SET @sqlSelect = 'SELECT * FROM  ' 
	    + '    (SELECT ROW_NUMBER()  OVER( ORDER BY ' + @Order +
	    ' ) AS RowNumber,* '
	    + '        FROM ' + @TableName 
	    + '        WHERE ' + @Where 
	    + '     ) as  T2 ' 
	    + ' WHERE T2.RowNumber<= ' + STR(@CurrentCount + @PageSize) +
	    ' AND T2.RowNumber>' + STR(@CurrentCount) 
	
	SET @sqlGetCount = 'SELECT @TotalCount = COUNT(*) FROM ' + @TableName 
	    + ' WHERE ' + @Where
	
	
	EXEC (@sqlSelect) 
	EXEC SP_EXECUTESQL @sqlGetCount,
	     N'@TotalCount INT OUTPUT',
	     @TotalCount OUTPUT




GO
/****** Object:  StoredProcedure [dbo].[sp_Pager]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_Pager]
@tableName varchar(64),  --分页表名
@columns varchar(512),  --查询的字段
@order varchar(256),    --排序方式
@pageSize int,  --每页大小
@pageIndex int,  --当前页
@where varchar(1024) = '1=1',  --查询条件
@totalCount int output  --总记录数
as
declare @beginIndex int,@endIndex int,@sqlResult nvarchar(2000),@sqlGetCount nvarchar(2000)
set @beginIndex = (@pageIndex - 1) * @pageSize + 1  --开始
set @endIndex = (@pageIndex) * @pageSize  --结束
set @sqlresult = 'select '+@columns+' from (
select row_number() over(order by '+ @order +')
as Rownum,'+@columns+'
from '+@tableName+' where '+ @where +') as T
where T.Rownum between ' + CONVERT(varchar(max),@beginIndex) + ' and ' + CONVERT(varchar(max),@endIndex)
set @sqlGetCount = 'select @totalCount = count(*) from '+@tablename+' where ' + @where  --总数
--print @sqlresult
exec(@sqlresult)
exec sp_executesql @sqlGetCount,N'@totalCount int output',@totalCount output
--测试调用：
--declare @total int
--exec sp_Pager 'tbLoginInfo','Id,UserName,Success','LoginDate','desc',4,2,'1=1',@total output
--print @total




GO
/****** Object:  StoredProcedure [dbo].[sp_SetRoleAuthorize]    Script Date: 2016/6/28 16:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_SetRoleAuthorize]
	@RoleId INT,
	@MenuButtonIds NVARCHAR(MAX)	--5 1,5 2,7 1,10 1,11 1
AS
BEGIN
	DECLARE @MenuButtonID NVARCHAR(200)
	DECLARE @MenuID NVARCHAR(200)
	DECLARE @ButtonID NVARCHAR(200)
	-- 此存储过程有数据逻辑待处理 暂不使用
	--开始事务
	BEGIN TRAN  
	DECLARE @tran_error INT;
	
	SET @tran_error = 0;
	BEGIN TRY
		-- 先删除
		DELETE 
		FROM   tbRoleMenuButton
		WHERE  RoleId = @RoleId ;
		SET @tran_error = @tran_error + @@ERROR;
		
		-- 获取采购按钮ID数据集合		
		DECLARE cur_data CURSOR  
		FOR
		    SELECT str2table menubuttonid
		    FROM   dbo.func_SplitStrToTable(@MenuButtonIds) AS fsstt
		
		OPEN cur_data
		FETCH NEXT FROM cur_data INTO @MenuButtonID
		WHILE @@FETCH_STATUS = 0
		BEGIN
		    BEGIN
		    	SET @MenuID = SUBSTRING(@MenuButtonID, 1, CHARINDEX(' ', @MenuButtonID) -1)
		    	SET @ButtonID = REVERSE(
		    	        SUBSTRING(
		    	            REVERSE(@MenuButtonID),
		    	            1,
		    	            CHARINDEX(' ', REVERSE(@MenuButtonID)) - 1
		    	        )
		    	) ;
		    	
		    	--  INSERT INTO tbRoleMenuButton(RoleId,MenuId,ButtonId)
		    	--  VALUES(@RoleId,@MenuID,@ButtonID) ;
		    	
		    	-- 递归插入数据
		    	WITH Menu_Temp
		    	     AS (
		    	         SELECT Id,NAME,ParentId
		    	         FROM   tbMenu
		    	         WHERE  Id = @MenuID  --第一个查询作为递归的基点(锚点)
		    	         UNION ALL
		    	         SELECT tbMenu.Id,tbMenu.Name,tbMenu.ParentId  --第二个查询作为递归成员， 下属成员的结果为空时，此递归结束。
		    	         FROM   Menu_Temp INNER JOIN tbMenu ON  Menu_Temp.ParentId = tbMenu.Id
		    	     )
		    	
		    	SELECT @RoleId RoleId,Id ,(CASE WHEN Id=@MenuID THEN @ButtonID ELSE 0 END )ButtonID INTO #MenuTemp
		    	FROM Menu_Temp 
		    	
		    	-- 先清除掉 避免插入重复数据
		    	DELETE FROM #MenuTemp WHERE Id IN (
		    		SELECT MenuId FROM tbRoleMenuButton WHERE RoleId=@RoleId
		    	)
		    	
		    	-- 插入 
		    	INSERT INTO tbRoleMenuButton(RoleId,MenuId,ButtonId)
		    	SELECT @RoleId,Id,(CASE WHEN Id=@MenuID THEN @ButtonID ELSE 0 END )
		    	FROM #MenuTemp 
		    	
		    	DROP TABLE #MenuTemp
		    	
		    END
		    FETCH NEXT FROM cur_data INTO @MenuButtonID
		END
		CLOSE cur_data;
		DEALLOCATE cur_data;
		SET @tran_error = @tran_error + @@ERROR;
	END TRY
	
	BEGIN CATCH
		PRINT '出现异常，错误编号：' + CONVERT(VARCHAR, ERROR_NUMBER()) +
		',错误消息：' + ERROR_MESSAGE()
		SET @tran_error = @tran_error + 1
	END CATCH
	
	IF (@tran_error > 0)
	BEGIN
	    --执行出错，回滚事务
	    ROLLBACK TRAN;
	    PRINT '角色权限设置失败!';
	END
	ELSE
	BEGIN
	    --没有异常，提交事务
	    COMMIT TRAN;
	    PRINT '角色权限设置成功!';
	END
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'字段名（数据库）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbFields', @level2type=N'COLUMN',@level2name=N'FieldName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'字段显示名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbFields', @level2type=N'COLUMN',@level2name=N'FieldViewName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbFields', @level2type=N'COLUMN',@level2name=N'FieldDataTypeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbNews', @level2type=N'COLUMN',@level2name=N'ftypeid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbNews', @level2type=N'COLUMN',@level2name=N'ftitle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbNews', @level2type=N'COLUMN',@level2name=N'fcontent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbRequestion', @level2type=N'COLUMN',@level2name=N'ftypeid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbRequestion', @level2type=N'COLUMN',@level2name=N'ftitle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbRequestion', @level2type=N'COLUMN',@level2name=N'fcontent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbRole', @level2type=N'COLUMN',@level2name=N'UpdateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'帐户ID(网站关联的AccountID)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbUser', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'帐户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbUser', @level2type=N'COLUMN',@level2name=N'AccountName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'帐户密码（32位MD5加密）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbUser', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系人手机号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbUser', @level2type=N'COLUMN',@level2name=N'MobilePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系的邮箱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbUser', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'介绍描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbUser', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbUser', @level2type=N'COLUMN',@level2name=N'UpdateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tr"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 145
               Right = 218
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "trt"
            Begin Extent = 
               Top = 6
               Left = 256
               Bottom = 145
               Right = 436
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_requestion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_requestion'
GO
