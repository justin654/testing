PRINT N'Creating table types...'
GO
PRINT N'Creating [dbo].[AttachedItem]'
GO
CREATE TYPE [dbo].[AttachedItem] AS TABLE(
	[item_key] [bigint] NOT NULL,
	[item_amount] [int] NOT NULL
)
GO
PRINT N'Creating [dbo].[AttachItem]'
GO
CREATE TYPE [dbo].[AttachItem] AS TABLE(
	[item_id] [bigint] NOT NULL
)
GO
PRINT N'Creating [dbo].[CashRackParam]'
GO
CREATE TYPE [dbo].[CashRackParam] AS TABLE(
	[rack_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[amount] [int] NOT NULL,
	[price] [int] NOT NULL,
	[is_limited_per_char] [bit] NOT NULL,
	[is_amount_limited] [bit] NULL
)
GO
PRINT N'Creating [dbo].[DBIDList]'
GO
CREATE TYPE [dbo].[DBIDList] AS TABLE(
	[dbid] [bigint] NOT NULL
)
GO
PRINT N'Creating [dbo].[DungeonKey]'
GO
CREATE TYPE [dbo].[DungeonKey] AS TABLE(
	[CreateTime] [bigint] NOT NULL,
	[DungeonOID] [bigint] NOT NULL,
	[DungeonClassID] [int] NOT NULL
)
GO
PRINT N'Creating [dbo].[IDLevKeyTable]'
GO
CREATE TYPE [dbo].[IDLevKeyTable] AS TABLE(
	[skill_id] [int] NOT NULL,
	[skill_level] [smallint] NOT NULL
)
GO
PRINT N'Creating [dbo].[IntIntTable]'
GO
CREATE TYPE [dbo].[IntIntTable] AS TABLE(
	[first] [int] NOT NULL,
	[second] [int] NOT NULL
)
GO
PRINT N'Creating [dbo].[IntTable]'
GO
CREATE TYPE [dbo].[IntTable] AS TABLE(
	[ID] [int] NULL
)
GO
PRINT N'Creating [dbo].[ItemGemList]'
GO
CREATE TYPE [dbo].[ItemGemList] AS TABLE(
	[item_id] [bigint] NOT NULL,
	[gem_class_id] [int] NOT NULL,
	[socket_index] [int] NOT NULL
)
GO
PRINT N'Creating [dbo].[ItemParam]'
GO
CREATE TYPE [dbo].[ItemParam] AS TABLE(
	[item_oid] [bigint] NULL,
	[item_dbid] [bigint] NOT NULL,
	[owner_dbid] [int] NOT NULL,
	[bag_dbid] [int] NOT NULL,
	[class_id] [int] NOT NULL,
	[amount] [int] NOT NULL,
	[slot_index] [int] NOT NULL,
	[repository_type] [int] NULL
)
GO
PRINT N'Creating [dbo].[NewItemList]'
GO
CREATE TYPE [dbo].[NewItemList] AS TABLE(
	[row_id] [int] NOT NULL,
	[class_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[durability] [int] NULL,
	[expiration_date] [int] NULL,
	[seal_count] [int] NULL,
	[possessed] [int] NULL,
	[identified] [int] NULL,
	[grade] [int] NULL,
	[experience] [float] NULL
)
GO
PRINT N'Creating [dbo].[RandomOptionList]'
GO
CREATE TYPE [dbo].[RandomOptionList] AS TABLE(
	[item_row_id] [int] NOT NULL,
	[type] [tinyint] NOT NULL,
	[value] [int] NOT NULL
)
GO
PRINT N'Creating [dbo].[SearchItem]'
GO
CREATE TYPE [dbo].[SearchItem] AS TABLE(
	[item] [int] NULL
)
GO
PRINT N'Creating [dbo].[ShortCutTable]'
GO
CREATE TYPE [dbo].[ShortCutTable] AS TABLE(
	[slot_no] [tinyint] NOT NULL,
	[reg_type] [tinyint] NOT NULL,
	[reg_id] [int] NOT NULL
)
GO
PRINT N'Creating [dbo].[TinyintIntPair]'
GO
CREATE TYPE [dbo].[TinyintIntPair] AS TABLE(
	[param1] [tinyint] NOT NULL,
	[param2] [int] NOT NULL
)
GO
PRINT N'Creating [dbo].[TripleIntParam]'
GO
CREATE TYPE [dbo].[TripleIntParam] AS TABLE(
	[first] [int] NOT NULL,
	[second] [int] NOT NULL,
	[third] [int] NOT NULL
)
GO
PRINT N'Creating [dbo].[UserPostTable]'
GO
CREATE TYPE [dbo].[UserPostTable] AS TABLE(
	[user_id] [int] NOT NULL,
	[post_id] [int] NOT NULL,
	[attached_item_count] [int] NOT NULL,
	[money] [bigint] NOT NULL
)
GO
PRINT N'Creating user functions...'
GO
PRINT N'Creating [dbo].[ConvertToDateTime32]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ConvertToDateTime32](@time_t INT)
RETURNS DATETIME
AS
BEGIN
	DECLARE @time_differential INT
	DECLARE @date_time DATETIME

	SET @time_differential = DATEDIFF(HOUR, GETUTCDATE(), GETDATE())
	SET @date_time = DATEADD(HOUR, @time_differential, DATEADD(SECOND, @time_t, '1970-01-01 00:00:00'))

	RETURN @date_time
END
GO
PRINT N'Creating [dbo].[ConvertToTimeT32]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ConvertToTimeT32](@date_time DATETIME)
RETURNS INT
AS
BEGIN
	DECLARE @time_differential INT
	DECLARE @time_t INT

	SET @time_differential = DATEDIFF(HOUR, GETUTCDATE(), GETDATE())
	SET @time_t = DATEDIFF(SECOND, DATEADD(HOUR, @time_differential, '1970-01-01 00:00:00'), @date_time)

	RETURN @time_t
END
GO
PRINT N'Creating tables...'
GO
PRINT N'Creating [dbo].[SB_ACCOUNT]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_ACCOUNT](
	[ID] [bigint] NOT NULL,
	[name] [nvarchar](64) NOT NULL,
	[created_time] [datetime] NOT NULL,
	[login_time] [datetime] NULL,
	[logout_time] [datetime] NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [CL_SB_ACCOUNT_ID] ON [dbo].[SB_ACCOUNT] 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_SB_ACCOUNT_NAME] ON [dbo].[SB_ACCOUNT] 
(
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'계정 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ACCOUNT', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'계정명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ACCOUNT', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'계정 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ACCOUNT'
GO
PRINT N'Creating [dbo].[SB_ANNOUNCE]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_ANNOUNCE](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[type] [int] NOT NULL,
	[cycle] [int] NOT NULL,
	[msg] [nvarchar](1024) NOT NULL,
 CONSTRAINT [PK_SB_ANNOUNCE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공지 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ANNOUNCE', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공지 타입(1:Chat, 2:Center, 4:Ticker)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ANNOUNCE', @level2type=N'COLUMN',@level2name=N'type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공지 주기' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ANNOUNCE', @level2type=N'COLUMN',@level2name=N'cycle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공지 내용' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ANNOUNCE', @level2type=N'COLUMN',@level2name=N'msg'
GO
PRINT N'Creating [dbo].[SB_ARENA_TEAM]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_ARENA_TEAM](
	[team_dbid] [int] NOT NULL,
	[team_name] [nvarchar](64) NOT NULL,
	[team_type] [tinyint] NOT NULL,
	[master_dbid] [int] NOT NULL,
	[deleted] [tinyint] NULL,
 CONSTRAINT [PK_SB_ARENA_TEAM] PRIMARY KEY CLUSTERED 
(
	[team_dbid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'투기장팀 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM', @level2type=N'COLUMN',@level2name=N'team_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'투기장팀 명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM', @level2type=N'COLUMN',@level2name=N'team_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'투기장팀 타입(5인, 3인 등등)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM', @level2type=N'COLUMN',@level2name=N'team_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'팀장 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM', @level2type=N'COLUMN',@level2name=N'master_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'해산 여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM', @level2type=N'COLUMN',@level2name=N'deleted'
GO
PRINT N'Creating [dbo].[SB_ARENA_TEAM_AWARD]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_ARENA_TEAM_AWARD](
	[user_dbid] [int] NOT NULL,
	[unpayed_award] [int] NOT NULL,
 CONSTRAINT [PK_SB_ARENA_TEAM_AWARD] PRIMARY KEY CLUSTERED 
(
	[user_dbid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_AWARD', @level2type=N'COLUMN',@level2name=N'user_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'정산시 미접속중인 유저에게 지급되어야 하는 훈장. 접속시 받게 된다.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_AWARD', @level2type=N'COLUMN',@level2name=N'unpayed_award'
GO
PRINT N'Creating [dbo].[SB_ARENA_TEAM_MEMBER]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_ARENA_TEAM_MEMBER](
	[team_dbid] [int] NOT NULL,
	[member_dbid] [int] NOT NULL,
 CONSTRAINT [PK_SB_ARENA_TEAM_MEMBER] PRIMARY KEY CLUSTERED 
(
	[team_dbid] ASC,
	[member_dbid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'투기장팀 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_MEMBER', @level2type=N'COLUMN',@level2name=N'team_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'투기장팀원 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_MEMBER', @level2type=N'COLUMN',@level2name=N'member_dbid'
GO
PRINT N'Creating [dbo].[SB_ARENA_TEAM_MEMBER_RECORD_SEASON]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_ARENA_TEAM_MEMBER_RECORD_SEASON](
	[team_dbid] [int] NOT NULL,
	[member_dbid] [int] NOT NULL,
	[season_no] [int] NOT NULL,
	[season_win] [int] NOT NULL,
	[season_lose] [int] NOT NULL,
	[season_draw] [int] NOT NULL,
	[season_win_in_row] [int] NOT NULL,
	[season_lose_in_row] [int] NOT NULL,
	[season_elo] [int] NOT NULL,
 CONSTRAINT [PK_SB_ARENA_TEAM_MEMBER_RECORD_SEASON] PRIMARY KEY CLUSTERED 
(
	[team_dbid] ASC,
	[member_dbid] ASC,
	[season_no] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'투기장팀 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_MEMBER_RECORD_SEASON', @level2type=N'COLUMN',@level2name=N'team_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'투기장팀원 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_MEMBER_RECORD_SEASON', @level2type=N'COLUMN',@level2name=N'member_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌no' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_MEMBER_RECORD_SEASON', @level2type=N'COLUMN',@level2name=N'season_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 승' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_MEMBER_RECORD_SEASON', @level2type=N'COLUMN',@level2name=N'season_win'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 패' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_MEMBER_RECORD_SEASON', @level2type=N'COLUMN',@level2name=N'season_lose'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 무승부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_MEMBER_RECORD_SEASON', @level2type=N'COLUMN',@level2name=N'season_draw'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 연승' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_MEMBER_RECORD_SEASON', @level2type=N'COLUMN',@level2name=N'season_win_in_row'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 연패' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_MEMBER_RECORD_SEASON', @level2type=N'COLUMN',@level2name=N'season_lose_in_row'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 평점' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_MEMBER_RECORD_SEASON', @level2type=N'COLUMN',@level2name=N'season_elo'
GO
PRINT N'Creating [dbo].[SB_ARENA_TEAM_MEMBER_RECORD_WEEK]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_ARENA_TEAM_MEMBER_RECORD_WEEK](
	[team_dbid] [int] NOT NULL,
	[member_dbid] [int] NOT NULL,
	[season_no] [int] NOT NULL,
	[week_no] [int] NOT NULL,
	[week_win] [int] NOT NULL,
	[week_lose] [int] NOT NULL,
	[week_draw] [int] NOT NULL,
 CONSTRAINT [PK_SB_ARENA_TEAM_MEMBER_RECORD_WEEK] PRIMARY KEY CLUSTERED 
(
	[team_dbid] ASC,
	[member_dbid] ASC,
	[season_no] ASC,
	[week_no] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'투기장팀 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_MEMBER_RECORD_WEEK', @level2type=N'COLUMN',@level2name=N'team_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'투기장팀원 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_MEMBER_RECORD_WEEK', @level2type=N'COLUMN',@level2name=N'member_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'투기장 시즌no' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_MEMBER_RECORD_WEEK', @level2type=N'COLUMN',@level2name=N'season_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'투기장 시즌 중 주no' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_MEMBER_RECORD_WEEK', @level2type=N'COLUMN',@level2name=N'week_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주간 승' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_MEMBER_RECORD_WEEK', @level2type=N'COLUMN',@level2name=N'week_win'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주간 패' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_MEMBER_RECORD_WEEK', @level2type=N'COLUMN',@level2name=N'week_lose'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주간 무승부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_MEMBER_RECORD_WEEK', @level2type=N'COLUMN',@level2name=N'week_draw'
GO
PRINT N'Creating [dbo].[SB_ARENA_TEAM_RECORD_SEASON]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_ARENA_TEAM_RECORD_SEASON](
	[team_dbid] [int] NOT NULL,
	[season_no] [int] NOT NULL,
	[season_win] [int] NOT NULL,
	[season_lose] [int] NOT NULL,
	[season_draw] [int] NOT NULL,
	[season_win_in_row] [int] NOT NULL,
	[season_lose_in_row] [int] NOT NULL,
	[season_elo] [int] NOT NULL,
 CONSTRAINT [PK_SB_ARENA_TEAM_SEASON] PRIMARY KEY CLUSTERED 
(
	[team_dbid] ASC,
	[season_no] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'투기장팀 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_RECORD_SEASON', @level2type=N'COLUMN',@level2name=N'team_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌no' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_RECORD_SEASON', @level2type=N'COLUMN',@level2name=N'season_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 승' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_RECORD_SEASON', @level2type=N'COLUMN',@level2name=N'season_win'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 패' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_RECORD_SEASON', @level2type=N'COLUMN',@level2name=N'season_lose'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 무승부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_RECORD_SEASON', @level2type=N'COLUMN',@level2name=N'season_draw'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 연승' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_RECORD_SEASON', @level2type=N'COLUMN',@level2name=N'season_win_in_row'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 연패' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_RECORD_SEASON', @level2type=N'COLUMN',@level2name=N'season_lose_in_row'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 평점' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_RECORD_SEASON', @level2type=N'COLUMN',@level2name=N'season_elo'
GO
PRINT N'Creating [dbo].[SB_ARENA_TEAM_RECORD_WEEK]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_ARENA_TEAM_RECORD_WEEK](
	[team_dbid] [int] NOT NULL,
	[season_no] [int] NOT NULL,
	[week_no] [int] NOT NULL,
	[week_win] [int] NOT NULL,
	[week_lose] [int] NOT NULL,
	[week_draw] [int] NOT NULL,
 CONSTRAINT [PK_SB_ARENA_TEAM_RECORD_WEEK] PRIMARY KEY CLUSTERED 
(
	[team_dbid] ASC,
	[season_no] ASC,
	[week_no] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'투기장팀 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_RECORD_WEEK', @level2type=N'COLUMN',@level2name=N'team_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'투기장 시즌no' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_RECORD_WEEK', @level2type=N'COLUMN',@level2name=N'season_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'투기장 시즌 중 주no' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_RECORD_WEEK', @level2type=N'COLUMN',@level2name=N'week_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주간 승' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_RECORD_WEEK', @level2type=N'COLUMN',@level2name=N'week_win'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주간 패' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_RECORD_WEEK', @level2type=N'COLUMN',@level2name=N'week_lose'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주간 무승부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_TEAM_RECORD_WEEK', @level2type=N'COLUMN',@level2name=N'week_draw'
GO
PRINT N'Creating [dbo].[SB_ARENA_WEEK]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_ARENA_WEEK](
	[season_no] [int] NOT NULL,
	[week_no] [int] NOT NULL,
	[week_start_time] [datetime] NOT NULL,
 CONSTRAINT [PK_SB_ARENA_WEEK] PRIMARY KEY CLUSTERED 
(
	[season_no] ASC,
	[week_no] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'투기장 시즌no' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_WEEK', @level2type=N'COLUMN',@level2name=N'season_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'투기장 시즌 중 주no' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_WEEK', @level2type=N'COLUMN',@level2name=N'week_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주 시작 시각' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ARENA_WEEK', @level2type=N'COLUMN',@level2name=N'week_start_time'
GO
PRINT N'Creating [dbo].[SB_BAN]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_BAN](
	[user_id] [int] NOT NULL,
	[ban_id] [int] NOT NULL,
	[created_time] [datetime] NULL,
 CONSTRAINT [PK_SB_BAN_USER_ID_BAN_ID] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[ban_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_BAN', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'차단 유저 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_BAN', @level2type=N'COLUMN',@level2name=N'ban_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'생성 시각' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_BAN', @level2type=N'COLUMN',@level2name=N'created_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'차단 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_BAN'
GO
ALTER TABLE [dbo].[SB_BAN] ADD  CONSTRAINT [DF_SB_BAN_created_time]  DEFAULT (getdate()) FOR [created_time]
GO
PRINT N'Creating [dbo].[SB_BUDDY]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_BUDDY](
	[user_id] [int] NOT NULL,
	[buddy_id] [int] NOT NULL,
	[created_time] [datetime] NULL,
 CONSTRAINT [PK_SB_BUDDY_USER_ID_BUDDY_ID] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[buddy_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SB_BUDDY_BUDDY_ID] ON [dbo].[SB_BUDDY] 
(
	[buddy_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_BUDDY', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'친구 유저 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_BUDDY', @level2type=N'COLUMN',@level2name=N'buddy_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'생성 시각' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_BUDDY', @level2type=N'COLUMN',@level2name=N'created_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'친구 목록' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_BUDDY'
GO
ALTER TABLE [dbo].[SB_BUDDY] ADD  CONSTRAINT [DF_SB_BUDDY_created_time]  DEFAULT (getdate()) FOR [created_time]
GO
PRINT N'Creating [dbo].[SB_DUEL_ARENA]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_DUEL_ARENA](
	[user_dbid] [int] NOT NULL,
	[season_no] [int] NOT NULL,
	[season_win] [int] NOT NULL,
	[season_lose] [int] NOT NULL,
	[season_draw] [int] NOT NULL,
	[season_win_in_row] [int] NOT NULL,
	[season_lose_in_row] [int] NOT NULL,
	[season_elo] [int] NOT NULL,
 CONSTRAINT [PK_SB_DUEL_ARENA] PRIMARY KEY CLUSTERED 
(
	[user_dbid] ASC,
	[season_no] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_DUEL_ARENA', @level2type=N'COLUMN',@level2name=N'user_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'투기장 시즌no' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_DUEL_ARENA', @level2type=N'COLUMN',@level2name=N'season_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 승' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_DUEL_ARENA', @level2type=N'COLUMN',@level2name=N'season_win'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 패' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_DUEL_ARENA', @level2type=N'COLUMN',@level2name=N'season_lose'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 무승부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_DUEL_ARENA', @level2type=N'COLUMN',@level2name=N'season_draw'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 연승' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_DUEL_ARENA', @level2type=N'COLUMN',@level2name=N'season_win_in_row'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 연패' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_DUEL_ARENA', @level2type=N'COLUMN',@level2name=N'season_lose_in_row'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 평점' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_DUEL_ARENA', @level2type=N'COLUMN',@level2name=N'season_elo'
GO
PRINT N'Creating [dbo].[SB_DUEL_ARENA_DETAIL]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_DUEL_ARENA_DETAIL](
	[user_dbid] [int] NOT NULL,
	[season_no] [int] NOT NULL,
	[job_type] [int] NOT NULL,
	[talent_type] [int] NOT NULL,
	[enemy_job_type] [int] NOT NULL,
	[enemy_talent_type] [int] NOT NULL,
	[season_win] [int] NOT NULL,
	[season_lose] [int] NOT NULL,
	[season_draw] [int] NOT NULL,
 CONSTRAINT [PK_DUEL_ARENA_DETAIL] PRIMARY KEY CLUSTERED 
(
	[user_dbid] ASC,
	[season_no] ASC,
	[job_type] ASC,
	[talent_type] ASC,
	[enemy_job_type] ASC,
	[enemy_talent_type] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
PRINT N'Creating [dbo].[SB_DUEL_ARENA_WEEK]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_DUEL_ARENA_WEEK](
	[user_dbid] [int] NOT NULL,
	[season_no] [int] NOT NULL,
	[week_no] [int] NOT NULL,
	[week_win] [int] NOT NULL,
	[week_lose] [int] NOT NULL,
	[week_draw] [int] NOT NULL,
 CONSTRAINT [PK_SB_DUEL_ARENA_WEEK] PRIMARY KEY CLUSTERED 
(
	[user_dbid] ASC,
	[season_no] ASC,
	[week_no] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_DUEL_ARENA_WEEK', @level2type=N'COLUMN',@level2name=N'user_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'투기장 시즌no' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_DUEL_ARENA_WEEK', @level2type=N'COLUMN',@level2name=N'season_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'투기장 시즌 중 주no' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_DUEL_ARENA_WEEK', @level2type=N'COLUMN',@level2name=N'week_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주간 승' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_DUEL_ARENA_WEEK', @level2type=N'COLUMN',@level2name=N'week_win'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주간 패' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_DUEL_ARENA_WEEK', @level2type=N'COLUMN',@level2name=N'week_lose'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주간 무승부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_DUEL_ARENA_WEEK', @level2type=N'COLUMN',@level2name=N'week_draw'
GO
PRINT N'Creating [dbo].[SB_GUILD]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_GUILD](
	[ID] [int] NOT NULL,
	[name] [nvarchar](64) NULL,
	[type] [int] NULL,
	[totype] [int] NULL,
	[masterDBID] [int] NOT NULL,
	[mark] [int] NOT NULL,
	[level] [int] NOT NULL,
	[exp] [int] NOT NULL,
	[sub_right] [int] NOT NULL,
	[senior_right] [int] NOT NULL,
	[junior_right] [int] NOT NULL,
	[newbie_right] [int] NOT NULL,
	[delegate_time] [datetime] NULL,
	[disband_time] [datetime] NULL,
	[recover_time] [datetime] NULL,
	[type_change_time] [datetime] NULL,
	[war_point] [int] NULL,
	[money] [bigint] NULL,
	[deleted] [int] NULL,
	[pre_season_rank] [int] NOT NULL,
 CONSTRAINT [PK_SB_GUILD_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UQ_SB_GUILD_NAME] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [NC_SB_GUILD_masterDBID] ON [dbo].[SB_GUILD] 
(
	[masterDBID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드 아이디' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드의 현재타입' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD', @level2type=N'COLUMN',@level2name=N'type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드의 예약된 타입 (전쟁 혹은 평화)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD', @level2type=N'COLUMN',@level2name=N'totype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드장의 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD', @level2type=N'COLUMN',@level2name=N'masterDBID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드 마크' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD', @level2type=N'COLUMN',@level2name=N'mark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드 자체의 레벨' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD', @level2type=N'COLUMN',@level2name=N'level'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드 레벨을 위한 경험치' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD', @level2type=N'COLUMN',@level2name=N'exp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'부길드장 권한' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD', @level2type=N'COLUMN',@level2name=N'sub_right'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상급길드원 권한' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD', @level2type=N'COLUMN',@level2name=N'senior_right'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'중급 길드원 권한' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD', @level2type=N'COLUMN',@level2name=N'junior_right'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'초급길드원의 권한' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD', @level2type=N'COLUMN',@level2name=N'newbie_right'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드장권한 위임시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD', @level2type=N'COLUMN',@level2name=N'delegate_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드 해체 시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD', @level2type=N'COLUMN',@level2name=N'disband_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드 복구 시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD', @level2type=N'COLUMN',@level2name=N'recover_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최근 길드 타입 변경 시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD', @level2type=N'COLUMN',@level2name=N'type_change_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전쟁 포인트 (킬,데스로 발생함)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD', @level2type=N'COLUMN',@level2name=N'war_point'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드가 가진 돈' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD', @level2type=N'COLUMN',@level2name=N'money'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드가 완전히 삭제된 지 여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD', @level2type=N'COLUMN',@level2name=N'deleted'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD'
GO
ALTER TABLE [dbo].[SB_GUILD] ADD  CONSTRAINT [DF_SB_GUILD_type]  DEFAULT ((0)) FOR [type]
GO
ALTER TABLE [dbo].[SB_GUILD] ADD  CONSTRAINT [DF_SB_GUILD_totype]  DEFAULT ((0)) FOR [totype]
GO
ALTER TABLE [dbo].[SB_GUILD] ADD  CONSTRAINT [DF_SB_GUILD_war_point]  DEFAULT ((0)) FOR [war_point]
GO
ALTER TABLE [dbo].[SB_GUILD] ADD  CONSTRAINT [DF_SB_GUILD_money]  DEFAULT ((0)) FOR [money]
GO
ALTER TABLE [dbo].[SB_GUILD] ADD  CONSTRAINT [DF_SB_GUILD_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[SB_GUILD] ADD  CONSTRAINT [DF_SB_GUILD_pre_season_rank]  DEFAULT ((0)) FOR [pre_season_rank]
GO
PRINT N'Creating [dbo].[SB_GUILD_DOMINION]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_GUILD_DOMINION](
	[spotID] [int] NOT NULL,
	[ownerGuildDBID] [int] NOT NULL,
	[weekNo] [int] NOT NULL,
 CONSTRAINT [PK_SB_GUILD_DOMINION] PRIMARY KEY CLUSTERED 
(
	[spotID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
PRINT N'Creating [dbo].[SB_GUILD_FRIENDSHIP]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_GUILD_FRIENDSHIP](
	[guild_dbid_from] [int] NOT NULL,
	[guild_dbid_to] [int] NOT NULL,
	[created_date] [datetime] NOT NULL,
 CONSTRAINT [PK_SB_GUILD_FRIENDSHIP] PRIMARY KEY CLUSTERED 
(
	[guild_dbid_from] ASC,
	[guild_dbid_to] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SB_GUILD_FREINDSHIP_GUILD_DBID_TO] ON [dbo].[SB_GUILD_FRIENDSHIP] 
(
	[guild_dbid_to] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'guild friendship from(< to)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_FRIENDSHIP', @level2type=N'COLUMN',@level2name=N'guild_dbid_from'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'guild friendship to(> from)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_FRIENDSHIP', @level2type=N'COLUMN',@level2name=N'guild_dbid_to'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'friendship created date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_FRIENDSHIP', @level2type=N'COLUMN',@level2name=N'created_date'
GO
ALTER TABLE [dbo].[SB_GUILD_FRIENDSHIP] ADD  CONSTRAINT [DF_SB_GUILD_FRIENDSHIP_CREATED_DATE]  DEFAULT (getdate()) FOR [created_date]
GO
PRINT N'Creating [dbo].[SB_GUILD_HISTORY]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_GUILD_HISTORY](
	[guildID] [int] NOT NULL,
	[historyType] [int] NOT NULL,
	[memberName] [nvarchar](64) NOT NULL,
	[targetGuildName] [nvarchar](64) NOT NULL,
	[targetMemberName] [nvarchar](64) NOT NULL,
	[itemClassID] [int] NULL,
	[itemAmount] [int] NULL,
	[fromGrade] [int] NULL,
	[toGrade] [int] NULL,
	[guildLevel] [int] NULL,
	[money] [bigint] NULL,
	[logTime] [datetime] NOT NULL,
	[itemDBID] [bigint] NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_SB_GUILD_HISTORY] ON [dbo].[SB_GUILD_HISTORY] 
(
	[guildID] ASC,
	[logTime] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드 아이디' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_HISTORY', @level2type=N'COLUMN',@level2name=N'guildID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'히스토리 타입(일반, 전쟁, 창고)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_HISTORY', @level2type=N'COLUMN',@level2name=N'historyType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'히스토리를 남긴 길드원의 이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_HISTORY', @level2type=N'COLUMN',@level2name=N'memberName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'대상 길드 이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_HISTORY', @level2type=N'COLUMN',@level2name=N'targetGuildName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'대상 길드원의 이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_HISTORY', @level2type=N'COLUMN',@level2name=N'targetMemberName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 식별자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_HISTORY', @level2type=N'COLUMN',@level2name=N'itemClassID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 개수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_HISTORY', @level2type=N'COLUMN',@level2name=N'itemAmount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드원의 이전 권한' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_HISTORY', @level2type=N'COLUMN',@level2name=N'fromGrade'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드원의 이후 권한' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_HISTORY', @level2type=N'COLUMN',@level2name=N'toGrade'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드 레벨' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_HISTORY', @level2type=N'COLUMN',@level2name=N'guildLevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드 머니' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_HISTORY', @level2type=N'COLUMN',@level2name=N'money'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드 히스토리를 남긴 시점' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_HISTORY', @level2type=N'COLUMN',@level2name=N'logTime'
GO
PRINT N'Creating [dbo].[SB_GUILD_LAIR_TIME_ATTACK]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_GUILD_LAIR_TIME_ATTACK](
	[guild_db_id] [int] NOT NULL,
	[elapsed_seconds] [int] NOT NULL,
 CONSTRAINT [PK_SB_GUILD_LAIR_TIME_ATTACK] PRIMARY KEY CLUSTERED 
(
	[guild_db_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
PRINT N'Creating [dbo].[SB_GUILD_MEMBER]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_GUILD_MEMBER](
	[guildID] [int] NOT NULL,
	[memberDBID] [int] NOT NULL,
	[grade] [int] NOT NULL,
	[kill_count] [int] NULL,
	[death_count] [int] NULL,
	[memo] [nvarchar](25) NULL,
	[join_date] [datetime] NOT NULL,
 CONSTRAINT [PK_SB_GUILD_MEMBER] PRIMARY KEY CLUSTERED 
(
	[memberDBID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SB_GUILD_MEMBER_GUILDID] ON [dbo].[SB_GUILD_MEMBER] 
(
	[guildID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드 아이디' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_MEMBER', @level2type=N'COLUMN',@level2name=N'guildID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드원의 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_MEMBER', @level2type=N'COLUMN',@level2name=N'memberDBID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드원 등급' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_MEMBER', @level2type=N'COLUMN',@level2name=N'grade'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드원의 킬수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_MEMBER', @level2type=N'COLUMN',@level2name=N'kill_count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드원의 죽은 횟수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_MEMBER', @level2type=N'COLUMN',@level2name=N'death_count'
GO
ALTER TABLE [dbo].[SB_GUILD_MEMBER] ADD  CONSTRAINT [DF_SB_GUILD_MEMBER_kill_count]  DEFAULT ((0)) FOR [kill_count]
GO
ALTER TABLE [dbo].[SB_GUILD_MEMBER] ADD  CONSTRAINT [DF_SB_GUILD_MEMBER_death_count]  DEFAULT ((0)) FOR [death_count]
GO
ALTER TABLE [dbo].[SB_GUILD_MEMBER] ADD  CONSTRAINT [DF_SB_GUILD_MEMBER_join_date]  DEFAULT (getdate()) FOR [join_date]
GO
PRINT N'Creating [dbo].[SB_GUILD_NOTICE]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_GUILD_NOTICE](
	[ID] [int] NOT NULL,
	[memberName] [nvarchar](64) NOT NULL,
	[notice] [nvarchar](512) NOT NULL,
	[modify_time] [datetime] NOT NULL,
 CONSTRAINT [PK_SB_GUILD_NOTICE_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드 아이디' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_NOTICE', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드 공지를 한 길드원의 이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_NOTICE', @level2type=N'COLUMN',@level2name=N'memberName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드공지' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_NOTICE', @level2type=N'COLUMN',@level2name=N'notice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드 공지한 시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_NOTICE', @level2type=N'COLUMN',@level2name=N'modify_time'
GO
PRINT N'Creating [dbo].[SB_GUILD_WAR]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_GUILD_WAR](
	[guildID] [int] NOT NULL,
	[targetGuildID] [int] NOT NULL,
	[in_progress] [bit] NOT NULL,
	[declared] [bit] NOT NULL,
	[declare_time] [datetime] NOT NULL,
	[kill_count] [int] NOT NULL,
	[death_count] [int] NOT NULL,
 CONSTRAINT [PK_SB_GUILD_WAR_GUILDID_TARGETGUILDID_INPROGRESS] PRIMARY KEY CLUSTERED 
(
	[guildID] ASC,
	[targetGuildID] ASC,
	[in_progress] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'길드 아이디' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_WAR', @level2type=N'COLUMN',@level2name=N'guildID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'대상 길드 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_WAR', @level2type=N'COLUMN',@level2name=N'targetGuildID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'현재 전쟁 진행 여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_WAR', @level2type=N'COLUMN',@level2name=N'in_progress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전쟁 선포 여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_WAR', @level2type=N'COLUMN',@level2name=N'declared'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전쟁 선포를 한 시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_WAR', @level2type=N'COLUMN',@level2name=N'declare_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'진행중인 전쟁일 경우 킬수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_WAR', @level2type=N'COLUMN',@level2name=N'kill_count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'진행중인 전쟁일 경우 죽은 횟수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_WAR', @level2type=N'COLUMN',@level2name=N'death_count'
GO
PRINT N'Creating [dbo].[SB_GUILD_WAR_SEASON]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_GUILD_WAR_SEASON](
	[season] [int] NOT NULL,
	[season_start_time] [datetime] NOT NULL,
	[reset_time] [datetime] NOT NULL
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� Ƚ�� (1ȸ ���� ������)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_WAR_SEASON', @level2type=N'COLUMN',@level2name=N'season'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ���� �ð�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_WAR_SEASON', @level2type=N'COLUMN',@level2name=N'season_start_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ���� �ð�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_GUILD_WAR_SEASON', @level2type=N'COLUMN',@level2name=N'reset_time'
GO
PRINT N'Creating [dbo].[SB_INN]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_INN](
	[ID] [int] NOT NULL,
	[inn_id] [int] NULL
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_SB_INN_ID] ON [dbo].[SB_INN] 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_INN', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'귀환지 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_INN', @level2type=N'COLUMN',@level2name=N'inn_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'귀환지 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_INN'
GO
PRINT N'Creating [dbo].[SB_ITEM]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_ITEM](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[owner_id] [int] NOT NULL,
	[bag_id] [int] NOT NULL,
	[class_id] [int] NOT NULL,
	[amount] [int] NOT NULL,
	[slot_index] [int] NOT NULL,
	[created_date] [datetime] NOT NULL,
	[is_deleted] [bit] NULL,
	[delete_date] [datetime] NULL,
 CONSTRAINT [PK_SB_ITEM_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SB_ITEM_owner_id_bag_id_is_deleted] ON [dbo].[SB_ITEM] 
(
	[owner_id] ASC,
	[bag_id] ASC,
	[is_deleted] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 소유자 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM', @level2type=N'COLUMN',@level2name=N'owner_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 가방 DBID (착용아이템은 -1)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM', @level2type=N'COLUMN',@level2name=N'bag_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 class id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM', @level2type=N'COLUMN',@level2name=N'class_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 수량' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템의 가방 내 위치' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM', @level2type=N'COLUMN',@level2name=N'slot_index'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 기본 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM'
GO
ALTER TABLE [dbo].[SB_ITEM] ADD  CONSTRAINT [DF_SB_ITEM_created_date]  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[SB_ITEM] ADD  CONSTRAINT [DF_SB_ITEM_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
PRINT N'Creating [dbo].[SB_ITEM_ACCOUNT]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_ITEM_ACCOUNT](
	[account_id] [bigint] NOT NULL,
	[item_id] [bigint] NOT NULL,
	[slot_index] [int] NOT NULL,
	[updated_date] [datetime] NULL,
 CONSTRAINT [PK_SB_ITEM_ACCOUNT_account_id_item_id] PRIMARY KEY CLUSTERED 
(
	[account_id] ASC,
	[item_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UQ_SB_ITEM_ACCOUNT_item_id] UNIQUE NONCLUSTERED 
(
	[item_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SB_ITEM_ACCOUNT] ADD  CONSTRAINT [DF_SB_ITEM_ACCOUNT_updated_date]  DEFAULT (getdate()) FOR [updated_date]
GO
PRINT N'Creating [dbo].[SB_ITEM_BAG]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_ITEM_BAG](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[owner_dbid] [int] NOT NULL,
	[bag_type] [int] NOT NULL,
	[slot_index] [int] NOT NULL,
	[source_item_class_id] [int] NOT NULL,
	[max_slot_count] [int] NOT NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_SB_ITEM_BAG_OWNER_DBID] ON [dbo].[SB_ITEM_BAG] 
(
	[owner_dbid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_SB_ITEM_BAG_ID] ON [dbo].[SB_ITEM_BAG] 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'가방 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_BAG', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'소유자 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_BAG', @level2type=N'COLUMN',@level2name=N'owner_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'가방 타입 (인벤:0, 창고:1)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_BAG', @level2type=N'COLUMN',@level2name=N'bag_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'착용 위치 (0번은 기본 가방)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_BAG', @level2type=N'COLUMN',@level2name=N'slot_index'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'가방의 원본 아이템 Class ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_BAG', @level2type=N'COLUMN',@level2name=N'source_item_class_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 슬롯 개수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_BAG', @level2type=N'COLUMN',@level2name=N'max_slot_count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'가방정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_BAG'
GO
PRINT N'Creating [dbo].[SB_ITEM_COOL]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_ITEM_COOL](
	[user_id] [int] NOT NULL,
	[cool_id] [int] NOT NULL,
	[cool_time] [bigint] NOT NULL,
 CONSTRAINT [PK_SB_ITEM_COOL_USER_ID_COOL_ID] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[cool_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_COOL', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 쿨타임 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_COOL', @level2type=N'COLUMN',@level2name=N'cool_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 쿨타임 만료시간 (초)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_COOL', @level2type=N'COLUMN',@level2name=N'cool_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 쿨타임 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_COOL'
GO
PRINT N'Creating [dbo].[SB_ITEM_DURATION]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_ITEM_DURATION](
	[item_dbid] [bigint] NOT NULL,
	[expire_date] [datetime] NOT NULL,
 CONSTRAINT [PK_SB_ITEM_DURATION_item_dbid] PRIMARY KEY CLUSTERED 
(
	[item_dbid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_DURATION', @level2type=N'COLUMN',@level2name=N'item_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 만료시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_DURATION', @level2type=N'COLUMN',@level2name=N'expire_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 기간제 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_DURATION'
GO
PRINT N'Creating [dbo].[SB_ITEM_EQUIPMENT]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_ITEM_EQUIPMENT](
	[ID] [bigint] NOT NULL,
	[durability] [int] NOT NULL,
	[estimated] [bit] NOT NULL,
	[reestimated] [bit] NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [IX_SB_ITEM_EQUIPMENT_ID] ON [dbo].[SB_ITEM_EQUIPMENT] 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_EQUIPMENT', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템의 현재 내구도' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_EQUIPMENT', @level2type=N'COLUMN',@level2name=N'durability'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'감정 여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_EQUIPMENT', @level2type=N'COLUMN',@level2name=N'estimated'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'재감정 여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_EQUIPMENT', @level2type=N'COLUMN',@level2name=N'reestimated'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'장비 아이템 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_EQUIPMENT'
GO
ALTER TABLE [dbo].[SB_ITEM_EQUIPMENT] ADD  CONSTRAINT [DF_SB_ITEM_EQUIPMENT_durability]  DEFAULT ((-1)) FOR [durability]
GO
ALTER TABLE [dbo].[SB_ITEM_EQUIPMENT] ADD  CONSTRAINT [DF_SB_ITEM_EQUIPMENT_estimated]  DEFAULT ((0)) FOR [estimated]
GO
ALTER TABLE [dbo].[SB_ITEM_EQUIPMENT] ADD  CONSTRAINT [DF_SB_ITEM_EQUIPMENT_reestimated]  DEFAULT ((0)) FOR [reestimated]
GO
PRINT N'Creating [dbo].[SB_ITEM_GEM]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_ITEM_GEM](
	[ID] [bigint] NOT NULL,
	[GemClassID] [int] NOT NULL,
	[SocketIndex] [int] NOT NULL,
 CONSTRAINT [PK_SB_ITEM_GEM_USER_ID_SOCKET_INDEX] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[SocketIndex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_GEM', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'보석 아이템의 class id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_GEM', @level2type=N'COLUMN',@level2name=N'GemClassID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'보석 아이템의 장착 위치' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_GEM', @level2type=N'COLUMN',@level2name=N'SocketIndex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템에 장착된 보석 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_GEM'
GO
PRINT N'Creating [dbo].[SB_ITEM_POSSESSION]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_ITEM_POSSESSION](
	[item_dbid] [bigint] NOT NULL,
	[seal_count] [int] NOT NULL,
	[possession_status] [int] NOT NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [IX_SB_ITEM_POSSESSION_item_dbid] ON [dbo].[SB_ITEM_POSSESSION] 
(
	[item_dbid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_POSSESSION', @level2type=N'COLUMN',@level2name=N'item_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'봉인 회수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_POSSESSION', @level2type=N'COLUMN',@level2name=N'seal_count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'귀속 상태 (0:귀속 안됨, 1:귀속, 2:봉인)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_POSSESSION', @level2type=N'COLUMN',@level2name=N'possession_status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 귀속 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_POSSESSION'
GO
PRINT N'Creating [dbo].[SB_ITEM_RANDOM_ABILITY]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_ITEM_RANDOM_ABILITY](
	[ID] [bigint] NOT NULL,
	[ability_type] [tinyint] NOT NULL,
	[ability_value] [int] NOT NULL,
 CONSTRAINT [PK_SB_ITEM_RANDOM_ABILITY_ID_ability_type] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[ability_type] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_RANDOM_ABILITY', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'능력치 타입 (0:공격, 1:명중, 2:치명, 3:회피, 4:최대HP, 5:방어, 6:관통, 7:치명회피, 8:최대CP, 9:CP회복, 10:대인관통, 11:대인방어)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_RANDOM_ABILITY', @level2type=N'COLUMN',@level2name=N'ability_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'랜덤 능력치 값' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_RANDOM_ABILITY', @level2type=N'COLUMN',@level2name=N'ability_value'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 랜덤 속성 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_RANDOM_ABILITY'
GO
PRINT N'Creating [dbo].[SB_ITEM_RANDOM_ABILITY_UNDECIDED]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_ITEM_RANDOM_ABILITY_UNDECIDED](
	[ID] [bigint] NOT NULL,
	[ability_type] [tinyint] NOT NULL,
	[ability_value] [int] NOT NULL,
 CONSTRAINT [PK_SB_ITEM_RANDOM_ABILITY_UNDECIDED_ID] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC,
	[ability_type] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_RANDOM_ABILITY_UNDECIDED', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'능력치 타입 (0:공격, 1:명중, 2:치명, 3:회피, 4:최대HP, 5:방어, 6:관통, 7:치명회피, 8:최대CP, 9:CP회복, 10:대인관통, 11:대인방어)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_RANDOM_ABILITY_UNDECIDED', @level2type=N'COLUMN',@level2name=N'ability_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'능력치 값' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_RANDOM_ABILITY_UNDECIDED', @level2type=N'COLUMN',@level2name=N'ability_value'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 랜덤 속성' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_RANDOM_ABILITY_UNDECIDED'
GO
PRINT N'Creating [dbo].[SB_ITEM_REINFORCEMENT]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_ITEM_REINFORCEMENT](
	[ID] [bigint] NOT NULL,
	[grade] [int] NULL,
	[experience] [float] NULL,
 CONSTRAINT [PK_SB_ITEM_REINFORCEMENT_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SB_ITEM_REINFORCEMENT] ADD  CONSTRAINT [DF_SB_ITEM_REINFORCEMENT_grade]  DEFAULT ((0)) FOR [grade]
GO
ALTER TABLE [dbo].[SB_ITEM_REINFORCEMENT] ADD  CONSTRAINT [DF_SB_ITEM_REINFORCEMENT_experience]  DEFAULT ((0)) FOR [experience]
GO
PRINT N'Creating [dbo].[SB_ITEM_RUNE]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_ITEM_RUNE](
	[ID] [bigint] NOT NULL,
	[RuneClassID] [int] NOT NULL,
	[AttributeType] [int] NOT NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [IX_SB_ITEM_RUNE_ID] ON [dbo].[SB_ITEM_RUNE] 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_RUNE', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'장착된 룬 아이템의 class id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_RUNE', @level2type=N'COLUMN',@level2name=N'RuneClassID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'장착된 룬의 속성' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_RUNE', @level2type=N'COLUMN',@level2name=N'AttributeType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템에 장착된 룬 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_ITEM_RUNE'
GO
PRINT N'Creating [dbo].[SB_MAGIC_TIME]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_MAGIC_TIME](
	[user_id] [int] NOT NULL,
	[play_time] [bigint] NOT NULL,
	[last_reset_time] [datetime] NOT NULL,
 CONSTRAINT [PK_SB_MAGIC_TIME] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
PRINT N'Creating [dbo].[SB_MONEY_RESTRAINT]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_MONEY_RESTRAINT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[target_id] [int] NOT NULL,
	[type] [varchar](1) NOT NULL,
	[money_type] [varchar](1) NOT NULL,
	[money] [bigint] NOT NULL,
	[created_time] [datetime] NOT NULL,
	[is_deleted] [bit] NOT NULL,
 CONSTRAINT [PK_SB_MONEY_RESTRAINT_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SB_MONEY_RESTRAINT] ADD  CONSTRAINT [DF_SB_MONEY_RESTRAINT_created_time]  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[SB_MONEY_RESTRAINT] ADD  CONSTRAINT [DF_SB_MONEY_RESTRAINT_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
PRINT N'Creating [dbo].[SB_POST_ATTACHED_ITEM]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_POST_ATTACHED_ITEM](
	[post_id] [int] NOT NULL,
	[item_key] [bigint] NOT NULL,
	[item_amount] [int] NOT NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_SB_POST_ATTACHED_ITEM_POST_ID] ON [dbo].[SB_POST_ATTACHED_ITEM] 
(
	[post_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'우편 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_POST_ATTACHED_ITEM', @level2type=N'COLUMN',@level2name=N'post_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'첨부 아이템 key (DBID or ClassID)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_POST_ATTACHED_ITEM', @level2type=N'COLUMN',@level2name=N'item_key'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'첨부 아이템 수량 (ClassID인 경우만 의미를 가짐)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_POST_ATTACHED_ITEM', @level2type=N'COLUMN',@level2name=N'item_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'우편 첨부 아이템 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_POST_ATTACHED_ITEM'
GO
PRINT N'Creating [dbo].[SB_POST_ATTACHED_ITEM_EXPIRED]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_POST_ATTACHED_ITEM_EXPIRED](
	[post_id] [int] NOT NULL,
	[item_key] [bigint] NOT NULL,
	[item_amount] [int] NOT NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_SB_POST_ATTACHED_ITEM_POST_ID] ON [dbo].[SB_POST_ATTACHED_ITEM_EXPIRED] 
(
	[post_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
PRINT N'Creating [dbo].[SB_POST_BOX]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_POST_BOX](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[sender_type] [int] NOT NULL,
	[sender_dbid] [int] NOT NULL,
	[sender_name] [nvarchar](64) NOT NULL,
	[recipient_dbid] [int] NOT NULL,
	[recipient_name] [nvarchar](64) NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[text] [nvarchar](500) NOT NULL,
	[attached_money] [bigint] NOT NULL,
	[attached_item_type] [int] NOT NULL,
	[send_time] [datetime] NOT NULL,
	[open_time] [datetime] NULL,
	[delete_time] [datetime] NULL,
	[take_attached_time] [datetime] NULL,
	[blocked] [bit] NOT NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_SB_POST_BOX_RECIPIENT_DBID] ON [dbo].[SB_POST_BOX] 
(
	[recipient_dbid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SB_POST_BOX_ID] ON [dbo].[SB_POST_BOX] 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SB_POST_BOX_SENDER_DBID] ON [dbo].[SB_POST_BOX] 
(
	[sender_dbid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_POST_BOX', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'발송자 타입 (1:유저, 2:모바일 유저, 3:시스템)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_POST_BOX', @level2type=N'COLUMN',@level2name=N'sender_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'발송자 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_POST_BOX', @level2type=N'COLUMN',@level2name=N'sender_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'발송자 이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_POST_BOX', @level2type=N'COLUMN',@level2name=N'sender_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수취인 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_POST_BOX', @level2type=N'COLUMN',@level2name=N'recipient_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수취인 이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_POST_BOX', @level2type=N'COLUMN',@level2name=N'recipient_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'제목' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_POST_BOX', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'본문' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_POST_BOX', @level2type=N'COLUMN',@level2name=N'text'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'첨부 금액' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_POST_BOX', @level2type=N'COLUMN',@level2name=N'attached_money'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'첨부 아이템 타입 (0:첨부 없음, 1:DBID 기반 아이템, 2:ClassID 기반 아이템' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_POST_BOX', @level2type=N'COLUMN',@level2name=N'attached_item_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'발송 일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_POST_BOX', @level2type=N'COLUMN',@level2name=N'send_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'읽은 일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_POST_BOX', @level2type=N'COLUMN',@level2name=N'open_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'삭제 일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_POST_BOX', @level2type=N'COLUMN',@level2name=N'delete_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'첨부물 수신 일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_POST_BOX', @level2type=N'COLUMN',@level2name=N'take_attached_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'압류 여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_POST_BOX', @level2type=N'COLUMN',@level2name=N'blocked'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'우편함 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_POST_BOX'
GO
ALTER TABLE [dbo].[SB_POST_BOX] ADD  CONSTRAINT [DF_SB_POST_BOX_SEND_TIME]  DEFAULT (getdate()) FOR [send_time]
GO
ALTER TABLE [dbo].[SB_POST_BOX] ADD  CONSTRAINT [DF_SB_POST_BOX_blocked]  DEFAULT ((0)) FOR [blocked]
GO
PRINT N'Creating [dbo].[SB_POST_BOX_EXPIRED]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_POST_BOX_EXPIRED](
	[ID] [int] NOT NULL,
	[sender_type] [int] NOT NULL,
	[sender_dbid] [int] NOT NULL,
	[sender_name] [nvarchar](64) NOT NULL,
	[recipient_dbid] [int] NOT NULL,
	[recipient_name] [nvarchar](64) NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[text] [nvarchar](500) NOT NULL,
	[attached_money] [bigint] NOT NULL,
	[attached_item_type] [int] NOT NULL,
	[send_time] [datetime] NOT NULL,
	[open_time] [datetime] NULL,
	[delete_time] [datetime] NULL,
	[take_attached_time] [datetime] NULL,
	[blocked] [bit] NOT NULL,
	[expired_date] [datetime] NOT NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_SB_POST_BOX_EXPIRED_RECIPIENT_DBID] ON [dbo].[SB_POST_BOX_EXPIRED] 
(
	[recipient_dbid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SB_POST_BOX_EXPIRED_ID] ON [dbo].[SB_POST_BOX_EXPIRED] 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SB_POST_BOX_EXPIRED_SENDER_DBID] ON [dbo].[SB_POST_BOX_EXPIRED] 
(
	[sender_dbid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SB_POST_BOX_EXPIRED] ADD  CONSTRAINT [DF_SB_POST_BOX_EXPIRED_expired_date]  DEFAULT (getdate()) FOR [expired_date]
GO
PRINT N'Creating [dbo].[SB_PRIVATE_ARENA]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_PRIVATE_ARENA](
	[user_dbid] [int] NOT NULL,
	[season_no] [int] NOT NULL,
	[season_win] [int] NOT NULL,
	[season_lose] [int] NOT NULL,
	[season_draw] [int] NOT NULL,
	[season_win_in_row] [int] NOT NULL,
	[season_lose_in_row] [int] NOT NULL,
	[season_elo] [int] NOT NULL,
	[season_award] [bigint] NOT NULL,
 CONSTRAINT [PK_SB_PRIVATE_ARENA] PRIMARY KEY CLUSTERED 
(
	[user_dbid] ASC,
	[season_no] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_PRIVATE_ARENA', @level2type=N'COLUMN',@level2name=N'user_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'투기장 시즌no' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_PRIVATE_ARENA', @level2type=N'COLUMN',@level2name=N'season_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 승' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_PRIVATE_ARENA', @level2type=N'COLUMN',@level2name=N'season_win'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 패' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_PRIVATE_ARENA', @level2type=N'COLUMN',@level2name=N'season_lose'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 무승부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_PRIVATE_ARENA', @level2type=N'COLUMN',@level2name=N'season_draw'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 연승' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_PRIVATE_ARENA', @level2type=N'COLUMN',@level2name=N'season_win_in_row'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 연패' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_PRIVATE_ARENA', @level2type=N'COLUMN',@level2name=N'season_lose_in_row'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 평점' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_PRIVATE_ARENA', @level2type=N'COLUMN',@level2name=N'season_elo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 획득 훈장' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_PRIVATE_ARENA', @level2type=N'COLUMN',@level2name=N'season_award'
GO
PRINT N'Creating [dbo].[SB_PRIVATE_ARENA_WEEK]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_PRIVATE_ARENA_WEEK](
	[user_dbid] [int] NOT NULL,
	[season_no] [int] NOT NULL,
	[week_no] [int] NOT NULL,
	[week_win] [int] NOT NULL,
	[week_lose] [int] NOT NULL,
	[week_draw] [int] NOT NULL,
 CONSTRAINT [PK_SB_PRIVATE_ARENA_WEEK] PRIMARY KEY CLUSTERED 
(
	[user_dbid] ASC,
	[season_no] ASC,
	[week_no] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_PRIVATE_ARENA_WEEK', @level2type=N'COLUMN',@level2name=N'user_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'투기장 시즌no' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_PRIVATE_ARENA_WEEK', @level2type=N'COLUMN',@level2name=N'season_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'투기장 시즌 중 주no' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_PRIVATE_ARENA_WEEK', @level2type=N'COLUMN',@level2name=N'week_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주간 승' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_PRIVATE_ARENA_WEEK', @level2type=N'COLUMN',@level2name=N'week_win'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주간 패' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_PRIVATE_ARENA_WEEK', @level2type=N'COLUMN',@level2name=N'week_lose'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주간 무승부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_PRIVATE_ARENA_WEEK', @level2type=N'COLUMN',@level2name=N'week_draw'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'자유투기장 주간 성적' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_PRIVATE_ARENA_WEEK'
GO
PRINT N'Creating [dbo].[SB_SERVER_HISTORY]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_SERVER_HISTORY](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[event_time] [datetime] NOT NULL,
	[peer_name] [nvarchar](50) NOT NULL,
	[up_down_flag] [nvarchar](1) NOT NULL,
 CONSTRAINT [PK_SB_SERVER_HISTORY_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SB_SERVER_HISTORY] ADD  CONSTRAINT [DF_SB_SERVER_HISTORY_event_time]  DEFAULT (getdate()) FOR [event_time]
GO
PRINT N'Creating [dbo].[SB_SHOP_GIFT_BOX]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_SHOP_GIFT_BOX](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[gift_type] [int] NOT NULL,
	[sender_dbid] [int] NOT NULL,
	[sender_name] [nvarchar](64) NOT NULL,
	[recipient_dbid] [int] NOT NULL,
	[recipient_name] [nvarchar](64) NOT NULL,
	[message] [nvarchar](64) NOT NULL,
	[send_date] [datetime] NOT NULL,
	[open_date] [datetime] NULL,
	[delete_date] [datetime] NULL,
	[receive_date] [datetime] NULL,
 CONSTRAINT [PK_SB_SHOP_GIFT_BOX_ID] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_SB_SHOP_GIFT_BOX_recipient_dbid] ON [dbo].[SB_SHOP_GIFT_BOX] 
(
	[recipient_dbid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'선물/조르기 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_GIFT_BOX', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'타입 (0:선물, 1:조르기, 2:시스템 선물)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_GIFT_BOX', @level2type=N'COLUMN',@level2name=N'gift_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'발송인 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_GIFT_BOX', @level2type=N'COLUMN',@level2name=N'sender_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'발송인 이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_GIFT_BOX', @level2type=N'COLUMN',@level2name=N'sender_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신인 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_GIFT_BOX', @level2type=N'COLUMN',@level2name=N'recipient_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신인 이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_GIFT_BOX', @level2type=N'COLUMN',@level2name=N'recipient_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'메시지' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_GIFT_BOX', @level2type=N'COLUMN',@level2name=N'message'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'발송일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_GIFT_BOX', @level2type=N'COLUMN',@level2name=N'send_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'읽은일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_GIFT_BOX', @level2type=N'COLUMN',@level2name=N'open_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'삭제일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_GIFT_BOX', @level2type=N'COLUMN',@level2name=N'delete_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'첨부물 수령일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_GIFT_BOX', @level2type=N'COLUMN',@level2name=N'receive_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'[유료상점] 선물함 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_GIFT_BOX'
GO
ALTER TABLE [dbo].[SB_SHOP_GIFT_BOX] ADD  CONSTRAINT [DF_SB_SHOP_GIFT_BOX_send_date]  DEFAULT (getdate()) FOR [send_date]
GO
PRINT N'Creating [dbo].[SB_SHOP_GIFT_ITEM]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_SHOP_GIFT_ITEM](
	[gift_id] [bigint] NOT NULL,
	[rack_id] [int] NOT NULL,
	[rack_amount] [int] NOT NULL,
	[selected_product_id] [int] NOT NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_SB_SHOP_GIFT_ITEM_gift_id] ON [dbo].[SB_SHOP_GIFT_ITEM] 
(
	[gift_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'선물/조르기 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_GIFT_ITEM', @level2type=N'COLUMN',@level2name=N'gift_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'매대 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_GIFT_ITEM', @level2type=N'COLUMN',@level2name=N'rack_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수량' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_GIFT_ITEM', @level2type=N'COLUMN',@level2name=N'rack_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'선택 옵션(상품)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_GIFT_ITEM', @level2type=N'COLUMN',@level2name=N'selected_product_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'[유료상점] 선물/조르기 상품 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_GIFT_ITEM'
GO
PRINT N'Creating [dbo].[SB_SHOP_LIMIT_COUNT]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_SHOP_LIMIT_COUNT](
	[user_dbid] [int] NOT NULL,
	[rack_id] [int] NOT NULL,
	[buy_amount] [int] NOT NULL,
 CONSTRAINT [PK_SB_SHOP_LIMIT_COUNT_user_dbid_rack_id] PRIMARY KEY CLUSTERED 
(
	[user_dbid] ASC,
	[rack_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_LIMIT_COUNT', @level2type=N'COLUMN',@level2name=N'user_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'매대 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_LIMIT_COUNT', @level2type=N'COLUMN',@level2name=N'rack_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'구매 수량' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_LIMIT_COUNT', @level2type=N'COLUMN',@level2name=N'buy_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'[유료상점] 캐릭터 제한 상품 구매 수량 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_LIMIT_COUNT'
GO
PRINT N'Creating [dbo].[SB_SHOP_LIMITED_SELL]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_SHOP_LIMITED_SELL](
	[rack_id] [int] NOT NULL,
	[sell_amount] [int] NOT NULL,
 CONSTRAINT [PK_SB_SHOP_LIMITED_SELL_rack_id] PRIMARY KEY CLUSTERED 
(
	[rack_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'매대 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_LIMITED_SELL', @level2type=N'COLUMN',@level2name=N'rack_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매 수량' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_LIMITED_SELL', @level2type=N'COLUMN',@level2name=N'sell_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'[유료상점] 한정 수량 상품 판매 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_LIMITED_SELL'
GO
PRINT N'Creating [dbo].[SB_SHOP_ORDER_HISTORY]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_SHOP_ORDER_HISTORY](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[rack_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[amount] [int] NOT NULL,
	[price] [int] NOT NULL,
	[buyer_id] [int] NOT NULL,
	[buyer_name] [nvarchar](64) NOT NULL,
	[buyer_account_id] [bigint] NOT NULL,
	[buyer_account_name] [nvarchar](64) NOT NULL,
	[recipient_id] [int] NOT NULL,
	[recipient_name] [nvarchar](64) NOT NULL,
	[order_date] [datetime] NOT NULL,
	[serial_no] [bigint] NULL,
 CONSTRAINT [PK_SB_SHOP_ORDER_HISTORY_ID] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_SB_SHOP_ORDER_HISTORY_buyer_id] ON [dbo].[SB_SHOP_ORDER_HISTORY] 
(
	[buyer_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SB_SHOP_ORDER_HISTORY_SERIAL_NO] ON [dbo].[SB_SHOP_ORDER_HISTORY] 
(
	[serial_no] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주문 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_ORDER_HISTORY', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'매대 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_ORDER_HISTORY', @level2type=N'COLUMN',@level2name=N'rack_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상품 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_ORDER_HISTORY', @level2type=N'COLUMN',@level2name=N'product_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수량' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_ORDER_HISTORY', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'가격' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_ORDER_HISTORY', @level2type=N'COLUMN',@level2name=N'price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'구매 캐릭터 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_ORDER_HISTORY', @level2type=N'COLUMN',@level2name=N'buyer_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'구매 캐릭터 이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_ORDER_HISTORY', @level2type=N'COLUMN',@level2name=N'buyer_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'구매 계정 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_ORDER_HISTORY', @level2type=N'COLUMN',@level2name=N'buyer_account_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'구매 계정명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_ORDER_HISTORY', @level2type=N'COLUMN',@level2name=N'buyer_account_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신 캐릭터 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_ORDER_HISTORY', @level2type=N'COLUMN',@level2name=N'recipient_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'수신 캐릭터 이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_ORDER_HISTORY', @level2type=N'COLUMN',@level2name=N'recipient_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'주문일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_ORDER_HISTORY', @level2type=N'COLUMN',@level2name=N'order_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'[유료상점] 구매 이력' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHOP_ORDER_HISTORY'
GO
ALTER TABLE [dbo].[SB_SHOP_ORDER_HISTORY] ADD  CONSTRAINT [DF_SB_SHOP_ORDER_HISTORY_order_date]  DEFAULT (getdate()) FOR [order_date]
GO
PRINT N'Creating [dbo].[SB_SHORT_CUT]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_SHORT_CUT](
	[user_id] [int] NOT NULL,
	[slot_no] [tinyint] NOT NULL,
	[reg_type] [tinyint] NOT NULL,
	[reg_id] [int] NOT NULL,
	[spec_id] [tinyint] NOT NULL,
 CONSTRAINT [PK_SB_SHORT_CUT_USER_ID_SPEC_ID_SLOT_NO] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[spec_id] ASC,
	[slot_no] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'소유자 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHORT_CUT', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'슬롯 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHORT_CUT', @level2type=N'COLUMN',@level2name=N'slot_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'숏컷 타입(스킬:1,아이템:2)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHORT_CUT', @level2type=N'COLUMN',@level2name=N'reg_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'스킬/아이템 id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHORT_CUT', @level2type=N'COLUMN',@level2name=N'reg_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퀵슬롯 리스트' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_SHORT_CUT'
GO
ALTER TABLE [dbo].[SB_SHORT_CUT] ADD  CONSTRAINT [DF_SB_SHORT_CUT_spec_id]  DEFAULT ((0)) FOR [spec_id]
GO
PRINT N'Creating [dbo].[SB_TAX]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_TAX](
	[date] [datetime] NOT NULL,
	[tax] [bigint] NOT NULL,
	[tax_rate] [int] NOT NULL,
	[is_pvp_sent] [int] NOT NULL,
	[is_pve_sent] [int] NOT NULL,
 CONSTRAINT [PK_SB_TAX] PRIMARY KEY CLUSTERED 
(
	[date] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SB_TAX] ADD  CONSTRAINT [sb_tax_default_tax_rate]  DEFAULT ((0)) FOR [tax_rate]
GO
ALTER TABLE [dbo].[SB_TAX] ADD  CONSTRAINT [sb_tax_pvp_sent]  DEFAULT ((0)) FOR [is_pvp_sent]
GO
ALTER TABLE [dbo].[SB_TAX] ADD  CONSTRAINT [sb_tax_pve_sent]  DEFAULT ((0)) FOR [is_pve_sent]
GO
PRINT N'Creating [dbo].[SB_TAX_GUILD]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_TAX_GUILD](
	[week_no] [int] NOT NULL,
	[week_date] [datetime] NOT NULL,
	[pvp_winner] [int] NOT NULL,
	[pve_winner] [int] NOT NULL,
 CONSTRAINT [PK_SB_TAX_GUILD] PRIMARY KEY CLUSTERED 
(
	[week_no] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
PRINT N'Creating [dbo].[SB_TELEPORT_POINT]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_TELEPORT_POINT](
	[name] [nvarchar](256) NOT NULL,
	[area_id] [int] NOT NULL,
	[region_id] [int] NOT NULL,
	[resource_id] [int] NOT NULL,
	[grid_x] [int] NOT NULL,
	[grid_y] [int] NOT NULL,
	[grid_z] [int] NOT NULL,
	[reserved] [int] NOT NULL,
	[x] [float] NOT NULL,
	[y] [float] NOT NULL,
	[z] [float] NOT NULL
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_SB_TELEPORT_POINT_NAME] ON [dbo].[SB_TELEPORT_POINT] 
(
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
PRINT N'Creating [dbo].[SB_TRUST_SALE]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_TRUST_SALE](
	[ts_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[user_name] [nvarchar](64) NOT NULL,
	[status] [tinyint] NOT NULL,
	[registered_date] [datetime] NULL,
	[expire_date] [datetime] NULL,
	[blocked] [bit] NOT NULL,
	[item_id] [bigint] NOT NULL,
	[item_class_id] [int] NOT NULL,
	[item_amount] [int] NOT NULL,
	[price] [bigint] NOT NULL,
	[price_per_item] [float] NOT NULL,
	[item_level] [int] NOT NULL,
	[item_grade] [int] NULL,
	[job_type] [int] NULL,
	[category1] [int] NOT NULL,
	[category2] [int] NOT NULL,
	[category3] [int] NOT NULL,
 CONSTRAINT [PK_SB_TRUST_SALE_ID] PRIMARY KEY CLUSTERED 
(
	[ts_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SB_TRUST_SALE_CATEGORY] ON [dbo].[SB_TRUST_SALE] 
(
	[category1] ASC,
	[category2] ASC,
	[category3] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SB_TRUST_SALE_item_class_id] ON [dbo].[SB_TRUST_SALE] 
(
	[item_class_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SB_TRUST_SALE_item_level_item_grade] ON [dbo].[SB_TRUST_SALE] 
(
	[item_level] ASC,
	[item_grade] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SB_TRUST_SALE_status] ON [dbo].[SB_TRUST_SALE] 
(
	[status] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SB_TRUST_SALE_user_id] ON [dbo].[SB_TRUST_SALE] 
(
	[user_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'위탁판매 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE', @level2type=N'COLUMN',@level2name=N'ts_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매자 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매자 이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE', @level2type=N'COLUMN',@level2name=N'user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매 상태' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록 날짜' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE', @level2type=N'COLUMN',@level2name=N'registered_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'만료 날짜' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE', @level2type=N'COLUMN',@level2name=N'expire_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'운영툴을 통한 사용제한 여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE', @level2type=N'COLUMN',@level2name=N'blocked'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매 아이템 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE', @level2type=N'COLUMN',@level2name=N'item_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매 아이템 ClassID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE', @level2type=N'COLUMN',@level2name=N'item_class_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매 아이템 수량' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE', @level2type=N'COLUMN',@level2name=N'item_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매 아이템 가격' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE', @level2type=N'COLUMN',@level2name=N'price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매 아이템 별 가격' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE', @level2type=N'COLUMN',@level2name=N'price_per_item'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'검색조건(아이템 레벨)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE', @level2type=N'COLUMN',@level2name=N'item_level'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'검색조건(아이템 등급)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE', @level2type=N'COLUMN',@level2name=N'item_grade'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'검색조건(직업)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE', @level2type=N'COLUMN',@level2name=N'job_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'검색조건(분류1)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE', @level2type=N'COLUMN',@level2name=N'category1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'검색조건(분류2)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE', @level2type=N'COLUMN',@level2name=N'category2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'검색조건(분류3)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE', @level2type=N'COLUMN',@level2name=N'category3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'위탁판매 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE'
GO
ALTER TABLE [dbo].[SB_TRUST_SALE] ADD  CONSTRAINT [DF_SB_TRUST_SALE_blocked]  DEFAULT ((0)) FOR [blocked]
GO
PRINT N'Creating [dbo].[SB_TRUST_SALE_CURRENCY]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_TRUST_SALE_CURRENCY](
	[tsc_dbid] [int] IDENTITY(1,1) NOT NULL,
	[seller_dbid] [int] NOT NULL,
	[seller_name] [nchar](64) NOT NULL,
	[status] [tinyint] NOT NULL,
	[registered_date] [datetime] NOT NULL,
	[expire_date] [datetime] NOT NULL,
	[sell_type] [tinyint] NOT NULL,
	[sell_amount] [bigint] NOT NULL,
	[buy_type] [tinyint] NOT NULL,
	[buy_amount_one] [bigint] NOT NULL,
	[buy_amount_total] [bigint] NOT NULL,
	[buyer_dbid] [int] NULL,
	[buy_date] [datetime] NULL,
	[blocked] [int] NOT NULL,
 CONSTRAINT [PK_SB_TRUST_SALE_CURRENCY] PRIMARY KEY CLUSTERED 
(
	[tsc_dbid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'화폐 위탁판매 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY', @level2type=N'COLUMN',@level2name=N'tsc_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매자 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY', @level2type=N'COLUMN',@level2name=N'seller_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매자 이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY', @level2type=N'COLUMN',@level2name=N'seller_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록 상태. TrustSale::SaleStatus 참조' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록 일자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY', @level2type=N'COLUMN',@level2name=N'registered_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'만료 일자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY', @level2type=N'COLUMN',@level2name=N'expire_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매할 화폐 타입' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY', @level2type=N'COLUMN',@level2name=N'sell_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매할 화폐량' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY', @level2type=N'COLUMN',@level2name=N'sell_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'구입할 화폐타입' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY', @level2type=N'COLUMN',@level2name=N'buy_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매량 1당 구입할 화폐량' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY', @level2type=N'COLUMN',@level2name=N'buy_amount_one'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전체 구입할 화폐량' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY', @level2type=N'COLUMN',@level2name=N'buy_amount_total'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'구매자 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY', @level2type=N'COLUMN',@level2name=N'buyer_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'구매(판매) 일자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY', @level2type=N'COLUMN',@level2name=N'buy_date'
GO
ALTER TABLE [dbo].[SB_TRUST_SALE_CURRENCY] ADD  CONSTRAINT [df_blocked]  DEFAULT ((0)) FOR [blocked]
GO
PRINT N'Creating [dbo].[SB_TRUST_SALE_CURRENCY_HISTORY]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_TRUST_SALE_CURRENCY_HISTORY](
	[tsc_dbid] [int] NOT NULL,
	[seller_dbid] [int] NOT NULL,
	[sell_type] [tinyint] NOT NULL,
	[sell_amount] [bigint] NOT NULL,
	[buy_type] [tinyint] NOT NULL,
	[buy_amount_one] [bigint] NOT NULL,
	[buy_amount_total] [bigint] NOT NULL,
	[buyer_dbid] [int] NULL,
	[buy_date] [datetime] NULL,
 CONSTRAINT [PK_SB_TRUST_SALE_CURRENCY_HISTORY] PRIMARY KEY CLUSTERED 
(
	[tsc_dbid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'화폐 위탁판매 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY_HISTORY', @level2type=N'COLUMN',@level2name=N'tsc_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매자 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY_HISTORY', @level2type=N'COLUMN',@level2name=N'seller_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매할 화폐 타입' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY_HISTORY', @level2type=N'COLUMN',@level2name=N'sell_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매할 화폐량' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY_HISTORY', @level2type=N'COLUMN',@level2name=N'sell_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'구입할 화폐타입' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY_HISTORY', @level2type=N'COLUMN',@level2name=N'buy_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매량 1당 구입할 화폐량' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY_HISTORY', @level2type=N'COLUMN',@level2name=N'buy_amount_one'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전체 구입할 화폐량' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY_HISTORY', @level2type=N'COLUMN',@level2name=N'buy_amount_total'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'구매자 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY_HISTORY', @level2type=N'COLUMN',@level2name=N'buyer_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'구매(판매) 일자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY_HISTORY', @level2type=N'COLUMN',@level2name=N'buy_date'
GO
PRINT N'Creating [dbo].[SB_TRUST_SALE_CURRENCY_OLD]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_TRUST_SALE_CURRENCY_OLD](
	[tsc_dbid] [int] NOT NULL,
	[seller_dbid] [int] NOT NULL,
	[seller_name] [nchar](64) NOT NULL,
	[status] [tinyint] NOT NULL,
	[registered_date] [datetime] NOT NULL,
	[expire_date] [datetime] NOT NULL,
	[sell_type] [tinyint] NOT NULL,
	[sell_amount] [bigint] NOT NULL,
	[buy_type] [tinyint] NOT NULL,
	[buy_amount_one] [bigint] NOT NULL,
	[buy_amount_total] [bigint] NOT NULL,
	[buyer_dbid] [int] NULL,
	[buy_date] [datetime] NULL,
	[blocked] [int] NOT NULL,
 CONSTRAINT [PK_SB_TRUST_SALE_CURRENCY_OLD] PRIMARY KEY CLUSTERED 
(
	[tsc_dbid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'화폐 위탁판매 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY_OLD', @level2type=N'COLUMN',@level2name=N'tsc_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매자 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY_OLD', @level2type=N'COLUMN',@level2name=N'seller_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매자 이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY_OLD', @level2type=N'COLUMN',@level2name=N'seller_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록 상태. TrustSale::SaleStatus 참조' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY_OLD', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록 일자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY_OLD', @level2type=N'COLUMN',@level2name=N'registered_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'만료 일자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY_OLD', @level2type=N'COLUMN',@level2name=N'expire_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매할 화폐 타입' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY_OLD', @level2type=N'COLUMN',@level2name=N'sell_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매할 화폐량' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY_OLD', @level2type=N'COLUMN',@level2name=N'sell_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'구입할 화폐타입' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY_OLD', @level2type=N'COLUMN',@level2name=N'buy_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매량 1당 구입할 화폐량' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY_OLD', @level2type=N'COLUMN',@level2name=N'buy_amount_one'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전체 구입할 화폐량' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY_OLD', @level2type=N'COLUMN',@level2name=N'buy_amount_total'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'구매자 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY_OLD', @level2type=N'COLUMN',@level2name=N'buyer_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'구매(판매) 일자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_CURRENCY_OLD', @level2type=N'COLUMN',@level2name=N'buy_date'
GO
ALTER TABLE [dbo].[SB_TRUST_SALE_CURRENCY_OLD] ADD  CONSTRAINT [df_TSC_OLD_blocked]  DEFAULT ((0)) FOR [blocked]
GO
PRINT N'Creating [dbo].[SB_TRUST_SALE_OLD]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_TRUST_SALE_OLD](
	[ts_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[user_name] [nvarchar](64) NOT NULL,
	[status] [tinyint] NOT NULL,
	[registered_date] [datetime] NULL,
	[expire_date] [datetime] NULL,
	[blocked] [bit] NOT NULL,
	[item_id] [bigint] NOT NULL,
	[item_class_id] [int] NOT NULL,
	[item_amount] [int] NOT NULL,
	[price] [bigint] NOT NULL,
	[price_per_item] [float] NOT NULL,
	[item_level] [int] NOT NULL,
	[item_grade] [int] NULL,
	[job_type] [int] NULL,
	[category1] [int] NOT NULL,
	[category2] [int] NOT NULL,
	[category3] [int] NOT NULL,
 CONSTRAINT [PK_SB_TRUST_SALE_OLD_ID] PRIMARY KEY NONCLUSTERED 
(
	[ts_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_SB_TRUST_SALE_OLD_item_class_id] ON [dbo].[SB_TRUST_SALE_OLD] 
(
	[item_class_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'위탁판매 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_OLD', @level2type=N'COLUMN',@level2name=N'ts_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매자 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_OLD', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매자 이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_OLD', @level2type=N'COLUMN',@level2name=N'user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매 상태' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_OLD', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록 날짜' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_OLD', @level2type=N'COLUMN',@level2name=N'registered_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'만료 날짜' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_OLD', @level2type=N'COLUMN',@level2name=N'expire_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'운영툴을 통한 사용제한 여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_OLD', @level2type=N'COLUMN',@level2name=N'blocked'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매 아이템 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_OLD', @level2type=N'COLUMN',@level2name=N'item_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매 아이템 ClassID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_OLD', @level2type=N'COLUMN',@level2name=N'item_class_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매 아이템 수량' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_OLD', @level2type=N'COLUMN',@level2name=N'item_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매 아이템 가격' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_OLD', @level2type=N'COLUMN',@level2name=N'price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'판매 아이템 별 가격' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_OLD', @level2type=N'COLUMN',@level2name=N'price_per_item'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'검색조건(아이템 레벨)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_OLD', @level2type=N'COLUMN',@level2name=N'item_level'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'검색조건(아이템 등급)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_OLD', @level2type=N'COLUMN',@level2name=N'item_grade'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'검색조건(직업)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_OLD', @level2type=N'COLUMN',@level2name=N'job_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'검색조건(분류1)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_OLD', @level2type=N'COLUMN',@level2name=N'category1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'검색조건(분류2)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_OLD', @level2type=N'COLUMN',@level2name=N'category2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'검색조건(분류3)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_OLD', @level2type=N'COLUMN',@level2name=N'category3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'위탁판매 과거 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_TRUST_SALE_OLD'
GO
PRINT N'Creating [dbo].[SB_USER]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER](
	[ID] [int] NOT NULL,
	[account_id] [bigint] NOT NULL,
	[job_type] [smallint] NOT NULL,
	[name] [nvarchar](64) NOT NULL,
	[created_time] [datetime] NOT NULL,
	[deleted_time] [datetime] NULL,
	[final_deleted] [char](1) NOT NULL,
	[face] [int] NOT NULL,
	[body_color] [int] NOT NULL,
	[eye] [int] NOT NULL,
	[eye_color] [int] NOT NULL,
	[hair] [int] NOT NULL,
	[hair_color] [int] NOT NULL,
	[decal] [int] NOT NULL,
	[body_size] [int] NOT NULL,
	[leg_size] [int] NOT NULL,
	[head_size] [int] NOT NULL,
	[title_id] [int] NOT NULL,
	[breast_size] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UQ_SB_USER_NAME] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SB_USER_ACCOUNT_ID_FINAL_DELETED] ON [dbo].[SB_USER] 
(
	[account_id] ASC,
	[final_deleted] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'계정 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER', @level2type=N'COLUMN',@level2name=N'account_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'직업 타입' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER', @level2type=N'COLUMN',@level2name=N'job_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'생성일자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER', @level2type=N'COLUMN',@level2name=N'created_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'삭제일자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER', @level2type=N'COLUMN',@level2name=N'deleted_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최종 삭제 여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER', @level2type=N'COLUMN',@level2name=N'final_deleted'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'칭호 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER', @level2type=N'COLUMN',@level2name=N'title_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터 기본정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER'
GO
ALTER TABLE [dbo].[SB_USER] ADD  CONSTRAINT [DF_SB_USER_created_time]  DEFAULT (getdate()) FOR [created_time]
GO
ALTER TABLE [dbo].[SB_USER] ADD  CONSTRAINT [DF_SB_USER_final_deleted]  DEFAULT ('N') FOR [final_deleted]
GO
ALTER TABLE [dbo].[SB_USER] ADD  CONSTRAINT [DF_SB_USER_face]  DEFAULT ((0)) FOR [face]
GO
ALTER TABLE [dbo].[SB_USER] ADD  CONSTRAINT [DF_SB_USER_body_color]  DEFAULT ((0)) FOR [body_color]
GO
ALTER TABLE [dbo].[SB_USER] ADD  CONSTRAINT [DF_SB_USER_eye]  DEFAULT ((0)) FOR [eye]
GO
ALTER TABLE [dbo].[SB_USER] ADD  CONSTRAINT [DF_SB_USER_eye_color]  DEFAULT ((0)) FOR [eye_color]
GO
ALTER TABLE [dbo].[SB_USER] ADD  CONSTRAINT [DF_SB_USER_hair]  DEFAULT ((0)) FOR [hair]
GO
ALTER TABLE [dbo].[SB_USER] ADD  CONSTRAINT [DF_SB_USER_hair_color]  DEFAULT ((0)) FOR [hair_color]
GO
ALTER TABLE [dbo].[SB_USER] ADD  CONSTRAINT [DF_SB_USER_decal]  DEFAULT ((-1)) FOR [decal]
GO
ALTER TABLE [dbo].[SB_USER] ADD  CONSTRAINT [DF_SB_USER_body_size]  DEFAULT ((0)) FOR [body_size]
GO
ALTER TABLE [dbo].[SB_USER] ADD  CONSTRAINT [DF_SB_USER_leg_size]  DEFAULT ((0)) FOR [leg_size]
GO
ALTER TABLE [dbo].[SB_USER] ADD  CONSTRAINT [DF_SB_USER_head_size]  DEFAULT ((0)) FOR [head_size]
GO
ALTER TABLE [dbo].[SB_USER] ADD  CONSTRAINT [DF_SB_USER_title_id]  DEFAULT ((-1)) FOR [title_id]
GO
ALTER TABLE [dbo].[SB_USER] ADD  CONSTRAINT [DF_SB_USER_breast_size]  DEFAULT ((0)) FOR [breast_size]
GO
PRINT N'Creating [dbo].[SB_USER_ABILITY]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_ABILITY](
	[ID] [int] NOT NULL,
	[base_run_speed] [int] NOT NULL,
	[run_speed] [int] NOT NULL,
	[base_walk_speed] [int] NOT NULL,
	[walk_speed] [int] NOT NULL,
	[attack_speed] [int] NOT NULL,
	[attack] [int] NOT NULL,
	[hit_rate] [int] NOT NULL,
	[critical_hit_rate] [int] NOT NULL,
	[evasion] [int] NOT NULL,
	[critical_evasion] [int] NOT NULL,
	[defense] [int] NOT NULL,
	[attr_attack_type] [int] NOT NULL,
	[attr_attack] [int] NOT NULL,
	[attr_defense_fire] [int] NOT NULL,
	[attr_defense_water] [int] NOT NULL,
	[attr_defense_earth] [int] NOT NULL,
	[attr_defense_wind] [int] NOT NULL,
	[regen_CP] [int] NOT NULL,
	[regen_HP] [int] NOT NULL,
	[penetration] [int] NOT NULL,
	[pvp_penetration] [int] NOT NULL,
	[pvp_defense] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_ABILITY_USER_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ABILITY', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'기본 달리기 속도' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ABILITY', @level2type=N'COLUMN',@level2name=N'base_run_speed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'현재 달리기 속도' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ABILITY', @level2type=N'COLUMN',@level2name=N'run_speed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'기본 걷기 속도' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ABILITY', @level2type=N'COLUMN',@level2name=N'base_walk_speed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'현재 걷기 속도' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ABILITY', @level2type=N'COLUMN',@level2name=N'walk_speed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공격 속도' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ABILITY', @level2type=N'COLUMN',@level2name=N'attack_speed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'공격력' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ABILITY', @level2type=N'COLUMN',@level2name=N'attack'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'적중률' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ABILITY', @level2type=N'COLUMN',@level2name=N'hit_rate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'치명타 적중률' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ABILITY', @level2type=N'COLUMN',@level2name=N'critical_hit_rate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'회피율' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ABILITY', @level2type=N'COLUMN',@level2name=N'evasion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'치명타 회피율' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ABILITY', @level2type=N'COLUMN',@level2name=N'critical_evasion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'방어력' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ABILITY', @level2type=N'COLUMN',@level2name=N'defense'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'속성 공격 타입' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ABILITY', @level2type=N'COLUMN',@level2name=N'attr_attack_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'속성 공격력' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ABILITY', @level2type=N'COLUMN',@level2name=N'attr_attack'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'불 속성 방어력' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ABILITY', @level2type=N'COLUMN',@level2name=N'attr_defense_fire'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'물 속성 방어력' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ABILITY', @level2type=N'COLUMN',@level2name=N'attr_defense_water'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'대지 속성 방어력' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ABILITY', @level2type=N'COLUMN',@level2name=N'attr_defense_earth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'바람 속성 방어력' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ABILITY', @level2type=N'COLUMN',@level2name=N'attr_defense_wind'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'CP 회복력' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ABILITY', @level2type=N'COLUMN',@level2name=N'regen_CP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'HP 회복력' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ABILITY', @level2type=N'COLUMN',@level2name=N'regen_HP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'관통력' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ABILITY', @level2type=N'COLUMN',@level2name=N'penetration'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'대인 관통' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ABILITY', @level2type=N'COLUMN',@level2name=N'pvp_penetration'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'대인 방어' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ABILITY', @level2type=N'COLUMN',@level2name=N'pvp_defense'
GO
PRINT N'Creating [dbo].[SB_USER_ACHIEVEMENT]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_ACHIEVEMENT](
	[user_id] [int] NOT NULL,
	[achievement_id] [int] NOT NULL,
	[finished_time] [datetime] NOT NULL,
 CONSTRAINT [PK_SB_USER_ACHIEVEMENT] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[achievement_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ACHIEVEMENT', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� script ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ACHIEVEMENT', @level2type=N'COLUMN',@level2name=N'achievement_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� �Ϸ�ð�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ACHIEVEMENT', @level2type=N'COLUMN',@level2name=N'finished_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저의 완료 업적 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ACHIEVEMENT'
GO
PRINT N'Creating [dbo].[SB_USER_ACHIEVEMENT_PROGRESS]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_ACHIEVEMENT_PROGRESS](
	[user_id] [int] NOT NULL,
	[achievement_id] [int] NOT NULL,
	[goal_id] [tinyint] NOT NULL,
	[progress] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_ACHIEVEMENT_PROGRESS] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[achievement_id] ASC,
	[goal_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ACHIEVEMENT_PROGRESS', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'업적 script ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ACHIEVEMENT_PROGRESS', @level2type=N'COLUMN',@level2name=N'achievement_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'업적 목표  ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ACHIEVEMENT_PROGRESS', @level2type=N'COLUMN',@level2name=N'goal_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'업적 진행' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ACHIEVEMENT_PROGRESS', @level2type=N'COLUMN',@level2name=N'progress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저의 업적 목표 수행 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ACHIEVEMENT_PROGRESS'
GO
PRINT N'Creating [dbo].[SB_USER_ATTENDANCE_REWARD]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_ATTENDANCE_REWARD](
	[user_id] [int] NOT NULL,
	[attendance_time] [datetime] NOT NULL,
	[item_class_id] [int] NOT NULL,
	[item_amount] [int] NOT NULL,
	[receipt_time] [datetime] NULL,
	[receipt_method] [int] NULL,
 CONSTRAINT [PK_SB_USER_ATTENDANCE_REWARD] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[attendance_time] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ATTENDANCE_REWARD', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터의 출석 시각' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ATTENDANCE_REWARD', @level2type=N'COLUMN',@level2name=N'attendance_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'보상 아이템 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ATTENDANCE_REWARD', @level2type=N'COLUMN',@level2name=N'item_class_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'보상 아이템 개수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ATTENDANCE_REWARD', @level2type=N'COLUMN',@level2name=N'item_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'보상 아이템을 캐릭터가 수령한 시각' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ATTENDANCE_REWARD', @level2type=N'COLUMN',@level2name=N'receipt_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'보상 아이템을 캐릭터가 수령한 방법(1:인벤토리로 수령, 2:우편함으로 수령)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ATTENDANCE_REWARD', @level2type=N'COLUMN',@level2name=N'receipt_method'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터에게 할당된 출석 보상' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ATTENDANCE_REWARD'
GO
PRINT N'Creating [dbo].[SB_USER_ATTENDANCE_ROUND]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_ATTENDANCE_ROUND](
	[user_id] [int] NOT NULL,
	[total_attendance_count] [int] NOT NULL,
	[number] [int] NOT NULL,
	[start_time] [datetime] NOT NULL,
	[attendance_count] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_ATTENDANCE_ROUND] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ATTENDANCE_ROUND', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터의 총 출석 일수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ATTENDANCE_ROUND', @level2type=N'COLUMN',@level2name=N'total_attendance_count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'출석부 회차' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ATTENDANCE_ROUND', @level2type=N'COLUMN',@level2name=N'number'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'현재 출석부 회차가 시작된 시각' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ATTENDANCE_ROUND', @level2type=N'COLUMN',@level2name=N'start_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'현재 출석부 회차 중에 캐릭터의 출석 일수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ATTENDANCE_ROUND', @level2type=N'COLUMN',@level2name=N'attendance_count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터가 이용 중인 출석부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ATTENDANCE_ROUND'
GO
PRINT N'Creating [dbo].[SB_USER_AVATAR_ITEM]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_AVATAR_ITEM](
	[ID] [int] NOT NULL,
	[hide_special] [bit] NOT NULL,
	[hide_corsage1] [bit] NOT NULL,
	[hide_corsage2] [bit] NOT NULL,
	[hide_costume] [bit] NOT NULL,
	[hide_special_equip] [bit] NOT NULL,
 CONSTRAINT [PK_SB_USER_AVATAR_ITEM] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_AVATAR_ITEM', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'스페셜 아이템 가리기 여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_AVATAR_ITEM', @level2type=N'COLUMN',@level2name=N'hide_special'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코사주1 아이템 가리기 여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_AVATAR_ITEM', @level2type=N'COLUMN',@level2name=N'hide_corsage1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코사주2 아이템 가리기 여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_AVATAR_ITEM', @level2type=N'COLUMN',@level2name=N'hide_corsage2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코스튬 아이템 가리기 여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_AVATAR_ITEM', @level2type=N'COLUMN',@level2name=N'hide_costume'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아바타 아이템 가리기 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_AVATAR_ITEM'
GO
ALTER TABLE [dbo].[SB_USER_AVATAR_ITEM] ADD  CONSTRAINT [DF_SB_USER_AVATAR_ITEM_hide_special]  DEFAULT ((0)) FOR [hide_special]
GO
ALTER TABLE [dbo].[SB_USER_AVATAR_ITEM] ADD  CONSTRAINT [DF_SB_USER_AVATAR_ITEM_hide_corsage1]  DEFAULT ((0)) FOR [hide_corsage1]
GO
ALTER TABLE [dbo].[SB_USER_AVATAR_ITEM] ADD  CONSTRAINT [DF_SB_USER_AVATAR_ITEM_hide_corsage2]  DEFAULT ((0)) FOR [hide_corsage2]
GO
ALTER TABLE [dbo].[SB_USER_AVATAR_ITEM] ADD  CONSTRAINT [DF_SB_USER_AVATAR_ITEM_hide_costume]  DEFAULT ((0)) FOR [hide_costume]
GO
ALTER TABLE [dbo].[SB_USER_AVATAR_ITEM] ADD  CONSTRAINT [DF_SB_USER_AVATAR_ITEM_hide_special_equip]  DEFAULT ((0)) FOR [hide_special_equip]
GO
PRINT N'Creating [dbo].[SB_USER_BEHAVIOR_ITEM_IN_FINITE_DUNGEON]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_BEHAVIOR_ITEM_IN_FINITE_DUNGEON](
	[user_dbid] [int] NOT NULL,
	[class_id] [int] NOT NULL,
	[grade_type] [int] NOT NULL,
	[joint_type] [int] NOT NULL,
	[item_count] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_BEHAVIOR_ITEM_IN_FINITE_DUNGEON] PRIMARY KEY CLUSTERED 
(
	[user_dbid] ASC,
	[class_id] ASC,
	[grade_type] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BEHAVIOR_ITEM_IN_FINITE_DUNGEON', @level2type=N'COLUMN',@level2name=N'user_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'던전 class id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BEHAVIOR_ITEM_IN_FINITE_DUNGEON', @level2type=N'COLUMN',@level2name=N'class_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 등급 User::GradeType' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BEHAVIOR_ITEM_IN_FINITE_DUNGEON', @level2type=N'COLUMN',@level2name=N'grade_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Dungeon::JointType' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BEHAVIOR_ITEM_IN_FINITE_DUNGEON', @level2type=N'COLUMN',@level2name=N'joint_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 획득 횟수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BEHAVIOR_ITEM_IN_FINITE_DUNGEON', @level2type=N'COLUMN',@level2name=N'item_count'
GO
PRINT N'Creating [dbo].[SB_USER_BEHAVIOR_ITEM_IN_INFINITE_DUNGEON]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_BEHAVIOR_ITEM_IN_INFINITE_DUNGEON](
	[user_dbid] [int] NOT NULL,
	[level_ex] [int] NOT NULL,
	[joint_type] [int] NOT NULL,
	[grade_type] [int] NOT NULL,
	[item_count] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_BEHAVIOR_ITEM_IN_INFINITE_DUNGEON] PRIMARY KEY CLUSTERED 
(
	[user_dbid] ASC,
	[level_ex] ASC,
	[joint_type] ASC,
	[grade_type] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BEHAVIOR_ITEM_IN_INFINITE_DUNGEON', @level2type=N'COLUMN',@level2name=N'user_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'무한 던전 단계 Dungeon::LevelEx' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BEHAVIOR_ITEM_IN_INFINITE_DUNGEON', @level2type=N'COLUMN',@level2name=N'level_ex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Dungeon::JointType' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BEHAVIOR_ITEM_IN_INFINITE_DUNGEON', @level2type=N'COLUMN',@level2name=N'joint_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 등급 User::GradeType' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BEHAVIOR_ITEM_IN_INFINITE_DUNGEON', @level2type=N'COLUMN',@level2name=N'grade_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 획득 횟수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BEHAVIOR_ITEM_IN_INFINITE_DUNGEON', @level2type=N'COLUMN',@level2name=N'item_count'
GO
PRINT N'Creating [dbo].[SB_USER_BEHAVIOR_START_FINITE_DUNGEON]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_BEHAVIOR_START_FINITE_DUNGEON](
	[user_dbid] [int] NOT NULL,
	[class_id] [int] NOT NULL,
	[joint_type] [int] NOT NULL,
	[start_count] [int] NOT NULL,
 CONSTRAINT [PK_USER_BEHAVIOR_FINITE_DUNGEON] PRIMARY KEY CLUSTERED 
(
	[user_dbid] ASC,
	[class_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BEHAVIOR_START_FINITE_DUNGEON', @level2type=N'COLUMN',@level2name=N'user_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'던전 class id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BEHAVIOR_START_FINITE_DUNGEON', @level2type=N'COLUMN',@level2name=N'class_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Dungeon::JointType' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BEHAVIOR_START_FINITE_DUNGEON', @level2type=N'COLUMN',@level2name=N'joint_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시작한 횟수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BEHAVIOR_START_FINITE_DUNGEON', @level2type=N'COLUMN',@level2name=N'start_count'
GO
PRINT N'Creating [dbo].[SB_USER_BEHAVIOR_START_INFINITE_DUNGEON]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_BEHAVIOR_START_INFINITE_DUNGEON](
	[user_dbid] [int] NOT NULL,
	[level_ex] [int] NOT NULL,
	[joint_type] [int] NOT NULL,
	[start_count] [int] NOT NULL,
 CONSTRAINT [PK_USER_BEHAVIOR_INFINITE_DUNGEON] PRIMARY KEY CLUSTERED 
(
	[user_dbid] ASC,
	[level_ex] ASC,
	[joint_type] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BEHAVIOR_START_INFINITE_DUNGEON', @level2type=N'COLUMN',@level2name=N'user_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'무한 던전 단계 Dungeon::LevelEx' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BEHAVIOR_START_INFINITE_DUNGEON', @level2type=N'COLUMN',@level2name=N'level_ex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Dungeon::JointType' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BEHAVIOR_START_INFINITE_DUNGEON', @level2type=N'COLUMN',@level2name=N'joint_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시작한 횟수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BEHAVIOR_START_INFINITE_DUNGEON', @level2type=N'COLUMN',@level2name=N'start_count'
GO
PRINT N'Creating [dbo].[SB_USER_BOT_REPORT]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_BOT_REPORT](
	[user_dbid] [int] NOT NULL,
	[reported_time] [datetime] NOT NULL,
	[report_count] [int] NOT NULL
) ON [PRIMARY]
GO
PRINT N'Creating [dbo].[SB_USER_BOUND_DUNGEON]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_BOUND_DUNGEON](
	[user_db_id] [int] NOT NULL,
	[dungeon_class_id] [int] NOT NULL,
	[checkpoint_seq_no] [int] NOT NULL,
	[expired_time] [datetime] NOT NULL,
 CONSTRAINT [PK_SB_USER_BOUND_DUNGEON] PRIMARY KEY CLUSTERED 
(
	[user_db_id] ASC,
	[dungeon_class_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
PRINT N'Creating [dbo].[SB_USER_BUFF]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_BUFF](
	[user_id] [int] NOT NULL,
	[buff_id] [int] NOT NULL,
	[buff_level] [int] NOT NULL,
	[accumulation] [tinyint] NOT NULL,
	[start_time] [bigint] NOT NULL,
	[remain_time] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_BUFF_USER_ID_BUFF_ID] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[buff_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BUFF', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'버프 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BUFF', @level2type=N'COLUMN',@level2name=N'buff_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'버프 레벨' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BUFF', @level2type=N'COLUMN',@level2name=N'buff_level'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'중첩 개수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BUFF', @level2type=N'COLUMN',@level2name=N'accumulation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'버프 시작 시간 (초)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BUFF', @level2type=N'COLUMN',@level2name=N'start_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'버프 남은 시간 (초)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BUFF', @level2type=N'COLUMN',@level2name=N'remain_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터 버프 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_BUFF'
GO
PRINT N'Creating [dbo].[SB_USER_CHAT_REPORT]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_CHAT_REPORT](
	[user_dbid] [int] NOT NULL,
	[reported_time] [datetime] NULL,
	[report_count] [int] NOT NULL,
	[reported_count_normal] [int] NOT NULL,
	[reported_count_guild] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SB_USER_CHAT_REPORT] ADD  CONSTRAINT [DF_SB_USER_CHAT_REPORT_report_count]  DEFAULT ((0)) FOR [report_count]
GO
ALTER TABLE [dbo].[SB_USER_CHAT_REPORT] ADD  CONSTRAINT [DF_SB_USER_CHAT_REPORT_reported_count_normal]  DEFAULT ((0)) FOR [reported_count_normal]
GO
ALTER TABLE [dbo].[SB_USER_CHAT_REPORT] ADD  CONSTRAINT [DF_SB_USER_CHAT_REPORT_reported_count_guild]  DEFAULT ((0)) FOR [reported_count_guild]
GO
PRINT N'Creating [dbo].[SB_USER_CORPSE]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_CORPSE](
	[MASTER_ID] [int] NOT NULL,
	[x] [float] NULL,
	[y] [float] NULL,
	[z] [float] NULL,
	[area_id] [int] NULL,
	[region_id] [int] NULL,
	[resource_id] [int] NULL,
	[grid_x] [int] NULL,
	[grid_y] [int] NULL,
	[grid_z] [int] NULL,
	[reserved] [int] NULL,
	[yaw] [int] NULL,
 CONSTRAINT [PK_SB_USER_CORPSE_MASTER_ID] PRIMARY KEY CLUSTERED 
(
	[MASTER_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_CORPSE', @level2type=N'COLUMN',@level2name=N'MASTER_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'좌표 X' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_CORPSE', @level2type=N'COLUMN',@level2name=N'x'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'좌표 Y' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_CORPSE', @level2type=N'COLUMN',@level2name=N'y'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'좌표 Z' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_CORPSE', @level2type=N'COLUMN',@level2name=N'z'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 대지역 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_CORPSE', @level2type=N'COLUMN',@level2name=N'area_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 소지역 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_CORPSE', @level2type=N'COLUMN',@level2name=N'region_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 리소스 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_CORPSE', @level2type=N'COLUMN',@level2name=N'resource_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 X' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_CORPSE', @level2type=N'COLUMN',@level2name=N'grid_x'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 Y' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_CORPSE', @level2type=N'COLUMN',@level2name=N'grid_y'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 Z' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_CORPSE', @level2type=N'COLUMN',@level2name=N'grid_z'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 예약 필드 (일단은 포탈 index)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_CORPSE', @level2type=N'COLUMN',@level2name=N'reserved'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시체 방향' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_CORPSE', @level2type=N'COLUMN',@level2name=N'yaw'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시체 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_CORPSE'
GO
PRINT N'Creating [dbo].[SB_USER_DUNGEON]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_DUNGEON](
	[ID] [int] NOT NULL,
	[dungeon_level] [int] NOT NULL,
	[dungeon_level_ex] [int] NOT NULL,
	[dungeon_raid_level] [int] NOT NULL,
	[dungeon_ticket_reset_time] [datetime] NULL,
	[dungeon_bind_init_reset_time] [datetime] NULL,
 CONSTRAINT [PK_SB_USER_DUNGEON] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_DUNGEON', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'던전 난이도' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_DUNGEON', @level2type=N'COLUMN',@level2name=N'dungeon_level'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'무한 던전용 난이도' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_DUNGEON', @level2type=N'COLUMN',@level2name=N'dungeon_level_ex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'레이드 난이도' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_DUNGEON', @level2type=N'COLUMN',@level2name=N'dungeon_raid_level'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'던전 입장권 초기화 시각' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_DUNGEON', @level2type=N'COLUMN',@level2name=N'dungeon_ticket_reset_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'던전 귀속 해제 초기화 시각' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_DUNGEON', @level2type=N'COLUMN',@level2name=N'dungeon_bind_init_reset_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저의 던전 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_DUNGEON'
GO
PRINT N'Creating [dbo].[SB_USER_DUNGEON_BIND_INIT]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_DUNGEON_BIND_INIT](
	[user_db_id] [int] NOT NULL,
	[init_id] [int] NOT NULL,
	[init_used_count] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_DUNGEON_BIND_INIT] PRIMARY KEY CLUSTERED 
(
	[user_db_id] ASC,
	[init_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_DUNGEON_BIND_INIT', @level2type=N'COLUMN',@level2name=N'user_db_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'귀속해제 ID (DungeonBindInit.xlsm 에서 생성됨)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_DUNGEON_BIND_INIT', @level2type=N'COLUMN',@level2name=N'init_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'귀속해제 횟수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_DUNGEON_BIND_INIT', @level2type=N'COLUMN',@level2name=N'init_used_count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저의 던전별 귀속 해제 횟수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_DUNGEON_BIND_INIT'
GO
PRINT N'Creating [dbo].[SB_USER_DUNGEON_TICKET]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_DUNGEON_TICKET](
	[ticket_id] [int] NOT NULL,
	[user_db_id] [int] NOT NULL,
	[ticket_used_count] [int] NOT NULL,
	[addable_ticket_buy_count] [int] NOT NULL,
	[paid_used_count] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_DUNGEON_TICKET] PRIMARY KEY CLUSTERED 
(
	[user_db_id] ASC,
	[ticket_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입장권 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_DUNGEON_TICKET', @level2type=N'COLUMN',@level2name=N'ticket_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저의 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_DUNGEON_TICKET', @level2type=N'COLUMN',@level2name=N'user_db_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입장권 사용 횟수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_DUNGEON_TICKET', @level2type=N'COLUMN',@level2name=N'ticket_used_count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'추가 구매한 입장권 횟수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_DUNGEON_TICKET', @level2type=N'COLUMN',@level2name=N'addable_ticket_buy_count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저의 던전 입장권 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_DUNGEON_TICKET'
GO
ALTER TABLE [dbo].[SB_USER_DUNGEON_TICKET] ADD  CONSTRAINT [DF_SB_USER_DUNGEON_TICKET_ticket_used_count]  DEFAULT ((0)) FOR [ticket_used_count]
GO
ALTER TABLE [dbo].[SB_USER_DUNGEON_TICKET] ADD  CONSTRAINT [DF_SB_USER_DUNGEON_TICKET_addable_ticket_buy_count]  DEFAULT ((0)) FOR [addable_ticket_buy_count]
GO
ALTER TABLE [dbo].[SB_USER_DUNGEON_TICKET] ADD  CONSTRAINT [DF_SB_USER_DUNGEON_TICKET_paid_used_count]  DEFAULT ((0)) FOR [paid_used_count]
GO
PRINT N'Creating [dbo].[SB_USER_DUNGEON_TICKET_BOSS]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_DUNGEON_TICKET_BOSS](
	[user_db_id] [int] NOT NULL,
	[ticket_id] [int] NOT NULL,
	[boss_id] [int] NOT NULL,
	[is_first_kill] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_DUNGEON_TICKET_BOSS] PRIMARY KEY CLUSTERED 
(
	[user_db_id] ASC,
	[ticket_id] ASC,
	[boss_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'user db id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_DUNGEON_TICKET_BOSS', @level2type=N'COLUMN',@level2name=N'user_db_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'입장권 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_DUNGEON_TICKET_BOSS', @level2type=N'COLUMN',@level2name=N'ticket_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'죽은 보스 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_DUNGEON_TICKET_BOSS', @level2type=N'COLUMN',@level2name=N'boss_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'해당 입장권에서 해당 보스를 처음 잡았는 지 여부' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_DUNGEON_TICKET_BOSS', @level2type=N'COLUMN',@level2name=N'is_first_kill'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저의 던전 입장권과 연결된 죽은 보스 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_DUNGEON_TICKET_BOSS'
GO
PRINT N'Creating [dbo].[SB_USER_EVENT_COOL]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_EVENT_COOL](
	[user_id] [int] NOT NULL,
	[cool_id] [int] NOT NULL,
	[remain_time] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_EVENT_COOLTIME_USER_ID_COOL_ID] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[cool_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_EVENT_COOL', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'이벤트 쿨 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_EVENT_COOL', @level2type=N'COLUMN',@level2name=N'cool_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'남은 쿨타임' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_EVENT_COOL', @level2type=N'COLUMN',@level2name=N'remain_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'이벤트 쿨타임 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_EVENT_COOL'
GO
PRINT N'Creating [dbo].[SB_USER_FATIGUE]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_FATIGUE](
	[user_id] [int] NOT NULL,
	[fatigue] [int] NOT NULL,
	[last_reset_time] [datetime] NOT NULL,
 CONSTRAINT [PK_SB_USER_FATIGUE] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_FATIGUE', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'피로도 수치' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_FATIGUE', @level2type=N'COLUMN',@level2name=N'fatigue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'마지막 피로도 추기화 시각' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_FATIGUE', @level2type=N'COLUMN',@level2name=N'last_reset_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저의 피로도 페널티 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_FATIGUE'
GO
PRINT N'Creating [dbo].[SB_USER_HONOR_SEASON]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_HONOR_SEASON](
	[user_dbid] [int] NOT NULL,
	[season_no] [int] NOT NULL,
	[season_honor] [bigint] NOT NULL,
 CONSTRAINT [PK_SB_USER_HONOR_SEASON] PRIMARY KEY CLUSTERED 
(
	[user_dbid] ASC,
	[season_no] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 dbid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_HONOR_SEASON', @level2type=N'COLUMN',@level2name=N'user_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전장(투기장) 시즌no' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_HONOR_SEASON', @level2type=N'COLUMN',@level2name=N'season_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시즌 획득 명예점수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_HONOR_SEASON', @level2type=N'COLUMN',@level2name=N'season_honor'
GO
PRINT N'Creating [dbo].[SB_USER_HONOR_WEEK]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_HONOR_WEEK](
	[user_dbid] [int] NOT NULL,
	[season_no] [int] NOT NULL,
	[week_no] [int] NOT NULL,
	[week_honor] [bigint] NOT NULL,
	[grade] [int] NULL,
	[ranking] [int] NULL,
 CONSTRAINT [PK_SB_USER_HONOR_WEEK] PRIMARY KEY CLUSTERED 
(
	[user_dbid] ASC,
	[season_no] ASC,
	[week_no] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전장(투기장) 시즌no' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_HONOR_WEEK', @level2type=N'COLUMN',@level2name=N'season_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전장(투기장) 시즌 중 주no' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_HONOR_WEEK', @level2type=N'COLUMN',@level2name=N'week_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'명예 등급' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_HONOR_WEEK', @level2type=N'COLUMN',@level2name=N'grade'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'명예 등수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_HONOR_WEEK', @level2type=N'COLUMN',@level2name=N'ranking'
GO
PRINT N'Creating [dbo].[SB_USER_INFO]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_INFO](
	[ID] [int] NOT NULL,
	[lev] [smallint] NOT NULL,
	[exp] [int] NOT NULL,
	[energy] [int] NOT NULL,
	[hp] [int] NOT NULL,
	[cp] [int] NOT NULL,
	[money] [bigint] NOT NULL,
	[satiety] [smallint] NOT NULL,
	[logInTime] [datetime] NULL,
	[logOutTime] [datetime] NULL,
	[elapsed_play_time_in_sec] [bigint] NOT NULL,
	[builder_lev] [int] NOT NULL,
	[ip] [nvarchar](50) NULL,
	[vehicle] [int] NOT NULL,
	[rest] [float] NOT NULL,
	[spec_id] [tinyint] NOT NULL,
	[spec_count] [tinyint] NOT NULL,
	[elo] [int] NULL,
	[refusal] [int] NULL,
	[bf_item_point] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_INFO_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_INFO', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'레벨' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_INFO', @level2type=N'COLUMN',@level2name=N'lev'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'경험치' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_INFO', @level2type=N'COLUMN',@level2name=N'exp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'에너지' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_INFO', @level2type=N'COLUMN',@level2name=N'energy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'HP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_INFO', @level2type=N'COLUMN',@level2name=N'hp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'전투 포인트 (정기, 마나, 활력, 분노)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_INFO', @level2type=N'COLUMN',@level2name=N'cp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'게임 머니' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_INFO', @level2type=N'COLUMN',@level2name=N'money'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'포만도' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_INFO', @level2type=N'COLUMN',@level2name=N'satiety'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터 부가 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_INFO'
GO
ALTER TABLE [dbo].[SB_USER_INFO] ADD  CONSTRAINT [DF_SB_USER_INFO_ENERGY]  DEFAULT ((0)) FOR [energy]
GO
ALTER TABLE [dbo].[SB_USER_INFO] ADD  CONSTRAINT [DF_SB_USER_INFO_HP]  DEFAULT ((0)) FOR [hp]
GO
ALTER TABLE [dbo].[SB_USER_INFO] ADD  CONSTRAINT [DF_SB_USER_INFO_CP]  DEFAULT ((0)) FOR [cp]
GO
ALTER TABLE [dbo].[SB_USER_INFO] ADD  CONSTRAINT [DF_SB_USER_INFO_MONEY]  DEFAULT ((0)) FOR [money]
GO
ALTER TABLE [dbo].[SB_USER_INFO] ADD  CONSTRAINT [DF_SB_USER_INFO_satiety]  DEFAULT ((0)) FOR [satiety]
GO
ALTER TABLE [dbo].[SB_USER_INFO] ADD  CONSTRAINT [DF_SB_USER_INFO_elapsed_play_time]  DEFAULT ((0)) FOR [elapsed_play_time_in_sec]
GO
ALTER TABLE [dbo].[SB_USER_INFO] ADD  CONSTRAINT [DF_SB_USER_INFO_builderLev]  DEFAULT ((0)) FOR [builder_lev]
GO
ALTER TABLE [dbo].[SB_USER_INFO] ADD  CONSTRAINT [DF_SB_USER_INFO_vehicle]  DEFAULT ((0)) FOR [vehicle]
GO
ALTER TABLE [dbo].[SB_USER_INFO] ADD  CONSTRAINT [DF_SB_USER_INFO_rest]  DEFAULT ((0.0)) FOR [rest]
GO
ALTER TABLE [dbo].[SB_USER_INFO] ADD  CONSTRAINT [DF_SB_USER_INFO_spec_id]  DEFAULT ((0)) FOR [spec_id]
GO
ALTER TABLE [dbo].[SB_USER_INFO] ADD  CONSTRAINT [DF_SB_USER_INFO_spec_count]  DEFAULT ((1)) FOR [spec_count]
GO
ALTER TABLE [dbo].[SB_USER_INFO] ADD  CONSTRAINT [DF_SB_USER_INFO_elo]  DEFAULT ((1500)) FOR [elo]
GO
ALTER TABLE [dbo].[SB_USER_INFO] ADD  CONSTRAINT [DF_SB_USER_INFO_refusal]  DEFAULT ((0)) FOR [refusal]
GO
ALTER TABLE [dbo].[SB_USER_INFO] ADD  CONSTRAINT [DF_SB_USER_INFO_bf_item_point]  DEFAULT ((0)) FOR [bf_item_point]
GO
PRINT N'Creating [dbo].[SB_USER_INFO_MULTI_SPEC]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_INFO_MULTI_SPEC](
	[user_id] [int] NOT NULL,
	[spec_id] [int] NOT NULL,
	[talent] [int] NOT NULL,
	[ultimate_skill_id] [int] NOT NULL,
	[ultimate_soul_type] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_INFO_MULTI_SPEC_USER_ID_SPEC_ID] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[spec_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'User''s DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_INFO_MULTI_SPEC', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SpecID(0~3)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_INFO_MULTI_SPEC', @level2type=N'COLUMN',@level2name=N'spec_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Selected Talent(0:BASE, 1:TALENT1, 2:TALENT2, 3:TALENT_MAX)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_INFO_MULTI_SPEC', @level2type=N'COLUMN',@level2name=N'talent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Selected Ultimate SkillID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_INFO_MULTI_SPEC', @level2type=N'COLUMN',@level2name=N'ultimate_skill_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Selected Ultimate SkillID''s SoulType' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_INFO_MULTI_SPEC', @level2type=N'COLUMN',@level2name=N'ultimate_soul_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 특성 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_INFO_MULTI_SPEC'
GO
ALTER TABLE [dbo].[SB_USER_INFO_MULTI_SPEC] ADD  CONSTRAINT [DF_SB_USER_INFO_MULTI_SPEC_ultimate_skill_id]  DEFAULT ((0)) FOR [ultimate_skill_id]
GO
ALTER TABLE [dbo].[SB_USER_INFO_MULTI_SPEC] ADD  CONSTRAINT [DF_SB_USER_INFO_MULTI_SPEC_ultimate_soul_type]  DEFAULT ((-1)) FOR [ultimate_soul_type]
GO
PRINT N'Creating [dbo].[SB_USER_KEYBOARD_CONFIG]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_KEYBOARD_CONFIG](
	[user_id] [int] NOT NULL,
	[keyboard_config] [nvarchar](max) NULL,
 CONSTRAINT [PK_SB_USER_KEYBOARD_CONFIG_ID] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 키보드 설정 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_KEYBOARD_CONFIG'
GO
PRINT N'Creating [dbo].[SB_USER_LEVELUP_HISTORY]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_LEVELUP_HISTORY](
	[ID] [int] NOT NULL,
	[lev] [int] NOT NULL,
	[play_time] [bigint] NOT NULL,
	[lev_time] [datetime] NOT NULL,
 CONSTRAINT [PK_SB_USER_LEVELUP_HISTORY_ID_LEV] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[lev] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_LEVELUP_HISTORY', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'레벨' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_LEVELUP_HISTORY', @level2type=N'COLUMN',@level2name=N'lev'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'레벨 플레이 시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_LEVELUP_HISTORY', @level2type=N'COLUMN',@level2name=N'play_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'레벨 업 시각' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_LEVELUP_HISTORY', @level2type=N'COLUMN',@level2name=N'lev_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 레벨업 히스토리' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_LEVELUP_HISTORY'
GO
ALTER TABLE [dbo].[SB_USER_LEVELUP_HISTORY] ADD  CONSTRAINT [DF_SB_USER_LEVELUP_HISTORY_lev_time]  DEFAULT (getdate()) FOR [lev_time]
GO
PRINT N'Creating [dbo].[SB_USER_LIFE]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_LIFE](
	[ID] [int] NOT NULL,
	[is_alive] [bit] NOT NULL,
	[last_time_of_death] [datetime] NULL,
	[last_death_reason] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_LIFE_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저의 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_LIFE', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저의 생/사' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_LIFE', @level2type=N'COLUMN',@level2name=N'is_alive'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'마지막으로 죽은  시각' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_LIFE', @level2type=N'COLUMN',@level2name=N'last_time_of_death'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저의 생사 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_LIFE'
GO
ALTER TABLE [dbo].[SB_USER_LIFE] ADD  CONSTRAINT [DF_SB_USER_LIFE_is_alive]  DEFAULT ((1)) FOR [is_alive]
GO
ALTER TABLE [dbo].[SB_USER_LIFE] ADD  CONSTRAINT [DF_SB_USER_LIFE_last_death_reason]  DEFAULT ((3)) FOR [last_death_reason]
GO
PRINT N'Creating [dbo].[SB_USER_MONTHLY_SUBSCRIPTION]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_MONTHLY_SUBSCRIPTION](
	[user_db_id] [int] NOT NULL,
	[last_provided_basis_time] [datetime] NOT NULL,
	[activated_subscription_time] [datetime] NOT NULL,
	[expired_subscription_time] [datetime] NOT NULL,
 CONSTRAINT [PK_sb_user_monthly_subscription] PRIMARY KEY CLUSTERED 
(
	[user_db_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
PRINT N'Creating [dbo].[SB_USER_MONTHLY_SUBSCRIPTION_HISTORY]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_MONTHLY_SUBSCRIPTION_HISTORY](
	[global_seq_id] [bigint] IDENTITY(1,1) NOT NULL,
	[user_db_id] [int] NOT NULL,
	[provided_time] [datetime] NOT NULL,
	[provided_basis_time] [datetime] NOT NULL,
 CONSTRAINT [PK_SB_USER_MONTHLY_SUBSCRIPTION_HISTORY] PRIMARY KEY NONCLUSTERED 
(
	[global_seq_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_SB_USER_MONTHLY_SUBSCRIPTION_HISTORY] ON [dbo].[SB_USER_MONTHLY_SUBSCRIPTION_HISTORY] 
(
	[user_db_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
PRINT N'Creating [dbo].[SB_USER_NAME_HISTORY]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_NAME_HISTORY](
	[user_id] [int] NOT NULL,
	[before_name] [nvarchar](64) NOT NULL,
	[after_name] [nvarchar](64) NOT NULL,
	[created_time] [datetime] NOT NULL
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_NAME_HISTORY', @level2type=N'COLUMN',@level2name=N'user_id'
GO
ALTER TABLE [dbo].[SB_USER_NAME_HISTORY] ADD  CONSTRAINT [DF_SB_USER_NAME_created_time]  DEFAULT (getdate()) FOR [created_time]
GO
PRINT N'Creating [dbo].[SB_USER_PACKAGE_POINT]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_PACKAGE_POINT](
	[user_dbid] [int] NOT NULL,
	[item_class_id] [int] NOT NULL,
	[package_point] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_PACKAGE_POINT_user_dbid_item_class_id] PRIMARY KEY CLUSTERED 
(
	[user_dbid] ASC,
	[item_class_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
PRINT N'Creating [dbo].[SB_USER_PET]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_PET](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[owner_dbid] [int] NOT NULL,
	[pet_class_id] [int] NOT NULL,
	[pet_slot_index] [int] NOT NULL,
	[pet_name] [nvarchar](64) NOT NULL,
	[expire_date] [datetime] NULL,
 CONSTRAINT [PK_SB_USER_PET_ID] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_SB_USER_PET_OWNER] ON [dbo].[SB_USER_PET] 
(
	[owner_dbid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PET DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_PET', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Pet''s OwnerDBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_PET', @level2type=N'COLUMN',@level2name=N'owner_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Pet''s NPCClassID at MonsterData' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_PET', @level2type=N'COLUMN',@level2name=N'pet_class_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Pet SlotIndex, SB_ITEM_BAG.slot_index(if SB_ITEM_BAG.bag_type=3)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_PET', @level2type=N'COLUMN',@level2name=N'pet_slot_index'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Pet Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_PET', @level2type=N'COLUMN',@level2name=N'pet_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ExpireDate(if Periodic Pet), default is -1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_PET', @level2type=N'COLUMN',@level2name=N'expire_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저의 펫 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_PET'
GO
PRINT N'Creating [dbo].[SB_USER_PET_HISTORY]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_PET_HISTORY](
	[owner_id] [int] NOT NULL,
	[pet_id] [int] NOT NULL,
	[pet_class_id] [int] NOT NULL,
	[pet_name] [nvarchar](64) NOT NULL,
	[expire_date] [datetime] NULL,
	[log_type] [int] NULL,
	[log_date] [datetime] NULL,
	[minutes_to_expire] [int] NULL,
	[pet_slot_index] [int] NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_SB_USER_PET_HISTORY_OWNER_ID] ON [dbo].[SB_USER_PET_HISTORY] 
(
	[owner_id] ASC,
	[pet_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SB_USER_PET_HISTORY] ADD  CONSTRAINT [DF_SB_USER_PET_HISTORY_log_date]  DEFAULT (getdate()) FOR [log_date]
GO
PRINT N'Creating [dbo].[SB_USER_PLAYTIME_PER_DAY]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_PLAYTIME_PER_DAY](
	[user_id] [int] NOT NULL,
	[play_day] [date] NOT NULL,
	[playtime] [bigint] NOT NULL,
 CONSTRAINT [PK_SB_USER_PLAYTIME_PER_DAY] PRIMARY KEY NONCLUSTERED 
(
	[user_id] ASC,
	[play_day] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_PLAYTIME_PER_DAY', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'날짜' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_PLAYTIME_PER_DAY', @level2type=N'COLUMN',@level2name=N'play_day'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'플레이 시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_PLAYTIME_PER_DAY', @level2type=N'COLUMN',@level2name=N'playtime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'날짜별 플레이 시간' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_PLAYTIME_PER_DAY'
GO
PRINT N'Creating [dbo].[SB_USER_POS]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_POS](
	[ID] [int] NOT NULL,
	[x] [float] NOT NULL,
	[y] [float] NOT NULL,
	[z] [float] NOT NULL,
	[area_id] [int] NULL,
	[region_id] [int] NULL,
	[resource_id] [int] NULL,
	[grid_x] [int] NULL,
	[grid_y] [int] NULL,
	[grid_z] [int] NULL,
	[reserved] [int] NULL,
	[yaw] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_POS_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'좌표 X' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS', @level2type=N'COLUMN',@level2name=N'x'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'좌표 Y' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS', @level2type=N'COLUMN',@level2name=N'y'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'좌표 Z' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS', @level2type=N'COLUMN',@level2name=N'z'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 대지역 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS', @level2type=N'COLUMN',@level2name=N'area_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 소지역 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS', @level2type=N'COLUMN',@level2name=N'region_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 리소스 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS', @level2type=N'COLUMN',@level2name=N'resource_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 X' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS', @level2type=N'COLUMN',@level2name=N'grid_x'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 Y' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS', @level2type=N'COLUMN',@level2name=N'grid_y'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 Z' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS', @level2type=N'COLUMN',@level2name=N'grid_z'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 예약 필드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS', @level2type=N'COLUMN',@level2name=N'reserved'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터 위치 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS'
GO
ALTER TABLE [dbo].[SB_USER_POS] ADD  CONSTRAINT [DF_SB_USER_POS_yaw]  DEFAULT ((0)) FOR [yaw]
GO
PRINT N'Creating [dbo].[SB_USER_POS_REVIVE]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_POS_REVIVE](
	[user_id] [int] NOT NULL,
	[x] [float] NOT NULL,
	[y] [float] NOT NULL,
	[z] [float] NOT NULL,
	[area_id] [int] NOT NULL,
	[region_id] [int] NOT NULL,
	[resource_id] [int] NOT NULL,
	[grid_x] [int] NOT NULL,
	[grid_y] [int] NOT NULL,
	[grid_z] [int] NOT NULL,
	[reserved] [int] NOT NULL,
	[yaw] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_POS_REVIVE] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_REVIVE', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'좌표 x' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_REVIVE', @level2type=N'COLUMN',@level2name=N'x'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'좌표 y' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_REVIVE', @level2type=N'COLUMN',@level2name=N'y'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'좌표 z' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_REVIVE', @level2type=N'COLUMN',@level2name=N'z'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 대지역 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_REVIVE', @level2type=N'COLUMN',@level2name=N'area_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 소지역 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_REVIVE', @level2type=N'COLUMN',@level2name=N'region_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 리소스 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_REVIVE', @level2type=N'COLUMN',@level2name=N'resource_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 X' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_REVIVE', @level2type=N'COLUMN',@level2name=N'grid_x'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 Y' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_REVIVE', @level2type=N'COLUMN',@level2name=N'grid_y'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 Z' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_REVIVE', @level2type=N'COLUMN',@level2name=N'grid_z'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 예약필드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_REVIVE', @level2type=N'COLUMN',@level2name=N'reserved'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'방향' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_REVIVE', @level2type=N'COLUMN',@level2name=N'yaw'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저의 등록된 부활위치' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_REVIVE'
GO
PRINT N'Creating [dbo].[SB_USER_POS_VALID]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_POS_VALID](
	[user_id] [int] NOT NULL,
	[x] [float] NOT NULL,
	[y] [float] NOT NULL,
	[z] [float] NOT NULL,
	[area_id] [int] NOT NULL,
	[region_id] [int] NOT NULL,
	[resource_id] [int] NOT NULL,
	[grid_x] [int] NOT NULL,
	[grid_y] [int] NOT NULL,
	[grid_z] [int] NOT NULL,
	[reserved] [int] NOT NULL,
	[yaw] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_POS_VALID] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SB_USER_POS_VALID] ON [dbo].[SB_USER_POS_VALID] 
(
	[user_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_VALID', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'좌표 x' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_VALID', @level2type=N'COLUMN',@level2name=N'x'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'좌표 y' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_VALID', @level2type=N'COLUMN',@level2name=N'y'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'좌표 z' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_VALID', @level2type=N'COLUMN',@level2name=N'z'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 대지역 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_VALID', @level2type=N'COLUMN',@level2name=N'area_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 소지역 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_VALID', @level2type=N'COLUMN',@level2name=N'region_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 리소스 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_VALID', @level2type=N'COLUMN',@level2name=N'resource_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 X' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_VALID', @level2type=N'COLUMN',@level2name=N'grid_x'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 Y' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_VALID', @level2type=N'COLUMN',@level2name=N'grid_y'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 Z' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_VALID', @level2type=N'COLUMN',@level2name=N'grid_z'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'코디네이터 예약 필드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_VALID', @level2type=N'COLUMN',@level2name=N'reserved'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터가 바라보는 방향' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_VALID', @level2type=N'COLUMN',@level2name=N'yaw'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저의 고립탈출용 좌표정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_POS_VALID'
GO
PRINT N'Creating [dbo].[SB_USER_PROFESSION]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_PROFESSION](
	[user_id] [int] NOT NULL,
	[profession_id] [int] NOT NULL,
	[grade_id] [int] NOT NULL,
	[point] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_PROFESSION_USER_ID_PROFESSION_ID] PRIMARY KEY NONCLUSTERED 
(
	[user_id] ASC,
	[profession_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'소유자 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_PROFESSION', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'습득한 전문기술 스크립트 id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_PROFESSION', @level2type=N'COLUMN',@level2name=N'profession_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'습득한 전문기술 그레이드 id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_PROFESSION', @level2type=N'COLUMN',@level2name=N'grade_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'현재까지의 전문기술 숙련도' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_PROFESSION', @level2type=N'COLUMN',@level2name=N'point'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 전문기술 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_PROFESSION'
GO
PRINT N'Creating [dbo].[SB_USER_QUEST]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_QUEST](
	[user_id] [int] NOT NULL,
	[quest_id] [int] NOT NULL,
	[finished] [tinyint] NOT NULL,
	[registered] [tinyint] NOT NULL,
	[registered_date] [datetime] NULL,
	[finished_date] [datetime] NULL,
 CONSTRAINT [PK_SB_USER_QUEST_USER_ID_QUEST_ID] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[quest_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'소유자 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_QUEST', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퀘스트 스크립트 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_QUEST', @level2type=N'COLUMN',@level2name=N'quest_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퀘스트 완료여부 (0/1)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_QUEST', @level2type=N'COLUMN',@level2name=N'finished'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'알리미 UI 등록여부 (0/1)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_QUEST', @level2type=N'COLUMN',@level2name=N'registered'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'알리미 등록 시각' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_QUEST', @level2type=N'COLUMN',@level2name=N'registered_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저의 진행중/완료한 퀘스트 리스트' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_QUEST'
GO
ALTER TABLE [dbo].[SB_USER_QUEST] ADD  CONSTRAINT [DF_SB_USER_QUEST_registered_date]  DEFAULT (getdate()) FOR [registered_date]
GO
PRINT N'Creating [dbo].[SB_USER_QUEST_PROGRESS]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_QUEST_PROGRESS](
	[user_id] [int] NOT NULL,
	[quest_id] [int] NOT NULL,
	[goal_id] [int] NOT NULL,
	[progress] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_QUEST_PROGRESS_USER_ID_QUEST_ID_GOAL_ID] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[quest_id] ASC,
	[goal_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'소유자 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_QUEST_PROGRESS', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퀘스트 스크립트 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_QUEST_PROGRESS', @level2type=N'COLUMN',@level2name=N'quest_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퀘스트 목표ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_QUEST_PROGRESS', @level2type=N'COLUMN',@level2name=N'goal_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퀘스트 목표에 대한 진행 정도' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_QUEST_PROGRESS', @level2type=N'COLUMN',@level2name=N'progress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'퀘스트 목표 수행 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_QUEST_PROGRESS'
GO
PRINT N'Creating [dbo].[SB_USER_QUEST_RESET]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_QUEST_RESET](
	[user_id] [int] NOT NULL,
	[daily_quest_reset] [datetime] NOT NULL,
 CONSTRAINT [PK_SB_USER_QUEST_RESET] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
PRINT N'Creating [dbo].[SB_USER_RECIPE]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_RECIPE](
	[user_id] [int] NOT NULL,
	[recipe_id] [int] NOT NULL,
	[profession_id] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_RECIPE_USER_ID_RECIPE_ID] PRIMARY KEY NONCLUSTERED 
(
	[user_id] ASC,
	[recipe_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'소유자 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_RECIPE', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'습득한 recipe 스크립트 id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_RECIPE', @level2type=N'COLUMN',@level2name=N'recipe_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'해당 recipe의 전문기술ID. 전문기술 삭제 시, 해당 전문기술의 recipe를 지울 때 이용한다.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_RECIPE', @level2type=N'COLUMN',@level2name=N'profession_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저의 도안 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_RECIPE'
GO
ALTER TABLE [dbo].[SB_USER_RECIPE] ADD  CONSTRAINT [DF_SB_USER_RECIPE_profession_id]  DEFAULT ((0)) FOR [profession_id]
GO
PRINT N'Creating [dbo].[SB_USER_RECIPE_COOL]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_RECIPE_COOL](
	[user_id] [int] NOT NULL,
	[cool_id] [int] NOT NULL,
	[cool_time] [bigint] NOT NULL,
 CONSTRAINT [PK_SB_USER_RECIPE_COOLTIME_USER_ID_COOL_ID] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[cool_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'User DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_RECIPE_COOL', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'도안 쿨타임 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_RECIPE_COOL', @level2type=N'COLUMN',@level2name=N'cool_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'도안 쿨타임 만료시간(초)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_RECIPE_COOL', @level2type=N'COLUMN',@level2name=N'cool_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 도안 쿨타임 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_RECIPE_COOL'
GO
PRINT N'Creating [dbo].[SB_USER_SECONDARY_MONEY]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_SECONDARY_MONEY](
	[ID] [int] NOT NULL,
	[infinite_hunt_point] [bigint] NULL,
	[infinite_hunt_point_weekly] [bigint] NULL,
	[guild_warrior_point] [bigint] NULL,
	[guild_warrior_point_weekly] [bigint] NULL,
	[arena_point] [bigint] NULL,
	[arena_point_weekly] [bigint] NULL,
	[reset_time] [datetime] NULL,
	[private_arena_point] [bigint] NOT NULL,
	[private_arena_point_weekly] [bigint] NOT NULL,
	[team_arena_point] [bigint] NOT NULL,
	[team_arena_point_weekly] [bigint] NOT NULL,
 CONSTRAINT [PK_SB_USER_SECONDARY_MONEY_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SB_USER_SECONDARY_MONEY] ADD  CONSTRAINT [DF_SB_USER_SECONDARY_MONEY_infinite_hunt_point]  DEFAULT ((0)) FOR [infinite_hunt_point]
GO
ALTER TABLE [dbo].[SB_USER_SECONDARY_MONEY] ADD  CONSTRAINT [DF_SB_USER_SECONDARY_MONEY_infinite_hunt_point_weekly]  DEFAULT ((0)) FOR [infinite_hunt_point_weekly]
GO
ALTER TABLE [dbo].[SB_USER_SECONDARY_MONEY] ADD  CONSTRAINT [DF_SB_USER_SECONDARY_MONEY_guild_warrior_point]  DEFAULT ((0)) FOR [guild_warrior_point]
GO
ALTER TABLE [dbo].[SB_USER_SECONDARY_MONEY] ADD  CONSTRAINT [DF_SB_USER_SECONDARY_MONEY_guild_warrior_point_weekly]  DEFAULT ((0)) FOR [guild_warrior_point_weekly]
GO
ALTER TABLE [dbo].[SB_USER_SECONDARY_MONEY] ADD  CONSTRAINT [DF_SB_USER_SECONDARY_MONEY_arena_point]  DEFAULT ((0)) FOR [arena_point]
GO
ALTER TABLE [dbo].[SB_USER_SECONDARY_MONEY] ADD  CONSTRAINT [DF_SB_USER_SECONDARY_MONEY_arena_point_weekly]  DEFAULT ((0)) FOR [arena_point_weekly]
GO
ALTER TABLE [dbo].[SB_USER_SECONDARY_MONEY] ADD  CONSTRAINT [DF_SB_USER_SECONDARY_MONEY_private_arena_point]  DEFAULT ((0)) FOR [private_arena_point]
GO
ALTER TABLE [dbo].[SB_USER_SECONDARY_MONEY] ADD  CONSTRAINT [DF_SB_USER_SECONDARY_MONEY_private_arena_point_weekly]  DEFAULT ((0)) FOR [private_arena_point_weekly]
GO
ALTER TABLE [dbo].[SB_USER_SECONDARY_MONEY] ADD  CONSTRAINT [DF_SB_USER_SECONDARY_MONEY_team_arena_point]  DEFAULT ((0)) FOR [team_arena_point]
GO
ALTER TABLE [dbo].[SB_USER_SECONDARY_MONEY] ADD  CONSTRAINT [DF_SB_USER_SECONDARY_MONEY_team_arena_point_weekly]  DEFAULT ((0)) FOR [team_arena_point_weekly]
GO
PRINT N'Creating [dbo].[SB_USER_SKILL]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_SKILL](
	[ID] [int] NOT NULL,
	[skill_id] [int] NOT NULL,
	[skill_level] [smallint] NULL,
	[spec_id] [tinyint] NOT NULL,
 CONSTRAINT [PK_SB_USER_SKILL_ID_SPEC_ID_SKILL_ID] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC,
	[spec_id] ASC,
	[skill_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_SKILL', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'스킬 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_SKILL', @level2type=N'COLUMN',@level2name=N'skill_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'스킬 레벨' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_SKILL', @level2type=N'COLUMN',@level2name=N'skill_level'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터가 보유한 스킬 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_SKILL'
GO
ALTER TABLE [dbo].[SB_USER_SKILL] ADD  CONSTRAINT [DF_SB_USER_SKILL_spec_id]  DEFAULT ((0)) FOR [spec_id]
GO
PRINT N'Creating [dbo].[SB_USER_SKILL_COOL]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_SKILL_COOL](
	[user_id] [int] NOT NULL,
	[cool_id] [int] NOT NULL,
	[cool_time] [bigint] NOT NULL,
 CONSTRAINT [PK_SB_USER_SKILL_COOL_USER_ID_COOL_ID] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[cool_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_SKILL_COOL', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'스킬 쿨 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_SKILL_COOL', @level2type=N'COLUMN',@level2name=N'cool_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'스킬 쿨 만료시각' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_SKILL_COOL', @level2type=N'COLUMN',@level2name=N'cool_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터의 스킬 쿨 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_SKILL_COOL'
GO
PRINT N'Creating [dbo].[SB_USER_SKILL_TRIGGER]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_SKILL_TRIGGER](
	[ID] [int] NOT NULL,
	[trigger_id] [int] NOT NULL,
	[trigger_level] [int] NOT NULL,
	[spec_id] [tinyint] NOT NULL,
 CONSTRAINT [PK_SB_USER_SKILL_TRIGGER_ID_TRIGGER_ID] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC,
	[spec_id] ASC,
	[trigger_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_SKILL_TRIGGER', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'트리거 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_SKILL_TRIGGER', @level2type=N'COLUMN',@level2name=N'trigger_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'트리거 레벨' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_SKILL_TRIGGER', @level2type=N'COLUMN',@level2name=N'trigger_level'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터가 보유한 스킬 트리거 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_SKILL_TRIGGER'
GO
ALTER TABLE [dbo].[SB_USER_SKILL_TRIGGER] ADD  CONSTRAINT [DF_SB_USER_SKILL_TRIGGER_spec_id]  DEFAULT ((0)) FOR [spec_id]
GO
PRINT N'Creating [dbo].[SB_USER_SOUL]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_SOUL](
	[user_id] [int] NOT NULL,
	[soul_type] [int] NOT NULL,
	[amount] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_SOUL_OWNER_DBID_TYPE] PRIMARY KEY NONCLUSTERED 
(
	[user_id] ASC,
	[soul_type] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'User DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_SOUL', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'소울 타입(-1:혼돈, 0:희망, 1:순수, 2:용기, 3:평안)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_SOUL', @level2type=N'COLUMN',@level2name=N'soul_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'소울 수량' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_SOUL', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'소울스킬 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_SOUL'
GO
PRINT N'Creating [dbo].[SB_USER_SOUL_MONEY]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_SOUL_MONEY](
	[user_db_id] [int] NOT NULL,
	[soul_money] [bigint] NULL,
 CONSTRAINT [PK_SB_USER_SOUL_MONEY] PRIMARY KEY CLUSTERED 
(
	[user_db_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SB_USER_SOUL_MONEY] ADD  CONSTRAINT [DF_SB_USER_SOUL_MONEY_soul_money]  DEFAULT ((0)) FOR [soul_money]
GO
PRINT N'Creating [dbo].[SB_USER_SOUL_SKILL]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_SOUL_SKILL](
	[user_dbid] [int] NOT NULL,
	[hope_exp] [int] NOT NULL,
	[purity_exp] [int] NOT NULL,
	[courage_exp] [int] NOT NULL,
	[well_exp] [int] NOT NULL,
	[selected_soul_type] [int] NOT NULL,
	[selected_seq] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_SOUL_SKILL_user_dbid] PRIMARY KEY NONCLUSTERED 
(
	[user_dbid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_SOUL_SKILL', @level2type=N'COLUMN',@level2name=N'user_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'희망 소울 경험치' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_SOUL_SKILL', @level2type=N'COLUMN',@level2name=N'hope_exp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'순수 소울 경험치' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_SOUL_SKILL', @level2type=N'COLUMN',@level2name=N'purity_exp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'용기 소울 경험치' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_SOUL_SKILL', @level2type=N'COLUMN',@level2name=N'courage_exp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'평안 소울 경험치' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_SOUL_SKILL', @level2type=N'COLUMN',@level2name=N'well_exp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'선택된 소울 타입' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_SOUL_SKILL', @level2type=N'COLUMN',@level2name=N'selected_soul_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'선택된 소울 순서번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_SOUL_SKILL', @level2type=N'COLUMN',@level2name=N'selected_seq'
GO
ALTER TABLE [dbo].[SB_USER_SOUL_SKILL] ADD  CONSTRAINT [DF_SB_USER_SOUL_SKILL_hope_exp]  DEFAULT ((0)) FOR [hope_exp]
GO
ALTER TABLE [dbo].[SB_USER_SOUL_SKILL] ADD  CONSTRAINT [DF_SB_USER_SOUL_SKILL_purity_exp]  DEFAULT ((0)) FOR [purity_exp]
GO
ALTER TABLE [dbo].[SB_USER_SOUL_SKILL] ADD  CONSTRAINT [DF_SB_USER_SOUL_SKILL_courage_exp]  DEFAULT ((0)) FOR [courage_exp]
GO
ALTER TABLE [dbo].[SB_USER_SOUL_SKILL] ADD  CONSTRAINT [DF_SB_USER_SOUL_SKILL_well_exp]  DEFAULT ((0)) FOR [well_exp]
GO
ALTER TABLE [dbo].[SB_USER_SOUL_SKILL] ADD  CONSTRAINT [DF_SB_USER_SOUL_SKILL_selected_soul_type]  DEFAULT ((0)) FOR [selected_soul_type]
GO
ALTER TABLE [dbo].[SB_USER_SOUL_SKILL] ADD  CONSTRAINT [DF_SB_USER_SOUL_SKILL_selected_seq]  DEFAULT ((0)) FOR [selected_seq]
GO
PRINT N'Creating [dbo].[SB_USER_SPVP]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_SPVP](
	[user_id] [int] NOT NULL,
	[bf_class_id] [int] NOT NULL,
	[win_count] [int] NULL,
	[lost_count] [int] NULL,
	[win_streak_count] [int] NULL,
	[lost_streak_count] [int] NULL,
	[mvp_count] [int] NULL,
	[kill_count] [int] NULL,
	[assist_count] [int] NULL,
	[occupy_count] [int] NULL,
	[weekly_afk_count] [int] NULL,
	[afk_count] [int] NULL,
	[resource_mvp_count] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_SPVP_user_id_bf_class_id] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[bf_class_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SB_USER_SPVP] ADD  CONSTRAINT [DF_SB_USER_SPVP_win_count]  DEFAULT ((0)) FOR [win_count]
GO
ALTER TABLE [dbo].[SB_USER_SPVP] ADD  CONSTRAINT [DF_SB_USER_SPVP_lost_count]  DEFAULT ((0)) FOR [lost_count]
GO
ALTER TABLE [dbo].[SB_USER_SPVP] ADD  CONSTRAINT [DF_SB_USER_SPVP_win_streak_count]  DEFAULT ((0)) FOR [win_streak_count]
GO
ALTER TABLE [dbo].[SB_USER_SPVP] ADD  CONSTRAINT [DF_SB_USER_SPVP_lost_streak_count]  DEFAULT ((0)) FOR [lost_streak_count]
GO
ALTER TABLE [dbo].[SB_USER_SPVP] ADD  CONSTRAINT [DF_SB_USER_SPVP_mvp_count]  DEFAULT ((0)) FOR [mvp_count]
GO
ALTER TABLE [dbo].[SB_USER_SPVP] ADD  CONSTRAINT [DF_SB_USER_SPVP_kill_count]  DEFAULT ((0)) FOR [kill_count]
GO
ALTER TABLE [dbo].[SB_USER_SPVP] ADD  CONSTRAINT [DF_SB_USER_SPVP_assist_count]  DEFAULT ((0)) FOR [assist_count]
GO
ALTER TABLE [dbo].[SB_USER_SPVP] ADD  CONSTRAINT [DF_SB_USER_SPVP_occupy_count]  DEFAULT ((0)) FOR [occupy_count]
GO
ALTER TABLE [dbo].[SB_USER_SPVP] ADD  CONSTRAINT [DF_SB_USER_SPVP_weekly_afk_count]  DEFAULT ((0)) FOR [weekly_afk_count]
GO
ALTER TABLE [dbo].[SB_USER_SPVP] ADD  CONSTRAINT [DF_SB_USER_SPVP_afk_count]  DEFAULT ((0)) FOR [afk_count]
GO
ALTER TABLE [dbo].[SB_USER_SPVP] ADD  CONSTRAINT [DF_SB_USER_SPVP_resource_mvp_count]  DEFAULT ((0)) FOR [resource_mvp_count]
GO
PRINT N'Creating [dbo].[SB_USER_SPVP_INFO]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_SPVP_INFO](
	[ID] [int] NOT NULL,
	[bf_daily_play_count] [int] NOT NULL,
	[play_count_reset_time] [bigint] NULL,
 CONSTRAINT [PK_SB_USER_SPVP_INFO_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SB_USER_SPVP_INFO] ADD  CONSTRAINT [DF_SB_USER_SPVP_INFO_bf_daily_play_count]  DEFAULT ((0)) FOR [bf_daily_play_count]
GO
PRINT N'Creating [dbo].[SB_USER_TIME_ATTACK]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_TIME_ATTACK](
	[user_db_id] [int] NOT NULL,
	[infinite_dungeon_set_name] [nvarchar](64) NOT NULL,
	[dungeon_class_id] [int] NOT NULL,
	[dungeon_level_ex] [int] NOT NULL,
	[complete_seconds] [int] NOT NULL,
	[update_time] [datetime] NOT NULL,
 CONSTRAINT [PK_SB_USER_TIME_ATTACK] PRIMARY KEY CLUSTERED 
(
	[user_db_id] ASC,
	[infinite_dungeon_set_name] ASC,
	[dungeon_class_id] ASC,
	[dungeon_level_ex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
PRINT N'Creating [dbo].[SB_USER_TITLE]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_TITLE](
	[user_id] [int] NOT NULL,
	[title_id] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_TITLE] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[title_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_TITLE', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'호칭 스크립트 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_TITLE', @level2type=N'COLUMN',@level2name=N'title_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저가 습득한 호칭 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_TITLE'
GO
PRINT N'Creating [dbo].[SB_USER_TRANSMOGRIFY_LIST]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_TRANSMOGRIFY_LIST](
	[ID] [int] NOT NULL,
	[class_id] [int] NOT NULL,
	[slot_type] [int] NULL,
	[used] [bit] NULL,
	[create_date] [datetime] NULL,
 CONSTRAINT [PK_USER_TRANSMOGRIFY_ID_CLASS_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[class_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SB_USER_TRANSMOGRIFY_LIST] ADD  CONSTRAINT [DF_SB_USER_TRANSMOGRIFY_LIST_used]  DEFAULT ((0)) FOR [used]
GO
PRINT N'Creating [dbo].[SB_USER_TRUST_SALE]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_TRUST_SALE](
	[userDBID] [int] NOT NULL,
	[slotMax] [int] NULL,
	[usedSlot] [int] NULL,
	[useMaxInWeek] [int] NULL,
	[usedUseCount] [int] NULL,
	[use_count_reset_time] [datetime] NULL,
	[free_commission_reset_time] [datetime] NULL,
	[slot_max_reset_time] [datetime] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SB_USER_TRUST_SALE_USERDBID] ON [dbo].[SB_USER_TRUST_SALE] 
(
	[userDBID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저의 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_TRUST_SALE', @level2type=N'COLUMN',@level2name=N'userDBID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'위탁판매 등록 슬롯' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_TRUST_SALE', @level2type=N'COLUMN',@level2name=N'slotMax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'현재 사용중인 슬롯 개수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_TRUST_SALE', @level2type=N'COLUMN',@level2name=N'usedSlot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'일주일동안 사용 횟수의 최대값' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_TRUST_SALE', @level2type=N'COLUMN',@level2name=N'useMaxInWeek'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사용 횟수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_TRUST_SALE', @level2type=N'COLUMN',@level2name=N'usedUseCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저 위탁판매 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_TRUST_SALE'
GO
ALTER TABLE [dbo].[SB_USER_TRUST_SALE] ADD  CONSTRAINT [DF_SB_USER_TRUST_SALE_usedSlot]  DEFAULT ((0)) FOR [usedSlot]
GO
ALTER TABLE [dbo].[SB_USER_TRUST_SALE] ADD  CONSTRAINT [DF_SB_USER_TRUST_SALE_usedUseCount]  DEFAULT ((0)) FOR [usedUseCount]
GO
PRINT N'Creating [dbo].[SB_USER_ULTIMATE_SKILL]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_ULTIMATE_SKILL](
	[user_id] [int] NOT NULL,
	[ultimate_skill_id] [int] NOT NULL,
	[hope_exp] [int] NOT NULL,
	[courage_exp] [int] NOT NULL,
	[purity_exp] [int] NOT NULL,
	[well_exp] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_ULTIMATE_SKILL_USER_ID_ULTIMATE_SKILL_ID] PRIMARY KEY NONCLUSTERED 
(
	[user_id] ASC,
	[ultimate_skill_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UserDBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ULTIMATE_SKILL', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'궁극기 SkillID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ULTIMATE_SKILL', @level2type=N'COLUMN',@level2name=N'ultimate_skill_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'궁극기 소울(희망) 경험치' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ULTIMATE_SKILL', @level2type=N'COLUMN',@level2name=N'hope_exp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'궁극기 소울(용기) 경험치' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ULTIMATE_SKILL', @level2type=N'COLUMN',@level2name=N'courage_exp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'궁극기 소울(순수) 경험치' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ULTIMATE_SKILL', @level2type=N'COLUMN',@level2name=N'purity_exp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'궁극기 소울(평안) 경험치' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_ULTIMATE_SKILL', @level2type=N'COLUMN',@level2name=N'well_exp'
GO
PRINT N'Creating [dbo].[SB_USER_VEHICLE]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_VEHICLE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[owner_dbid] [int] NOT NULL,
	[vehicle_class_id] [int] NOT NULL,
	[vehicle_slot_index] [int] NOT NULL,
	[expire_date] [datetime] NULL,
 CONSTRAINT [PK_SB_USER_VEHICLE_ID] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
PRINT N'Creating [dbo].[SB_USER_VEHICLE_HISTORY]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_VEHICLE_HISTORY](
	[owner_dbid] [int] NOT NULL,
	[vehicle_dbid] [int] NOT NULL,
	[vehicle_class_id] [int] NOT NULL,
	[expire_date] [datetime] NULL,
	[log_type] [int] NULL,
	[log_date] [datetime] NULL,
	[minutes_to_expire] [int] NULL,
	[vehicle_slot_index] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SB_USER_VEHICLE_HISTORY] ADD  CONSTRAINT [DF_SB_USER_VEHICLE_HISTORY_log_date]  DEFAULT (getdate()) FOR [log_date]
GO
PRINT N'Creating [dbo].[SB_USER_VISITED_POS]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_VISITED_POS](
	[ID] [int] NOT NULL,
	[world_coord] [bigint] NOT NULL,
	[area_id] [int] NOT NULL,
	[region_id] [int] NOT NULL,
	[resource_id] [int] NOT NULL,
	[grid_x] [int] NOT NULL,
	[grid_y] [int] NOT NULL,
	[grid_z] [int] NOT NULL,
	[reserved] [int] NOT NULL,
 CONSTRAINT [PK_SB_USER_VISITED_POS_ID_WORLD_COORD] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC,
	[world_coord] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_SB_USER_VISITED_POS_ID] ON [dbo].[SB_USER_VISITED_POS] 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SB_USER_VISITED_POS_ID_WORLD_COORD] ON [dbo].[SB_USER_VISITED_POS] 
(
	[ID] ASC,
	[world_coord] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
PRINT N'Creating [dbo].[SB_USER_WAREHOUSE]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_USER_WAREHOUSE](
	[owner_dbid] [int] NOT NULL,
	[available_slot_count] [int] NOT NULL,
	[money] [bigint] NOT NULL
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_SB_USER_WAREHOUSE_OWNER_ID] ON [dbo].[SB_USER_WAREHOUSE] 
(
	[owner_dbid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'캐릭터 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_WAREHOUSE', @level2type=N'COLUMN',@level2name=N'owner_dbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'가용 슬롯 수' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_WAREHOUSE', @level2type=N'COLUMN',@level2name=N'available_slot_count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'창고에 보관된 게임 머니' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_WAREHOUSE', @level2type=N'COLUMN',@level2name=N'money'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'개인 창고 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_USER_WAREHOUSE'
GO
PRINT N'Creating [dbo].[SB_WARP]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_WARP](
	[ID] [int] NOT NULL,
	[warp_region] [int] NOT NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_SB_WARP_ID] ON [dbo].[SB_WARP] 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저의 DBID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_WARP', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'워프존에 대한 classID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_WARP', @level2type=N'COLUMN',@level2name=N'warp_region'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'유저가 소유하고 있는 워프 가능한 지역 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_WARP'
GO
PRINT N'Creating [dbo].[SB_WORLD_TIME_ATTACK_SOLO]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_WORLD_TIME_ATTACK_SOLO](
	[job_type] [int] NOT NULL,
	[talent_type] [int] NOT NULL,
	[dungeon_class_id] [int] NOT NULL,
	[infinite_dungeon_set_name] [nvarchar](64) NOT NULL,
	[dungeon_level_ex] [int] NOT NULL,
	[user_name] [nvarchar](64) NOT NULL,
	[complete_seconds] [int] NOT NULL,
	[update_time] [datetime] NOT NULL,
 CONSTRAINT [PK_SB_WORLD_TIME_ATTACK_SOLO] PRIMARY KEY CLUSTERED 
(
	[job_type] ASC,
	[talent_type] ASC,
	[infinite_dungeon_set_name] ASC,
	[dungeon_class_id] ASC,
	[dungeon_level_ex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
PRINT N'Creating [dbo].[SB_WORLD_TIME_ATTACK_USER_GROUP]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_WORLD_TIME_ATTACK_USER_GROUP](
	[dungeon_class_id] [int] NOT NULL,
	[infinite_dungeon_set_name] [nvarchar](64) NOT NULL,
	[dungeon_level_ex] [int] NOT NULL,
	[user_name] [nvarchar](64) NOT NULL,
	[complete_seconds] [int] NOT NULL,
	[update_time] [datetime] NOT NULL,
 CONSTRAINT [PK_SB_WORLD_TIME_ATTACK_USER_GROUP] PRIMARY KEY CLUSTERED 
(
	[dungeon_class_id] ASC,
	[infinite_dungeon_set_name] ASC,
	[dungeon_level_ex] ASC,
	[user_name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
PRINT N'Creating [dbo].[SB_WORLDFIRST_ACHIEVEMENT]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SB_WORLDFIRST_ACHIEVEMENT](
	[achievement_id] [int] NOT NULL,
	[finished_time] [datetime] NOT NULL,
 CONSTRAINT [PK_FINISHED_WORLDFIRST_ACHIEVEMENT] PRIMARY KEY CLUSTERED 
(
	[achievement_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'완료된 WorldFirst 업적 스크립트 ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_WORLDFIRST_ACHIEVEMENT', @level2type=N'COLUMN',@level2name=N'achievement_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'업적 완료 시각' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_WORLDFIRST_ACHIEVEMENT', @level2type=N'COLUMN',@level2name=N'finished_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'완료된 WorldFirst 업적 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SB_WORLDFIRST_ACHIEVEMENT'
GO
PRINT N'Creating procedure...'
GO
PRINT N'Creating [dbo].[EOS_FindGuild]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EOS_FindGuild]
	@keyword_type INT,
	@keyword NVARCHAR(100),
	@page_no INT,
	@record_per_page INT
AS
BEGIN
	SET NOCOUNT ON
	IF @keyword_type = 0 --Guild Name
	BEGIN
	
	;WITH GuildMemberTbl(guild_id, guild_member_size)
	AS
	(
		SELECT guildID, COUNT(*)
		FROM SB_GUILD_MEMBER (READUNCOMMITTED)
		GROUP BY guildID
	),
	GuildRankTbl(guild_id, guild_rank)
	AS
	(
		SELECT ID, RANK() OVER(ORDER BY war_point DESC)
		FROM SB_GUILD (READUNCOMMITTED)
		WHERE disband_time IS NULL
	),
	SearchListTbl(row_no, guild_id)
	AS
	(
		SELECT ROW_NUMBER() OVER(ORDER BY ID ASC), ID
		FROM SB_GUILD (READUNCOMMITTED) 
		WHERE name LIKE @keyword + '%'
				AND disband_time IS NULL
	),
	TotalSizeTbl(total_record_size, total_page_size)
	AS
	(
		SELECT COUNT(*), (COUNT(*)+@record_per_page-1)/@record_per_page
		FROM SB_GUILD (READUNCOMMITTED) 
		WHERE name LIKE @keyword + '%'
				AND disband_time IS NULL
	)
	SELECT S.row_no row_no, R.guild_rank guild_rank, G.name guild_name, U.name master_name,
			U.job_type master_job_type, M.guild_member_size member_size,
			G.war_point war_point, T.total_record_size total_record_size, T.total_page_size total_page_size
	FROM SB_GUILD G (READUNCOMMITTED)
		 LEFT JOIN SB_USER U (READUNCOMMITTED) ON G.masterDBID = U.ID
		 LEFT JOIN GuildMemberTbl M ON G.ID = M.guild_id
		 LEFT JOIN GuildRankTbl R ON G.ID = R.guild_id 
		 LEFT JOIN SearchListTbl S ON G.ID = S.guild_id,
		 TotalSizeTbl T
	WHERE S.row_no BETWEEN ((@page_no - 1) * @record_per_page)+1 AND @page_no * @record_per_page
	ORDER BY S.row_no ASC
	END
	
	ELSE IF @keyword_type = 1 --Master Character Name
	BEGIN
	
	;WITH GuildMemberTbl(guild_id, guild_member_size)
	AS
	(
		SELECT guildID, COUNT(*)
		FROM SB_GUILD_MEMBER (READUNCOMMITTED)
		GROUP BY guildID
	),
	GuildRankTbl(guild_id, guild_rank)
	AS
	(
		SELECT ID, RANK() OVER(ORDER BY war_point DESC)
		FROM SB_GUILD (READUNCOMMITTED)
		WHERE disband_time IS NULL
	),
	SearchListTbl(row_no, guild_id)
	AS
	(
		SELECT ROW_NUMBER() OVER(ORDER BY G.ID ASC), G.ID
		FROM SB_GUILD G (READUNCOMMITTED)
			 LEFT JOIN SB_USER U (READUNCOMMITTED) ON G.masterDBID = U.ID
		WHERE U.name LIKE @keyword + '%'
			AND G.disband_time IS NULL
	),
	TotalSizeTbl(total_record_size, total_page_size)
	AS
	(
		SELECT COUNT(*), (COUNT(*)+@record_per_page-1)/@record_per_page
		FROM SB_GUILD G (READUNCOMMITTED)
			 LEFT JOIN SB_USER U (READUNCOMMITTED) ON G.masterDBID = U.ID
		WHERE U.name LIKE @keyword + '%'
			AND G.disband_time IS NULL
	)
	SELECT S.row_no row_no, R.guild_rank guild_rank, G.ID guild_id, G.name guild_name, U.name master_name,
			U.job_type master_job_type, M.guild_member_size member_size,
			G.war_point war_point, G.mark guild_mark, T.total_record_size total_record_size, T.total_page_size total_page_size
	FROM SB_GUILD G (READUNCOMMITTED)
		 LEFT JOIN SB_USER U (READUNCOMMITTED) ON G.masterDBID = U.ID
		 LEFT JOIN GuildMemberTbl M ON G.ID = M.guild_id
		 LEFT JOIN GuildRankTbl R ON G.ID = R.guild_id 
		 LEFT JOIN SearchListTbl S ON G.ID = S.guild_id,
		 TotalSizeTbl T
	WHERE S.row_no BETWEEN ((@page_no - 1) * @record_per_page)+1 AND @page_no * @record_per_page
	ORDER BY S.row_no ASC
	END
	
END
GO
PRINT N'Creating [dbo].[EOS_LoadCharacterInfo]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EOS_LoadCharacterInfo]
	@char_id INT
AS
BEGIN

	SET NOCOUNT ON
	
	SELECT U.name, U.job_type, I.lev, G.name guild_name, G.ID guild_id, G.mark guild_mark 
	FROM SB_USER U (READUNCOMMITTED) 
		 LEFT JOIN SB_GUILD_MEMBER M (READUNCOMMITTED) ON U.ID = M.memberDBID
		 LEFT JOIN SB_GUILD G (READUNCOMMITTED) ON guildID = G.ID
		 LEFT JOIN SB_USER_INFO I (READUNCOMMITTED) ON U.ID = I.ID
	WHERE U.ID = @char_id
	
END
GO
PRINT N'Creating [dbo].[EOS_LoadClearDungeon]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EOS_LoadClearDungeon]
	@user_id INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @result_table TABLE
	(
		achievement_id INT
		, dungeon_name NVARCHAR(64)
		, is_clear INT
	)

	INSERT INTO @result_table (achievement_id, dungeon_name, is_clear) values (77, N'숨겨진 동굴(일반)', 0)
	INSERT INTO @result_table (achievement_id, dungeon_name, is_clear) values (78, N'숨겨진 동굴(영웅)', 0)
	INSERT INTO @result_table (achievement_id, dungeon_name, is_clear) values (79, N'돌아오지 않는 숲(일반)', 0)
	INSERT INTO @result_table (achievement_id, dungeon_name, is_clear) values (80, N'돌아오지 않는 숲(영웅)', 0)
	INSERT INTO @result_table (achievement_id, dungeon_name, is_clear) values (81, N'사령술사의 비밀거처(일반)', 0)
	INSERT INTO @result_table (achievement_id, dungeon_name, is_clear) values (82, N'사령술사의 비밀거처(영웅)', 0)
	INSERT INTO @result_table (achievement_id, dungeon_name, is_clear) values (87, N'프로메기간테 은신처(일반)', 0)
	INSERT INTO @result_table (achievement_id, dungeon_name, is_clear) values (88, N'프로메기간테 은신처(영웅)', 0)

	UPDATE @result_table
	SET is_clear = 1
	WHERE achievement_id IN (SELECT achievement_id FROM SB_USER_ACHIEVEMENT (READUNCOMMITTED) WHERE user_id = @user_id)

	SELECT dungeon_name, is_clear
	FROM @result_table
END
GO
PRINT N'Creating [dbo].[EOS_LoadGuildInfo]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EOS_LoadGuildInfo]
	@guild_id INT
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @member_size INT
	SELECT @member_size = COUNT(*) FROM SB_GUILD_MEMBER M (READUNCOMMITTED) WHERE M.guildID = @guild_id
	
	DECLARE @guild_rank INT
	
	SELECT @guild_rank =  rank 
	FROM
	(
		SELECT ID, RANK() OVER(ORDER BY war_point DESC) rank
		FROM SB_GUILD (READUNCOMMITTED)
	) AS T
	WHERE T.ID = @guild_id
	
	SELECT @guild_rank guild_rank, G.name guild_name, 
			U.name master_name, U.job_type master_job_type, @member_size member_size, G.mark, G.war_point war_point
	FROM SB_GUILD G (READUNCOMMITTED)
		 LEFT JOIN SB_USER U (READUNCOMMITTED) ON G.masterDBID = U.ID
	WHERE G.ID = @guild_id
		
END
GO
PRINT N'Creating [dbo].[EOS_LoadGuildMember]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EOS_LoadGuildMember]
	@guild_id INT,
	@page INT,
	@page_size INT,
	@total_record_count INT OUTPUT,
	@total_page_count INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @row_count INT
		, @page_count INT
	SELECT @row_count = COUNT(*) FROM SB_GUILD_MEMBER (READUNCOMMITTED) WHERE guildID = @guild_id
	SELECT @page_count = (@row_count+@page_size-1) / @page_size 

	SET @total_record_count = @row_count
	SET @total_page_count = @page_count

	DECLARE @max_row INT = (((@page - 1) * @page_size) + @page_size)
	SET ROWCOUNT @max_row;
		
	;WITH T_GUILD_MEMBER AS
	(
		SELECT ROW_NUMBER() OVER
			(ORDER BY grade) AS row_num,
			grade, memberDBID
		FROM SB_GUILD_MEMBER (READUNCOMMITTED)
		WHERE guildID = @guild_id
	)
	SELECT /*@row_count, @page_count, */
		g.grade, u.name, u.job_type, ui.lev
	FROM T_GUILD_MEMBER g
		INNER JOIN SB_USER u (READUNCOMMITTED) ON g.memberDBID = u.ID
		INNER JOIN SB_USER_INFO ui (READUNCOMMITTED) ON u.ID = ui.ID
	WHERE row_num BETWEEN ((@page - 1) * @page_size) + 1 AND @page * @page_size
END
GO
PRINT N'Creating [dbo].[EOS_LoadSecondaryMoney]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EOS_LoadSecondaryMoney]
	@char_id INT
AS
BEGIN

	SET NOCOUNT ON
	
	SELECT infinite_hunt_point, guild_warrior_point, arena_point
	FROM SB_USER_SECONDARY_MONEY (READUNCOMMITTED)
	WHERE ID = @char_id
	
END
GO
PRINT N'Creating [dbo].[SB_SaveAchievementFinish]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_SaveAchievementFinish]
	@user_id int,
	@achievement_id int,
	@finished_time int
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO SB_USER_ACHIEVEMENT (user_id, achievement_id, finished_time)
	VALUES (@user_id, @achievement_id, dbo.ConvertToDateTime32(@finished_time))
END
GO
PRINT N'Creating [dbo].[EWM_AddAchievement]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_AddAchievement]
	@user_id int,
	@achieve_id int,
	@finished_time int,
	@goal_list IntIntTable READONLY
AS
BEGIN
	SET NOCOUNT ON;
	
	EXECUTE SB_SaveAchievementFinish @user_id, @achieve_id, @finished_time;
	
	DECLARE @GoalID int;
	DECLARE @Progress int;
	
	MERGE SB_USER_ACHIEVEMENT_PROGRESS WITH (HOLDLOCK) uap
	USING (SELECT @user_id, @achieve_id, first, second
		FROM @goal_list) AS t (user_id, achievement_id, goal_id, progress)
		ON uap.user_id = t.user_id AND uap.achievement_id = t.achievement_id AND uap.goal_id = t.goal_id
	WHEN MATCHED THEN
		UPDATE SET uap.progress = t.progress
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_id, achievement_id, goal_id, progress)
		VALUES (@user_id, @achieve_id, t.goal_id, t.progress);
END
GO
PRINT N'Creating [dbo].[ewm_AddMultipleItemToUser]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ewm_AddMultipleItemToUser]
	@sender_type INT
	, @sender_dbid INT
	, @sender_name NVARCHAR(64)
	, @recipient_dbid INT
	, @recipient_name NVARCHAR(64)
	, @max_receive_count INT
	, @title NVARCHAR(50)
	, @text NVARCHAR(500)
	, @attached_money INT
	, @attached_item_type INT
	, @item_list NewItemList READONLY
	, @random_option_list RandomOptionList READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @UserPostTable UserPostTable;
	
	
	
	-- loop variable
	DECLARE @RowID INT;
	DECLARE @ClassID INT;
	DECLARE @Quantity INT;
	DECLARE @Durability INT;
	DECLARE @ExpirationDate INT;
	DECLARE @SealCount INT;
	DECLARE @Possessed INT;
	DECLARE @Identified INT;
	DECLARE @Grade INT;
	DECLARE @Experience FLOAT;
	-- /loop variable
	
	DECLARE @ItemDBIDList AttachedItem;
	
	-- Iterate ItemList and Insert Item to DB, push id in DBIDLIST
	
	DECLARE itemCursor CURSOR LOCAL FAST_FORWARD
	FOR 
	SELECT [row_id], [class_id], [quantity], [durability], [expiration_date], [possessed], [identified], [seal_count], [grade], [experience]
	FROM @item_list;
	
	OPEN itemCursor;
	
	FETCH NEXT FROM itemCursor INTO @RowID, @ClassID, @Quantity, @Durability, @ExpirationDate, @Possessed, @Identified, @SealCount, @Grade, @Experience;
	
	WHILE @@FETCH_STATUS = 0
	BEGIN 
		DECLARE @ItemDBID BIGINT;
	-- Iteration Content
	
	-- Insert Item, Get and set DBID
		INSERT INTO SB_ITEM (amount, bag_id, class_id, created_date, is_deleted, owner_id, slot_index) VALUES (@Quantity, -4, @ClassID, GETDATE(), 0, @recipient_dbid, 0);
		
		SET @ItemDBID = SCOPE_IDENTITY();
		
		INSERT INTO @ItemDBIDList (item_key, item_amount) VALUES (@ItemDBID, @Quantity);
	
	-- Insert Durability
		IF not (@Durability = -1 and @Identified = 2)
		BEGIN
			INSERT INTO SB_ITEM_EQUIPMENT (ID, durability, estimated, reestimated) VALUES (@ItemDBID, @Durability, @Identified, null);
		END
	
	-- Insert Possession
		IF @Possessed != 2
		BEGIN
			INSERT INTO SB_ITEM_POSSESSION (item_dbid, seal_count, possession_status) VALUES (@ItemDBID, @SealCount, @Possessed);
		END
	
	-- Insert Expiration
	
		IF @ExpirationDate != -1
		BEGIN
			INSERT INTO SB_ITEM_DURATION (item_dbid, expire_date) VALUES (@ItemDBID, dbo.ConvertToDateTime32(@ExpirationDate));
		END
		
	-- Insert Reinforce Info
		IF @Grade != -1
		BEGIN
			INSERT INTO SB_ITEM_REINFORCEMENT (ID, grade, experience) VALUES (@ItemDBID, @Grade, @Experience);
		END
		
	-- Iterate Random Option, Insert RandomOption
	
		-- inner loop variable
		DECLARE @Type tinyint;
		DECLARE @Value INT;
		DECLARE @ItemRowID INT;
		
		DECLARE RandomOptionCursor CURSOR LOCAL FAST_FORWARD
		FOR
		SELECT [type], [value]
		FROM @random_option_list
		WHERE [item_row_id] = @RowID;
		
		OPEN RandomOptionCursor;
		
		FETCH NEXT FROM RandomOptionCursor INTO @Type, @Value;
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
		
		-- inner loop content
		
		-- Insert RandomOption
			INSERT INTO SB_ITEM_RANDOM_ABILITY (ID, ability_type, ability_value) VALUES (@ItemDBID, @Type, @Value);
		
		FETCH NEXT FROM RandomOptionCursor INTO @Type, @Value;
		END
		
		CLOSE RandomOptionCursor;
		DEALLOCATE RandomOptionCursor;
	
	FETCH NEXT FROM itemCursor INTO @RowID, @ClassID, @Quantity, @Durability, @ExpirationDate, @Possessed, @Identified, @SealCount, @Grade, @Experience;
	END
	
	-- END ITERATION
	
	
	--Attach Iteration
	DECLARE @AttachID bigint;
	
	DECLARE @PostID INT; 
	
	DECLARE @AttachAmount INT;
	
	DECLARE @AttachCount INT;
	
	SET @AttachCount = 0;
	
	DECLARE attachCursor CURSOR LOCAL FAST_FORWARD
	FOR 
	SELECT [item_key], [item_amount]
	FROM @ItemDBIDList;
	
	OPEN attachCursor
	
	FETCH NEXT FROM attachCursor INTO @AttachID, @AttachAmount
	
	WHILE @@FETCH_STATUS = 0
	BEGIN 
	
		IF (@AttachCount != 0)
		BEGIN
			SET @attached_money = 0;
		END
	
		IF (@AttachCount % 5 = 0)
		BEGIN
			-- Make Post
			INSERT INTO SB_POST_BOX (sender_type, sender_dbid, sender_name, recipient_dbid, recipient_name, title, text, attached_money, attached_item_type)
			VALUES (@sender_type, @sender_dbid, @sender_name, @recipient_dbid, @recipient_name, @title, @text, @attached_money, @attached_item_type)
		
			SET @PostID = SCOPE_IDENTITY();
			
			INSERT INTO @UserPostTable (user_id, post_id, attached_item_count, money) VALUES (@recipient_dbid, @PostID, 0, @attached_money);
		END
		
		-- Make Attachment
		INSERT INTO SB_POST_ATTACHED_ITEM (post_id, item_key, item_amount) VALUES (@PostID, @AttachID, @AttachAmount);
		
		UPDATE @UserPostTable SET attached_item_count = attached_item_count + 1 WHERE post_id = @PostID;
		
		SET @AttachCount = @AttachCount + 1;
	
	FETCH NEXT FROM attachCursor INTO @AttachID, @AttachAmount
	END
	
	CLOSE attachCursor;
	DEALLOCATE attachCursor;
	
	-- NO ATTACHMENT
	IF (@AttachCount = 0)
	BEGIN
		INSERT INTO SB_POST_BOX (sender_type, sender_dbid, sender_name, recipient_dbid, recipient_name, title, text, attached_money, attached_item_type)
		VALUES (@sender_type, @sender_dbid, @sender_name, @recipient_dbid, @recipient_name, @title, @text, @attached_money, @attached_item_type)
		
		SET @PostID = SCOPE_IDENTITY();
		
		INSERT INTO @UserPostTable (user_id, post_id, attached_item_count, money) VALUES (@recipient_dbid, @PostID, 0, @attached_money);
	END
	
	
	SELECT * FROM @UserPostTable;
	
END
GO
PRINT N'Creating [dbo].[sb_WritePetHistory]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_WritePetHistory]
	@user_id INT,
	@pet_id INT,
	@log_type INT,	
	@minutes_to_expire INT
AS  
BEGIN
	SET NOCOUNT ON;
	
	--@log_type = 1 : REGISTER_PET
	--@log_type = 2 : UNREGISTER_PET
	--@log_type = 3 : EXTEND_PET_EXPIRE
	--@log_type = 11 : EWM_ADD_PET
	--@log_type = 12 : EWM_DELETE_PET
	--@log_type = 13 : EW_MODIFY_PET
	
	INSERT INTO SB_USER_PET_HISTORY
		SELECT @user_id, @pet_id, pet_class_id, pet_name, expire_date, @log_type, GETDATE(), @minutes_to_expire, pet_slot_index
		FROM SB_USER_PET (READUNCOMMITTED)
		WHERE owner_dbid = @user_id AND ID = @pet_id
END
GO
PRINT N'Creating [dbo].[EWM_AddPet]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_AddPet]
	@user_id int,
	@pet_class_id int,
	@pet_name nvarchar(64),
	@expire_date int,
	@bag_class_id int,
	@bag_size int
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @EmptyIndex int;
	SET @EmptyIndex = (select TOP 1 * FROM (
		SELECT pet_slot_index + 1 as pet_slot_index FROM
		SB_USER_PET P (READUNCOMMITTED) WHERE P.owner_dbid = @user_id AND
		NOT EXISTS (SELECT * FROM SB_USER_PET P2 (READUNCOMMITTED) WHERE P2.owner_dbid = @user_id AND P2.pet_slot_index = P.pet_slot_index + 1)
		UNION
		SELECT 0 as pet_slot_index
		WHERE
		NOT EXISTS (SELECT * FROM SB_USER_PET P2 (READUNCOMMITTED) WHERE P2.owner_dbid = @user_id AND P2.pet_slot_index = 0)
	) result
	ORDER BY result.pet_slot_index ASC);
	
	DECLARE @BagCount int;
	SET @BagCount = (select COUNT(*) FROM
	SB_ITEM_BAG (READUNCOMMITTED) WHERE owner_dbid = @user_id AND bag_type = 3 AND slot_index = @EmptyIndex);
		
	IF(@BagCount = 0)
	BEGIN
		INSERT INTO SB_USER_PET (owner_dbid, pet_class_id, pet_slot_index, pet_name, expire_date)
		VALUES (@user_id, @pet_class_id, @EmptyIndex, @pet_name, dbo.ConvertToDateTime32(@expire_date));
			
		DECLARE @pet_id INT = SCOPE_IDENTITY()
				, @minutes_to_expire INT = DATEDIFF(MINUTE, GETDATE(), dbo.ConvertToDateTime32(@expire_date))
		IF @@ROWCOUNT > 0
			EXEC sb_WritePetHistory @user_id, @pet_id, 11, @minutes_to_expire
		
		IF @bag_size != 0
		BEGIN
			INSERT INTO SB_ITEM_BAG (owner_dbid, bag_type, slot_index, source_item_class_id, max_slot_count)
			VALUES (@user_id, 3, @EmptyIndex, @bag_class_id, @bag_size);
		END
	END
	ELSE
	BEGIN
		RAISERROR('Bag and Pet Slot Index Mismatch', 0, 0);
	END
END
GO
PRINT N'Creating [dbo].[sb_WriteVehicleHistory]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_WriteVehicleHistory]
	@user_dbid INT,
	@vehicle_dbid INT,
	@log_type INT,	
	@minutes_to_expire INT
AS  
BEGIN
	SET NOCOUNT ON;
	
	--@log_type = 1 : REGISTER_VEHICLE
	--@log_type = 2 : UNREGISTER_VEHICLE
	--@log_type = 11 : EWM_ADD_VEHICLE
	--@log_type = 12 : EWM_DELETE_VEHICLE
	--@log_type = 13 : EW_MODIFY_VEHICLE
	
	INSERT INTO SB_USER_VEHICLE_HISTORY
		SELECT @user_dbid, @vehicle_dbid, vehicle_class_id, expire_date, @log_type, GETDATE(), @minutes_to_expire, vehicle_slot_index
		FROM SB_USER_VEHICLE (READUNCOMMITTED)
		WHERE owner_dbid = @user_dbid AND ID = @vehicle_dbid
END
GO
PRINT N'Creating [dbo].[EWM_AddVehicle]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_AddVehicle]
	@user_id int,
	@vehicle_class_id int,
	@expire_date int
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @EmptyIndex int;
	SET @EmptyIndex = (select TOP 1 * FROM (
		SELECT vehicle_slot_index + 1 as vehicle_slot_index FROM
		SB_USER_VEHICLE P (READUNCOMMITTED) WHERE P.owner_dbid = @user_id AND
		NOT EXISTS (SELECT * FROM SB_USER_VEHICLE P2 (READUNCOMMITTED) WHERE P2.owner_dbid = @user_id AND P2.vehicle_slot_index = P.vehicle_slot_index + 1)
		UNION
		SELECT 0 as vehicle_slot_index
		WHERE
		NOT EXISTS (SELECT * FROM SB_USER_VEHICLE P2 (READUNCOMMITTED) WHERE P2.owner_dbid = @user_id AND P2.vehicle_slot_index = 0)
	) result
	ORDER BY result.vehicle_slot_index ASC);

	IF @expire_date > 0
		INSERT INTO SB_USER_VEHICLE (owner_dbid, vehicle_class_id, vehicle_slot_index, expire_date)
		VALUES (@user_id, @vehicle_class_id, @EmptyIndex, dbo.ConvertToDateTime32(@expire_date));
	ELSE
		INSERT INTO SB_USER_VEHICLE (owner_dbid, vehicle_class_id, vehicle_slot_index, expire_date)
		VALUES (@user_id, @vehicle_class_id, @EmptyIndex, null);
		
	DECLARE @vehicle_id INT = SCOPE_IDENTITY()
			, @minutes_to_expire INT = DATEDIFF(MINUTE, GETDATE(), dbo.ConvertToDateTime32(@expire_date))
	IF @@ROWCOUNT > 0
		EXEC sb_WriteVehicleHistory @user_id, @vehicle_id, 11, @minutes_to_expire
	
END
GO
PRINT N'Creating [dbo].[ewm_ChangeCharName]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ewm_ChangeCharName]  
	@user_id INT
	, @name nvarchar(64)
AS  
BEGIN  
	SET NOCOUNT ON  
	
	DECLARE @before_name nvarchar(64);
	
	SET @before_name = (SELECT name FROM SB_USER (READUNCOMMITTED) WHERE ID = @user_id);
	
	IF (@before_name IS NULL) OR (SELECT COUNT(*) FROM SB_USER (READUNCOMMITTED) WHERE name = @name) > 0
	BEGIN
		SELECT -1;
	END
	ELSE
	BEGIN
		UPDATE SB_USER SET name = @name WHERE ID = @user_id;
	
		INSERT INTO SB_USER_NAME_HISTORY (user_id, before_name, after_name) VALUES (@user_id, @before_name, @name);
		
		SELECT 1;
	END
END
GO
PRINT N'Creating [dbo].[EWM_ClearCharChatReportedCount]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_ClearCharChatReportedCount]
	@ID int,
	@type int
AS
BEGIN
	SET NOCOUNT ON;
	
	IF @type = 0
	BEGIN
		UPDATE [dbo].[SB_USER_CHAT_REPORT] 
			SET [reported_count_normal] = 0 
		WHERE [user_dbid] = @ID;
	END
	ELSE IF @type = 1
	BEGIN
		UPDATE [dbo].[SB_USER_CHAT_REPORT] 
			SET [reported_count_guild] = 0 
		WHERE [user_dbid] = @ID;
	END
END
GO
PRINT N'Creating [dbo].[EWM_DeletePet]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_DeletePet]
	@pet_id INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @SlotIndex INT
			, @OwnerDBID INT
			, @BagID INT
	
	SELECT @SlotIndex = pet_slot_index, @OwnerDBID = owner_dbid FROM SB_USER_PET (READUNCOMMITTED) WHERE ID = @pet_id
	SELECT @BagID = ID FROM SB_ITEM_BAG (READUNCOMMITTED) WHERE slot_index = @SlotIndex AND bag_type = 3 AND owner_dbid = @OwnerDBID
	
	UPDATE SB_ITEM SET bag_id = -8 WHERE owner_id = @OwnerDBID AND bag_id = @BagID AND is_deleted = 0;
	
	EXEC sb_WritePetHistory @OwnerDBID, @pet_id, 12, 0

	DELETE FROM SB_ITEM_BAG
	WHERE slot_index = @SlotIndex
		AND owner_dbid = @OwnerDBID
		AND bag_type = 3;

	DELETE FROM SB_USER_PET
	WHERE ID = @pet_id;
END
GO
PRINT N'Creating [dbo].[EWM_DeletePost]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_DeletePost]
	@post_id_list IntTable READONLY
AS
BEGIN
	SET NOCOUNT ON
	
	UPDATE SB_POST_BOX SET delete_time = GETDATE() WHERE ID IN (SELECT ID FROM @post_id_list)
		
	SELECT @@ROWCOUNT
END
GO
PRINT N'Creating [dbo].[EWM_DeleteUserTitle]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_DeleteUserTitle]
	@userID INT,
	@titleID INT

AS
BEGIN
	
	SET NOCOUNT ON;
	
	UPDATE SB_USER SET title_id = -1 WHERE ID = @userID;
	
	DELETE FROM SB_USER_TITLE WHERE user_id = @userID and title_id = @titleID;

	
END
GO
PRINT N'Creating [dbo].[EWM_DeleteVehicle]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_DeleteVehicle]
	@vehicle_id INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @OwnerDBID INT
	
	SELECT @OwnerDBID = owner_dbid FROM SB_USER_VEHICLE (READUNCOMMITTED) WHERE ID = @vehicle_id
	
	EXEC sb_WriteVehicleHistory @OwnerDBID, @vehicle_id, 12, 0

	DELETE FROM SB_USER_VEHICLE
	WHERE ID = @vehicle_id;
END
GO
PRINT N'Creating [dbo].[ewm_EditItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ewm_EditItem]
	@dbID bigint,
	@quantity int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    UPDATE SB_ITEM SET amount = @quantity WHERE ID = @dbID;
END
GO
PRINT N'Creating [dbo].[EWM_EscapeUser]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_EscapeUser]
	@charID int
AS
BEGIN

	UPDATE SB_USER_POS
	SET
	x = V.x,
	y = V.y,
	z = V.z,
	area_id = V.area_id,
	region_id = V.region_id,
	resource_id = V.resource_id,
	grid_x = V.grid_x,
	grid_y = V.grid_y,
	grid_z = V.grid_z,
	reserved = V.reserved,
	yaw = V.yaw
	FROM
	SB_USER_POS T (READUNCOMMITTED)
	INNER JOIN 
	SB_USER_POS_VALID V (READUNCOMMITTED) 
	ON (T.ID = V.user_id)
	WHERE T.ID = @charID
	
END
GO
PRINT N'Creating [dbo].[EWM_ExpireCurrencyTrustSale]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_ExpireCurrencyTrustSale]
	@tsc_id int
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE SB_TRUST_SALE_CURRENCY SET expire_date = GETDATE() WHERE tsc_dbid = @tsc_id
	
END
GO
PRINT N'Creating [dbo].[ewm_ExpireTrustSale]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ewm_ExpireTrustSale]
	@ts_id_list IntTable READONLY
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE SB_TRUST_SALE SET expire_date = registered_date WHERE ts_id IN (SELECT ID FROM @ts_id_list);
END
GO
PRINT N'Creating [dbo].[EWM_FindAccountIDByCharID]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindAccountIDByCharID]
	@ID BIGINT
AS
BEGIN

	SELECT account_id ID 
	FROM SB_USER (READUNCOMMITTED) 
	WHERE ID = @ID
	
END
GO
PRINT N'Creating [dbo].[EWM_FindAccountIDByCharName]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindAccountIDByCharName]
	@Name NVARCHAR(50)
AS
BEGIN

	SELECT account_id ID 
	FROM SB_USER (READUNCOMMITTED) 
	WHERE name = @Name
	
END
GO
PRINT N'Creating [dbo].[EWM_FindAccountIDByContainName]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindAccountIDByContainName]
	@accountName NVARCHAR(50)
AS
BEGIN

	SELECT name, ID
	FROM SB_ACCOUNT (READUNCOMMITTED) 
	WHERE name LIKE '%' + @accountName + '%'
	
END
GO
PRINT N'Creating [dbo].[EWM_FindAccountIDByName]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindAccountIDByName]
	@accountName NVARCHAR(50)
AS
BEGIN

	SELECT ID 
	FROM SB_ACCOUNT (READUNCOMMITTED) 
	WHERE name = @accountName
	
END
GO
PRINT N'Creating [dbo].[EWM_FindAccountName]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindAccountName]
	@ID BIGINT
AS
BEGIN

	SELECT name, ID
	FROM SB_ACCOUNT (READUNCOMMITTED) 
	WHERE ID = @ID
	
END


SET ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[EWM_FindAttachedItemClassIDBased]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindAttachedItemClassIDBased]
	@postID INT
AS
BEGIN
	
	SELECT item_key AS class_id, * 
	FROM SB_POST_ATTACHED_ITEM (READUNCOMMITTED) 
	WHERE post_id = @postID
	
END
GO
PRINT N'Creating [dbo].[EWM_FindAttachedItemDBIDBased]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindAttachedItemDBIDBased]
	@postID INT
AS
BEGIN

	SELECT item_key AS item_id, class_id, amount AS item_amount, post_id 
	FROM SB_POST_ATTACHED_ITEM T1 (READUNCOMMITTED)
		 LEFT JOIN SB_ITEM T2 (READUNCOMMITTED) ON T1.item_key = T2.ID 
	WHERE T1.post_id = @postID
	
END
GO
PRINT N'Creating [dbo].[EWM_FindBookmark]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindBookmark]
	@name NVARCHAR(100)
AS
BEGIN

	SELECT [name]
      ,[area_id]
      ,[region_id]
      ,[resource_id]
      ,[grid_x]
      ,[grid_y]
      ,[grid_z]
      ,[reserved]
      ,[x]
      ,[y]
      ,[z]
	FROM [SB_TELEPORT_POINT] (READUNCOMMITTED)
	WHERE name = @name
	
END
GO
PRINT N'Creating [dbo].[EWM_FindCharByAccountID]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindCharByAccountID]
	@AccountID BIGINT,
	@final_deleted NVARCHAR
AS
BEGIN

	SELECT  A.name ACCOUNT_NAME, A.ID ACCOUNT_ID,
	U.ID, U.account_id, U.job_type, U.name, U.created_time, U.deleted_time,
	I.lev, I.exp, I.money, I.logInTime, I.logOutTime, 
	P.area_id, P.region_id
	FROM 
		SB_USER U (READUNCOMMITTED)
		LEFT JOIN SB_ACCOUNT A (READUNCOMMITTED) ON U.account_id = A.ID
		LEFT JOIN SB_USER_INFO I (READUNCOMMITTED) ON U.ID = I.ID
		LEFT JOIN SB_USER_POS P (READUNCOMMITTED) ON U.ID = P.ID
	WHERE 
	A.ID = @AccountID AND U.final_deleted = @final_deleted

END
GO
PRINT N'Creating [dbo].[EWM_FindCharByAccountName]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindCharByAccountName]
	@AccountName NVARCHAR(100),
	@final_deleted NVARCHAR
AS
BEGIN

	SELECT  A.name ACCOUNT_NAME, A.ID ACCOUNT_ID,
	U.ID, U.account_id, U.job_type, U.name, U.created_time, U.deleted_time,
	I.lev, I.exp, I.money, I.logInTime, I.logOutTime, 
	P.area_id, P.region_id
	FROM 
		SB_USER U (READUNCOMMITTED)
		LEFT JOIN SB_ACCOUNT A (READUNCOMMITTED) ON U.account_id = A.ID
		LEFT JOIN SB_USER_INFO I (READUNCOMMITTED) ON U.ID = I.ID
		LEFT JOIN SB_USER_POS P (READUNCOMMITTED) ON U.ID = P.ID
	WHERE 
	A.name = @AccountName AND U.final_deleted = @final_deleted

END
GO
PRINT N'Creating [dbo].[EWM_FindCharByIncludingName]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindCharByIncludingName]
	@CharName NVARCHAR(100)
AS
BEGIN

	SELECT U.name, U.ID, a.name ACCOUNT_NAME
	FROM SB_USER U (READUNCOMMITTED)
		 INNER JOIN SB_ACCOUNT A (READUNCOMMITTED) ON U.account_id = A.ID 
	WHERE U.name LIKE @CharName + '%'

END
GO
PRINT N'Creating [dbo].[EWM_FindCharByIncludingNamePaged]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindCharByIncludingNamePaged]
	@CharName NVARCHAR(100),
	@Page INT,
	@PageSize INT
AS
BEGIN

	DECLARE @maxRow INT = @Page * @PageSize;
	SET ROWCOUNT @maxRow;

	WITH charTbl AS
	(
	SELECT ROW_NUMBER() OVER (ORDER BY U.name ASC) AS rowNum, COUNT(*) OVER () AS 'total_count', U.name, U.ID, a.name ACCOUNT_NAME
	FROM SB_USER U (READUNCOMMITTED)
		 INNER JOIN SB_ACCOUNT A (READUNCOMMITTED) ON U.account_id = A.ID 
	WHERE U.name LIKE @CharName + '%'
	)
	
	SELECT *
	FROM charTbl
	WHERE rowNum BETWEEN ((@Page - 1) * @PageSize) + 1 AND @Page * @PageSize;
	
	SET ROWCOUNT 0;
END
GO
PRINT N'Creating [dbo].[EWM_FindCharByName]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindCharByName]
	@CharName NVARCHAR(100)
AS
BEGIN

	SELECT U.ID, A.name ACCOUNT_NAME, U.account_id, U.job_type, U.name, I.lev, U.created_time, I.exp, I.money
	FROM SB_USER U (READUNCOMMITTED)
		 LEFT JOIN SB_ACCOUNT A (READUNCOMMITTED) ON U.account_id = A.ID 
		 LEFT JOIN SB_USER_INFO I (READUNCOMMITTED) ON U.ID = I.ID
	WHERE U.name = @CharName
	
END
GO
PRINT N'Creating [dbo].[EWM_FindCharIDByAccountID]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindCharIDByAccountID]
	@AccountID BIGINT
AS
BEGIN

	SELECT ID 
	FROM SB_USER (READUNCOMMITTED) 
	WHERE account_id IN (SELECT ID FROM SB_ACCOUNT (READUNCOMMITTED) WHERE ID = @AccountID)
	
END
GO
PRINT N'Creating [dbo].[EWM_FindCharIDByAccountName]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindCharIDByAccountName]
	@AccountName NVARCHAR(100)
AS
BEGIN

	SELECT ID 
	FROM SB_USER (READUNCOMMITTED) 
	WHERE account_id IN (SELECT ID FROM SB_ACCOUNT (READUNCOMMITTED) WHERE name = @AccountName)
	
END
GO
PRINT N'Creating [dbo].[EWM_FindCharIDByName]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindCharIDByName]
	@CharName NVARCHAR(100)
AS
BEGIN

	SELECT ID 
	FROM SB_USER (READUNCOMMITTED) 
	WHERE name = @CharName
	
END
GO
PRINT N'Creating [dbo].[EWM_FindExpiredAttachmentByClassID]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindExpiredAttachmentByClassID]
	@postID INT
AS
BEGIN
	
	SELECT item_key AS class_id, * 
	FROM SB_POST_ATTACHED_ITEM_EXPIRED (READUNCOMMITTED) 
	WHERE post_id = @postID
	
END
GO
PRINT N'Creating [dbo].[EWM_FindExpiredAttachmentByDBID]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindExpiredAttachmentByDBID]
	@postID INT
AS
BEGIN

	SELECT item_key AS item_id, class_id, amount AS item_amount, post_id 
	FROM SB_POST_ATTACHED_ITEM_EXPIRED T1 (READUNCOMMITTED)
		 LEFT JOIN SB_ITEM T2 (READUNCOMMITTED) ON T1.item_key = T2.ID 
	WHERE T1.post_id = @postID
	
END
GO
PRINT N'Creating [dbo].[EWM_FindGuildByIDAlignByID]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindGuildByIDAlignByID]
	@ID INT
AS
BEGIN

	SELECT G.ID, G.name, G.level, COUNT(*) member_no 
	FROM SB_GUILD G (READUNCOMMITTED) 
		 LEFT JOIN SB_GUILD_MEMBER M (READUNCOMMITTED) ON G.ID = M.guildID
	WHERE G.ID = @ID
	GROUP BY G.ID, G.name, G.level
	ORDER BY G.ID
	
END
GO
PRINT N'Creating [dbo].[EWM_FindGuildByIDAlignByLevel]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindGuildByIDAlignByLevel]
	@ID INT
AS
BEGIN

	SELECT G.ID, G.name, G.level, COUNT(*) member_no 
	FROM SB_GUILD G (READUNCOMMITTED) 
		 LEFT JOIN SB_GUILD_MEMBER M (READUNCOMMITTED) ON G.ID = M.guildID
	WHERE G.ID = @ID
	GROUP BY G.ID, G.name, G.level
	ORDER BY G.level

END
GO
PRINT N'Creating [dbo].[EWM_FindGuildByIDAlignByName]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindGuildByIDAlignByName]
	@ID INT
AS
BEGIN

	SELECT G.ID, G.name, G.level, COUNT(*) member_no 
	FROM SB_GUILD G (READUNCOMMITTED) 
		 LEFT JOIN SB_GUILD_MEMBER M (READUNCOMMITTED) ON G.ID = M.guildID
	WHERE G.ID = @ID
	GROUP BY G.ID, G.name, G.level
	ORDER BY G.name
	
END
GO
PRINT N'Creating [dbo].[EWM_FindGuildByIDAlignByNumOfMember]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindGuildByIDAlignByNumOfMember]
	@ID INT
AS
BEGIN


	SELECT G.ID, G.name, G.level, COUNT(*) member_no 
	FROM SB_GUILD G (READUNCOMMITTED) 
		 LEFT JOIN SB_GUILD_MEMBER M (READUNCOMMITTED) ON G.ID = M.guildID
	WHERE G.ID = @ID
	GROUP BY G.ID, G.name, G.level
	ORDER BY member_no

END
GO
PRINT N'Creating [dbo].[EWM_FindPost]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindPost]
	@postID INT
AS
BEGIN

	SELECT * 
	FROM SB_POST_BOX (READUNCOMMITTED) 
	WHERE ID = @postID
	
END
GO
PRINT N'Creating [dbo].[EWM_FindPostExpired]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindPostExpired]
	@postID INT
AS
BEGIN

	SELECT * 
	FROM SB_POST_BOX_EXPIRED (READUNCOMMITTED) 
	WHERE ID = @postID
	
END
GO
PRINT N'Creating [dbo].[EWM_FindTrustSaleAccountItemList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindTrustSaleAccountItemList]

	@CharTable IntTable READONLY,
	@BeginDate DATETIME,
	@EndDate DATETIME
	
AS
BEGIN

	SELECT * FROM
	(
	SELECT T1.*, T2.[name] AS [userName], T3.[name] AS [accountName], 0 isOld
	FROM SB_TRUST_SALE (READUNCOMMITTED) AS T1
		 INNER JOIN SB_USER (READUNCOMMITTED) AS T2 ON(T1.[user_id] = T2.[ID])
         INNER JOIN SB_ACCOUNT (READUNCOMMITTED) AS T3 ON(T2.account_id = T3.[ID])
    UNION ALL
    SELECT T1.*, T2.[name] AS [userName], T3.[name] AS [accountName], 1 isOld
	FROM SB_TRUST_SALE_OLD (READUNCOMMITTED) AS T1
		 INNER JOIN SB_USER (READUNCOMMITTED) AS T2 ON(T1.[user_id] = T2.[ID])
         INNER JOIN SB_ACCOUNT (READUNCOMMITTED) AS T3 ON(T2.account_id = T3.[ID])
    ) T
	WHERE [user_id] IN (SELECT ID FROM @CharTable)
	AND registered_date BETWEEN @BeginDate AND @EndDate
	ORDER BY ts_id DESC

END
GO
PRINT N'Creating [dbo].[EWM_FindUserNameChange]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_FindUserNameChange]

	@name nvarchar(64)
	
AS
BEGIN

	SELECT U.ID, U.name, H.before_name, H.after_name, H.created_time 
	FROM SB_USER_NAME_HISTORY H (READUNCOMMITTED) 
		 LEFT JOIN SB_USER U (READUNCOMMITTED) ON (H.user_id = u.ID) 
	WHERE before_name = @name or after_name = @name 
	ORDER BY H.created_time DESC

END
GO
PRINT N'Creating [dbo].[EWM_GetBanListTotalCount]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_GetBanListTotalCount]

	@user_id INT

AS
BEGIN

	SELECT COUNT(*) AS TCount 
	FROM SB_BAN (READUNCOMMITTED) 
	WHERE user_id = @user_id

END
GO
PRINT N'Creating [dbo].[EWM_GetBuddyListTotalCount]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_GetBuddyListTotalCount]

	@user_id INT
	
AS
BEGIN

	SELECT COUNT(*) AS TCount 
	FROM SB_BUDDY (READUNCOMMITTED) 
	WHERE user_id = @user_id

END
GO
PRINT N'Creating [dbo].[EWM_GetPostInBoxTotalCount]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_GetPostInBoxTotalCount]

	@user_id INT

AS
BEGIN

	SELECT COUNT(*) AS TCount 
	FROM [dbo].[SB_POST_BOX] (READUNCOMMITTED) 
	WHERE recipient_dbid = @user_id

END
GO
PRINT N'Creating [dbo].[EWM_GetPostSentTotalCount]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_GetPostSentTotalCount]

	@user_id INT

AS
BEGIN

	SELECT COUNT(*) AS TCount 
	FROM [dbo].[SB_POST_BOX] (READUNCOMMITTED) 
	WHERE sender_dbid = @user_id

END
GO
PRINT N'Creating [dbo].[EWM_HasQuest]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_HasQuest]
	@user_id int,
	@quest_id int
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @temp INT = 0
	DECLARE @result INT = 0 -- not exists
	
	SELECT @temp=user_id FROM SB_USER_QUEST (READUNCOMMITTED)
	WHERE user_id = @user_id AND quest_id = @quest_id
	
	IF(@@ROWCOUNT > 0)
	BEGIN
		SET @result = 1
	END
	
	SELECT @result
END
GO
PRINT N'Creating [dbo].[EWM_InitDailyQuest]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[EWM_InitDailyQuest]

	@CharID int,
	@QuestIDTable IntTable READONLY

AS
BEGIN

	DELETE FROM SB_USER_QUEST
	WHERE user_id = @CharID AND quest_id IN (SELECT ID FROM @QuestIDTable);
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadAccountWarehouseItemList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadAccountWarehouseItemList]  
	@account_id BIGINT
AS  
BEGIN  
	SET NOCOUNT ON  
	
	SELECT ID, class_id, amount, created_date, updated_date, I.slot_index
	FROM SB_ITEM_ACCOUNT AS I (READUNCOMMITTED)  
		LEFT JOIN SB_ITEM AS T (READUNCOMMITTED) ON (I.item_id = T.ID)
	WHERE (I.account_id = @account_id)
	ORDER BY slot_index
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadAnnounce]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadAnnounce]
	
AS
BEGIN

	SELECT ID, type, cycle, msg 
	FROM SB_ANNOUNCE (READUNCOMMITTED) 
	WHERE cycle = 0

END
GO
PRINT N'Creating [dbo].[EWM_LoadArenaTeam]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadArenaTeam]

	@CharID int

AS
BEGIN

	SELECT team_dbid, team_name, team_type, master_dbid, deleted, U.name master_name 
	FROM 
	SB_ARENA_TEAM A (READUNCOMMITTED) 
	LEFT JOIN SB_USER U (READUNCOMMITTED) ON A.master_dbid = U.ID
	WHERE team_dbid IN
	(SELECT team_dbid FROM SB_ARENA_TEAM_MEMBER (READUNCOMMITTED)
	WHERE member_dbid = @CharID)
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadArenaTeamInfo]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadArenaTeamInfo]

	@TeamID int

AS
BEGIN

	SELECT team_dbid, team_name, team_type, master_dbid, deleted, U.name master_name 
	FROM 
	SB_ARENA_TEAM A (READUNCOMMITTED) 
	LEFT JOIN SB_USER U (READUNCOMMITTED) ON A.master_dbid = U.ID
	WHERE team_dbid = @TeamID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadArenaTeamMember]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadArenaTeamMember]
	@TeamID int
AS
BEGIN
	SELECT team_dbid, member_dbid, U.name member_name, ISNULL(unpayed_award, 0) unpayed_award
	FROM SB_ARENA_TEAM_MEMBER M (READUNCOMMITTED) 
		LEFT JOIN SB_ARENA_TEAM_AWARD A (READUNCOMMITTED)ON M.member_dbid = A.user_dbid
		LEFT JOIN SB_USER U (READUNCOMMITTED) ON M.member_dbid = U.ID
	WHERE team_dbid = @TeamID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadArenaTeamMemberRecordSeason]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadArenaTeamMemberRecordSeason]

	@TeamID int,
	@CharID int

AS
BEGIN

	SELECT *
	FROM 
	SB_ARENA_TEAM_MEMBER_RECORD_SEASON
	WHERE team_dbid = @TeamID AND member_dbid = @CharID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadArenaTeamMemberRecordWeek]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadArenaTeamMemberRecordWeek]

	@TeamID int,
	@CharID int

AS
BEGIN

	SELECT *
	FROM 
	SB_ARENA_TEAM_MEMBER_RECORD_WEEK
	WHERE team_dbid = @TeamID AND member_dbid = @CharID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadArenaTeamRecordSeason]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadArenaTeamRecordSeason]

	@TeamID int

AS
BEGIN

	SELECT *
	FROM 
	SB_ARENA_TEAM_RECORD_SEASON
	WHERE team_dbid = @TeamID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadArenaTeamRecordWeek]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadArenaTeamRecordWeek]

	@TeamID int

AS
BEGIN

	SELECT *
	FROM 
	SB_ARENA_TEAM_RECORD_WEEK
	WHERE team_dbid = @TeamID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadBagItemList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadBagItemList]  
	@OwnerID INT,
	@BagID INT,
	@IsDeleted BIT
AS  
BEGIN  
	SET NOCOUNT ON  
	
	SELECT I.ID, bag_id, class_id, amount, slot_index, created_date, estimated, possession_status
	FROM SB_ITEM AS I (READUNCOMMITTED)  
		 LEFT JOIN SB_ITEM_EQUIPMENT AS E (READUNCOMMITTED) ON (I.ID = E.ID)
		 LEFT JOIN SB_ITEM_POSSESSION AS P (READUNCOMMITTED) ON (I.ID = P.item_dbid)
	WHERE I.is_deleted = @IsDeleted AND
		 (bag_id = @BagID) AND (owner_id = @OwnerID)
	ORDER BY bag_id, slot_index
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadBagListType]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadBagListType]  
	@UserID INT,
	@Type INT
AS  
BEGIN  
	SET NOCOUNT ON  
	
	SELECT *
	FROM [SB_ITEM_BAG] B (READUNCOMMITTED)
	WHERE B.owner_dbid = @UserID and B.bag_type = @Type
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadBanListPaged]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadBanListPaged]
	@user_id int,
	@page int,
	@pageSize int
AS
BEGIN


	WITH searchBuddyListTBL AS
	(
		SELECT Row_Number() OVER (ORDER BY P1.CharID desc) AS rowNum,
			P1.*
		FROM
		(
			SELECT A.ID AS AccountID, A.name AS AccountName, U.ID AS CharID, U.name AS CharName, U.job_type Job, I.lev Level, B.created_time
			FROM SB_USER U (READUNCOMMITTED)
				 LEFT JOIN SB_ACCOUNT A (READUNCOMMITTED) ON U.account_id = A.ID
				 LEFT JOIN SB_BAN B (READUNCOMMITTED) ON U.ID = B.ban_id
				 LEFT JOIN SB_USER_INFO I (READUNCOMMITTED) ON U.ID = I.ID
			WHERE B.user_id = @user_id
  		) P1
	)

	SELECT AccountID, AccountName, CharID, CharName, Job, Level, created_time
	FROM searchBuddyListTBL
	WHERE rowNum BETWEEN ((@page - 1) * @pageSize) + 1 and @page * @pageSize

END
GO
PRINT N'Creating [dbo].[EWM_LoadBindDungeonList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadBindDungeonList]

	@CharID int
	
AS
BEGIN


	SELECT user_db_id, dungeon_class_id, expired_time, checkpoint_seq_no
	FROM SB_USER_BOUND_DUNGEON (READUNCOMMITTED)
	WHERE expired_time > GETDATE()
		  AND user_db_id = @CharID


END
GO
PRINT N'Creating [dbo].[EWM_LoadBindInitList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadBindInitList]

	@CharID INT

AS
BEGIN

	SELECT * 
	FROM SB_USER_DUNGEON_BIND_INIT (READUNCOMMITTED) 
	WHERE user_db_id = @CharID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadBookmark]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadBookmark]

AS
BEGIN

	SELECT [name]
	FROM [SB_TELEPORT_POINT] (READUNCOMMITTED)

END
GO
PRINT N'Creating [dbo].[EWM_LoadBuddyListPaged]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadBuddyListPaged]

	@user_id int,
	@page int,
	@pageSize int

AS
BEGIN


	WITH searchBuddyListTBL AS
	(
		SELECT Row_Number() OVER (ORDER BY P1.CharID desc) AS rowNum,
			P1.*
		FROM
		(
			SELECT A.ID AS AccountID, A.name AS AccountName, U.ID AS CharID, U.name AS CharName, U.job_type Job, I.lev Level, B.created_time
			FROM SB_USER U (READUNCOMMITTED)
				 LEFT JOIN SB_ACCOUNT A (READUNCOMMITTED) ON U.account_id = A.ID
				 LEFT JOIN SB_BUDDY B (READUNCOMMITTED) ON U.ID = B.buddy_id
				 LEFT JOIN SB_USER_INFO I (READUNCOMMITTED) ON U.ID = I.ID
			WHERE B.user_id = @user_id
  		) P1
	)

	SELECT AccountID, AccountName, CharID, CharName, Job, Level, created_time
	FROM searchBuddyListTBL
	WHERE rowNum BETWEEN ((@page - 1) * @pageSize) + 1 and @page * @pageSize
	
END


/****** Object:  StoredProcedure [dbo].[EWM_LoadBanListPaged]    Script Date: 09/02/2013 14:54:54 ******/
SET ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[EWM_LoadBuff]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadBuff]

	@CharID Int

AS
BEGIN

	SELECT *
	FROM SB_USER_BUFF (READUNCOMMITTED) 
	WHERE user_id = @CharID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadBuilderCharacterList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadBuilderCharacterList]

AS
BEGIN
	SELECT U.ID, U.name, I.builder_lev
	FROM SB_USER U (READUNCOMMITTED)
		 LEFT JOIN SB_USER_INFO I (READUNCOMMITTED) ON U.ID = I.ID	
	WHERE I.builder_lev > 0
END
GO
PRINT N'Creating [dbo].[EWM_LoadCash]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadCash]

	@BeginDate DATETIME,
	@EndDate DATETIME
	
AS
BEGIN

	SELECT DATEADD(DAY, DATEDIFF(DAY, 0, [order_date]), 0) AS [Date], SUM(amount * price) Cash, rack_id RackID
	FROM SB_SHOP_ORDER_HISTORY (READUNCOMMITTED) 
	WHERE order_date BETWEEN @BeginDate AND DATEADD(DAY, 1, @EndDate) 
	GROUP BY DATEADD(DAY, DATEDIFF(DAY, 0, [order_date]), 0), rack_id
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadCashOrder]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadCashOrder]

	@BeginDate DATETIME,
	@EndDate DATETIME
	
AS
BEGIN

	SELECT DATEADD(DAY, DATEDIFF(DAY, 0, [order_date]), 0) AS reg_date, rack_id, product_id, SUM(amount) AS amount
	FROM SB_SHOP_ORDER_HISTORY (READUNCOMMITTED) 
	WHERE order_date BETWEEN @BeginDate AND DATEADD(DAY, 1, @EndDate) 
	GROUP BY DATEADD(DAY, DATEDIFF(DAY, 0, [order_date]), 0), rack_id, product_id
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadCashProduct]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadCashProduct]

	@BeginDate DATETIME,
	@EndDate DATETIME
	
AS
BEGIN

	SELECT rack_id, product_id, SUM(amount) AS amount
	FROM SB_SHOP_ORDER_HISTORY (READUNCOMMITTED) 
	WHERE order_date BETWEEN @BeginDate AND DATEADD(DAY, 1, @EndDate) 
	GROUP BY rack_id, product_id
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadChar]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadChar]

	@CharID int

AS
BEGIN

	SELECT
	A.name account_name, 
	U.account_id, U.job_type, U.name, U.ID, U.created_time, U.deleted_time, U.final_deleted, U.title_id,
	ISNULL(P.area_id, 0) area_id, ISNULL(P.region_id, 0) region_id, P.resource_id, P.grid_x, P.grid_y, P.grid_z, P.reserved, P.x PosX, P.y PosY, P.Z PosZ,
	I.lev, I.exp, I.hp, I.cp, I.energy, I.satiety, I.money, I.logInTime, I.logOutTime, I.elapsed_play_time_in_sec, I.builder_lev builder_lev_char, I.ip, I.spec_id, I.elo,
	L.is_alive, 
	S.attack, S.attack_speed, S.run_speed, S.defense,
	G.name guild_name, G.ID guild_id,
	SM.infinite_hunt_point, SM.arena_point, SM.guild_warrior_point, SM.private_arena_point, SM.team_arena_point,
	SM.infinite_hunt_point_weekly, SM.arena_point_weekly, SM.guild_warrior_point_weekly, SM.private_arena_point_weekly, SM.team_arena_point_weekly,
	W.money warehouse_money
	FROM 
	SB_USER U (READUNCOMMITTED)
	LEFT JOIN SB_GUILD_MEMBER M (READUNCOMMITTED) ON U.ID = M.memberDBID 
	LEFT JOIN SB_GUILD G (READUNCOMMITTED) ON M.guildID = G.ID
	LEFT JOIN SB_USER_ABILITY S (READUNCOMMITTED) ON U.ID = S.ID
	LEFT JOIN SB_USER_SECONDARY_MONEY SM (READUNCOMMITTED) ON U.ID = SM.ID
	LEFT JOIN SB_USER_WAREHOUSE W (READUNCOMMITTED) ON U.ID = W.owner_dbid
	LEFT JOIN SB_USER_POS P (READUNCOMMITTED) ON U.ID = P.ID 
	LEFT JOIN SB_USER_INFO I (READUNCOMMITTED) ON U.ID = I.ID
	LEFT JOIN SB_USER_LIFE L (READUNCOMMITTED) ON U.ID = L.ID 
	LEFT JOIN SB_ACCOUNT A (READUNCOMMITTED) ON U.account_id = A.ID
	WHERE 
	U.ID = @CharID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadCharBlockedItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadCharBlockedItem]
	@CharID int
AS
BEGIN
	SELECT I.ID, bag_id, class_id, amount, slot_index, created_date, estimated
	FROM SB_ITEM I (READUNCOMMITTED) 
		 LEFT JOIN SB_ITEM_EQUIPMENT E (READUNCOMMITTED) ON (I.ID = E.ID)
	WHERE owner_id = @CharID AND I.bag_id = -8 AND I.is_deleted = 0
END
GO
PRINT N'Creating [dbo].[EWM_LoadCharBlockedReceivedPost]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadCharBlockedReceivedPost]

	@ID int

AS
BEGIN

	SELECT * 
	FROM SB_POST_BOX (READUNCOMMITTED) 
	WHERE recipient_dbid = @ID AND blocked = 1
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadCharBlockedSentPost]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadCharBlockedSentPost]

	@ID int

AS
BEGIN

	SELECT * 
	FROM SB_POST_BOX (READUNCOMMITTED) 
	WHERE sender_dbid = @ID AND blocked = 1
	
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadCharBlockedTrustSale]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadCharBlockedTrustSale]

	@seller int

AS
BEGIN

	SELECT * 
	FROM [dbo].[SB_TRUST_SALE] (READUNCOMMITTED) 
	WHERE [user_id] = @seller and blocked = 1
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadCharChatReportedInfo]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadCharChatReportedInfo]
	@ID int
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT reported_time, report_count, reported_count_normal, reported_count_guild
	FROM [dbo].[SB_USER_CHAT_REPORT] (READUNCOMMITTED) 
	WHERE [user_dbid]=@ID	
END
GO
PRINT N'Creating [dbo].[EWM_LoadCharDeletedItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadCharDeletedItem]
	@charID INT,
	@page INT,
	@pageSize INT
AS
BEGIN

	WITH itemTable AS
	(
	SELECT ROW_NUMBER() OVER (ORDER BY delete_date DESC) AS rowNum, I.*, E.durability, E.estimated, COUNT(*) OVER() AS 'total_count'
	FROM SB_ITEM I LEFT JOIN SB_ITEM_EQUIPMENT E ON (I.ID = E.ID)
	WHERE owner_id = @charID AND I.is_deleted = 1
	)
	
	SELECT * FROM itemTable
	WHERE rowNum BETWEEN((@page -1) * @pageSize) + 1 and @page * @pageSize;
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadCharEquipItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadCharEquipItem]
	@CharID int
AS
BEGIN
	SELECT I.ID, class_id, slot_index, created_date, amount, estimated, P.possession_status
	FROM SB_ITEM AS I (READUNCOMMITTED) 
		 LEFT JOIN SB_ITEM_EQUIPMENT AS E (READUNCOMMITTED) ON (I.ID = E.ID) 
		 LEFT JOIN SB_ITEM_POSSESSION AS P (READUNCOMMITTED) ON (I.ID = P.item_dbid)
	WHERE owner_id = @CharID AND bag_id = -1 AND is_deleted = 0
	ORDER BY slot_index
END
GO
PRINT N'Creating [dbo].[EWM_LoadCharInvenItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadCharInvenItem]

	@CharID int,
	@IsDeleted bit

AS
BEGIN

	SELECT I.ID, bag_id, class_id, amount, slot_index, created_date, estimated, possession_status
	FROM SB_ITEM AS I (READUNCOMMITTED)  
		 LEFT JOIN SB_ITEM_EQUIPMENT AS E (READUNCOMMITTED) ON (I.ID = E.ID)
		 LEFT JOIN SB_ITEM_POSSESSION AS P (READUNCOMMITTED) ON (I.ID = P.item_dbid)
	WHERE owner_id = @CharID AND I.is_deleted = @IsDeleted AND
		 (bag_id = 0 OR bag_id IN (SELECT ID FROM SB_ITEM_BAG (READUNCOMMITTED) WHERE bag_type = 0 AND owner_dbid = @CharID))
	ORDER BY bag_id, slot_index
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadCharInvenMoney]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadCharInvenMoney]

	@CharID int

AS
BEGIN

	SELECT money 
	FROM SB_USER_INFO (READUNCOMMITTED) 
	WHERE ID = @CharID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadCharName]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadCharName]

	@ID int

AS
BEGIN

	SELECT name 
	FROM SB_USER (READUNCOMMITTED) 
	WHERE ID=@ID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadCharNameHistory]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadCharNameHistory]  

	@user_id INT

AS  
BEGIN  

	SET NOCOUNT ON  
	
	SELECT * 
	FROM SB_USER_NAME_HISTORY (READUNCOMMITTED) 
	WHERE [user_id] = @user_id;
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadCharPetInven]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadCharPetInven]

	@CharID int,
	@IsDeleted bit

AS
BEGIN

	SELECT I.ID, bag_id, class_id, amount, I.slot_index, created_date, estimated, p.pet_name, Q.possession_status
	FROM SB_ITEM AS I (READUNCOMMITTED)  
		 LEFT JOIN SB_ITEM_EQUIPMENT AS E (READUNCOMMITTED) ON (I.ID = E.ID)
		 LEFT JOIN SB_ITEM_BAG AS B (READUNCOMMITTED) ON (I.bag_id = B.ID)
		 LEFT JOIN SB_USER_PET AS P (READUNCOMMITTED) ON (B.slot_index = P.pet_slot_index)
		 LEFT JOIN SB_ITEM_POSSESSION AS Q (READUNCOMMITTED) ON (I.ID = Q.item_dbid)
	WHERE owner_id = @CharID AND p.owner_dbid = @CharID AND I.is_deleted = @IsDeleted AND
		 (bag_id IN (SELECT ID FROM SB_ITEM_BAG (READUNCOMMITTED) WHERE bag_type = 3 AND owner_dbid = @CharID))
	ORDER BY bag_id, I.slot_index
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadCharSkill]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadCharSkill]

	@user_id INT

AS
BEGIN

	SELECT S.skill_id, S.skill_level, S.spec_id
	FROM SB_USER_SKILL S (READUNCOMMITTED)
	WHERE S.ID = @user_id
END
GO
PRINT N'Creating [dbo].[EWM_LoadCharSoul]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadCharSoul]

	@ID int

AS
BEGIN

	SELECT S.soul_type, S.amount 
	FROM SB_USER_SOUL S (READUNCOMMITTED) 
	WHERE S.user_id = @ID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadCharSpec]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadCharSpec]

	@charID int

AS
BEGIN

	SELECT * 
	FROM SB_USER_ABILITY A (READUNCOMMITTED)
		 LEFT JOIN SB_USER_INFO I (READUNCOMMITTED) ON A.ID = I.ID
	WHERE A.ID = @charID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadCharWarehouse]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadCharWarehouse]

	@CharID int,
	@IsDeleted bit

AS
BEGIN

	SELECT I.ID, bag_id, class_id, amount, slot_index, created_date, estimated, P.possession_status
	FROM SB_ITEM AS I (READUNCOMMITTED)
		 LEFT JOIN SB_ITEM_EQUIPMENT AS E (READUNCOMMITTED) ON (I.ID = E.ID)
		 LEFT JOIN SB_ITEM_POSSESSION AS P (READUNCOMMITTED) ON (I.ID = P.item_dbid)
	WHERE owner_id = @CharID AND I.is_deleted = @IsDeleted AND
		(bag_id = -5 OR bag_id IN (SELECT ID FROM SB_ITEM_BAG (READUNCOMMITTED) WHERE bag_type = 1 AND owner_dbid = @CharID))
	ORDER BY bag_id, slot_index
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadCharWarehouseMoney]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadCharWarehouseMoney]

	@CharID int

AS
BEGIN

	SELECT money 
	FROM SB_USER_WAREHOUSE (READUNCOMMITTED) 
	WHERE owner_dbid = @CharID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadCurrentTax]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadCurrentTax]
	@date datetime
AS
BEGIN
SELECT [date], tax, tax_rate, is_pvp_sent, is_pve_sent, week_no, pvp_winner, pve_winner, PG.name pvp_name, EG.name pve_name
FROM SB_TAX T (READUNCOMMITTED)
LEFT JOIN SB_TAX_GUILD G (READUNCOMMITTED) ON (T.date BETWEEN G.week_date AND DATEADD(day, 6, G.week_date))
LEFT JOIN SB_GUILD PG (READUNCOMMITTED) on (G.pvp_winner = PG.ID)
LEFT JOIN SB_GUILD EG (READUNCOMMITTED) on (G.pve_winner = EG.ID)
WHERE date = @date
ORDER BY date desc
END
GO
PRINT N'Creating [dbo].[EWM_LoadCycleAnnounce]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadCycleAnnounce]


AS
BEGIN

	SELECT ID, type, cycle, msg 
	FROM SB_ANNOUNCE (READUNCOMMITTED) 
	WHERE cycle > 0
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadDuelArena]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadDuelArena]

	@CharID int,
	@SeasonNo int

AS
BEGIN
	SET NOCOUNT ON;

	SELECT [user_dbid]
		, [season_no]
		, [season_win]
		, [season_lose]
		, [season_draw]
		, [season_win_in_row]
		, [season_lose_in_row]
		, [season_elo]
	FROM SB_DUEL_ARENA (READUNCOMMITTED) 
	WHERE user_dbid = @CharID
	AND season_no = @SeasonNo
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadDuelArenaDetail]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadDuelArenaDetail]

	@CharID int,
	@SeasonNo int

AS
BEGIN
	SET NOCOUNT ON;

	SELECT [user_dbid]
		, [season_no]
		, [job_type]
		, [talent_type]
		, [enemy_job_type]
		, [enemy_talent_type]
		, [season_win]
		, [season_lose]
		, [season_draw]
	FROM SB_DUEL_ARENA_DETAIL (READUNCOMMITTED) 
	WHERE user_dbid = @CharID
	AND season_no = @SeasonNo
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadDuelArenaSeasonInfo]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadDuelArenaSeasonInfo]

	@CharID int

AS
BEGIN
	SET NOCOUNT ON;

	SELECT season_no
	FROM SB_DUEL_ARENA (READUNCOMMITTED) 
	WHERE user_dbid = @CharID
	GROUP BY season_no
	ORDER BY season_no
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadDuelArenaSesaonInfo]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadDuelArenaSesaonInfo]

	@CharID int

AS
BEGIN
	SET NOCOUNT ON;

	SELECT season_no
	FROM SB_DUEL_ARENA (READUNCOMMITTED) 
	WHERE user_dbid = @CharID
	GROUP BY season_no
	ORDER BY season_no
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadDungeonTicketBoss]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadDungeonTicketBoss]
	@userDBID int,
	@ticketID int
AS
BEGIN

	SELECT user_db_id, ticket_id, boss_id, is_first_kill FROM
	SB_USER_DUNGEON_TICKET_BOSS(READUNCOMMITTED)
	WHERE user_db_id = @userDBID AND ticket_id = @ticketID;

END
GO
PRINT N'Creating [dbo].[EWM_LoadDungeonTicketList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadDungeonTicketList]

	@CharID INT

AS
BEGIN

	SELECT * 
	FROM SB_USER_DUNGEON_TICKET (READUNCOMMITTED) 
	WHERE user_db_id = @CharID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadDungeonTimeAttackRecord]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadDungeonTimeAttackRecord]

	@CharID int

AS
BEGIN

	SELECT dungeon_class_id, dungeon_level_ex, complete_seconds, update_time
	FROM SB_USER_TIME_ATTACK (READUNCOMMITTED) 
	WHERE user_db_id = @CharID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadGemByDBID]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadGemByDBID]

	@dbID bigint

AS
BEGIN

	SELECT * 
	FROM SB_ITEM_GEM (READUNCOMMITTED) 
	WHERE ID = @dbID 
	ORDER BY SocketIndex
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadGuildBlockedItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadGuildBlockedItem]
	@GuildID int
AS
BEGIN

	SELECT I.ID, bag_id, class_id, amount, slot_index, created_date, estimated
	FROM SB_ITEM I (READUNCOMMITTED) 
		 LEFT JOIN SB_ITEM_EQUIPMENT E (READUNCOMMITTED) ON (I.ID = E.ID)
	WHERE owner_id = @GuildID AND I.bag_id = -10 AND I.is_deleted = 0
END
GO
PRINT N'Creating [dbo].[EWM_LoadGuildDetail]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadGuildDetail]

	@guildID INT

AS
BEGIN

	SELECT U.ID char_id, U.name char_name,
	G.*, N.notice
	FROM SB_GUILD G
		 LEFT JOIN SB_USER U (READUNCOMMITTED) ON G.masterDBID = U.ID 
		 LEFT JOIN SB_GUILD_NOTICE N (READUNCOMMITTED) ON G.ID=N.ID
	WHERE G.ID = @GuildID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadGuildDetailByName]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadGuildDetailByName]

	@guildName NVARCHAR(64)

AS
BEGIN

	SELECT U.ID char_id, U.name char_name,
	G.*, N.notice
	FROM SB_GUILD G (READUNCOMMITTED)
		 LEFT JOIN SB_USER U (READUNCOMMITTED) ON G.masterDBID = U.ID 
		 LEFT JOIN SB_GUILD_NOTICE N (READUNCOMMITTED) ON G.ID=N.ID
	WHERE G.name = @guildName
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadGuildFriendship]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadGuildFriendship]
	@guildID int
AS
BEGIN

	SELECT guild_dbid_from, guild_dbid_to, created_date
	FROM SB_GUILD_FRIENDSHIP (READUNCOMMITTED)
	WHERE guild_dbid_from = @guildID OR guild_dbid_to = @guildID;
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadGuildHistory]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadGuildHistory]
	@GuildID int
AS
BEGIN
	SELECT *
FROM SB_GUILD_HISTORY
WHERE guildID = @GuildID
END
GO
PRINT N'Creating [dbo].[EWM_LoadGuildMember]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadGuildMember]

	@guildID INT

AS
BEGIN

	SELECT U.ID, U.name, U.job_type, 
	A.ID account_id, A.name account_name, 
	G.grade, G.kill_count, G.death_count
	FROM SB_USER U (READUNCOMMITTED)
		 LEFT JOIN SB_ACCOUNT A (READUNCOMMITTED) ON U.account_id = A.ID
		 LEFT JOIN SB_GUILD_MEMBER G (READUNCOMMITTED) ON U.ID = G.memberDBID 
	WHERE G.guildID = @GuildID
	ORDER BY G.grade
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadGuildWar]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadGuildWar]

	@guildID INT

AS
BEGIN

	SELECT G.name targetGuildName, W.* 
	FROM SB_GUILD G (READUNCOMMITTED)
		 LEFT JOIN SB_GUILD_WAR W (READUNCOMMITTED) ON G.ID = W.targetGuildID 
	WHERE W.guildID = @GuildID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadGuildWarehouse]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadGuildWarehouse]

	@GuildID int,
	@IsDeleted bit

AS
BEGIN

	SELECT I.ID, bag_id, class_id, amount, I.slot_index, created_date, estimated, possession_status
	FROM SB_ITEM AS I (READUNCOMMITTED)  
		 LEFT JOIN SB_ITEM_EQUIPMENT AS E (READUNCOMMITTED) ON (I.ID = E.ID)
		 LEFT JOIN SB_ITEM_BAG B (READUNCOMMITTED) ON (I.bag_id = B.ID)
		 LEFT JOIN SB_ITEM_POSSESSION AS P (READUNCOMMITTED) ON (I.ID = P.item_dbid)
	WHERE I.owner_id = @GuildID AND I.is_deleted = @IsDeleted AND (I.bag_id = -7 OR B.bag_type = 2)
	ORDER BY bag_id, I.slot_index
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadItem]

	@owner_id int, 
	@bag_id int

AS
BEGIN


SET NOCOUNT ON;
	--caution: see also sb_LoadItem, sb_LoadItemByDBID, sb_LoadItemByDBIDList

	SELECT
		T1.ID, T1.class_id, T1.amount, T1.slot_index, T1.created_date,
		ISNULL(T2.durability, -1) durability, ISNULL(T3.RuneClassID, 0) RuneClassID, ISNULL(T3.AttributeType, 0) AttributeTye,
		ISNULL(T6.GEM0, 0) GEM0,
		ISNULL(T6.GEM1, 0) GEM1,
		ISNULL(T6.GEM2, 0) GEM2,
		ISNULL(T2.estimated, 0) estimated,
		ISNULL(T2.reestimated, 0) reestimated,
		ISNULL(T5.Attack, 0) Attack,
		ISNULL(T5.HitRate, 0) HitRate,
		ISNULL(T5.CriticalHitRate, 0) CriticalHitRate,
		ISNULL(T5.Evasion, 0) Evasion,
		ISNULL(T5.MaxHP, 0) MaxHP,
		ISNULL(T5.Defense, 0) Defense,
		ISNULL(T5.Penetration, 0) Penetration,
		ISNULL(T5.CriticalEvasion, 0) CriticalEvasion,
		ISNULL(T5.MaxCP, 0) MaxCP,
		ISNULL(T5.RegenCP, 0) RegenCP,
		ISNULL(T5.PVPPenetration, 0) PVPPenetration,
		ISNULL(T5.PVPDefense, 0) PVPDefense,
		ISNULL(T4.seal_count, 0) seal_count, 
		ISNULL(T4.possession_status, 0) possession_status,
		CASE WHEN T7.expire_date IS NULL THEN -1 ELSE dbo.ConvertToTimeT32(T7.expire_date) END expire_date
	FROM (
			SELECT ID, class_id, amount, slot_index, dbo.ConvertToTimeT32(created_date) created_date
			FROM SB_ITEM (READUNCOMMITTED)
			WHERE owner_id = @owner_id
				AND bag_id = @bag_id
				AND is_deleted = 0
		) T1
		LEFT JOIN SB_ITEM_EQUIPMENT AS T2 (READUNCOMMITTED) ON (T1.ID = T2.ID)
		LEFT JOIN SB_ITEM_RUNE AS T3 (READUNCOMMITTED) ON (T1.ID = T3.ID)
		LEFT JOIN SB_ITEM_POSSESSION AS T4 (READUNCOMMITTED) ON (T1.ID = T4.item_dbid)
		LEFT JOIN (
			SELECT ID, 
				[0] AS Attack, [1] AS HitRate, [2] AS CriticalHitRate, [3] AS Evasion, [4] AS MaxHP, 
				[5] AS Defense, [6] AS Penetration, [7] AS CriticalEvasion, [8] AS MaxCP, [9] AS RegenCP, 
				[10] AS PVPPenetration, [11] AS PVPDefense
				--caution: see also condition BETWEEN 0 AND 11
			FROM (SELECT ID, ability_type, ability_value FROM SB_ITEM_RANDOM_ABILITY (READUNCOMMITTED) WHERE ability_type BETWEEN 0 AND 11) s
			PIVOT(SUM(ability_value) FOR ability_type IN ([0],[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11])) AS pvt
		) T5 ON (T1.ID = T5.ID)
		LEFT JOIN (
			SELECT ID, 
				[0] AS GEM0, [1] AS GEM1, [2] AS GEM2
			FROM (SELECT ID, SocketIndex, GemClassID FROM SB_ITEM_GEM (READUNCOMMITTED) WHERE SocketIndex BETWEEN 0 AND 2) s2
			PIVOT( SUM(GemClassID) FOR SocketIndex IN ([0],[1],[2])) AS pvt2
		) T6 ON (T1.ID = T6.ID)
		LEFT JOIN SB_ITEM_DURATION AS T7 (READUNCOMMITTED) ON (T1.ID = T7.item_dbid)
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadItemByDBID]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadItemByDBID]

	@DBID bigint

AS
BEGIN

	SELECT U.name, I.owner_id, I.ID, I.class_id, I.amount, I.is_deleted, P.possession_status, E.durability, E.estimated, E.reestimated, D.expire_date, R.grade, R.experience
	FROM 
	SB_ITEM I (READUNCOMMITTED) 
	LEFT JOIN SB_USER U (READUNCOMMITTED) ON I.owner_id = U.ID
	LEFT JOIN SB_ITEM_POSSESSION P (READUNCOMMITTED) ON I.ID = P.item_dbid 
	LEFT JOIN SB_ITEM_EQUIPMENT E (READUNCOMMITTED) ON I.ID = E.ID
	LEFT JOIN SB_ITEM_DURATION D (READUNCOMMITTED) ON I.ID = D.item_dbid
	LEFT JOIN SB_ITEM_REINFORCEMENT R (READUNCOMMITTED) ON I.ID = R.ID
	WHERE I.ID = @DBID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadItemClassIDByDBID]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadItemClassIDByDBID]
	@dbID bigint
AS
BEGIN

	SELECT class_id 
	FROM SB_ITEM (READUNCOMMITTED) 
	WHERE ID = @dbID	
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadItemGemList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadItemGemList]
	@itemID BIGINT
AS
BEGIN

	SELECT * FROM SB_ITEM_GEM (READUNCOMMITTED) WHERE ID = @itemID

	
END
GO
PRINT N'Creating [dbo].[EWM_LoadItemOwner]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadItemOwner]
	@itemID BIGINT
AS
BEGIN

	SELECT U.ID [user_id], U.name [user_name], A.ID [account_id], A.name [account_name] FROM (SB_ITEM I (READUNCOMMITTED) LEFT JOIN SB_USER U (READUNCOMMITTED) ON (I.owner_id = U.ID)) LEFT JOIN SB_ACCOUNT A (READUNCOMMITTED) ON (U.account_id = A.ID)
	WHERE I.ID = @itemID;
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadLevelUpHistory]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadLevelUpHistory]

	@CharID Int

AS
BEGIN

	SELECT lev, play_time, lev_time 
	FROM SB_USER_LEVELUP_HISTORY (READUNCOMMITTED) 
	WHERE ID = @CharID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadMoneyRestraint]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadMoneyRestraint]
	@target_id int,
	@type varchar(1),
	@money_type varchar(1),
	@is_deleted bit
AS
BEGIN
	SELECT * 
	FROM SB_MONEY_RESTRAINT AS M (READUNCOMMITTED)
	WHERE target_id = @target_id AND type = @type AND money_type = @money_type AND is_deleted = @is_deleted;
END
GO
PRINT N'Creating [dbo].[EWM_LoadPartyDungeonTimeAttackRecord]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadPartyDungeonTimeAttackRecord]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT dungeon_class_id, infinite_dungeon_set_name, dungeon_level_ex, user_name, complete_seconds, update_time
	FROM SB_WORLD_TIME_ATTACK_USER_GROUP (READUNCOMMITTED) 
END
GO
PRINT N'Creating [dbo].[EWM_LoadPet]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadPet]
	@user_id INT
AS
BEGIN

	SELECT * 
	FROM SB_USER_PET (READUNCOMMITTED) 
	WHERE owner_dbid=@user_id

END
GO
PRINT N'Creating [dbo].[EWM_LoadPostInBoxPaged]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadPostInBoxPaged]

	@user_id Int,
	@page int,
	@pageSize int

AS
BEGIN

	WITH inboxTBL AS
	(
		SELECT ROW_NUMBER() OVER (ORDER BY send_time DESC) AS rowNum, * 
		FROM SB_POST_BOX (READUNCOMMITTED)
		WHERE recipient_dbid = @user_id AND blocked = 0
	)
	SELECT * FROM inboxTBL
	WHERE rowNum BETWEEN ((@page - 1) * @pageSize) AND @page * @pageSize
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadPostSentPaged]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadPostSentPaged]

	@user_id Int,
	@page int,
	@pageSize int

AS
BEGIN

	WITH sentTBL AS
	(
		SELECT ROW_NUMBER() OVER (ORDER BY send_time DESC) AS rowNum, * 
		FROM SB_POST_BOX (READUNCOMMITTED)
		WHERE sender_dbid = @user_id AND blocked = 0
	)
	SELECT * FROM sentTBL
	WHERE rowNum BETWEEN ((@page - 1) * @pageSize) AND @page * @pageSize
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadPrivateArena]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadPrivateArena]

	@CharID int

AS
BEGIN

	SELECT [user_dbid]
      ,[season_no]
      ,[season_win]
      ,[season_lose]
      ,[season_draw]
      ,[season_win_in_row]
      ,[season_lose_in_row]
      ,[season_elo]
      ,[season_award]
	FROM SB_PRIVATE_ARENA (READUNCOMMITTED) 
	WHERE user_dbid = @CharID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadPrivateArenaWeek]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadPrivateArenaWeek]
	@CharID int
AS
BEGIN

	SELECT [user_dbid]
	, [season_no], [week_no]
    , [week_win], [week_lose], [week_draw]
	FROM SB_PRIVATE_ARENA_WEEK (READUNCOMMITTED) 
	WHERE user_dbid = @CharID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadProfession]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadProfession]

	@CharID int

AS
BEGIN

	SELECT * 
	FROM SB_USER_PROFESSION (READUNCOMMITTED) 
	WHERE user_id = @CharID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadQuest]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadQuest]

	@CharID int,
	@Finished int

AS
BEGIN

	SELECT quest_id, finished_date 
	FROM SB_USER_QUEST (READUNCOMMITTED) 
	WHERE user_id = @CharID AND finished = @Finished
	ORDER BY quest_id ASC
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadQuestDetail]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadQuestDetail]

	@CharID int,
	@QuestID int

AS
BEGIN

	SELECT uq.quest_id, uq.registered, isnull(uqp.goal_id, -1) goal_id, isnull(uqp.progress, -1) progress, finished, registered_date, uq.finished_date
	FROM SB_USER_QUEST (READUNCOMMITTED) uq 
	LEFT JOIN SB_USER_QUEST_PROGRESS (READUNCOMMITTED) uqp
	ON uq.quest_id = uqp.quest_id AND uq.user_id = uqp.user_id
	WHERE uq.user_id = @CharID AND uq.quest_id = @QuestID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadRandomOptionByDBID]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadRandomOptionByDBID]

	@dbID bigint

AS
BEGIN

	SELECT * 
	FROM SB_ITEM_RANDOM_ABILITY (READUNCOMMITTED) 
	WHERE ID = @dbID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadRuneByDBID]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadRuneByDBID]

	@dbID bigint

AS
BEGIN

	SELECT * FROM 
	SB_ITEM_RUNE (READUNCOMMITTED) 
	WHERE ID = @dbID 
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadServerHistory]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadServerHistory]
AS
BEGIN
	SELECT * 
	FROM SB_SERVER_HISTORY AS H (READUNCOMMITTED);
END
GO
PRINT N'Creating [dbo].[EWM_LoadShopGiftBox]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadShopGiftBox]
@is_sender BIT,
@user_id INT
AS
BEGIN

IF @is_sender = 1 
	BEGIN
	SELECT 
	ISNULL(send_date, 0) AS send_date, 
	ISNULL(open_date, 0) AS open_date, 
	ISNULL(delete_date, 0) AS delete_date, 
	ISNULL(receive_date, 0) AS receive_date, 
	* FROM SB_SHOP_GIFT_BOX B LEFT JOIN SB_SHOP_GIFT_ITEM I ON B.ID = I.gift_id
	WHERE B.sender_dbid = @user_id
	END

ELSE
	BEGIN
	SELECT
	ISNULL(send_date, 0) AS send_date, 
	ISNULL(open_date, 0) AS open_date, 
	ISNULL(delete_date, 0) AS delete_date, 
	ISNULL(receive_date, 0) AS receive_date,
	 * FROM SB_SHOP_GIFT_BOX B LEFT JOIN SB_SHOP_GIFT_ITEM I ON B.ID = I.gift_id
	WHERE B.recipient_dbid = @user_id
	END
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadShopOrderHistory]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadShopOrderHistory]
@user_id INT
AS
BEGIN

	SELECT * FROM SB_SHOP_ORDER_HISTORY
	WHERE recipient_id = @user_id

END
GO
PRINT N'Creating [dbo].[EWM_LoadSinglePet]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadSinglePet]
	@pet_id INT
AS
BEGIN

	SELECT * 
	FROM SB_USER_PET (READUNCOMMITTED) 
	WHERE ID = @pet_id

END
GO
PRINT N'Creating [dbo].[EWM_LoadSoloDungeonTimeAttackRecord]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadSoloDungeonTimeAttackRecord]
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT dungeon_class_id, infinite_dungeon_set_name, dungeon_level_ex, user_name, job_type, talent_type, complete_seconds, update_time
	FROM SB_WORLD_TIME_ATTACK_SOLO (READUNCOMMITTED) 
END
GO
PRINT N'Creating [dbo].[EWM_LoadSoulMoney]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadSoulMoney]
	@CharID INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT soul_money FROM SB_USER_SOUL_MONEY (READUNCOMMITTED) WHERE user_db_id = @CharID;


END
GO
PRINT N'Creating [dbo].[EWM_LoadSoulSkill]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadSoulSkill]

	@user_id bigint

AS
BEGIN
	SELECT S.courage_exp, S.hope_exp, S.purity_exp, S.well_exp, S.selected_soul_type
	FROM SB_USER_SOUL_SKILL S (READUNCOMMITTED)
	WHERE S.user_dbid = @user_id
END
GO
PRINT N'Creating [dbo].[EWM_LoadSpecSkill]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadSpecSkill]

	@user_id INT,
	@spec_id INT

AS
BEGIN

	SELECT S.skill_id, S.skill_level, S.spec_id
	FROM SB_USER_SKILL S (READUNCOMMITTED)
	WHERE S.ID = @user_id AND s.spec_id = @spec_id
END
GO
PRINT N'Creating [dbo].[EWM_LoadSpiros]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadSpiros]
AS
BEGIN
	SELECT guild_db_id, elapsed_seconds, G.name, RANK() OVER (order by elapsed_seconds asc) rank 
FROM SB_GUILD_LAIR_TIME_ATTACK A(READUNCOMMITTED)
LEFT JOIN SB_GUILD G(READUNCOMMITTED) ON (A.guild_db_id = G.ID)
ORDER BY rank ASC
END
GO
PRINT N'Creating [dbo].[EWM_LoadTaxHistory]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadTaxHistory]
AS
BEGIN
SELECT [date], tax, tax_rate, is_pvp_sent, is_pve_sent, week_no, pvp_winner, pve_winner, PG.name pvp_name, EG.name pve_name
FROM SB_TAX T (READUNCOMMITTED)
LEFT JOIN SB_TAX_GUILD G (READUNCOMMITTED) ON (T.date BETWEEN G.week_date AND DATEADD(day, 6, G.week_date))
LEFT JOIN SB_GUILD PG (READUNCOMMITTED) on (G.pvp_winner = PG.ID)
LEFT JOIN SB_GUILD EG (READUNCOMMITTED) on (G.pve_winner = EG.ID)
ORDER BY date desc
END
GO
PRINT N'Creating [dbo].[ewm_LoadTransmogrifyList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ewm_LoadTransmogrifyList]
	@charID Int
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT ID, class_id, slot_type, used, create_date
	FROM SB_USER_TRANSMOGRIFY_LIST T (READUNCOMMITTED)
	WHERE T.ID = @charID
END
GO
PRINT N'Creating [dbo].[EWM_LoadTrustSaleMyList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadTrustSaleMyList]

	@seller INT

AS
BEGIN

	SELECT * 
	FROM [dbo].[SB_TRUST_SALE] (READUNCOMMITTED) 
	WHERE [user_id] = @seller and [status] != 2 and blocked = 0
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadUltimateSkill]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadUltimateSkill]

	@user_id bigint
	
AS
BEGIN
	SELECT S.ultimate_skill_id, S.courage_exp, S.hope_exp, S.purity_exp, S.well_exp
	FROM SB_USER_ULTIMATE_SKILL S (READUNCOMMITTED)
	WHERE S.user_id = @user_id 
END
GO
PRINT N'Creating [dbo].[EWM_LoadUserAchievementList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadUserAchievementList]

	@UserID int

AS
BEGIN

	SELECT * 
	FROM SB_USER_ACHIEVEMENT (READUNCOMMITTED)
	WHERE [user_id] = @UserID;
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadUserAchievementNotFinished]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadUserAchievementNotFinished]

	@UserID int

AS
BEGIN

SELECT DISTINCT P.achievement_id
FROM 
SB_USER_ACHIEVEMENT_PROGRESS (READUNCOMMITTED) P 
LEFT JOIN SB_USER_ACHIEVEMENT (READUNCOMMITTED) A 
ON P.user_id = A.user_id AND P.achievement_id = A.achievement_id
WHERE 
A.finished_time IS NULL AND P.user_id = @UserID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadUserAchievementProgress]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadUserAchievementProgress]

	@UserID int,
	@AchievementID int

AS
BEGIN

SELECT *
FROM 
SB_USER_ACHIEVEMENT_PROGRESS (READUNCOMMITTED)
WHERE 
user_id = @UserID AND achievement_id = @AchievementID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadUserAttendance]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadUserAttendance]
	@CharID int
AS
BEGIN

	SELECT R.total_attendance_count, R.number, R.start_time, R.number, R.attendance_count, W.attendance_time, W.item_amount, W.item_class_id, W.receipt_method, W.receipt_time
	FROM SB_USER_ATTENDANCE_ROUND R (READUNCOMMITTED)
		LEFT JOIN SB_USER_ATTENDANCE_REWARD W (READUNCOMMITTED) ON (R.user_id = W.user_id)
	WHERE R.user_id = @CharID
END
GO
PRINT N'Creating [dbo].[EWM_LoadUserBagList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadUserBagList]
	@user_id int
AS
BEGIN

	SELECT *
	FROM [SB_ITEM_BAG] B (READUNCOMMITTED)
	LEFT JOIN [SB_USER_PET] P (READUNCOMMITTED) ON (B.bag_type = 3 AND B.owner_dbid = P.owner_dbid AND B.slot_index = P.pet_slot_index)
	WHERE B.owner_dbid = @user_id;
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadUserBFHistory]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadUserBFHistory]

	@CharID int

AS
BEGIN

	SELECT * 
	FROM SB_USER_SPVP (READUNCOMMITTED) 
	WHERE user_id = @CharID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadUserHonorWeek]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadUserHonorWeek]

	@CharID int

AS
BEGIN

	SELECT season_no, week_no, week_honor, grade, ranking
	FROM SB_USER_HONOR_WEEK (READUNCOMMITTED) 
	WHERE user_dbid = @CharID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadUserMultiSpec]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[EWM_LoadUserMultiSpec]
	@user_id int
AS 
BEGIN

	select * from SB_USER_INFO_MULTI_SPEC (READUNCOMMITTED)
	where user_id = @user_id

END
GO
PRINT N'Creating [dbo].[EWM_LoadUserRecipeList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadUserRecipeList]

	@user_id INT

AS
BEGIN

	SELECT * 
	FROM SB_USER_RECIPE (READUNCOMMITTED) 
	WHERE user_id=@user_id
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadUserRecipeListByProfession]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadUserRecipeListByProfession]

	@user_id INT,
	@profession_id INT

AS
BEGIN

	SELECT * 
	FROM SB_USER_RECIPE (READUNCOMMITTED) 
	WHERE user_id=@user_id AND profession_id = @profession_id
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadUserSPVPHistory]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[EWM_LoadUserSPVPHistory]
	@CharID int
AS
BEGIN

	SELECT * 
	FROM SB_USER_SPVP (READUNCOMMITTED) 
	WHERE user_id = @CharID
END
GO
PRINT N'Creating [dbo].[EWM_LoadUserTitleList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadUserTitleList]

	@UserID int

AS
BEGIN

	SELECT * 
	FROM SB_USER_TITLE (READUNCOMMITTED)
	WHERE [user_id] = @UserID;
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadUserTrustSale]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadUserTrustSale]

	@userDBID INT

AS
BEGIN

	SELECT * 
	FROM [dbo].[SB_USER_TRUST_SALE] (READUNCOMMITTED) 
	WHERE [userDBID] = @userDBID
	
END
GO
PRINT N'Creating [dbo].[EWM_LoadUserVehicle]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadUserVehicle]

	@user_id bigint

AS
BEGIN
	SELECT ID, vehicle_class_id, vehicle_slot_index, expire_date
	FROM SB_USER_VEHICLE S (READUNCOMMITTED)
	WHERE S.owner_dbid = @user_id
END
GO
PRINT N'Creating [dbo].[EWM_LoadWarehouseInfo]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_LoadWarehouseInfo]  
	@UserID INT
AS  
BEGIN  
	SET NOCOUNT ON  
	
	SELECT * FROM SB_USER_WAREHOUSE (READUNCOMMITTED) WHERE owner_dbid = @UserID;
	
END
GO
PRINT N'Creating [dbo].[EWM_ModifyPet]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_ModifyPet]
	@pet_id INT,
	@name nvarchar(64),
	@expire_date int
AS
BEGIN

	UPDATE SB_USER_PET SET pet_name = @name, expire_date = dbo.ConvertToDateTime32(@expire_date)
	WHERE ID = @pet_id

	DECLARE @owner_id INT
	SELECT @owner_id = owner_dbid FROM SB_USER_PET (READUNCOMMITTED) WHERE ID = @pet_id
	
	IF @@ROWCOUNT > 0
		EXEC sb_WritePetHistory @owner_id, @pet_id, 13, 0
END
GO
PRINT N'Creating [dbo].[EWM_ModifyVehicle]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_ModifyVehicle]
	@vehicle_id INT,
	@expire_date int
AS
BEGIN

	UPDATE SB_USER_VEHICLE SET expire_date = dbo.ConvertToDateTime32(@expire_date)
	WHERE ID = @vehicle_id

	DECLARE @owner_id INT
	SELECT @owner_id = owner_dbid FROM SB_USER_VEHICLE (READUNCOMMITTED) WHERE ID = @vehicle_id
	
	IF @@ROWCOUNT > 0
		EXEC sb_WritePetHistory @owner_id, @vehicle_id, 13, 0
END
GO
PRINT N'Creating [dbo].[ewm_RestoreItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ewm_RestoreItem]
	@sender_type INT
	, @sender_dbid INT
	, @sender_name NVARCHAR(64)
	, @recipient_dbid INT
	, @recipient_name NVARCHAR(64)
	, @max_receive_count INT
	, @title NVARCHAR(50)
	, @text NVARCHAR(500)
	, @attached_item_type INT
	, @item_dbid bigint
	, @item_quantity INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	--Restore Deleted Item
	
	UPDATE SB_ITEM SET bag_id = -4, is_deleted = 0, delete_date = null WHERE ID = @item_dbid
	
	DECLARE @UserPostTable UserPostTable;
	
	--Attach Iteration
	DECLARE @PostID INT; 
	
	INSERT INTO SB_POST_BOX (sender_type, sender_dbid, sender_name, recipient_dbid, recipient_name, title, text, attached_money, attached_item_type)
	VALUES (@sender_type, @sender_dbid, @sender_name, @recipient_dbid, @recipient_name, @title, @text, 0, @attached_item_type)
		
	SET @PostID = SCOPE_IDENTITY();
			
	INSERT INTO @UserPostTable (user_id, post_id, attached_item_count, money) VALUES (@recipient_dbid, @PostID, 0, 0);
		
	-- Make Attachment
	INSERT INTO SB_POST_ATTACHED_ITEM (post_id, item_key, item_amount) VALUES (@PostID, @item_dbid, @item_quantity);
		
	UPDATE @UserPostTable SET attached_item_count = attached_item_count + 1 WHERE post_id = @PostID;
	
	SELECT * FROM @UserPostTable;
END
GO
PRINT N'Creating [dbo].[sb_BlockItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sb_BlockItem]
	-- Add the parameters for the stored procedure here
	@item_id_list DBIDList READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE SB_ITEM SET bag_id = -8 WHERE id IN (SELECT dbid FROM @item_id_list)
END
GO
PRINT N'Creating [dbo].[EWM_RestrainBag]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_RestrainBag]
	@sender_type INT
	, @sender_dbid INT
	, @sender_name NVARCHAR(64)
	, @recipient_dbid INT
	, @max_receive_count INT
	, @title NVARCHAR(50)
	, @text NVARCHAR(500)
	, @attached_item_type INT
	, @bag_id INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @UserPostTable UserPostTable;
	
	DECLARE @RecipientName NVARCHAR(64);
	
	SET @RecipientName = (SELECT name FROM SB_USER (READUNCOMMITTED) WHERE ID = @recipient_dbid);
	
	DECLARE @AttachedMoney INT;
	SET @AttachedMoney = 0;
	
	DECLARE @ItemBagID INT;
	SET @ItemBagID = -4;
	
	DECLARE @ItemDBIDList AttachedItem;
	
	-- Iterate Items in Bag
	
	INSERT INTO @ItemDBIDList SELECT ID, amount FROM SB_ITEM (READUNCOMMITTED) WHERE bag_id = @bag_id AND is_deleted = 0 AND owner_id = @recipient_dbid;
	
	UPDATE SB_ITEM SET bag_id = @ItemBagID WHERE bag_id = @bag_id AND is_deleted = 0 AND owner_id = @recipient_dbid;

	-- END ITERATION
	
	--Attach Iteration
	DECLARE @AttachID INT;
	
	DECLARE @PostID INT; 
	
	DECLARE @AttachAmount INT;
	
	DECLARE @AttachCount INT;
	
	SET @AttachCount = 0;
	
	DECLARE attachCursor CURSOR LOCAL FAST_FORWARD
	FOR 
	SELECT [item_key], [item_amount]
	FROM @ItemDBIDList;
	
	OPEN attachCursor
	
	FETCH NEXT FROM attachCursor INTO @AttachID, @AttachAmount
	
	WHILE @@FETCH_STATUS = 0
	BEGIN 
		IF (@AttachCount % 5 = 0)
		BEGIN
			-- Make Post
			INSERT INTO SB_POST_BOX (sender_type, sender_dbid, sender_name, recipient_dbid, recipient_name, title, text, attached_money, attached_item_type)
			VALUES (@sender_type, @sender_dbid, @sender_name, @recipient_dbid, @RecipientName, @title, @text, @AttachedMoney, @attached_item_type)
		
			SET @PostID = SCOPE_IDENTITY();
			
			INSERT INTO @UserPostTable (user_id, post_id, attached_item_count, money) VALUES (@recipient_dbid, @PostID, 0, @AttachedMoney);
		END
		
		-- Make Attachment
		INSERT INTO SB_POST_ATTACHED_ITEM (post_id, item_key, item_amount) VALUES (@PostID, @AttachID, @AttachAmount);
		
		UPDATE @UserPostTable SET attached_item_count = attached_item_count + 1 WHERE post_id = @PostID;
		
		SET @AttachCount = @AttachCount + 1;
	
	FETCH NEXT FROM attachCursor INTO @AttachID, @AttachAmount
	END
	
	CLOSE attachCursor;
	DEALLOCATE attachCursor;
	
	-- No Operation for NO ATTACHMENT
	
	-- Restrain Bag
	DECLARE @BagClassID INT;
	SET @BagClassID = (SELECT source_item_class_id FROM SB_ITEM_BAG (READUNCOMMITTED) WHERE ID = @bag_id);
	
	DECLARE @BagDBID BIGINT;
	
	INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index, is_deleted) VALUES	(@recipient_dbid, -8, @BagClassID, 1, 0, 0);
	
	SET @BagDBID = SCOPE_IDENTITY();
	
	DECLARE @BlockItemList DBIDList;
	
	INSERT INTO @BlockItemList (dbid) VALUES (@BagDBID);
	
	EXEC sb_BlockItem @BlockItemList;
	
	DELETE SB_ITEM_BAG WHERE ID = @bag_id;
	
	SELECT * FROM @UserPostTable;
END
GO
PRINT N'Creating [dbo].[EWM_RestrainCurrencyTrustSale]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_RestrainCurrencyTrustSale]
	@tsc_id int
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE SB_TRUST_SALE_CURRENCY SET blocked = 1 WHERE tsc_dbid = @tsc_id
	
END
GO
PRINT N'Creating [dbo].[EWM_RestrainGem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_RestrainGem]	
	@user_id INT,
	@item_gem_list ItemGemList READONLY
AS
BEGIN	
	SET NOCOUNT ON;
	
	MERGE INTO SB_ITEM_GEM WITH (HOLDLOCK) G
	USING @item_gem_list AS S
	ON (G.ID = S.item_id AND G.SocketIndex = S.socket_index)
	WHEN MATCHED THEN DELETE;
	
	INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index) 
	(SELECT @user_id, -8, gem_class_id, 1, 0 FROM @item_gem_list);

END
GO
PRINT N'Creating [dbo].[EWM_SearchItemCount]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_SearchItemCount]
	@class_id INT
AS
BEGIN
	SELECT SUM(count) as count, ISNULL(SUM(amount), 0) as amount 
	FROM
	(
		(
			SELECT COUNT(*) as count, SUM(T.amount) as amount
			FROM SB_USER U (READUNCOMMITTED) 
				LEFT JOIN SB_ITEM T (READUNCOMMITTED) ON (U.ID = T.owner_id)
			WHERE U.ID = T.owner_id AND T.is_deleted = 0 AND U.final_deleted = 'N' AND T.class_id = @class_id
		) UNION ALL
		(
			SELECT COUNT(*) as count, SUM(I.amount) as amount
			FROM SB_ITEM I (READUNCOMMITTED)
			LEFT JOIN SB_ITEM_BAG B (READUNCOMMITTED) ON (I.bag_id = B.ID)
			INNER JOIN SB_GUILD G (READUNCOMMITTED) ON (I.owner_id = G.ID)
			
			WHERE I.is_deleted = 0 AND (I.bag_id = -7 OR B.bag_type = 2)
				AND G.deleted = 0 AND I.class_id = @class_id
				
		)
	) AS A				
END
GO
PRINT N'Creating [dbo].[ewm_SendPostToMultipleUser]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ewm_SendPostToMultipleUser]
	@sender_type INT
	, @sender_dbid INT
	, @sender_name NVARCHAR(64)
	, @max_receive_count INT
	, @title NVARCHAR(50)
	, @text NVARCHAR(500)
	, @attached_money INT
	, @attached_item_type INT
	, @item_list NewItemList READONLY
	, @random_option_list RandomOptionList READONLY
	, @user_list IntTable READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @UserPostTable UserPostTable;
	
	DECLARE @userID INT;
	
	DECLARE @aMoney INT;
	
	DECLARE userCursor CURSOR LOCAL FAST_FORWARD
	FOR
	SELECT [ID]
	FROM @user_list;
	
	OPEN userCursor;
	
	-- user loop
	
	FETCH NEXT FROM userCursor INTO @userID;
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	
		DECLARE @userName nvarchar(64);
		
		SET @aMoney = @attached_money;
		
		IF (SELECT COUNT(*) FROM SB_USER (READUNCOMMITTED) WHERE ID = @userID) > 0
		BEGIN
			-- valid userID
			SET @userName = (SELECT name FROM SB_USER (READUNCOMMITTED) WHERE ID = @userID);
		END
		ELSE
		BEGIN
			-- invalid userID
			FETCH NEXT FROM userCursor INTO @userID;
			CONTINUE;
		END
	
		-- loop variable REFRESHED AT EVERY LOOP
		DECLARE @RowID INT;
		DECLARE @ClassID INT;
		DECLARE @Quantity INT;
		DECLARE @Durability INT;
		DECLARE @ExpirationDate INT;
		DECLARE @SealCount INT;
		DECLARE @Possessed INT;
		DECLARE @Identified INT;
		DECLARE @Grade INT;
		DECLARE @Experience FLOAT;
		-- /loop variable
		
		DECLARE @ItemDBIDList AttachedItem;
		
		-- Iterate ItemList and Insert Item to DB, push id in DBIDLIST
		
		DECLARE itemCursor CURSOR LOCAL FAST_FORWARD
		FOR 
		SELECT [row_id], [class_id], [quantity], [durability], [expiration_date], [possessed], [identified], [seal_count], [grade], [experience]
		FROM @item_list;
		
		OPEN itemCursor;
		
		FETCH NEXT FROM itemCursor INTO @RowID, @ClassID, @Quantity, @Durability, @ExpirationDate, @Possessed, @Identified, @SealCount, @Grade, @Experience;
		
		WHILE @@FETCH_STATUS = 0
		BEGIN 
			DECLARE @ItemDBID bigint;
		-- Iteration Content
		
		-- Insert Item, Get and set DBID
			INSERT INTO SB_ITEM (amount, bag_id, class_id, created_date, is_deleted, owner_id, slot_index) VALUES (@Quantity, -4, @ClassID, GETDATE(), 0, @userID, 0);
			
			SET @ItemDBID = SCOPE_IDENTITY();
			
			INSERT INTO @ItemDBIDList (item_key, item_amount) VALUES (@ItemDBID, @Quantity);
		
		-- Insert Durability
			IF not (@Durability = -1 and @Identified = 2)
			BEGIN
				INSERT INTO SB_ITEM_EQUIPMENT (ID, durability, estimated, reestimated) VALUES (@ItemDBID, @Durability, @Identified, null);
			END
		
		-- Insert Possession
			IF @Possessed != 2
			BEGIN
				INSERT INTO SB_ITEM_POSSESSION (item_dbid, seal_count, possession_status) VALUES (@ItemDBID, @SealCount, @Possessed);
			END
		
		-- Insert Expiration
		
			IF @ExpirationDate != -1
			BEGIN
				INSERT INTO SB_ITEM_DURATION (item_dbid, expire_date) VALUES (@ItemDBID, dbo.ConvertToDateTime32(@ExpirationDate));
			END
		
		-- Insert Reinforce Info
		IF @Grade != -1
		BEGIN
			INSERT INTO SB_ITEM_REINFORCEMENT (ID, grade, experience) VALUES (@ItemDBID, @Grade, @Experience);
		END
		
		-- Iterate Random Option, Insert RandomOption
		
			-- inner loop variable REFRESHED AT EVERY LOOP
			DECLARE @Type tinyint;
			DECLARE @Value INT;
			-- inner loop variable
			
			DECLARE RandomOptionCursor CURSOR LOCAL FAST_FORWARD
			FOR
			SELECT [type], [value]
			FROM @random_option_list
			WHERE [item_row_id] = @RowID;
			
			OPEN RandomOptionCursor;
			
			FETCH NEXT FROM RandomOptionCursor INTO @Type, @Value;
			
			WHILE @@FETCH_STATUS = 0
			BEGIN
			
			-- inner loop content
			
			-- Insert RandomOption
				INSERT INTO SB_ITEM_RANDOM_ABILITY (ID, ability_type, ability_value) VALUES (@ItemDBID, @Type, @Value);
			
			FETCH NEXT FROM RandomOptionCursor INTO @Type, @Value;
			END
			
			CLOSE RandomOptionCursor;
			DEALLOCATE RandomOptionCursor;
		
		FETCH NEXT FROM itemCursor INTO @RowID, @ClassID, @Quantity, @Durability, @ExpirationDate, @Possessed, @Identified, @SealCount, @Grade, @Experience;
		END
		
		CLOSE itemCursor;
		DEALLOCATE itemCursor;
		
		-- END ITERATION
		
		-- Make Post
		DECLARE @PostID INT; 
		
		DECLARE @AttachCount INT;
	
		SET @AttachCount = 0;
		
		
		
		-- Make Attachment
		
		DECLARE @AttachID INT;
		DECLARE @AttachAmount INT;
		
		DECLARE attachCursor CURSOR LOCAL FAST_FORWARD
		FOR 
		SELECT [item_key], [item_amount]
		FROM @ItemDBIDList;
		
		OPEN attachCursor
		
		FETCH NEXT FROM attachCursor INTO @AttachID, @AttachAmount
		
		WHILE @@FETCH_STATUS = 0
		BEGIN 
		
			IF (@AttachCount != 0)
			BEGIN
				SET @aMoney = 0;
			END
			
			IF (@AttachCount % 5 = 0)
			BEGIN
				INSERT INTO SB_POST_BOX (sender_type, sender_dbid, sender_name, recipient_dbid, recipient_name, title, text, attached_money, attached_item_type)
				VALUES (@sender_type, @sender_dbid, @sender_name, @userID, @userName, @title, @text, @aMoney, @attached_item_type)
			
				SET @PostID = SCOPE_IDENTITY();
				
				INSERT INTO @UserPostTable (user_id, post_id, attached_item_count, money) VALUES (@userID, @PostID, 0, @aMoney);
			END
			
			--Attach Iteration
			INSERT INTO SB_POST_ATTACHED_ITEM (post_id, item_key, item_amount) VALUES (@PostID, @AttachID, @AttachAmount);
			
			UPDATE @UserPostTable SET attached_item_count = attached_item_count + 1 WHERE post_id = @PostID;
			
			SET @AttachCount = @AttachCount + 1;
		
		FETCH NEXT FROM attachCursor INTO @AttachID, @AttachAmount;
		END
		
		CLOSE attachCursor;
		DEALLOCATE attachCursor;
		
		IF (@AttachCount = 0)
		BEGIN
			INSERT INTO SB_POST_BOX (sender_type, sender_dbid, sender_name, recipient_dbid, recipient_name, title, text, attached_money, attached_item_type)
			VALUES (@sender_type, @sender_dbid, @sender_name, @userID, @userName, @title, @text, @aMoney, @attached_item_type)
			
			SET @PostID = SCOPE_IDENTITY();
			
			INSERT INTO @UserPostTable (user_id, post_id, attached_item_count, money) VALUES (@userID, @PostID, 0, @aMoney);
		END
		
		DELETE FROM @ItemDBIDList;
		
	FETCH NEXT FROM userCursor INTO @userID;
	END
	
	CLOSE userCursor;
	DEALLOCATE userCursor;
	
	SELECT * FROM @UserPostTable;
	

END
GO
PRINT N'Creating [dbo].[SB_SendPost]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_SendPost]
	@sender_type INT
	, @sender_dbid INT
	, @sender_name NVARCHAR(64)
	, @recipient_dbid INT
	, @recipient_name NVARCHAR(64)
	, @max_receive_count INT
	, @title NVARCHAR(50)
	, @text NVARCHAR(500)
	, @attached_money BIGINT
	, @attached_item_type INT
	, @attached_items AttachedItem READONLY 
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @post_id INT = 0
	
	IF @sender_type IN (1, 2)	-- SEND_BY_USER, SEND_BY_MOBILE_USER
	BEGIN
		SELECT @recipient_dbid = ID
		FROM dbo.SB_USER (READUNCOMMITTED)
		WHERE name = @recipient_name
			AND deleted_time IS NULL
			AND final_deleted = 'N'
		
		IF @recipient_dbid = 0
		BEGIN
			SELECT @post_id, @recipient_dbid, 1
			RETURN
		END
		
		IF EXISTS (SELECT * FROM dbo.SB_BAN (READUNCOMMITTED) WHERE user_id = @recipient_dbid AND ban_id = @sender_dbid)
		BEGIN
			SELECT @post_id, @recipient_dbid, 2
			RETURN
		END
		
		IF @max_receive_count <= (SELECT COUNT(*) FROM dbo.SB_POST_BOX (READUNCOMMITTED) WHERE recipient_dbid = @recipient_dbid AND delete_time IS NULL AND sender_type IN (1, 2))
		BEGIN
			SELECT @post_id, @recipient_dbid, 3
			RETURN
		END
	END

	INSERT INTO SB_POST_BOX (sender_type, sender_dbid, sender_name, recipient_dbid, recipient_name, title, text, attached_money, attached_item_type)
	VALUES (@sender_type, @sender_dbid, @sender_name, @recipient_dbid, @recipient_name, @title, @text, @attached_money, @attached_item_type)
	
	SET @post_id = SCOPE_IDENTITY()

	INSERT INTO SB_POST_ATTACHED_ITEM (post_id, item_key, item_amount)
	SELECT @post_id, item_key, item_amount
	FROM @attached_items
	
	SELECT @post_id, @recipient_dbid, 0
END
GO
PRINT N'Creating [dbo].[EWM_UnrestrainCurrencyTrustSale]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_UnrestrainCurrencyTrustSale]
	@tscID int,
	@userDBID int,
	@sender nvarchar(64),
	@title nvarchar(50),
	@message nvarchar(500)
AS
BEGIN

	UPDATE SB_TRUST_SALE_CURRENCY SET status = 2, blocked = 0 WHERE tsc_dbid = @tscID AND blocked = 1;
	
	DECLARE @moneyType tinyint;
	DECLARE @money bigint;
	 SELECT @moneyType = sell_type, @money = sell_amount FROM SB_TRUST_SALE_CURRENCY (READUNCOMMITTED) WHERE tsc_dbid = @tscID;
	
	IF @moneyType = 0
	BEGIN
		UPDATE SB_USER_INFO SET money += @money WHERE ID = @userDBID;
	END
	ELSE IF @moneyType = 1
	BEGIN
		UPDATE SB_USER_SECONDARY_MONEY SET infinite_hunt_point += @money WHERE ID = @userDBID;
	END
	ELSE IF @moneyType = 2
	BEGIN
		UPDATE SB_USER_SECONDARY_MONEY SET guild_warrior_point += @money WHERE ID = @userDBID;
	END
	ELSE IF @moneyType = 3
	BEGIN
		UPDATE SB_USER_SECONDARY_MONEY SET arena_point += @money WHERE ID = @userDBID;
	END
	ELSE IF @moneyType = 4
	BEGIN
		UPDATE SB_USER_SECONDARY_MONEY SET private_arena_point += @money WHERE ID = @userDBID;
	END
	ELSE IF @moneyType = 5
	BEGIN
		UPDATE SB_USER_SECONDARY_MONEY SET team_arena_point += @money WHERE ID = @userDBID;
	END
	ELSE IF @moneyType = 7
	BEGIN
		UPDATE SB_USER_SOUL_MONEY SET soul_money += @money WHERE user_db_id = @userDBID;
	END 
	
	DECLARE @receipientName nvarchar(64) = (select name from SB_USER (READUNCOMMITTED) where ID = @userDBID);
	
	DECLARE @attachedItems AttachedItem;
	
	EXEC sb_SendPost 4, 0, @sender, @userDBID, @receipientName, 0, @title, @message, 0, 0, @attachedItems;
	
END
GO
PRINT N'Creating [dbo].[EWM_UnrestrainMoney]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_UnrestrainMoney]
	@target_id int,
	@type varchar(1),
	@money_type varchar(1),
	@money	bigint,
	@restrainID int
AS

BEGIN
	IF @type = 'U'
	BEGIN
		IF @money_type = 'M'
		BEGIN
			UPDATE SB_USER_INFO SET money = money + @money WHERE ID = @target_id;
		END
		
		ELSE IF @money_type ='W'
		BEGIN
			UPDATE SB_USER_WAREHOUSE SET money = money + @money WHERE owner_dbid = @target_id;
		END
	END
	
	INSERT INTO SB_MONEY_RESTRAINT ([target_id], [type], [money_type], [money], [is_deleted]) VALUES (@target_id, @type, @money_type, -1 * @money, 1);
	
	UPDATE SB_MONEY_RESTRAINT SET [is_deleted] = 1 WHERE ID = @restrainID;
END
GO
PRINT N'Creating [dbo].[EWM_UpdateMoneyRestraint]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_UpdateMoneyRestraint]
	@target_id int,
	@type varchar(1),
	@money_type varchar(1),
	@money	bigint
AS

BEGIN
	IF @type = 'U'
	BEGIN
		IF @money_type = 'I'
		BEGIN
			UPDATE SB_USER_INFO SET money = money - @money WHERE ID = @target_id;
		END
		
		ELSE IF @money_type ='W'
		BEGIN
			UPDATE SB_USER_WAREHOUSE SET money = money - @money WHERE owner_dbid = @target_id;
		END
	END
	
	IF @type = 'G'
	BEGIN
		IF @money_type = 'W'
		BEGIN
			UPDATE SB_GUILD SET money = money - @money WHERE ID = @target_id;
		END
	END
	
	INSERT INTO SB_MONEY_RESTRAINT ([target_id], [type], [money_type], [money]) VALUES (@target_id, @type, @money_type, @money);
END
GO
PRINT N'Creating [dbo].[EWM_UpdatePrivateArenaPoint]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_UpdatePrivateArenaPoint]
 @owner_id int,
 @point bigint
AS  
BEGIN  
 SET NOCOUNT ON;  
 
 UPDATE SB_USER_SECONDARY_MONEY SET private_arena_point += @point WHERE ID = @owner_id
   
 SELECT private_arena_point FROM SB_USER_SECONDARY_MONEY (READUNCOMMITTED) WHERE ID = @owner_id
 
END
GO
PRINT N'Creating [dbo].[EWM_UpdateSoulMoney]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_UpdateSoulMoney]
 @owner_id int,
 @point bigint
AS  
BEGIN  
 SET NOCOUNT ON;  
 
 MERGE SB_USER_SOUL_MONEY WITH (HOLDLOCK) AS T
 USING (SELECT @owner_id owner_id, @point point) AS S
 ON T.user_db_id = S.owner_id
 WHEN MATCHED THEN 
	UPDATE SET soul_money += @point
 WHEN NOT MATCHED THEN
	INSERT (user_db_id, soul_money) values (S.owner_id, S.point);
END
GO
PRINT N'Creating [dbo].[EWM_UpdateTeamArenaPoint]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EWM_UpdateTeamArenaPoint]
 @owner_id int,
 @point bigint
AS  
BEGIN  
 SET NOCOUNT ON;  
 
 UPDATE SB_USER_SECONDARY_MONEY SET team_arena_point += @point WHERE ID = @owner_id
   
 SELECT team_arena_point FROM SB_USER_SECONDARY_MONEY (READUNCOMMITTED) WHERE ID = @owner_id
 
END
GO
PRINT N'Creating [dbo].[ewm_UpdateWarehouseMoney]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ewm_UpdateWarehouseMoney]
	@owner_dbid INT
	, @money BIGINT
AS
BEGIN
	SET NOCOUNT ON

    UPDATE SB_USER_WAREHOUSE
    SET [money] = [money] + @money
    WHERE owner_dbid = @owner_dbid
END
GO
PRINT N'Creating [dbo].[Q_ViewCharacterList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Q_ViewCharacterList]
	@sid	NVARCHAR(8),
	@cnMaster	NVARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @account_id BIGINT
	SET @account_id = -1
	
    SELECT @account_id = ID 
    FROM SB_ACCOUNT(READUNCOMMITTED)
    WHERE name = @cnMaster
    
    IF @account_id = -1
		BEGIN
			SELECT 2 retCode
		END
	ELSE
		BEGIN
			IF EXISTS(SELECT 1 FROM SB_USER(READUNCOMMITTED) WHERE account_id = @account_id)
				BEGIN
					SELECT 0 retCode
					
					SELECT 
					CONVERT(NVARCHAR(40), U.ID) roleGuid, 
					CONVERT(NVARCHAR(50), U.name) roleName, 
					I.lev roleLevel, 
					CONVERT(NVARCHAR(20), U.job_type) roleJob, 
					N'' reserve
					FROM SB_USER(READUNCOMMITTED) U, SB_USER_INFO(READUNCOMMITTED) I
					WHERE U.account_id = @account_id
					AND U.ID = I.ID
					AND U.final_deleted = N'N'
				END
			ELSE
				BEGIN
					SELECT 2 retCode
				END
		END
END
GO
PRINT N'Creating [dbo].[sb_AccountWarehouseDeposit]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_AccountWarehouseDeposit]
	@account_id BIGINT
	, @item_id BIGINT
	, @to_slot_index INT
AS
BEGIN
	SET NOCOUNT ON

	INSERT SB_ITEM_ACCOUNT (account_id, item_id, slot_index)
	VALUES (@account_id, @item_id, @to_slot_index)
END
GO
PRINT N'Creating [dbo].[sb_AccountWarehouseLoad]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_AccountWarehouseLoad]
	@account_id BIGINT
AS
BEGIN
	SET NOCOUNT ON

	SELECT item_id, slot_index, dbo.ConvertToTimeT32(updated_date)
	FROM SB_ITEM_ACCOUNT (READUNCOMMITTED)
	WHERE account_id = @account_id
	ORDER BY updated_date
END
GO
PRINT N'Creating [dbo].[sb_AccountWarehouseWithdraw]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_AccountWarehouseWithdraw]
	@account_id BIGINT
	, @item_id BIGINT
	, @from_slot_index INT
AS
BEGIN
	SET NOCOUNT ON

	DELETE FROM SB_ITEM_ACCOUNT
	WHERE account_id = @account_id AND item_id = @item_id-- AND slot_index = @from_slot_index
END
GO
PRINT N'Creating [dbo].[sb_AcquireSkill]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_AcquireSkill]  
	@user_id INT
	, @spec_id TINYINT
	, @skill_id INT
	, @skill_level INT
AS  
BEGIN  
	SET NOCOUNT ON  

	MERGE SB_USER_SKILL WITH (HOLDLOCK) T
	USING (SELECT @user_id, @skill_id, @skill_level, @spec_id) AS S (user_id, skill_id, skill_level, spec_id)
		ON T.ID = S.user_id AND T.spec_id = S.spec_id AND T.skill_id = S.skill_id
	WHEN MATCHED THEN
		UPDATE SET skill_level = S.skill_level
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (ID, skill_id, skill_level, spec_id) VALUES (@user_id, @skill_id, @skill_level, @spec_id)
	--OUTPUT $action, Inserted.*, Deleted.*
	;
	
	--INSERT INTO SB_USER_SKILL_BUILD (ID, skill_id, skill_level)
	--VALUES (@user_id, @skill_id, @skill_level)
END
GO
PRINT N'Creating [dbo].[sb_AcquireSkillTrigger]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_AcquireSkillTrigger]
	@user_id INT
	, @spec_id TINYINT
	, @trigger_id INT
	, @trigger_level INT
AS
BEGIN
	SET NOCOUNT ON
	
	MERGE SB_USER_SKILL_TRIGGER WITH (HOLDLOCK) T
	USING (SELECT @user_id, @spec_id, @trigger_id, @trigger_level) AS S (user_id, spec_id, trigger_id, trigger_level)
		ON T.ID = S.user_id AND T.spec_id = S.spec_id AND T.trigger_id = S.trigger_id
	WHEN MATCHED THEN
		UPDATE SET trigger_level = S.trigger_level
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (ID, spec_id, trigger_id, trigger_level) VALUES (@user_id, @spec_id, @trigger_id, @trigger_level)
	--OUTPUT $action, Inserted.*, Deleted.*
	;	
END
GO
PRINT N'Creating [dbo].[SB_AcquireSoulExp]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_AcquireSoulExp]
	@user_dbid INT
	, @hope_exp INT
	, @purity_exp INT
	, @courage_exp INT
	, @well_exp INT
AS
BEGIN
	SET NOCOUNT ON
	
	MERGE SB_USER_SOUL_SKILL WITH (HOLDLOCK) T
	USING (VALUES (@user_dbid, @hope_exp, @purity_exp, @courage_exp, @well_exp)) AS S (user_dbid, hope_exp, purity_exp, courage_exp, well_exp)
		ON T.user_dbid = S.user_dbid
	WHEN MATCHED THEN
		UPDATE SET hope_exp = T.hope_exp + S.hope_exp
				,purity_exp = T.purity_exp + S.purity_exp
				,courage_exp = T.courage_exp + S.courage_exp
				,well_exp = T.well_exp + S.well_exp
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_dbid, hope_exp, purity_exp, courage_exp, well_exp) VALUES (S.user_dbid, S.hope_exp, S.purity_exp, S.courage_exp, S.well_exp)
	--OUTPUT $action, Inserted.*, Deleted.*
	;
END
GO
PRINT N'Creating [dbo].[sb_AcquireUltimateSoulExp]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_AcquireUltimateSoulExp]
	@user_id INT
	, @ultimate_skill_id INT
	, @hope_exp INT
	, @purity_exp INT
	, @courage_exp INT
	, @well_exp INT
AS
BEGIN
	SET NOCOUNT ON
	
	MERGE SB_USER_ULTIMATE_SKILL WITH (HOLDLOCK) S
	USING (SELECT @user_id, @ultimate_skill_id, @hope_exp, @purity_exp, @courage_exp, @well_exp) AS N (user_id, ultimate_skill_id, hope_exp, purity_exp, courage_exp, well_exp)
		ON S.user_id=N.user_id AND S.ultimate_skill_id=N.ultimate_skill_id
	WHEN MATCHED THEN
		UPDATE SET S.hope_exp = S.hope_exp + @hope_exp
			,S.purity_exp = S.purity_exp + @purity_exp
			,S.courage_exp = S.courage_exp + @courage_exp
			,S.well_exp = S.well_exp + @well_exp
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_id, ultimate_skill_id, hope_exp, purity_exp, courage_exp, well_exp) VALUES (@user_id, @ultimate_skill_id, @hope_exp, @purity_exp, @courage_exp, @well_exp)
	--OUTPUT $action, Inserted.*, Deleted.*
	;
END
GO
PRINT N'Creating [dbo].[sb_AddGuildFriendship]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_AddGuildFriendship] 	
	@guild_dbid_from INT,
	@guild_dbid_to   INT
AS  
BEGIN
	SET NOCOUNT ON

	MERGE
		[dbo].[SB_GUILD_FRIENDSHIP] WITH(HOLDLOCK) AS D		
	USING		
		( VALUES  (@guild_dbid_from, @guild_dbid_to, GETDATE())) AS S(guild_dbid_from, guild_dbid_to, created_date)
	ON
		( D.guild_dbid_from = S.guild_dbid_from AND  D.guild_dbid_to = S.guild_dbid_to)
		
	WHEN MATCHED THEN
		UPDATE SET 	D.created_date	= S.created_date
	WHEN NOT MATCHED THEN	
		INSERT 
			(guild_dbid_from, guild_dbid_to, created_date)
		VALUES 
			(S.guild_dbid_from, S.guild_dbid_to, S.created_date);
END
GO
PRINT N'Creating [dbo].[SB_AddItemToUser]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_AddItemToUser]
	@sender_type INT
	, @sender_dbid INT
	, @sender_name NVARCHAR(64)
	, @recipient_dbid INT
	, @recipient_name NVARCHAR(64)
	, @max_receive_count INT
	, @title NVARCHAR(50)
	, @text NVARCHAR(500)
	, @attached_item_type INT
	, @item_key BIGINT
	, @item_amount INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @post_id INT = 0 
	
	INSERT INTO SB_POST_BOX (sender_type, sender_dbid, sender_name, recipient_dbid, recipient_name, title, text, attached_money, attached_item_type)
	VALUES (@sender_type, @sender_dbid, @sender_name, @recipient_dbid, @recipient_name, @title, @text, 0, @attached_item_type)
	
	SET @post_id = SCOPE_IDENTITY()

	INSERT INTO SB_POST_ATTACHED_ITEM (post_id, item_key, item_amount)
	VALUES (@post_id, @item_key, @item_amount)
	
	SELECT @post_id, @recipient_dbid, 0
END
GO
PRINT N'Creating [dbo].[sb_AddSecondaryMoney]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_AddSecondaryMoney]
	@user_id INT,
	@currency_type INT,
	@currency_amount BIGINT,
	@currency_amount_weekly BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	--caution SBConst.h CurrencyType
	DECLARE @CT_INFINITE_HUNT_POINT INT = 1
			, @CT_GUILD_WARRIOR_POINT INT = 2
			, @CT_BATTLEFIELD_POINT INT = 3
			, @CT_PRIVATE_ARENA_POINT INT = 4
			, @CT_TEAM_ARENA_POINT INT = 5

	IF @currency_type = @CT_INFINITE_HUNT_POINT
		UPDATE SB_USER_SECONDARY_MONEY
		SET infinite_hunt_point += @currency_amount, infinite_hunt_point_weekly += @currency_amount_weekly  
		WHERE ID = @user_id;

	ELSE IF @currency_type = @CT_GUILD_WARRIOR_POINT
		UPDATE SB_USER_SECONDARY_MONEY
		SET guild_warrior_point += @currency_amount, guild_warrior_point_weekly += @currency_amount_weekly 
		WHERE ID = @user_id;

	ELSE IF @currency_type = @CT_BATTLEFIELD_POINT
		UPDATE SB_USER_SECONDARY_MONEY 
		SET arena_point += @currency_amount, arena_point_weekly += @currency_amount_weekly 
		WHERE ID = @user_id;

	ELSE IF @currency_type = @CT_PRIVATE_ARENA_POINT
		UPDATE SB_USER_SECONDARY_MONEY 
		SET private_arena_point += @currency_amount, private_arena_point_weekly += @currency_amount_weekly 
		WHERE ID = @user_id;

	ELSE IF @currency_type = @CT_TEAM_ARENA_POINT
		UPDATE SB_USER_SECONDARY_MONEY 
		SET team_arena_point += @currency_amount, team_arena_point_weekly += @currency_amount_weekly 
		WHERE ID = @user_id;
END
GO
PRINT N'Creating [dbo].[sb_ApplyRuneToItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sb_ApplyRuneToItem]
	-- Add the parameters for the stored procedure here
	@UserDBID bigint,
	@ItemDBID bigint,
	@ItemAttributeType int,
	@RuneClassiD int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- 일단 아이템이 있어야 하고 아이템이 있다면 이미 있는 데이터를 지우고 다시 넣는다.
	delete from
		dbo.sb_item_rune
	where 
		id in (select ID from SB_ITEM (READUNCOMMITTED) where ID = @ItemDBID and owner_id = @UserDBID);
		
	insert into 
		[dbo].[sb_item_rune](ID, RuneClassID, AttributeType)
	Select 
		@ItemDBID, @RuneClassiD, @ItemAttributeType
	from 
		SB_ITEM (READUNCOMMITTED) 
	where ID = @ItemDBID and owner_id = @UserDBID;
END
GO
PRINT N'Creating [dbo].[sb_ArenaTeamAward]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ArenaTeamAward]
	@season_no INT,
	@week_no INT,
	@min_match_for_team INT,
	@min_match_ratio_for_member INT,
	@award_const_1 FLOAT,
	@award_const_2 FLOAT
AS
BEGIN
	SET NOCOUNT ON;
	
	MERGE SB_ARENA_TEAM_AWARD WITH (HOLDLOCK) A
	USING
		(SELECT R.dbid, SUM(R.award) FROM 
			(SELECT MW.member_dbid dbid,
				CAST(CASE WHEN MS.season_elo < TS.season_elo
					THEN (MS.season_elo / @award_const_1) + (MS.season_elo * MS.season_elo / @award_const_2)
					ELSE (TS.season_elo / @award_const_1) + (TS.season_elo * TS.season_elo / @award_const_2)
				END AS INT) award
			FROM SB_ARENA_TEAM_MEMBER_RECORD_WEEK MW (READUNCOMMITTED)
				INNER JOIN SB_ARENA_TEAM_MEMBER_RECORD_SEASON MS (READUNCOMMITTED) 
					ON MW.team_dbid = MS.team_dbid AND MW.member_dbid = MS.member_dbid and MW.season_no = MS.season_no
				INNER JOIN SB_ARENA_TEAM_RECORD_WEEK TW (READUNCOMMITTED) 
					ON MW.team_dbid = TW.team_dbid AND MW.season_no = TW.season_no AND MW.week_no = TW.week_no
				INNER JOIN SB_ARENA_TEAM_RECORD_SEASON TS (READUNCOMMITTED) 
					ON MW.team_dbid = TS.team_dbid AND MW.season_no = TS.season_no
				INNER JOIN SB_ARENA_TEAM T (READUNCOMMITTED) 
					ON MW.team_dbid = T.team_dbid
			WHERE (TW.week_win + TW.week_lose + TW.week_Draw) >= @min_match_for_team
				AND (MW.week_win + MW.week_lose + MW.week_Draw) * 100 / (TW.week_win + TW.week_lose + TW.week_Draw) >= @min_match_ratio_for_member
				AND MW.season_no = @season_no
				AND MW.week_no = @week_no
				AND T.deleted IS NULL) R
		GROUP BY R.dbid)
		AS T (user_dbid, unpayed_award)
		ON A.user_dbid = T.user_dbid
	WHEN MATCHED THEN
		UPDATE
		SET A.unpayed_award = A.unpayed_award + T.unpayed_award
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_dbid, unpayed_award)
		VALUES (T.user_dbid, T.unpayed_award)
	;
END
GO
PRINT N'Creating [dbo].[sb_ArenaTeamAwardLoad]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ArenaTeamAwardLoad]
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT user_dbid, unpayed_award FROM SB_ARENA_TEAM_AWARD (READUNCOMMITTED)
	WHERE unpayed_award > 0
END
GO
PRINT N'Creating [dbo].[sb_ArenaTeamAwardSave]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ArenaTeamAwardSave]
	@user_dbid INT,
	@award INT
AS
BEGIN
	SET NOCOUNT ON;

	MERGE SB_ARENA_TEAM_AWARD WITH (HOLDLOCK) A
	USING	
		(SELECT @user_dbid, @award) 
			AS T (user_dbid, unpayed_award)
		ON A.user_dbid = T.user_dbid
	WHEN MATCHED THEN
		UPDATE 
		SET
			A.unpayed_award = A.unpayed_award + T.unpayed_award
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_dbid, unpayed_award)
		VALUES (T.user_dbid, T.unpayed_award)
	;
END
GO
PRINT N'Creating [dbo].[sb_ArenaTeamCreate]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ArenaTeamCreate]
	@season_no INT,
	@week_no INT,
	@team_dbid INT,
	@team_name NVARCHAR(64),
	@team_type TINYINT,
	@master_dbid INT
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO SB_ARENA_TEAM
		(team_dbid, team_name, team_type, master_dbid)
	VALUES 
		(@team_dbid, @team_name, @team_type, @master_dbid)

	INSERT INTO SB_ARENA_TEAM_RECORD_SEASON
		(team_dbid, season_no,
		season_win, season_lose, season_draw, season_win_in_row, season_lose_in_row, season_elo)
	VALUES 
		(@team_dbid, @season_no,
		0, 0, 0, 0, 0, 1200)
		
	INSERT INTO SB_ARENA_TEAM_RECORD_WEEK
		(team_dbid, season_no, week_no,
		week_win, week_lose, week_draw)
	VALUES
		(@team_dbid, @season_no, @week_no,
		0, 0, 0)
END
GO
PRINT N'Creating [dbo].[sb_ArenaTeamDelegateMaster]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ArenaTeamDelegateMaster]
	@team_dbid INT,
	@master_dbid INT
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE SB_ARENA_TEAM
	SET	master_dbid = @master_dbid
	WHERE team_dbid = @team_dbid
END
GO
PRINT N'Creating [dbo].[sb_ArenaTeamDisband]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ArenaTeamDisband]
	@team_dbid INT
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE SB_ARENA_TEAM
	SET
		deleted = 1,
		team_name = team_name + N'_' + CAST(team_dbid as NVARCHAR(12))
	WHERE team_dbid = @team_dbid
END
GO
PRINT N'Creating [dbo].[sb_ArenaTeamLoad]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ArenaTeamLoad]
	@season_no INT,
	@week_no INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT T.team_type, T.team_dbid, T.team_name, T.master_dbid
		, ISNULL(S.season_win, 0), ISNULL(S.season_lose, 0), ISNULL(S.season_draw, 0), ISNULL(S.season_win_in_row, 0), ISNULL(S.season_lose_in_row, 0), ISNULL(S.season_elo, 1200)
		, ISNULL(W.week_win, 0), ISNULL(W.week_lose, 0), ISNULL(W.week_draw, 0)
	FROM SB_ARENA_TEAM (READUNCOMMITTED) T 
		LEFT JOIN 
		SB_ARENA_TEAM_RECORD_SEASON (READUNCOMMITTED) S
		ON T.team_dbid = S.team_dbid AND S.season_no = @season_no
		LEFT JOIN 
		SB_ARENA_TEAM_RECORD_WEEK (READUNCOMMITTED) W
		ON W.team_dbid = S.team_dbid AND W.season_no = @season_no AND W.week_no = @week_no
	WHERE T.deleted IS NULL
END
GO
PRINT N'Creating [dbo].[sb_ArenaTeamMemberAdd]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ArenaTeamMemberAdd]
	@season_no INT,
	@week_no INT,
	@team_dbid INT,
	@member_dbid INT
AS
BEGIN
	SET NOCOUNT ON;
	
	INSERT INTO SB_ARENA_TEAM_MEMBER
		(team_dbid, member_dbid)
	VALUES 
		(@team_dbid, @member_dbid)

	INSERT INTO SB_ARENA_TEAM_MEMBER_RECORD_SEASON
		(team_dbid, member_dbid, season_no,
		season_win, season_lose, season_draw, season_win_in_row, season_lose_in_row, season_elo)
	VALUES 
		(@team_dbid, @member_dbid, @season_no,
		0, 0, 0, 0, 0, 1200)
		
	INSERT INTO SB_ARENA_TEAM_MEMBER_RECORD_WEEK
		(team_dbid, member_dbid, season_no, week_no,
		week_win, week_lose, week_draw)
	VALUES
		(@team_dbid, @member_dbid, @season_no, @week_no,
		0, 0, 0)
END
GO
PRINT N'Creating [dbo].[sb_ArenaTeamMemberRemove]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ArenaTeamMemberRemove]
	@team_dbid INT,
	@member_dbid INT
AS
BEGIN
	SET NOCOUNT ON;

	DELETE SB_ARENA_TEAM_MEMBER
	WHERE team_dbid = @team_dbid AND member_dbid = @member_dbid
	
	DELETE SB_ARENA_TEAM_MEMBER_RECORD_SEASON
	WHERE team_dbid = @team_dbid AND member_dbid = @member_dbid	
	
	DELETE SB_ARENA_TEAM_MEMBER_RECORD_WEEK
	WHERE team_dbid = @team_dbid AND member_dbid = @member_dbid	
	
END
GO
PRINT N'Creating [dbo].[SB_ArenaTeamMemberCleanUp]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SB_ArenaTeamMemberCleanUp]
	@member_dbid INT
AS  
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @new_master_dbid INT
	DECLARE @arena_team_dbid INT

	DECLARE arena_team_dbid_cursor CURSOR FOR
	SELECT team_dbid FROM SB_ARENA_TEAM_MEMBER
	WHERE member_dbid = @member_dbid

	OPEN arena_team_dbid_cursor
	FETCH NEXT FROM arena_team_dbid_cursor INTO @arena_team_dbid

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF EXISTS (SELECT * FROM SB_ARENA_TEAM WHERE team_dbid = @arena_team_dbid AND master_dbid = @member_dbid)
		BEGIN
			SET @new_master_dbid = ISNULL((SELECT TOP 1 member_dbid FROM SB_ARENA_TEAM_MEMBER (READUNCOMMITTED) WHERE team_dbid = @arena_team_dbid AND member_dbid <> @member_dbid), 0)
			IF @new_master_dbid <> 0
			BEGIN
				EXEC sb_ArenaTeamDelegateMaster @arena_team_dbid, @new_master_dbid
				EXEC sb_ArenaTeamMemberRemove @arena_team_dbid, @member_dbid
			END
			ELSE 
			BEGIN
				EXEC sb_ArenaTeamMemberRemove @arena_team_dbid, @member_dbid
				EXEC sb_ArenaTeamDisband @arena_team_dbid
			END
		END
		ELSE		
		BEGIN
			EXEC sb_ArenaTeamMemberRemove @arena_team_dbid, @member_dbid
		END

		FETCH NEXT FROM arena_team_dbid_cursor INTO @arena_team_dbid
	END

	CLOSE arena_team_dbid_cursor
	DEALLOCATE arena_team_dbid_cursor

END
GO
PRINT N'Creating [dbo].[sb_ArenaTeamMemberLoad]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ArenaTeamMemberLoad]
	@season_no INT,
	@week_no INT,
	@team_dbid INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT M.member_dbid
		, ISNULL(S.season_win, 0), ISNULL(S.season_lose, 0), ISNULL(S.season_draw, 0), ISNULL(S.season_win_in_row, 0), ISNULL(S.season_lose_in_row, 0), ISNULL(S.season_elo, 1200)
		, ISNULL(W.week_win, 0), ISNULL(W.week_lose, 0), ISNULL(W.week_draw, 0)
		, U.name, U.job_type
	FROM 
		SB_ARENA_TEAM_MEMBER (READUNCOMMITTED) M 
		INNER JOIN
		SB_USER (READUNCOMMITTED) U
			ON M.member_dbid = U.ID
		LEFT JOIN 
		SB_ARENA_TEAM_MEMBER_RECORD_SEASON (READUNCOMMITTED) S
			ON S.team_dbid = M.team_dbid AND S.member_dbid = M.member_dbid AND S.season_no = @season_no
		LEFT JOIN 
		SB_ARENA_TEAM_MEMBER_RECORD_WEEK (READUNCOMMITTED) W
			ON W.team_dbid = S.team_dbid AND W.member_dbid = S.member_dbid AND W.season_no = S.season_no AND W.week_no = @week_no
	WHERE M.team_dbid = @team_dbid
END
GO
PRINT N'Creating [dbo].[sb_ArenaTeamMemberRecord]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ArenaTeamMemberRecord]
	@season_no INT,
	@week_no INT,
	@team_dbid INT,
	@member_dbid INT,
	@win_delta INT,
	@lose_delta INT,
	@draw_delta INT,
	@win_in_row_delta INT,
	@lose_in_row_delta INT,
	@elo_delta INT
AS
BEGIN
	SET NOCOUNT ON;
	
	MERGE SB_ARENA_TEAM_MEMBER_RECORD_SEASON S
	USING 
		(SELECT @team_dbid, @member_dbid, @season_no, @win_delta, @lose_delta, @draw_delta, @win_in_row_delta, @lose_in_row_delta, @elo_delta) 
			AS T (team_dbid, member_dbid, season_no, season_win, season_lose, season_draw, season_win_in_row, season_lose_in_row, season_elo)
		ON S.team_dbid = T.team_dbid AND S.member_dbid = T.member_dbid AND S.season_no = T.season_no
	WHEN MATCHED THEN
		UPDATE 
		SET
			S.season_win = S.season_win + T.season_win,
			S.season_lose = S.season_lose + T.season_lose,
			S.season_draw = S.season_draw + T.season_draw,
			S.season_win_in_row = S.season_win_in_row + T.season_win_in_row,
			S.season_lose_in_row = S.season_lose_in_row + T.season_lose_in_row,
			S.season_elo = S.season_elo + T.season_elo
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (team_dbid, member_dbid, season_no, season_win, season_lose, season_draw, season_win_in_row, season_lose_in_row, season_elo)
		VALUES (T.team_dbid, T.member_dbid, T.season_no, T.season_win, T.season_lose, T.season_draw, T.season_win_in_row, T.season_lose_in_row, 1200 + T.season_elo) 
	;
	
	MERGE SB_ARENA_TEAM_MEMBER_RECORD_WEEK W
	USING 
		(SELECT @team_dbid, @member_dbid, @season_no, @week_no, @win_delta, @lose_delta, @draw_delta) 
			AS T (team_dbid, member_dbid, season_no, week_no, week_win, week_lose, week_draw)
		ON W.team_dbid = T.team_dbid AND W.member_dbid = T.member_dbid AND W.season_no = T.season_no AND W.week_no = T.week_no
	WHEN MATCHED THEN
		UPDATE 
		SET
			W.week_win = W.week_win + T.week_win,
			W.week_lose = W.week_lose + T.week_lose,
			W.week_draw = W.week_draw + T.week_draw
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (team_dbid, member_dbid, season_no, week_no, week_win, week_lose, week_draw)
		VALUES (T.team_dbid, T.member_dbid, T.season_no, T.week_no, T.week_win, T.week_lose, T.week_draw)
	;
	
END
GO
PRINT N'Creating [dbo].[sb_ArenaTeamRecord]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ArenaTeamRecord]
	@season_no INT,
	@week_no INT,
	@team_dbid INT,
	@win_delta INT, 
	@lose_delta INT, 
	@draw_delta INT, 
	@win_in_row_delta INT, 
	@lose_in_row_delta INT, 
	@elo_delta INT,
    @DEFAULT_ELO INT  = 1200
AS
BEGIN
	SET NOCOUNT ON;
	
	MERGE SB_ARENA_TEAM_RECORD_SEASON WITH (HOLDLOCK) S
	USING 
		(SELECT @team_dbid, @season_no, @win_delta, @lose_delta, @draw_delta, @win_in_row_delta, @lose_in_row_delta, @elo_delta) 
			AS T (team_dbid, season_no, season_win, season_lose, season_draw, season_win_in_row, season_lose_in_row, elo_delta)
		ON S.team_dbid = T.team_dbid AND S.season_no = T.season_no
	WHEN MATCHED THEN
		UPDATE 
		SET
			S.season_win = S.season_win + T.season_win,
			S.season_lose = S.season_lose + T.season_lose,
			S.season_draw = S.season_draw + T.season_draw,
			S.season_win_in_row = S.season_win_in_row + T.season_win_in_row,
			S.season_lose_in_row = S.season_lose_in_row + T.season_lose_in_row,
			S.season_elo = S.season_elo + T.elo_delta
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (team_dbid, season_no, season_win, season_lose, season_draw, season_win_in_row, season_lose_in_row, season_elo)
		VALUES (T.team_dbid, T.season_no, T.season_win, T.season_lose, T.season_draw, T.season_win_in_row, T.season_lose_in_row, @DEFAULT_ELO + T.elo_delta) 
	;
	
	MERGE SB_ARENA_TEAM_RECORD_WEEK W
	USING 
		(SELECT @team_dbid, @season_no, @week_no, @win_delta, @lose_delta, @draw_delta) 
			AS T (team_dbid, season_no, week_no, week_win, week_lose, week_draw)
		ON W.team_dbid = T.team_dbid AND W.season_no = T.season_no AND W.week_no = T.week_no
	WHEN MATCHED THEN
		UPDATE 
		SET
			W.week_win = W.week_win + T.week_win,
			W.week_lose = W.week_lose + T.week_lose,
			W.week_draw = W.week_draw + T.week_draw
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (team_dbid, season_no, week_no, week_win, week_lose, week_draw)
		VALUES (T.team_dbid, T.season_no, T.week_no, T.week_win, T.week_lose, T.week_draw)
	;		
END
GO
PRINT N'Creating [dbo].[sb_ArenaWeekLoad]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ArenaWeekLoad]
	@season_no INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT season_no, week_no, dbo.ConvertToTimeT32(week_start_time)
	FROM SB_ARENA_WEEK (READUNCOMMITTED)
	WHERE season_no = @season_no 
	AND week_no = (SELECT MAX(week_no) FROM SB_ARENA_WEEK WHERE season_no = @season_no)
END
GO
PRINT N'Creating [dbo].[sb_ArenaWeekStart]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ArenaWeekStart]
	@season_no INT,
	@week_no INT,
	@week_start_time INT,
	@min_match_for_team INT,
	@min_match_ratio_for_member INT,
	@award_const_1 FLOAT,
	@award_const_2 FLOAT
AS
BEGIN
	SET NOCOUNT ON;
	
	BEGIN TRANSACTION

	INSERT INTO SB_ARENA_WEEK (season_no, week_no, week_start_time)
	VALUES (@season_no, @week_no, dbo.ConvertToDateTime32(@week_start_time))
	
	if @@ROWCOUNT = 1
	BEGIN
		DECLARE @award_week INT = @week_no - 1
		exec sb_ArenaTeamAward @season_no, @award_week, @min_match_for_team, @min_match_ratio_for_member, @award_const_1, @award_const_2
	END 

	COMMIT TRANSACTION
END
GO
PRINT N'Creating [dbo].[SB_BanAdd]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_BanAdd]
	@user_id INT,
	@ban_name NVARCHAR(64)
AS
BEGIN
	SET NOCOUNT ON;

	---------------------------------------------------------------------------------------------------------------	
	DECLARE @result INT = 0		-- success
	DECLARE @ban_id INT = 0
	DECLARE @ban_user_name NVARCHAR(64)
	DECLARE @char_builder_level INT = 0
	
	SELECT @ban_id = U1.ID, @ban_user_name = U1.name
		FROM SB_USER AS U1 (READUNCOMMITTED)
		WHERE name = @ban_name
		
	IF @ban_id = 0
	BEGIN
		SET @result = 1			-- not user
	END
	
	SELECT @char_builder_level = I.builder_lev 
	FROM SB_USER U (READUNCOMMITTED) INNER JOIN SB_USER_INFO I (READUNCOMMITTED) ON U.ID = I.ID 
	WHERE U.name = @ban_name
	 
	IF @char_builder_level > 0
	BEGIN
		SET @result = 4			-- builder
	END
	
	----------------------------------------------------------------------------------------------------------------
	
	IF @result = 0
	BEGIN
		IF NOT EXISTS (SELECT user_id FROM SB_BAN (READUNCOMMITTED) WHERE user_id = @user_id AND ban_id = @ban_id)
		BEGIN
			INSERT INTO SB_BAN(user_id, ban_id) VALUES(@user_id, @ban_id)
		END
		ELSE
		BEGIN
			SET @result = 2		-- exist ban
		END
	END
	
	SELECT @result, @ban_id, @ban_user_name

END
GO
PRINT N'Creating [dbo].[SB_BanDel]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_BanDel]
	@user_id int,
	@ban_id int
AS
BEGIN
	SET NOCOUNT ON;

	IF EXISTS (SELECT user_id FROM SB_BAN (READUNCOMMITTED) WHERE user_id = @user_id AND ban_id = @ban_id)
	BEGIN
		DELETE SB_BAN WHERE user_id = @user_id AND ban_id = @ban_id
		SELECT 0;	-- success
	END
	ELSE
	BEGIN
		SELECT 3;	-- exist not ban
	END

END
GO
PRINT N'Creating [dbo].[sb_BlockAWItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_BlockAWItem]
	@item_id_list DBIDList READONLY
AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE SB_ITEM SET bag_id = -8 WHERE id IN (SELECT dbid FROM @item_id_list)
	DELETE SB_ITEM_ACCOUNT WHERE item_id IN (SELECT dbid FROM @item_id_list)
END
GO
PRINT N'Creating [dbo].[sb_BlockPost]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sb_BlockPost]
	@post_id_list IntTable READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    UPDATE SB_POST_BOX SET blocked = 1 WHERE ID IN (SELECT ID FROM @post_id_list)
END
GO
PRINT N'Creating [dbo].[sb_BlockTrustSale]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_BlockTrustSale]
	@ts_id_list IntTable READONLY,
	@userDBID Int
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @BlockCount int;
	SET @BlockCount = (SELECT COUNT(*) FROM @ts_id_list);

    UPDATE SB_TRUST_SALE SET blocked = 1 WHERE ts_id IN (SELECT ID FROM @ts_id_list) and status = 0 and user_id = @userDBID;
    
    IF @@ROWCOUNT = 0
    BEGIN
		SELECT 0
	END
	ELSE
	BEGIN
		UPDATE SB_USER_TRUST_SALE SET usedSlot = usedSlot - @BlockCount WHERE userDBID = @userDBID;
    
		UPDATE SB_ITEM SET bag_id = -8 WHERE ID IN (SELECT item_id FROM SB_TRUST_SALE WHERE ts_id IN (SELECT ID FROM @ts_id_list));
		SELECT 1
    END
END
GO
PRINT N'Creating [dbo].[sb_BuddyAdd]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_BuddyAdd]
	@user_id INT,
	@buddy_name NVARCHAR(64)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @result INT = 0		-- success
	DECLARE @buddy_id INT = 0
	DECLARE @char_builder_level INT = 0
	
	SELECT @buddy_id = ID FROM SB_USER (READUNCOMMITTED) WHERE name = @buddy_name
	
	IF @buddy_id = 0
	BEGIN
		SET @result = 1			-- not user

		SELECT @result, @buddy_id, @buddy_name, N''/*account*/, 0/*lev*/, 0/*job*/, -1/*area*/, -1/*region*/, 0/*logout*/
		RETURN;
	END
	
	SELECT @char_builder_level = I.builder_lev 
	FROM SB_USER U (READUNCOMMITTED)
		INNER JOIN SB_USER_INFO I (READUNCOMMITTED) ON U.ID = I.ID
	WHERE U.name = @buddy_name
	
	IF @char_builder_level > 0 AND @char_builder_level != 9
	BEGIN
		SET @result = 4			-- builder

		SELECT @result, @buddy_id, @buddy_name, N''/*account*/, 0/*lev*/, 0/*job*/, -1/*area*/, -1/*region*/, 0/*logout*/
		RETURN;
	END
	
	MERGE SB_BUDDY WITH (HOLDLOCK) T
	USING (VALUES (@user_id, @buddy_id)) AS S (user_id, buddy_id)
		ON T.user_id = S.user_id AND T.buddy_id = S.buddy_id
	WHEN MATCHED THEN
		UPDATE SET @result = 2
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_id, buddy_id) VALUES (@user_id, @buddy_id)
	;
	
	SELECT @result, @buddy_id, @buddy_name, A1.name, U2.lev, U1.job_type, ISNULL(dbo.ConvertToTimeT32(U2.logOutTime), 0) logOutTime
	FROM SB_USER AS U1 (READUNCOMMITTED)
		INNER JOIN SB_ACCOUNT AS A1 (READUNCOMMITTED) ON (U1.account_id = A1.ID)
		INNER JOIN SB_USER_INFO AS U2 (READUNCOMMITTED) ON (U1.ID = U2.ID)
	WHERE U1.ID = @buddy_id
END
GO
PRINT N'Creating [dbo].[SB_BuddyDel]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_BuddyDel]
	@user_id int,
	@buddy_id int
AS
BEGIN
	SET NOCOUNT ON;
	
	IF EXISTS (SELECT user_id FROM SB_BUDDY (READUNCOMMITTED) WHERE user_id = @user_id AND buddy_id = @buddy_id)
	BEGIN
		DELETE SB_BUDDY WHERE user_id = @user_id AND buddy_id = @buddy_id
		SELECT 0;	-- success
	END
	ELSE
	BEGIN
		SELECT 3;	-- exist not buddy
	END

END
GO
PRINT N'Creating [dbo].[sb_BuddyFollowerList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_BuddyFollowerList]
	@user_id INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT user_id FROM SB_BUDDY (READUNCOMMITTED) WHERE buddy_id = @user_id
END
GO
PRINT N'Creating [dbo].[SB_BuffDisinfectedByID]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_BuffDisinfectedByID]
	@user_id int
	, @buff_id int
AS
BEGIN
	SET NOCOUNT ON
	
	DELETE FROM SB_USER_BUFF
	WHERE [user_id] = @user_id
		AND [buff_id] = @buff_id
END
GO
PRINT N'Creating [dbo].[SB_BuffInfected]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_BuffInfected]
	@user_id INT
	, @buff_id INT
	, @buff_level INT
	, @accumulation TINYINT
	, @start_time BIGINT
	, @duration INT
AS
BEGIN
	SET NOCOUNT ON
	
	MERGE SB_USER_BUFF WITH (HOLDLOCK) T
	USING (VALUES (@user_id, @buff_id, @buff_level, @accumulation, @start_time, @duration)) AS S (user_id, buff_id, buff_level, accumulation, start_time, remain_time)
		ON T.user_id = S.user_id AND T.buff_id = S.buff_id
	WHEN MATCHED THEN
		UPDATE SET start_time = S.start_time
				, accumulation = S.accumulation
				, remain_time = S.remain_time
				, buff_level = S.buff_level
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_id, buff_id, buff_level, accumulation, start_time, remain_time) VALUES (S.user_id, S.buff_id, S.buff_level, S.accumulation, S.start_time, S.remain_time)
	--OUTPUT $action, Inserted.*, Deleted.*
	;
END
GO
PRINT N'Creating [dbo].[sb_BuffInfectedForcibly]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_BuffInfectedForcibly]
	@user_id INT
	, @buff_id INT
	, @buff_level INT
	, @accumulation TINYINT
	, @start_time BIGINT
	, @duration INT
AS
BEGIN
	SET NOCOUNT ON
		
	MERGE SB_USER_BUFF WITH (HOLDLOCK) T
	USING (VALUES (@user_id, @buff_id, @buff_level, @accumulation, @start_time, @duration)) AS S (user_id, buff_id, buff_level, accumulation, start_time, remain_time)
		ON T.user_id = S.user_id AND T.buff_id = S.buff_id
	WHEN MATCHED THEN
		UPDATE SET start_time = S.start_time
				, accumulation = CASE 
									WHEN T.start_time + T.remain_time > S.start_time 
										THEN T.accumulation + S.accumulation 
										ELSE S.accumulation 
									END
				, remain_time = S.remain_time
				, buff_level = S.buff_level
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_id, buff_id, buff_level, accumulation, start_time, remain_time) VALUES (S.user_id, S.buff_id, S.buff_level, S.accumulation, S.start_time, S.remain_time)
	--OUTPUT $action, Inserted.*, Deleted.*
	;
END
GO
PRINT N'Creating [dbo].[sb_BuilderSaveTaxPVEGuild]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_BuilderSaveTaxPVEGuild]
	@weekDate bigint,
	@guildDBID int
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @weekNo AS INT;
	SET @weekNo = ISNULL((SELECT TOP 1 week_no FROM SB_TAX_GUILD (READUNCOMMITTED) WHERE week_date = dbo.ConvertToDateTime32(@weekDate) ORDER BY week_no DESC), -1);
	
	UPDATE SB_TAX_GUILD SET pve_winner = @guildDBID WHERE week_no = @weekNo;
	

END
GO
PRINT N'Creating [dbo].[sb_BuilderSaveTaxPVPGuild]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_BuilderSaveTaxPVPGuild]
	@weekDate bigint,
	@guildDBID int
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @weekNo AS INT;
	SET @weekNo = ISNULL((SELECT TOP 1 week_no FROM SB_TAX_GUILD (READUNCOMMITTED) WHERE week_date = dbo.ConvertToDateTime32(@weekDate) ORDER BY week_no DESC), -1);
	
	UPDATE SB_TAX_GUILD SET pvp_winner = @guildDBID WHERE week_no = @weekNo;
	

END
GO
PRINT N'Creating [dbo].[sb_BuyAddableDungeonTicket]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_BuyAddableDungeonTicket]
	@user_db_id INT,
	@ticket_id INT,
	@increase_times INT
AS
BEGIN
	SET NOCOUNT ON
	
	MERGE SB_USER_DUNGEON_TICKET WITH (HOLDLOCK) T
	USING (SELECT @user_db_id, @ticket_id) AS S (user_db_id, ticket_id)
		ON T.user_db_id= S.user_db_id AND T.ticket_id = S.ticket_id
	WHEN MATCHED THEN
		UPDATE SET addable_ticket_buy_count = addable_ticket_buy_count + @increase_times
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_db_id, ticket_id, ticket_used_count, addable_ticket_buy_count, paid_used_count) 
		VALUES (@user_db_id, @ticket_id, 0, @increase_times, 0);
END
GO
PRINT N'Creating [dbo].[SB_BuyCashProduct]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_BuyCashProduct]	
	 @buyer_id INT
	, @buyer_name NVARCHAR(64)
	, @buyer_account_id BIGINT
	, @buyer_account_name NVARCHAR(64)
	, @recipient_id INT
	, @recipient_name NVARCHAR(64)
	, @rack_list CashRackParam READONLY	
	, @server_id  INT = 0
	, @orderNo BIGINT = 0
AS
BEGIN
	SET NOCOUNT ON;
	
	MERGE [dbo].[SB_SHOP_LIMIT_COUNT] WITH (HOLDLOCK) T
	USING (SELECT rack_id, SUM(amount) as amount FROM @rack_list WHERE [is_limited_per_char] = 1 GROUP BY rack_id) AS S
		ON T.[user_dbid] = @buyer_id
			AND T.[rack_id] = S.[rack_id]
	WHEN MATCHED THEN
		UPDATE SET [buy_amount] = [buy_amount] + S.[amount]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([user_dbid], [rack_id], [buy_amount]) VALUES (@buyer_id, S.[rack_id], S.[amount])
	;

	MERGE [dbo].[SB_SHOP_LIMITED_SELL] WITH (HOLDLOCK) T
	USING (SELECT rack_id, SUM(amount) as amount FROM @rack_list WHERE [is_amount_limited] = 1 GROUP BY rack_id) AS S
		ON T.[rack_id] = S.[rack_id]
	WHEN MATCHED THEN
		UPDATE SET [sell_amount] = [sell_amount] + S.[amount]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([rack_id], [sell_amount]) VALUES (S.[rack_id], S.[amount])
	;	
	
	-- Temporary local for table for ID
	DECLARE @idTable TABLE(ID  BIGINT)	
	
	INSERT INTO [dbo].[SB_SHOP_ORDER_HISTORY] ([rack_id],[product_id],[amount],[price],[buyer_id],[buyer_name],[buyer_account_id],[buyer_account_name],[recipient_id],[recipient_name])
		OUTPUT inserted.ID	INTO   	@idTable
	SELECT [rack_id],[product_id],[amount],[price],@buyer_id,@buyer_name,@buyer_account_id,@buyer_account_name,@recipient_id,@recipient_name
	FROM @rack_list
	
	-- Issue new serial number.
	DECLARE @serial_base	AS BIGINT
	
	SET @serial_base = (@server_id & CONVERT(INT, 0xFFFF)) * CONVERT(BIGINT, 0x800000000000)		
	
	MERGE dbo.[SB_SHOP_ORDER_HISTORY] T
		USING
		(
			SELECT [ID] FROM @idTable
		) S
		ON T.ID = S.ID
	WHEN MATCHED THEN
		UPDATE 	SET serial_no = CASE @orderNo WHEN 0 THEN (@serial_base + T.ID) ELSE @orderNo END
	OUTPUT INSERTED.product_id, INSERTED.serial_no;
END
GO
PRINT N'Creating [dbo].[SB_CancelCharacterDeletion]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_CancelCharacterDeletion]
	@user_id INT
AS  
BEGIN  
	SET NOCOUNT ON;  
	
	UPDATE SB_USER
	SET deleted_time = NULL
	WHERE ID = @user_id
		AND deleted_time IS NOT NULL
		AND final_deleted = 'N'
		
	SELECT @@ROWCOUNT
END
GO
PRINT N'Creating [dbo].[SB_CancelGuildWar]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_CancelGuildWar]  
 @guildID		int, 
 @targetGuildID int 
AS  
BEGIN  
	SET NOCOUNT ON
	
	-- 예약된 길드만을 삭제(내가 선포한 것)
	DELETE FROM [dbo].[SB_GUILD_WAR] 
	WHERE guildID = @guildID and targetGuildID = @targetGuildID AND in_progress = 0;	
	
	DELETE FROM [dbo].[SB_GUILD_WAR] 
	WHERE guildID = @targetGuildID and targetGuildID = @guildID AND in_progress = 0;
	
	-- 전쟁 길드 포인트가 차감된다. (취소 페널티 적용은 서버 코드에서 제어
	--DECLARE @curWarPoint int;
	--SET @curWarPoint = (SELECT war_point FROM [dbo].[SB_GUILD] WHERE ID = @guildID);
	
	--IF @curWarPoint < @war_score_delta
	--	BEGIN
	--		UPDATE [dbo].[SB_GUILD] SET war_point = 0 WHERE ID = @guildID;
	--	END
	--ELSE
	--	UPDATE [dbo].[SB_GUILD] SET war_point -= @war_score_delta WHERE ID = @guildID;
END
GO
PRINT N'Creating [dbo].[SB_ChangeAvatarParameter]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_ChangeAvatarParameter]
	@user_id INT,
	@hide_special BIT,
	@hide_corsage1 BIT,
	@hide_corsage2 BIT,
	@hide_costume BIT,
	@hide_special_equip BIT
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE [dbo].[SB_USER_AVATAR_ITEM]
	SET hide_special=@hide_special, hide_corsage1=@hide_corsage1, hide_corsage2=@hide_corsage2, hide_costume=@hide_costume, hide_special_equip=@hide_special_equip
	WHERE ID=@user_id;

	SELECT @user_id;
END
GO
PRINT N'Creating [dbo].[sb_ChangeGem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ChangeGem]
	@old_item_dbid BIGINT
	, @new_item_dbid BIGINT
	, @gem_class_ids IntIntTable READONLY
AS
BEGIN
	SET NOCOUNT ON;
	
	BEGIN TRAN
		DELETE FROM SB_ITEM_GEM WHERE ID = @old_item_dbid
		IF (@@ERROR <> 0) GOTO ROLLBACK_
		
		INSERT INTO SB_ITEM_GEM (ID, GemClassID, SocketIndex)
			SELECT @new_item_dbid, first, second FROM @gem_class_ids
		IF (@@ERROR <> 0) GOTO ROLLBACK_
	COMMIT TRAN
	
	SELECT 1	
	RETURN
	
	ROLLBACK_:
		SELECT -1
		ROLLBACK TRAN
END
GO
PRINT N'Creating [dbo].[SB_ChangeGuildName]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_ChangeGuildName]  
 @guildID int,
 @guildName nvarchar(20)
AS  
BEGIN  
	SET NOCOUNT ON
	
	UPDATE [dbo].[SB_GUILD] 
	SET name = @guildName 
	WHERE ID = @guildID;
END
GO
PRINT N'Creating [dbo].[sb_ChangeGuildType]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ChangeGuildType]  
	@guild_dbid	INT,
	@from_type	INT,
	@to_type	INT
AS  
BEGIN  
	SET NOCOUNT ON
	
	UPDATE SB_GUILD SET type = @from_type, totype = @to_type, type_change_time = GETDATE() WHERE ID = @guild_dbid
	
	DECLARE @GT_NORMAL INT = 0
			, @GT_WAR INT = 1
			
	IF (@from_type = @GT_WAR AND @to_type = @GT_NORMAL) 
	BEGIN
		UPDATE SB_GUILD_MEMBER SET kill_count = 0, death_count = 0
		WHERE guildID = @guild_dbid
	END
END
GO
PRINT N'Creating [dbo].[SB_ChangeLookParameter]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_ChangeLookParameter]
	@user_id INT,
	@face INT,
	@body_color INT,
	@eye INT,
	@eye_color INT,
	@hair INT,
	@hair_color INT,
	@decal INT,
	@body_size INT,
	@leg_size INT,
	@head_size INT,
	@breast_size INT
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE [dbo].[SB_USER]
	SET face=@face, body_color=@body_color, eye=@eye, eye_color=@eye_color, hair=@hair, hair_color=@hair_color,
		decal=@decal, body_size=@body_size, leg_size=@leg_size, head_size=@head_size, breast_size=@breast_size
	WHERE ID=@user_id;

	SELECT @user_id;
END
GO
PRINT N'Creating [dbo].[sb_ChangeSpec]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ChangeSpec]
	@user_id	INT
	, @spec_id	TINYINT
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @SBC_TALENT_MAX INT = 3
		
	UPDATE SB_USER_INFO SET spec_id=@spec_id 
	WHERE ID=@user_id
	
	MERGE SB_USER_INFO_MULTI_SPEC WITH (HOLDLOCK) T
	USING (SELECT @user_id, @spec_id) AS S (user_id, spec_id)
		ON T.user_id = S.user_id AND T.spec_id = S.spec_id
	--WHEN MATCHED THEN
	--	UPDATE SET talent = S.talent
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_id, spec_id, talent) VALUES (@user_id, @spec_id, @SBC_TALENT_MAX)
	--OUTPUT $action, Inserted.*, Deleted.*
	;
END
GO
PRINT N'Creating [dbo].[SB_CheckCharName]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SB_CheckCharName]
	@char_name NVARCHAR(64)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT [job_type], [lev]
	FROM [dbo].[SB_USER] T1(READUNCOMMITTED)
		INNER JOIN [dbo].[SB_USER_INFO] T2(READUNCOMMITTED)
		ON T1.[ID] = T2.[ID]
	WHERE T1.[name] = @char_name
	
END
GO
PRINT N'Creating [dbo].[SB_CheckCharNameCHNNagging]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SB_CheckCharNameCHNNagging]
	@target_user_name NVARCHAR(64),
	@source_user_db_id int
AS
BEGIN
	SET NOCOUNT ON;

	--타겟의 이름으로 DBID를 가져오고 이를 키로 sb_buddy 에 source 가 있는 지 확인
	select buddy_id 
	from [dbo].[sb_buddy] (READUNCOMMITTED)
	where 
		user_id in (SELECT ID from [dbo].[SB_USER] (READUNCOMMITTED) where name = @target_user_name)
		and buddy_id = @source_user_db_id
	
END
GO
PRINT N'Creating [dbo].[sb_CheckCharNameInFollower]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_CheckCharNameInFollower]
	@source_user_db_id int,
	@target_user_name NVARCHAR(64)
	
AS
BEGIN
	SET NOCOUNT ON;

	IF NOT EXISTS ( SELECT [buddy_id]
				FROM [dbo].[SB_BUDDY] (READUNCOMMITTED)
				WHERE user_id in (SELECT ID from [dbo].[SB_USER] (READUNCOMMITTED) where name = @target_user_name)
					  and buddy_id = @source_user_db_id )
	BEGIN
		SET @target_user_name = NULL
	END
	
	SELECT [job_type], [lev]
	FROM [dbo].[SB_USER] T1(READUNCOMMITTED)
	INNER JOIN [dbo].[SB_USER_INFO] T2(READUNCOMMITTED)
	ON T1.[ID] = T2.[ID]
	WHERE T1.[name] = @target_user_name
END
GO
PRINT N'Creating [dbo].[SB_CleanGuildHistory]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_CleanGuildHistory]
	@seasonStartTime bigint
AS
BEGIN
	SET NOCOUNT ON;

	DELETE [dbo].[SB_GUILD_HISTORY] WHERE logTime < @seasonStartTime;

END
GO
PRINT N'Creating [dbo].[sb_CleanTrustSale]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_CleanTrustSale] 
	@DELETE_EXPIRE_DAY INT 
AS
BEGIN  
	SET NOCOUNT ON;  
	
	DECLARE @now DATETIME = GETDATE()
	DECLARE @expire_date DATETIME = DATEADD(DAY, -@DELETE_EXPIRE_DAY, @now)

	DECLARE @SS_ON_SALE INT = 0
	--DECLARE @SS_SOLD_OUT INT = 1
	DECLARE @SS_UNREGISTERED INT = 2
	DECLARE @SS_SELL_TRANSACTION INT = 3		
	
	
	DECLARE @tmp_unregistered TABLE
	(
		[ts_id] INT NOT NULL PRIMARY KEY
	); 
	
	DECLARE @tmp_expired TABLE
	(
		[ts_id] INT NOT NULL PRIMARY KEY
	) ; 
	
	-- change transaction
	UPDATE [dbo].[SB_TRUST_SALE] SET [status]=@SS_ON_SALE WHERE [status]=@SS_SELL_TRANSACTION
	
	-- insert unregisterd record to old table.
	INSERT INTO [dbo].[SB_TRUST_SALE_OLD]
		OUTPUT inserted.ts_id INTO @tmp_unregistered
		SELECT * FROM [dbo].[SB_TRUST_SALE] 
		WHERE [status]=@SS_UNREGISTERED;
		
	DELETE FROM [dbo].[SB_TRUST_SALE] 
		WHERE [ts_id] IN ( SELECT [ts_id] FROM @tmp_unregistered) ;
		
	DELETE FROM [dbo].[SB_TRUST_SALE_OLD]
		OUTPUT deleted.ts_id INTO @tmp_expired
		WHERE [expire_date] IS NULL
			OR
			  [expire_date] <= @expire_date;	
		
	DECLARE @unregistered_count AS BIGINT = 0;	
	DECLARE @expired_count AS BIGINT = 0;
	
	SELECT @unregistered_count = COUNT(*) FROM @tmp_unregistered;
	SELECT @expired_count = COUNT(*) FROM @tmp_expired;		
    
    SELECT @unregistered_count AS UnregisteredCount
        , @expired_count AS ExpiredCount
END
GO
PRINT N'Creating [dbo].[sb_CleanUpCool]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_CleanUpCool]
AS
BEGIN
	DECLARE @now BIGINT = CONVERT(BIGINT, dbo.ConvertToTimeT32(GETUTCDATE())) * 1000
	
    DELETE FROM SB_USER_SKILL_COOL WHERE cool_time < @now
    DELETE FROM SB_ITEM_COOL WHERE cool_time < @now
    DELETE FROM SB_USER_RECIPE_COOL WHERE cool_time < @now
END
GO
PRINT N'Creating [dbo].[SB_RemoveCharacter]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_RemoveCharacter]  
	@user_id INT
AS  
BEGIN  
	SET NOCOUNT ON;  

	UPDATE SB_USER
	SET deleted_time = GETDATE()
		, final_deleted = 'Y'
		, name = name + N'_' + CAST(account_id as NVARCHAR(20)) + N'_' + CAST(ID as NVARCHAR(20))
	WHERE ID = @user_id;

	
	DELETE FROM SB_BAN WHERE user_id = @user_id
	DELETE FROM SB_BAN WHERE ban_id = @user_id
	
	DELETE FROM SB_BUDDY WHERE user_id = @user_id
	DELETE FROM SB_BUDDY WHERE buddy_id = @user_id
END
GO
PRINT N'Creating [dbo].[SB_GuildDelegateMaster]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_GuildDelegateMaster]
	@guildID int,
	@newMasterID int,
	@oldMasterID int,
	@delegateTime int
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE SB_GUILD SET masterDBID = @newMasterID, 
			delegate_time = [dbo].ConvertToDateTime32(@delegateTime) 
	WHERE ID = @guildID
	
	UPDATE SB_GUILD_MEMBER SET grade = 1 
	WHERE guildID = @guildID AND memberDBID = @oldMasterID
	
	UPDATE SB_GUILD_MEMBER SET grade = 0 
	WHERE guildID = @guildID AND memberDBID = @newMasterID

END
GO
PRINT N'Creating [dbo].[SB_GuildDelete]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_GuildDelete]  
	@guildDBID int
AS  
BEGIN  
	SET NOCOUNT ON;
	
	UPDATE [dbo].SB_GUILD
	SET deleted = 1
		, name = name + N'_' + CAST(ID as NVARCHAR(12))		-- for reuse name
	WHERE ID = @guildDBID;
	
	DELETE SB_GUILD_WAR WHERE guildID = @guildDBID;
	DELETE SB_GUILD_NOTICE WHERE ID = @guildDBID;
END
GO
PRINT N'Creating [dbo].[SB_GuildDelMember]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_GuildDelMember]
	@guildID int,
	@memberID int
AS
BEGIN
	SET NOCOUNT ON;
	
	DELETE SB_GUILD_MEMBER WHERE guildID = @guildID AND memberDBID = @memberID
	
END
GO
PRINT N'Creating [dbo].[SB_CleanUpDeletingChar]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SB_CleanUpDeletingChar]  
	@DELETE_EXPIRE_DAY INT
AS  
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @before7days DATETIME = DATEADD(day, -@DELETE_EXPIRE_DAY, GETDATE())
	DECLARE @updated_list TABLE (ID INT NOT NULL, account_id BIGINT NOT NULL)
	DECLARE @updated_dbid INT
	DECLARE @updated_account_id BIGINT
	DECLARE @guild_id INT
	DECLARE @new_master_dbid INT
	DECLARE @now INT = dbo.ConvertToTimeT32(GETDATE())

	-- expired
	INSERT INTO @updated_list (ID, account_id)
	SELECT ID, account_id
	FROM SB_USER (READUNCOMMITTED)
	WHERE final_deleted = 'N'
		AND deleted_time IS NOT NULL
		AND deleted_time < @before7days

	-- batch (ex. channeling)
	INSERT INTO @updated_list (ID, account_id)
	SELECT ID, account_id
	FROM SB_USER (READUNCOMMITTED)
	WHERE account_id < 0
	
	
	DECLARE candidates CURSOR FOR
	SELECT ID, account_id
	FROM @updated_list
	
	OPEN candidates
	FETCH NEXT FROM candidates INTO @updated_dbid, @updated_account_id
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @updated_account_id < 0
		BEGIN
			UPDATE dbo.SB_USER
			SET account_id = -1 * account_id
			WHERE ID = @updated_dbid
		END
		
		SET @guild_id = ISNULL((SELECT guildID FROM dbo.SB_GUILD_MEMBER (READUNCOMMITTED) WHERE memberDBID = @updated_dbid), 0)
		IF @guild_id <> 0
		BEGIN
			-- if guild master then delegate to other
			IF EXISTS (SELECT * FROM dbo.SB_GUILD (READUNCOMMITTED) WHERE ID = @guild_id AND masterDBID = @updated_dbid)
			BEGIN
				SET @new_master_dbid = ISNULL((SELECT TOP 1 memberDBID FROM dbo.SB_GUILD_MEMBER (READUNCOMMITTED) WHERE guildID = @guild_id AND memberDBID <> @updated_dbid ORDER BY grade), 0)
				IF @new_master_dbid <> 0
				BEGIN
					EXEC dbo.SB_GuildDelegateMaster @guild_id, @new_master_dbid, @updated_dbid, @now
					EXEC dbo.SB_GuildDelMember @guild_id, @updated_dbid
				END
				ELSE
				BEGIN
					EXEC dbo.SB_GuildDelMember @guild_id, @updated_dbid
					EXEC dbo.SB_GuildDelete @guild_id
				END
			END
			-- if just member then expel
			ELSE
			BEGIN
				EXEC dbo.SB_GuildDelMember @guild_id, @updated_dbid
			END
		END
		
		EXEC SB_ArenaTeamMemberCleanUp @updated_dbid

		EXEC SB_RemoveCharacter @updated_dbid
		
		FETCH NEXT FROM candidates INTO @updated_dbid, @updated_account_id
	END
	
	CLOSE candidates
	DEALLOCATE candidates
		
	SELECT * FROM @updated_list
END
GO
PRINT N'Creating [dbo].[sb_CleanUpExpiredItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_CleanUpExpiredItem] 
    @DELETE_EXPIRE_DAY INT
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @now DATETIME = GETDATE()
	DECLARE @expire_date DATETIME = DATEADD(DAY, -@DELETE_EXPIRE_DAY, @now)
	
	UPDATE [dbo].[SB_ITEM]
	SET [is_deleted] = 1
		, [delete_date] = @now
	WHERE [bag_id] = -3
           AND [is_deleted] = 0
	
	DECLARE @_tmp_candidate_for_deleting_item_ TABLE
	(
		[ID] BIGINT NOT NULL PRIMARY KEY
	) ;   
	
	INSERT INTO @_tmp_candidate_for_deleting_item_ (ID)
	SELECT ID
	FROM [dbo].[SB_ITEM] (READUNCOMMITTED)
	WHERE [is_deleted] = 1 AND [delete_date] <= @expire_date
    
    DELETE FROM [dbo].[SB_ITEM_DURATION]
    WHERE [item_dbid] in (SELECT [ID] FROM @_tmp_candidate_for_deleting_item_)
    
    DELETE FROM [dbo].[SB_ITEM_EQUIPMENT]
    WHERE [ID] in (SELECT [ID] FROM @_tmp_candidate_for_deleting_item_)
    
    DELETE FROM [dbo].[SB_ITEM_GEM]
    WHERE [ID] in (SELECT [ID] FROM @_tmp_candidate_for_deleting_item_)
    
    DELETE FROM [dbo].[SB_ITEM_POSSESSION]
    WHERE [item_dbid] in (SELECT [ID] FROM @_tmp_candidate_for_deleting_item_)
    
    DELETE FROM [dbo].[SB_ITEM_RANDOM_ABILITY]
    WHERE [ID] in (SELECT [ID] FROM @_tmp_candidate_for_deleting_item_)
    
    DELETE FROM [dbo].[SB_ITEM_RANDOM_ABILITY_UNDECIDED]
    WHERE [ID] in (SELECT [ID] FROM @_tmp_candidate_for_deleting_item_)
    
    DELETE FROM [dbo].[SB_ITEM_REINFORCEMENT]
    WHERE [ID] in (SELECT [ID] FROM @_tmp_candidate_for_deleting_item_)    
    
    DELETE FROM [dbo].[SB_ITEM_RUNE]
    WHERE [ID] in (SELECT ID FROM @_tmp_candidate_for_deleting_item_)
    
    DELETE FROM [dbo].[SB_ITEM]
    WHERE [ID] in (SELECT [ID] FROM @_tmp_candidate_for_deleting_item_)
    
    DECLARE @expired_count AS BIGINT = 0;
    SELECT @expired_count = COUNT(*)   FROM @_tmp_candidate_for_deleting_item_;
    SELECT @expired_count AS ExpiredCount;
END
GO
PRINT N'Creating [dbo].[sb_CleanUpExpiredPost]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_CleanUpExpiredPost]
	@normal_post_expiration_period		INT,
	@sys_post_expiration_period			INT	
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @now DATETIME
	DECLARE @normal_expired_date		DATETIME
	DECLARE @sys_expired_date			DATETIME
	
	SET @now = GETDATE()
	SET @normal_expired_date			= DATEADD(DAY, -@normal_post_expiration_period, @now)
	SET @sys_expired_date				= DATEADD(DAY, -@sys_post_expiration_period, @now)
	
	DECLARE @expired_post_list TABLE (ID int)
	
	-- Collect expired post list
	INSERT INTO @expired_post_list (ID) 
		SELECT ID FROM [dbo].[SB_POST_BOX] (READUNCOMMITTED) 
		WHERE 
			([send_time] <= @normal_expired_date AND sender_type IN (1,2)) OR
			([send_time] <= @sys_expired_date    AND sender_type IN (3,4)) OR
			[delete_time] IS NOT NULL;
	
	-- Move expired post to expired post table.
	INSERT INTO [dbo].[SB_POST_BOX_EXPIRED](ID, sender_type, sender_dbid, sender_name, recipient_dbid, recipient_name, title, text, attached_money, attached_item_type, send_time, open_time, delete_time, take_attached_time, blocked)
		SELECT ID, sender_type, sender_dbid, sender_name, recipient_dbid, recipient_name, title, text, attached_money, attached_item_type, send_time, open_time, delete_time, take_attached_time, blocked
		FROM [dbo].[SB_POST_BOX] 
		WHERE ID IN (SELECT ID FROM @expired_post_list)
		
	INSERT INTO [dbo].[SB_POST_ATTACHED_ITEM_EXPIRED] (post_id, item_key, item_amount)	
		SELECT post_id, item_key, item_amount 
		FROM [dbo].[SB_POST_ATTACHED_ITEM] 
		WHERE post_id IN (SELECT ID FROM @expired_post_list)	
	
	-- Delete expired post from post box.
	DELETE FROM [dbo].[SB_POST_BOX] WHERE ID IN (SELECT ID FROM @expired_post_list)
	DELETE FROM [dbo].[SB_POST_ATTACHED_ITEM] WHERE post_id IN (SELECT ID FROM @expired_post_list)

END
GO
PRINT N'Creating [dbo].[sb_CountTelPoint]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_CountTelPoint]
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT COUNT(*)
	FROM dbo.SB_TELEPORT_POINT (READUNCOMMITTED)
END
GO
PRINT N'Creating [dbo].[SB_CreateAccount]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_CreateAccount]
	@name NVARCHAR(64)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO SB_ACCOUNT (name) VALUES (@name);
	
	SELECT @@IDENTITY;
END
GO
PRINT N'Creating [dbo].[SB_InitUserEquipped]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_InitUserEquipped]
	-- Add the parameters for the stored procedure here  
	@user_id INT,
	@weapon INT,
	@head int,
	@upper int,
	@glove int,
	@lower int,
	@foot int,
	@special int,
	@left_ring int,
	@right_ring int,
	@necklace int,
	@earring int,
	@bracelet int,
	@belt int,
	@inner int,
	@soul_accessory int,
	@corsage1 int,
	@corsage2 int,
	@costume int,
	@special_equip int,
	@seal_stone	int,
	@pet_tool int
AS  
BEGIN  
	SET NOCOUNT ON
	
	IF @weapon != 0
		BEGIN
			INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index)
			VALUES (@user_id, -1, @weapon, 1, 0)
		END

	IF @head != 0
		BEGIN
			INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index)
			VALUES (@user_id, -1, @head , 1, 1)
		END
		
	IF @upper != 0
		BEGIN	
			INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index)
			VALUES (@user_id, -1, @upper , 1, 2)
		END
		
	IF @glove != 0
		BEGIN
			INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index)
			VALUES (@user_id, -1, @glove , 1, 3)
	END
	
	IF @lower != 0
		BEGIN
			INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index)
			VALUES (@user_id, -1, @lower , 1, 4)
		END
	
	IF @foot != 0
		BEGIN
			INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index)
			VALUES (@user_id, -1, @foot , 1, 5)
		END
		
	IF @special != 0
		BEGIN		
			INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index)
			VALUES (@user_id, -1, @special , 1, 6)
		END
		
	IF @left_ring != 0
		BEGIN
			INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index)
			VALUES (@user_id, -1, @left_ring , 1, 7)
		END
		
	IF @right_ring != 0
		BEGIN
			INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index)
			VALUES (@user_id, -1, @right_ring , 1, 8)
		END
		
	IF @necklace != 0
		BEGIN	
			INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index)
			VALUES (@user_id, -1, @necklace , 1, 9)
		END
		
	IF @earring != 0
		BEGIN		
			INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index)
			VALUES (@user_id, -1, @earring , 1, 10)
		END
		
	IF @bracelet != 0
		BEGIN		
			INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index)
			VALUES (@user_id, -1, @bracelet , 1, 11)
		END
		
	IF @belt != 0
		BEGIN		
			INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index)
			VALUES (@user_id, -1, @belt , 1, 12)
		END
		
	IF @inner != 0
		BEGIN		
			INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index)
			VALUES (@user_id, -1, @inner  , 1, 13)
		END
		
	IF @soul_accessory != 0
		BEGIN		
			INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index)
			VALUES (@user_id, -1, @soul_accessory  , 1, 14)
		END
		
	IF @corsage1 != 0
		BEGIN		
			INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index)
			VALUES (@user_id, -1, @corsage1  , 1, 15)
		END

	IF @corsage2 != 0
		BEGIN		
			INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index)
			VALUES (@user_id, -1, @corsage2 , 1, 16)
		END
	
	IF @costume != 0
		BEGIN
			INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index)
			VALUES (@user_id, -1, @costume, 1, 17)
		END
		
	IF @special_equip != 0
		BEGIN
			INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index)
			VALUES (@user_id, -1, @special_equip, 1, 18)
		END

	IF @seal_stone != 0
		BEGIN
			INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index)
			VALUES (@user_id, -1, @seal_stone, 1, 19)
		END

	IF @pet_tool != 0
		BEGIN
			INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index)
			VALUES (@user_id, -1, @pet_tool, 1, 20)
		END
END
GO
PRINT N'Creating [dbo].[sb_CreateUser]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_CreateUser]
	@user_id		INT,
	@account_id     BIGINT,
	@job_type       SMALLINT,
	@name           NVARCHAR(64),
	@face           INT,
	@body_color     INT,
	@eye            INT,
	@eye_color      INT,
	@hair           INT,
	@hair_color     INT,
	@decal          INT,
	@body_size      INT,
	@leg_size       INT,
	@head_size      INT,
	@breast_size	INT,
	@hide_special   BIT,
	@hide_corsage1  BIT,
	@hide_corsage2  BIT,
	@hide_costume   BIT,
	@hide_special_equip BIT,
	@coord          BIGINT,
	@x              FLOAT,
	@y              FLOAT,
	@z              FLOAT,
	@yaw            INT,
	@inn            INT,
	@lev            INT,
	@exp            INT,
	@hp             INT,
	@energy         INT,
	@cp             INT,
	@money          BIGINT,
	@satiety        INT,
	@weapon         INT,
	@head           INT,
	@upper          INT,
	@glove          INT,
	@lower          INT,
	@foot           INT,
	@special        INT,
	@left_ring      INT,
	@right_ring     INT,
	@necklace       INT,
	@earring        INT,
	@bracelet       INT,
	@belt           INT,
	@inner          INT,
	@soul_accessory INT,
	@corsage1       INT,
	@corsage2       INT,
	@costume        INT,
	@special_equip	INT,
	@seal_stone		INT,
	@pet_tool		INT,
	@builder_lev	INT,
	@t_skill_build  IDLevKeyTable READONLY,
	@t_short_cut    ShortCutTable READONLY,
	@t_item_list	ItemParam READONLY
AS
BEGIN
	SET NOCOUNT ON;
	
	--const
	DECLARE @DEFAULT_SPEC_ID TINYINT = 0
		, @SBC_TALENT_MAX INT = 3
		
	INSERT INTO SB_USER (ID, account_id, job_type, name, face, body_color, eye, eye_color, hair, hair_color, decal, body_size, leg_size, head_size, title_id, breast_size) 
	VALUES (@user_id, @account_id, @job_type, @name, @face, @body_color, @eye, @eye_color, @hair, @hair_color, @decal, @body_size, @leg_size, @head_size, -1, @breast_size);
	
	--DECLARE @builder_lev INT
	--SET @builder_lev = 0
	
	--SELECT @builder_lev = builder_lev FROM SB_BUILDER_ACCOUNT (READUNCOMMITTED) WHERE id = @account_id

	INSERT INTO SB_USER_AVATAR_ITEM(ID, hide_special, hide_corsage1, hide_corsage2, hide_costume, hide_special_equip)
	VALUES (@user_id, @hide_special, @hide_corsage1, @hide_corsage2, @hide_costume, @hide_special_equip)
	
	INSERT INTO SB_USER_INFO (ID, lev, exp, energy, hp, cp, money, satiety, builder_lev, spec_id)
	VALUES (@user_id, @lev, @exp, @energy, @hp, @cp, @money, @satiety, @builder_lev, @DEFAULT_SPEC_ID);
	
	INSERT INTO SB_USER_LEVELUP_HISTORY(ID, lev, play_time) 
	VALUES (@user_id, 1, 0)
	
	INSERT INTO SB_INN (ID, inn_id) 
	VALUES (@user_id, @inn)
	
	INSERT INTO SB_USER_POS(ID, area_id, region_id, resource_id, grid_x, grid_y, grid_z, reserved, x, y, z, yaw)
	VALUES (@user_id, 
		(@coord & 0xff00000000000000) / 0xffffffffffffff, 
		(@coord & 0xff000000000000) / 0xffffffffffff, 
		(@coord & 0xffff00000000) / 0xffffffff, 
		(@coord & 0xff000000) / 0xffffff, 
		(@coord & 0xff0000) / 0xffff, 
		(@coord & 0xff00) / 0xff, 
		(@coord & 0xff), 
		@x, @y, @z, @yaw);
	
	INSERT INTO SB_USER_POS_VALID(user_id, area_id, region_id, resource_id, grid_x, grid_y, grid_z, reserved, x, y, z, yaw)
	VALUES (@user_id, 
		(@coord & 0xff00000000000000) / 0xffffffffffffff, 
		(@coord & 0xff000000000000) / 0xffffffffffff, 
		(@coord & 0xffff00000000) / 0xffffffff, 
		(@coord & 0xff000000) / 0xffffff, 
		(@coord & 0xff0000) / 0xffff, 
		(@coord & 0xff00) / 0xff, 
		(@coord & 0xff), 
		@x, @y, @z, @yaw);
		
	INSERT INTO SB_USER_POS_REVIVE(user_id, area_id, region_id, resource_id, grid_x, grid_y, grid_z, reserved, x, y, z, yaw)
	VALUES (@user_id, 
		(@coord & 0xff00000000000000) / 0xffffffffffffff, 
		(@coord & 0xff000000000000) / 0xffffffffffff, 
		(@coord & 0xffff00000000) / 0xffffffff, 
		(@coord & 0xff000000) / 0xffffff, 
		(@coord & 0xff0000) / 0xffff, 
		(@coord & 0xff00) / 0xff, 
		(@coord & 0xff), 
		@x, @y, @z, @yaw);
	
	
	INSERT INTO SB_USER_LIFE (ID) 
	VALUES (@user_id);
	
	INSERT INTO SB_USER_CORPSE (master_id)
	VALUES (@user_id);

	INSERT INTO SB_USER_DUNGEON(ID, DUNGEON_LEVEL, DUNGEON_LEVEL_EX, DUNGEON_RAID_LEVEL)
	VALUES (@user_id, 0, 1, 0);
	
	EXEC dbo.sb_InitUserEquipped @user_id, @weapon, @head, @upper, @glove, @lower,
								@foot, @special, @left_ring, @right_ring, @necklace,
								@earring, @bracelet, @belt, @inner, @soul_accessory, 
								@corsage1, @corsage2, @costume, @special_equip, @seal_stone, @pet_tool;
	
	INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index)
		SELECT @user_id, bag_dbid, class_id, amount, slot_index FROM @t_item_list
	
	INSERT INTO SB_USER_INFO_MULTI_SPEC (user_id, spec_id, talent)
		SELECT @user_id, @DEFAULT_SPEC_ID, @SBC_TALENT_MAX
		
	INSERT INTO SB_USER_SKILL (ID, skill_id, skill_level, spec_id)
		SELECT @user_id, skill_id, MAX(skill_level), @DEFAULT_SPEC_ID FROM @t_skill_build GROUP BY skill_id

	INSERT INTO SB_SHORT_CUT (user_id, slot_no, reg_type, reg_id, spec_id)
		SELECT @user_id, slot_no, reg_type, reg_id, @DEFAULT_SPEC_ID FROM @t_short_cut
		
	INSERT INTO SB_USER_WAREHOUSE (owner_dbid, available_slot_count, [money])
	VALUES (@user_id, 1, 0);
	
	INSERT INTO SB_USER_FATIGUE (user_id, fatigue, last_reset_time)
	VALUES (@user_id, 0, dbo.ConvertToDateTime32(0));

	SELECT @user_id, 1, [dbo].ConvertToTimeT32((SELECT created_time FROM SB_USER (READUNCOMMITTED) WHERE ID = @user_id));

	INSERT INTO SB_USER_MONTHLY_SUBSCRIPTION(USER_DB_ID, last_provided_basis_time, activated_subscription_time, expired_subscription_time)
	VALUES (@user_id, dbo.ConvertToDateTime32(0), dbo.ConvertToDateTime32(0),dbo.ConvertToDateTime32(0));
END
GO
PRINT N'Creating [dbo].[SB_CreateAll]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_CreateAll]
	@account_id NVARCHAR(64),
	@name NVARCHAR(64)
AS
BEGIN
	SET NOCOUNT ON;
    
	EXEC dbo.SB_CreateAccount @account_id
	
	DECLARE @id INT
	SELECT TOP 1 @id = ID FROM dbo.SB_ACCOUNT (READUNCOMMITTED) WHERE name = @account_id
	EXEC dbo.SB_CreateUser @id, 2, @name
END
GO
PRINT N'Creating [dbo].[sb_CreateSpec]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_CreateSpec]
	@user_id	INT
	, @spec_id	TINYINT
	, @t_skill_build  IDLevKeyTable READONLY
	, @t_short_cut    ShortCutTable READONLY
AS
BEGIN
	SET NOCOUNT ON;
	
	EXEC sb_ChangeSpec @user_id, @spec_id
	
	INSERT INTO SB_USER_SKILL (ID, skill_id, skill_level, spec_id)
		SELECT @user_id, skill_id, MAX(skill_level), @spec_id FROM @t_skill_build GROUP BY skill_id

	INSERT INTO SB_SHORT_CUT (user_id, slot_no, reg_type, reg_id, spec_id)
		SELECT @user_id, slot_no, reg_type, reg_id, @spec_id FROM @t_short_cut		
END
GO
PRINT N'Creating [dbo].[SB_DeclareGuildWar]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_DeclareGuildWar]  
 @guildID int, 
 @targetGuildID int,
 @time bigint
AS  
BEGIN  
	SET NOCOUNT ON
	
	INSERT INTO 
		[dbo].[SB_GUILD_WAR](guildID, targetGuildID, in_progress, declared, declare_time, kill_count, death_count)
		VALUES(@guildID, @targetGuildID, 0, 1, [dbo].ConvertToDateTime32(@time), 0, 0);
	
	INSERT INTO 
		[dbo].[SB_GUILD_WAR](guildID, targetGuildID, in_progress, declared, declare_time, kill_count, death_count)
		VALUES(@targetGuildID, @guildID, 0, 0, [dbo].ConvertToDateTime32(@time), 0, 0);
	
END
GO
PRINT N'Creating [dbo].[SB_DecreaseBuffRemainTime]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SB_DecreaseBuffRemainTime]
	@user_id int
	, @decrease_time int
AS
BEGIN
	SET NOCOUNT ON
	
	UPDATE SB_USER_BUFF
	SET remain_time = remain_time - @decrease_time
	WHERE [user_id] = @user_id
		AND [remain_time] > 0
END
GO
PRINT N'Creating [dbo].[sb_DecreaseEventRemainTime]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_DecreaseEventRemainTime]
	@user_id int,
	@decrease_time int
AS
BEGIN
	UPDATE SB_USER_EVENT_COOL
	SET remain_time = CASE 
						WHEN remain_time - @decrease_time > 0 THEN remain_time - @decrease_time
						ELSE 0
					  END
	WHERE [user_id] = @user_id
	AND [remain_time] > 0
END
GO
PRINT N'Creating [dbo].[SB_DeleteAnnounce]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SB_DeleteAnnounce]
	-- Add the parameters for the stored procedure here
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE sb_announce WHERE id = @id
END
GO
PRINT N'Creating [dbo].[sb_DeleteAttendanceReward]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_DeleteAttendanceReward]
	  @user_id         INT,
	  @attendance_time INT,
	  @receipt_method  INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @db_attendance_time DATETIME = [dbo].ConvertToDateTime32(@attendance_time);
	
	UPDATE [dbo].[SB_USER_ATTENDANCE_REWARD]
	SET
		  [receipt_time] = GETDATE()
		, [receipt_method] = @receipt_method
	OUTPUT
		  DELETED.[item_class_id] AS item_class_id
		, DELETED.[item_amount] AS item_amount
		, @attendance_time AS attendance_time
	WHERE
		[user_id] = @user_id
		AND [attendance_time] = @db_attendance_time
		AND [receipt_time] IS NULL
	;
END
GO
PRINT N'Creating [dbo].[SB_DeleteBoundDungeonSequence]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SB_DeleteBoundDungeonSequence]
	@UserDBID int,
	@DungeonClassID int
AS
BEGIN
	SET NOCOUNT ON;

    DELETE FROM
		[dbo].SB_USER_BOUND_DUNGEON
	WHERE user_db_id = @UserDBID and dungeon_class_id = @DungeonClassID
END
GO
PRINT N'Creating [dbo].[SB_DeleteCharacter]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_DeleteCharacter]  
	@user_id INT
AS  
BEGIN  
	SET NOCOUNT ON;  

	DECLARE @now DATETIME = GETDATE()
	
	UPDATE SB_USER
	SET deleted_time = @now
	WHERE ID = @user_id;
	
	SELECT dbo.ConvertToTimeT32(@now)
END
GO
PRINT N'Creating [dbo].[SB_DeleteCharacterForBatch]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SB_DeleteCharacterForBatch]
	@account_id BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE SB_USER
	SET account_id = -1 * account_id
	WHERE account_id = @account_id
		AND deleted_time IS NULL
		
	SELECT @@ROWCOUNT
END
GO
PRINT N'Creating [dbo].[sb_DeleteEventCool]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_DeleteEventCool]
	@user_id int,
	@cool_id int
AS
BEGIN
	SET NOCOUNT ON
	
	DELETE FROM SB_USER_EVENT_COOL
	WHERE [user_id] = @user_id AND [cool_id] = @cool_id
END
GO
PRINT N'Creating [dbo].[SB_DeleteExpiredGift]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_DeleteExpiredGift]
	@user_dbid INT
	, @gift_type INT
	, @day_to_expire INT
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @now DATETIME = GETDATE()
	DECLARE @time_to_expire DATETIME = DATEADD(SECOND, -@day_to_expire, @now)
	
	UPDATE [dbo].[SB_SHOP_GIFT_BOX]
	SET [delete_date] = @now
	WHERE [recipient_dbid] = @user_dbid
		AND [gift_type] = @gift_type
		AND [send_date] < @time_to_expire
		AND [delete_date] IS NULL
END
GO
PRINT N'Creating [dbo].[SB_DeleteGift]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SB_DeleteGift]
	@user_dbid INT
	, @gift_id BIGINT
AS
BEGIN
	SET NOCOUNT ON
	
	UPDATE [dbo].[SB_SHOP_GIFT_BOX]
	SET [delete_date] = GETDATE()
	WHERE [ID] = @gift_id
		AND [recipient_dbid] = @user_dbid
		
	SELECT @@ROWCOUNT
END
GO
PRINT N'Creating [dbo].[sb_DeleteGuildFriendship]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_DeleteGuildFriendship] 	
	@guild_dbid_from INT,
	@guild_dbid_to   INT
AS  
BEGIN
	SET NOCOUNT ON

	DELETE FROM dbo.SB_GUILD_FRIENDSHIP 
		WHERE 
			guild_dbid_from = @guild_dbid_from
			AND
			guild_dbid_to = @guild_dbid_to;
END
GO
PRINT N'Creating [dbo].[sb_DeleteINN]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_DeleteINN]  
 @user_id int
AS  
BEGIN  
 SET NOCOUNT ON  
    
 DELETE FROM SB_INN WHERE ID = @user_id
 
END
GO
PRINT N'Creating [dbo].[sb_DeleteItemRandomAbility]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_DeleteItemRandomAbility]
	@item_dbid bigint
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM dbo.SB_ITEM_RANDOM_ABILITY WHERE ID = @item_dbid 
	DELETE FROM dbo.SB_ITEM_RANDOM_ABILITY_UNDECIDED WHERE ID = @item_dbid 

	UPDATE dbo.SB_ITEM_EQUIPMENT
	SET estimated = 0
		, reestimated = 0
	WHERE ID = @item_dbid
END
GO
PRINT N'Creating [dbo].[SB_DeletePost]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_DeletePost]
	@user_dbid INT
	, @post_id INT
AS
BEGIN
	SET NOCOUNT ON
	
	UPDATE SB_POST_BOX
	SET delete_time = GETDATE()
	WHERE ID = @post_id
		AND recipient_dbid = @user_dbid
		
	SELECT @@ROWCOUNT
END
GO
PRINT N'Creating [dbo].[SB_DeleteQuest]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_DeleteQuest]
	@user_id int,
	@quest_id int
AS
BEGIN
	SET NOCOUNT ON;
	
	IF @quest_id = -1
	BEGIN
		DELETE FROM SB_USER_QUEST_PROGRESS
		WHERE user_id = @user_id 
				
		DELETE FROM SB_USER_QUEST 
		WHERE user_id = @user_id 
		
	END
	ELSE 
	BEGIN
		DELETE FROM SB_USER_QUEST
		WHERE user_id = @user_id AND quest_id = @quest_id
		
		DELETE FROM SB_USER_QUEST_PROGRESS
		WHERE user_id = @user_id AND quest_id = @quest_id
	END
END
GO
PRINT N'Creating [dbo].[sb_DeleteShortCut]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_DeleteShortCut]
	@user_id INT
	, @spec_id TINYINT
	, @slot_no TINYINT
AS
BEGIN
	SET NOCOUNT ON;

	DELETE SB_SHORT_CUT 
	WHERE user_id = @user_id 
		AND slot_no = @slot_no
		AND spec_id = @spec_id	
END
GO
PRINT N'Creating [dbo].[sb_DeleteSkill]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_DeleteSkill]
	@user_id INT
	, @spec_id TINYINT
	, @skill_id INT
AS
BEGIN
	SET NOCOUNT ON
	
	DELETE FROM SB_USER_SKILL
	WHERE ID = @user_id
		AND spec_id = @spec_id
		AND skill_id = @skill_id
END
GO
PRINT N'Creating [dbo].[sb_DeleteSkillTrigger]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_DeleteSkillTrigger]
	@user_id INT
	, @spec_id TINYINT
	, @trigger_id INT
AS
BEGIN
	SET NOCOUNT ON
	
	DELETE FROM SB_USER_SKILL_TRIGGER
	WHERE ID = @user_id
		AND trigger_id = trigger_id
		AND spec_id = @spec_id
END
GO
PRINT N'Creating [dbo].[sb_DeleteUserDungeonBindInit]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_DeleteUserDungeonBindInit]
	@user_db_id int,
	@init_id int
AS
BEGIN
	SET NOCOUNT ON
	
	DELETE FROM SB_USER_DUNGEON_BIND_INIT WHERE user_db_id = @user_db_id and init_id = @init_id
END
GO
PRINT N'Creating [dbo].[sb_DeleteUserDungeonTicket]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_DeleteUserDungeonTicket]
	@user_db_id int,
	@ticket_id int
AS
BEGIN
	SET NOCOUNT ON
	
	DELETE FROM SB_USER_DUNGEON_TICKET WHERE user_db_id = @user_db_id and ticket_id = @ticket_id
END
GO
PRINT N'Creating [dbo].[sb_DelTelPoint]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_DelTelPoint]
	@name NVARCHAR(256)
AS
BEGIN
	SET NOCOUNT ON;
	
	DELETE
	FROM dbo.SB_TELEPORT_POINT
	WHERE name = @name
	
	SELECT @@ROWCOUNT
END
GO
PRINT N'Creating [dbo].[sb_drop_constraint]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_drop_constraint]
(
	@table_name NVARCHAR(64),
	@column_name NVARCHAR(64),
	@column_default NVARCHAR(64) = '',
	@is_debug INT = 0
)
AS
BEGIN
	--DROP CONSTRAINT WITHOUT NAME
	DECLARE @command NVARCHAR(MAX) = ''
	SELECT @command = 'ALTER TABLE ' + @table_name + ' DROP CONSTRAINT ' + d.name + CHAR(10) + CHAR(13)
	FROM sys.tables t
		INNER JOIN sys.default_constraints d ON d.parent_object_id=t.object_id
		INNER JOIN sys.columns c ON c.object_id = t.object_id AND c.column_id = d.parent_column_id
	WHERE t.name = @table_name
		AND c.name = @column_name

	IF(@is_debug = 0)
		EXECUTE(@command)
	ELSE
		PRINT(@command)
	
	IF(LEN(@column_default) > 0)
	BEGIN
		DECLARE @sql NVARCHAR(MAX)
			, @df_name NVARCHAR(128) = 'DF_' + @table_name + '_' + @column_name
		
		--ALTER TABLE SB_TRUST_SALE ADD CONSTRAINT DF_SB_TRUST_SALE_blocked DEFAULT(0) FOR blocked
		SET @sql = 'ALTER TABLE ' + @table_name + ' ADD CONSTRAINT ' + @df_name + ' ' + @column_default + ' FOR ' + @column_name
		IF(@is_debug = 0)
			EXECUTE(@sql)
		ELSE
			PRINT(@sql)
	END
END
GO
PRINT N'Creating [dbo].[sb_DuelArenaLoad]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_DuelArenaLoad]
	@season_no INT,
	@week_no INT,
	@user_dbid INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT ISNULL(season_win, 0), ISNULL(season_lose, 0), ISNULL(season_draw, 0), ISNULL(season_win_in_row, 0), ISNULL(season_lose_in_row, 0), ISNULL(season_elo, 1200)
	, ISNULL(W.week_win, 0), ISNULL(W.week_lose, 0), ISNULL(W.week_draw, 0)	
	FROM SB_DUEL_ARENA (READUNCOMMITTED) A
		LEFT JOIN 
		SB_DUEL_ARENA_WEEK (READUNCOMMITTED) W
			ON W.user_dbid = A.user_dbid AND W.season_no = A.season_no AND W.week_no = @week_no
	WHERE A.user_dbid = @user_dbid AND A.season_no = @season_no	
END
GO
PRINT N'Creating [dbo].[sb_DuelArenaSave]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_DuelArenaSave]
	@season_no INT,
	@week_no INT,
	@user_dbid INT,
	@win_delta INT, 
	@lose_delta INT, 
	@draw_delta INT, 
	@win_in_row_delta INT, 
	@lose_in_row_delta INT, 
	@elo_delta INT
AS
BEGIN
	SET NOCOUNT ON;
	
	MERGE SB_DUEL_ARENA A
	USING 
		(SELECT @user_dbid, @season_no, @win_delta, @lose_delta, @draw_delta, @win_in_row_delta, @lose_in_row_delta, @elo_delta) 
			AS T (user_dbid, season_no, season_win, season_lose, season_draw, season_win_in_row, season_lose_in_row, season_elo)
		ON A.user_dbid = T.user_dbid AND A.season_no = T.season_no
	WHEN MATCHED THEN
		UPDATE 
		SET
			A.season_win = A.season_win + T.season_win,
			A.season_lose = A.season_lose + T.season_lose,
			A.season_draw = A.season_draw + T.season_draw,
			A.season_win_in_row = A.season_win_in_row + T.season_win_in_row,
			A.season_lose_in_row = A.season_lose_in_row + T.season_lose_in_row,
			A.season_elo = A.season_elo + T.season_elo
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (season_no, user_dbid, season_win, season_lose, season_draw, season_win_in_row, season_lose_in_row, season_elo)
		VALUES (T.season_no, T.user_dbid, T.season_win, T.season_lose, T.season_draw, T.season_win_in_row, T.season_lose_in_row, 1200 + T.season_elo)
	;
	
	MERGE SB_DUEL_ARENA_WEEK W
	USING	
		(SELECT @user_dbid, @season_no, @week_no, @win_delta, @lose_delta, @draw_delta) 
			AS T (user_dbid, season_no, week_no, week_win, week_lose, week_draw)
		ON W.user_dbid = T.user_dbid AND W.season_no = T.season_no AND W.week_no = T.week_no
	WHEN MATCHED THEN
		UPDATE 
		SET
			W.week_win = W.week_win + T.week_win,
			W.week_lose = W.week_lose + T.week_lose,
			W.week_draw = W.week_draw + T.week_draw
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_dbid, season_no, week_no, week_win, week_lose, week_draw)
		VALUES (T.user_dbid, T.season_no, T.week_no, T.week_win, T.week_lose, T.week_draw)
	;
		
END
GO
PRINT N'Creating [dbo].[sb_DuelArenaSaveDetail]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_DuelArenaSaveDetail]
	@season_no INT,
	@user_dbid INT,
	@job_type INT,
	@talent_type INT,
	@enemy_job_type INT,
	@enemy_talent_type INT,
	@win_delta INT, 
	@lose_delta INT, 
	@draw_delta INT
AS
BEGIN
	SET NOCOUNT ON;
	
	MERGE SB_DUEL_ARENA_DETAIL D
	USING 
		(SELECT @user_dbid, @season_no, @job_type, @talent_type, @enemy_job_type, @enemy_talent_type, @win_delta, @lose_delta, @draw_delta) 
			AS T (user_dbid, season_no, job_type, talent_type, enemy_job_type, enemy_talent_type, season_win, season_lose, season_draw)
		ON D.user_dbid = T.user_dbid AND D.season_no = T.season_no AND 
			D.job_type = T.job_type AND D.talent_type = T.talent_type AND
			D.enemy_job_type = T.enemy_job_type AND D.enemy_talent_type = T.enemy_talent_type
	WHEN MATCHED THEN
		UPDATE 
		SET
			D.season_win = D.season_win + T.season_win,
			D.season_lose = D.season_lose + T.season_lose,
			D.season_draw = D.season_draw + T.season_draw
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_dbid, season_no, job_type, talent_type, enemy_job_type, enemy_talent_type, season_win, season_lose, season_draw)
		VALUES (T.user_dbid, T.season_no, T.job_type, T.talent_type, T.enemy_job_type, T.enemy_talent_type, T.season_win, T.season_lose, T.season_draw)
	;
END
GO
PRINT N'Creating [dbo].[sb_DuelArenaSeasonRecordReset]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_DuelArenaSeasonRecordReset]
	@season_no INT,
	@user_dbid INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DELETE FROM SB_DUEL_ARENA
	WHERE user_dbid = @user_dbid AND season_no = @season_no
	
	DELETE FROM SB_DUEL_ARENA_WEEK
	WHERE user_dbid = @user_dbid AND season_no = @season_no
		
END
GO
PRINT N'Creating [dbo].[sb_UpdateMoney]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_UpdateMoney]
	@owner_id INT,
	@money BIGINT
AS  
BEGIN  
	SET NOCOUNT ON;  

	UPDATE SB_USER_INFO SET money += @money 
		OUTPUT inserted.money
	WHERE ID = @owner_id

	--SELECT money FROM SB_USER_INFO (READUNCOMMITTED) WHERE ID = @owner_id

END
GO
PRINT N'Creating [dbo].[SB_ExpandWarehouseSlot]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_ExpandWarehouseSlot]
	@owner_dbid INT
	, @money BIGINT
AS
BEGIN
	SET NOCOUNT ON

    UPDATE SB_USER_WAREHOUSE
    SET available_slot_count = available_slot_count + 1
    WHERE owner_dbid = @owner_dbid
    
    EXEC dbo.SB_UpdateMoney @owner_dbid, @money
END
GO
PRINT N'Creating [dbo].[sb_ExtendPetPeriod]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ExtendPetPeriod]
	@user_dbid INT,
	@pet_dbid INT,
	@minutes_to_expire INT
AS  
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @expired_date DATETIME = NULL
	
	IF 0 < @minutes_to_expire
	BEGIN
		SELECT 
			@expired_date = 
				CASE 
					WHEN expire_date < GETDATE() THEN DATEADD(MINUTE, @minutes_to_expire, GETDATE()) 
					ELSE DATEADD(MINUTE, @minutes_to_expire, expire_date) 
				END
		FROM SB_USER_PET (READUNCOMMITTED)
		WHERE ID = @pet_dbid AND owner_dbid = @user_dbid
	END

	UPDATE SB_USER_PET SET expire_date = @expired_date WHERE ID = @pet_dbid AND owner_dbid = @user_dbid
	
	IF @@ROWCOUNT > 0
		EXEC sb_WritePetHistory @user_dbid, @pet_dbid, 3, @minutes_to_expire
	
	SELECT pet_class_id, ID, pet_slot_index, pet_name, 
		CASE WHEN expire_date IS NULL THEN -1 ELSE dbo.ConvertToTimeT32(expire_date) END expire_date
	FROM SB_USER_PET (READUNCOMMITTED)
	WHERE owner_dbid = @user_dbid AND ID = @pet_dbid
END
GO
PRINT N'Creating [dbo].[sb_ExtractGemFromSocket]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sb_ExtractGemFromSocket] 
	@ItemDBID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    delete from SB_ITEM_GEM where ID = @ItemDBID;
	
END
GO
PRINT N'Creating [dbo].[sb_find_related]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sb_find_related]
(
	@table_name NVARCHAR(128)
)
AS
BEGIN
	SELECT  DISTINCT ISNULL(sd.referenced_schema_name+'.','')+ OBJECT_NAME(sd.referenced_id)TableName,
		OBJECT_NAME(sd.referencing_id)Ref_Object,
		CASE WHEN OBJECTPROPERTYEX(sd.referencing_id,N'ISTABLE')= 1 THEN'Table'
		WHEN OBJECTPROPERTYEX(sd.referencing_id,N'IsTableFunction')= 1 THEN'Function'
		WHEN OBJECTPROPERTYEX(sd.referencing_id,N'IsTableFunction')= 1 THEN'Function'
		WHEN OBJECTPROPERTYEX(sd.referencing_id,N'IsScalarFunction')=1 THEN'Function'
		WHEN OBJECTPROPERTYEX(sd.referencing_id,N'IsTrigger')= 1 THEN'Trigger'
		WHEN OBJECTPROPERTYEX(sd.referencing_id,N'IsView')= 1 THEN'View'
		WHEN OBJECTPROPERTYEX(sd.referencing_id,N'IsUserTable')= 1 THEN'Table'
		WHEN OBJECTPROPERTYEX(sd.referencing_id,N'IsProcedure')= 1 THEN'Procedure'
		WHEN OBJECTPROPERTYEX(sd.referencing_id,N'IsIndexed')= 1 THEN'Index'
		WHEN OBJECTPROPERTYEX(sd.referencing_id,N'IsForeignKey')= 1 THEN'ForeignKey'
		WHEN OBJECTPROPERTYEX(sd.referencing_id,N'IsPrimaryKey')= 1 THEN'PrimaryKey'
		END AS Ref_Object_Name
	FROM    sys.sql_expression_dependencies SD
		INNER JOIN sys.objects obj ON obj.object_id=sd.referenced_id
	WHERE   obj.is_ms_shipped= 0
		AND  referenced_id=object_id(@table_name) /*Where one can Replace table Name*/
		AND obj.type_desc='USER_TABLE'
	ORDER BY TableName,Ref_Object,Ref_Object_Name
END
GO
PRINT N'Creating [dbo].[SB_FindAccountName]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SB_FindAccountName]
	-- Add the parameters for the stored procedure here
	@ID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--SELECT ID, 0, 0, name, 0
	SELECT name
	FROM SB_ACCOUNT (READUNCOMMITTED)
	WHERE ID = @ID;
END
GO
PRINT N'Creating [dbo].[SB_FindMaxLevelInAccount]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_FindMaxLevelInAccount]
	@account_name NVARCHAR(64)
AS
BEGIN

	SET NOCOUNT ON;

    SELECT MAX(lev) 
    FROM SB_USER_INFO (READUNCOMMITTED)
    WHERE id IN 
		(
		SELECT ID 
		FROM SB_USER (READUNCOMMITTED)
		WHERE account_id = 
			(
			SELECT id 
			FROM SB_ACCOUNT (READUNCOMMITTED)
			WHERE name = @account_name
			)
		)
END
GO
PRINT N'Creating [dbo].[sb_FindTelPoint]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sb_FindTelPoint]
	-- Add the parameters for the stored procedure here
	@telPointName NVARCHAR(256)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT (
				(cast(area_id as bigint)		* 0x100000000000000) | 
				(cast(region_id as bigint)	* 0x1000000000000) | 
				(cast(resource_id as bigint)	* 0x100000000) | 
				(cast(grid_x as bigint)		* 0x1000000) | 
				(cast(grid_y as bigint)		* 0x10000) | 
				(cast(grid_z as bigint)		* 0x100) | 
				(cast(reserved as bigint))
			),
    x, y, z
    FROM SB_TELEPORT_POINT (READUNCOMMITTED)
    WHERE NAME = @telPointName
	
END
GO
PRINT N'Creating [dbo].[sb_FindUserEquippedItemsForBuilder]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_FindUserEquippedItemsForBuilder]
	@user_name NVARCHAR(64)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT 
		class_id
	FROM
		SB_ITEM (READUNCOMMITTED) I 
		INNER JOIN SB_USER (READUNCOMMITTED) U 
		ON U.ID = I.owner_id 
	WHERE
		U.name = @user_name 
		AND I.bag_id = -1
		AND I.is_deleted = 0
END
GO
PRINT N'Creating [dbo].[SB_FindUserForMobile]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_FindUserForMobile]
	@search_user_name NVARCHAR(64)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT U.ID, U.job_type, I.lev, @search_user_name, A.name FROM 
	(SELECT * FROM SB_USER (READUNCOMMITTED) WHERE name = @search_user_name) U
	LEFT JOIN SB_USER_INFO (READUNCOMMITTED) I ON U.ID = I.ID
	LEFT JOIN SB_ACCOUNT (READUNCOMMITTED) A ON U.account_id = A.ID
END
GO
PRINT N'Creating [dbo].[SB_GetAccountIDByUserID]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_GetAccountIDByUserID]
	-- Add the parameters for the stored procedure here
	@charDBID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT account_id
	FROM SB_USER (READUNCOMMITTED)
	WHERE ID = @charDBID;
END
GO
PRINT N'Creating [dbo].[sb_GetAccountIDByUserName]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_GetAccountIDByUserName]
	-- Add the parameters for the stored procedure here
	@name NVARCHAR(64)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [account_id]
	FROM [dbo].[SB_USER] (READUNCOMMITTED)
	WHERE [name] = @name;
END
GO
PRINT N'Creating [dbo].[sb_GetGuildInfo]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_GetGuildInfo]
	@guildID INT
AS  
BEGIN  
	SET NOCOUNT ON

	SELECT G.ID, G.name, ISNULL(U.name, N''), G.masterDBID, G.type, G.totype, G.mark, G.level, G.exp
		, ISNULL(GN.memberName, N'')
		, ISNULL(GN.notice, N'')
		, ISNULL(dbo.ConvertToTimeT32(GN.modify_time), 0)
		, G.sub_right, G.senior_right
		, G.junior_right, G.newbie_right
		, ISNULL(dbo.ConvertToTimeT32(G.delegate_time), 0) delegate_time
		, ISNULL(dbo.ConvertToTimeT32(G.disband_time), 0) disband_time
		, ISNULL(dbo.ConvertToTimeT32(G.recover_time),0) recover_time
		, ISNULL(dbo.ConvertToTimeT32(G.type_change_time),0) type_change_time
		, G.war_point
		, ISNULL(G.money, 0) money
		, G.pre_season_rank
	FROM 
		SB_GUILD AS G (READUNCOMMITTED) 
		LEFT JOIN SB_USER AS U (READUNCOMMITTED) ON U.ID = G.masterDBID
		LEFT JOIN SB_GUILD_NOTICE GN (READUNCOMMITTED) ON G.ID = GN.ID
	WHERE G.ID = @guildID
END
GO
PRINT N'Creating [dbo].[SB_GetGuildMember]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_GetGuildMember]
	@guildID int
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT G1.guildID, U1.ID, U1.name, A1.name, U2.lev, U1.job_type, G1.grade, U3.area_id, U3.region_id, 
		ISNULL(dbo.ConvertToTimeT32(U2.logOutTime), 0) logOutTime, ISNULL(memo, N'') memo,
		G1.kill_count, G1.death_count
	FROM 
		SB_USER AS U1 (READUNCOMMITTED)
		INNER JOIN 
		SB_USER_INFO AS U2 (READUNCOMMITTED) 
		ON (U1.ID = U2.ID)
		INNER JOIN 
		SB_USER_POS AS U3 (READUNCOMMITTED) 
		ON (U1.ID = U3.ID)
		INNER JOIN 
		SB_ACCOUNT AS A1 (READUNCOMMITTED)
		ON (U1.account_id = A1.ID)
		INNER JOIN
		SB_GUILD_MEMBER AS G1(READUNCOMMITTED) 
		ON(U1.ID = G1.memberDBID AND G1.guildID = @guildID)		
END
GO
PRINT N'Creating [dbo].[SB_GuildAddMember]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_GuildAddMember]
	@guildID int,
	@memberID int
AS
BEGIN
	SET NOCOUNT ON;
	
	INSERT INTO SB_GUILD_MEMBER(guildID, memberDBID, grade) VALUES(@guildID, @memberID, 4)
	
END
GO
PRINT N'Creating [dbo].[sb_GuildCreate]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_GuildCreate]
	@guildID		INT,
	@name			NVARCHAR(64),
	@masterID		INT,
	@subRight		INT,
	@seniorRight	INT,
	@juniorRight	INT,
	@newbieRight    INT
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO 
		SB_GUILD(ID, name, masterDBID, type, totype, mark, level, exp, sub_right, senior_right, junior_right, newbie_right, war_point, money)	
	VALUES(@guildID, @name, @masterID, 0, 0, 0, 1, 0, @subRight, @seniorRight, @juniorRight, @newbieRight, 0, 0)
		
	INSERT INTO SB_GUILD_MEMBER(guildID, memberDBID, grade) VALUES(@guildID, @masterID, 0)
END
GO
PRINT N'Creating [dbo].[sb_GuildDisband]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_GuildDisband]
	@guild_dbid int,
	@disband_time int
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE SB_GUILD SET disband_time = dbo.ConvertToDateTime32(@disband_time) WHERE ID = @guild_dbid
	
	DELETE SB_GUILD_WAR WHERE guildID = @guild_dbid
	
	DELETE FROM SB_GUILD_FRIENDSHIP WHERE guild_dbid_from = @guild_dbid
	DELETE FROM SB_GUILD_FRIENDSHIP WHERE guild_dbid_to = @guild_dbid
END
GO
PRINT N'Creating [dbo].[sb_GuildLairTimeAttackClearAll]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_GuildLairTimeAttackClearAll]
AS
BEGIN
	SET NOCOUNT ON
	
	delete from sb_guild_lair_time_attack
END
GO
PRINT N'Creating [dbo].[sb_GuildLairTimeAttackLoadGuildBest]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_GuildLairTimeAttackLoadGuildBest]
 @guild_db_id int
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT guild_db_id, elapsed_seconds
	FROM SB_GUILD_LAIR_TIME_ATTACK (READUNCOMMITTED)
	WHERE guild_db_id = @guild_db_id
END
GO
PRINT N'Creating [dbo].[sb_GuildLairTimeAttackLoadTop]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_GuildLairTimeAttackLoadTop]
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT top 10 guild_db_id, elapsed_seconds
	FROM SB_GUILD_LAIR_TIME_ATTACK (READUNCOMMITTED)
	order by elapsed_seconds asc
END
GO
PRINT N'Creating [dbo].[sb_GuildLairTimeAttackSave]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_GuildLairTimeAttackSave]
	@guild_db_id int,
	@elapsed_seconds int
AS
BEGIN
	SET NOCOUNT ON
	
	MERGE SB_GUILD_LAIR_TIME_ATTACK WITH (HOLDLOCK) AS T
	USING (SELECT @guild_db_id guild_db_id, @elapsed_seconds elapsed_seconds) AS S
	ON (T.guild_db_id = S.guild_db_id)
	WHEN MATCHED 
		THEN UPDATE SET T.elapsed_seconds = S.elapsed_seconds
	WHEN NOT MATCHED BY TARGET
		THEN INSERT (guild_db_id, elapsed_seconds) VALUES (S.guild_db_id, S.elapsed_seconds)
		;
END
GO
PRINT N'Creating [dbo].[SB_GuildRecover]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_GuildRecover]
	@guildID int,
	@recoverTime int
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE SB_GUILD SET recover_time = [dbo].ConvertToDateTime32(@recoverTime), disband_time = NULL WHERE ID = @guildID
	
END
GO
PRINT N'Creating [dbo].[SB_GuildSetGrade]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_GuildSetGrade]
	@guildID int,
	@memberID int,
	@grade int
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE SB_GUILD_MEMBER
		SET grade = @grade
		WHERE guildID = @guildID AND memberDBID = @memberID
	
END
GO
PRINT N'Creating [dbo].[SB_GuildSetRight]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_GuildSetRight]
	@guildID int,
	@sub_right int,
	@senior_right int,
	@junior_right int,
	@newbie_right int
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE SB_GUILD
		SET sub_right = @sub_right, senior_right = @senior_right, 
		junior_right = @junior_right, newbie_right = @newbie_right
	WHERE ID = @guildID
		
END
GO
PRINT N'Creating [dbo].[sb_GuildUpdateMemo]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_GuildUpdateMemo]  
	@user_id int, 
	@memo nvarchar(25)
AS  
BEGIN
	SET NOCOUNT ON
	
	UPDATE [dbo].SB_GUILD_MEMBER
	SET [memo] = @memo WHERE [memberDBID] = @user_id;
	
END
GO
PRINT N'Creating [dbo].[sb_GuildUpdateWarScore]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_GuildUpdateWarScore]  
	@guildID int, 
	@score_delta int
AS  
BEGIN
	SET NOCOUNT ON
	
	-- UPDATE [dbo].SB_GUILD
	-- SET [war_point] = (SELECT MAX(T.point) FROM (SELECT 0 AS point UNION SELECT war_point + @score_delta AS point) as T) WHERE ID = @guildID;
	
	UPDATE SB_GUILD SET [war_point] += @score_delta 
		OUTPUT inserted.war_point
	WHERE ID = @guildID;
	
END
GO
PRINT N'Creating [dbo].[sb_GuildWarKill]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_GuildWarKill]  
 @guildID int,
 @targetGuildID int,
 @killerUser  int,
 @deathUser int
AS  
BEGIN  
	SET NOCOUNT ON
	
	UPDATE [dbo].[SB_GUILD_WAR] SET kill_count += 1	
			WHERE guildID = @guildID and targetGuildID = @targetGuildID AND in_progress = 1;
	
	UPDATE [dbo].[SB_GUILD_MEMBER] SET kill_count += 1
			WHERE guildID = @guildID and memberDBID = @killerUser;
	
	UPDATE [dbo].[SB_GUILD_WAR] SET death_count += 1
			WHERE guildID = @targetGuildID and targetGuildID = @guildID AND in_progress = 1;
	
	UPDATE [dbo].[SB_GUILD_MEMBER] SET death_count += 1
			WHERE guildID = @targetGuildID and memberDBID = @deathUser;
	
END
GO
PRINT N'Creating [dbo].[sb_HasItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_HasItem]
	@user_id INT
	, @item_class_id INT
AS  
BEGIN  
	SET NOCOUNT ON  

	IF EXISTS (
		SELECT *
		FROM SB_ITEM (READUNCOMMITTED)
		WHERE owner_id = @user_id
			AND class_id = @item_class_id
			AND (bag_id IN (0, -5)					-- inven, warehouse default bag
				OR bag_id IN (
					SELECT ID 
					FROM SB_ITEM_BAG (READUNCOMMITTED)
					WHERE owner_dbid = @user_id
						AND bag_type IN (0, 1, 3)	-- inven, warehouse, pet
				)
			)
			AND is_deleted = 0
		)
	BEGIN
		SELECT 1
	END
	ELSE
	BEGIN
		SELECT 0
	END
	
END
GO
PRINT N'Creating [dbo].[sb_SaveDurability]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveDurability]
	@item_id BIGINT,
	@durability INT
AS
BEGIN
	SET NOCOUNT ON;

	MERGE SB_ITEM_EQUIPMENT WITH (HOLDLOCK) T
	USING (SELECT @item_id, @durability) AS S (item_id, durability)
		ON T.ID = S.item_id
	WHEN MATCHED THEN
		UPDATE SET T.durability = S.durability
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (ID, durability) VALUES (S.item_id, S.durability)
	--OUTPUT $action, Inserted.*, Deleted.*
	;
END
GO
PRINT N'Creating [dbo].[SB_InitItemInfo]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_InitItemInfo] 
	@item_dbid bigint,
	@minutes_to_expire int,
	@init_durability int
AS  
BEGIN
	SET NOCOUNT ON  

	IF 0 < @minutes_to_expire
	BEGIN
		DECLARE @create_date DATETIME
		DECLARE @expire_date DATETIME
		
		SELECT @create_date = created_date FROM SB_ITEM (READUNCOMMITTED) WHERE ID = @item_dbid
		SET @expire_date = DATEADD(MINUTE, @minutes_to_expire, @create_date)
		
		MERGE SB_ITEM_DURATION WITH (HOLDLOCK) T
		USING (SELECT @item_dbid) AS S (item_dbid)
			ON T.item_dbid = S.item_dbid
		WHEN MATCHED THEN
			UPDATE SET expire_date = @expire_date
		WHEN NOT MATCHED THEN
			INSERT (item_dbid, expire_date) VALUES (@item_dbid, @expire_date)
		;
	END
	
	IF 0 < @init_durability
	BEGIN
		EXECUTE SB_SaveDurability @item_dbid, @init_durability
	END
END
GO
PRINT N'Creating [dbo].[SB_LoadAccount]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadAccount]
	@name NVARCHAR(64)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @isNew as bit
	SET @isNew = 0;
	
	SELECT ID, name, @isNew
	FROM SB_ACCOUNT (READUNCOMMITTED)
	WHERE name = @name;
END
GO
PRINT N'Creating [dbo].[SB_LoadAchievement]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadAchievement]
	@user_id int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT achievement_id, goal_id, progress
	FROM SB_USER_ACHIEVEMENT_PROGRESS (READUNCOMMITTED)
	WHERE user_id = @user_id AND achievement_id NOT IN 
	(SELECT achievement_id FROM SB_USER_ACHIEVEMENT (READUNCOMMITTED) WHERE user_id = @user_id)
	
END
GO
PRINT N'Creating [dbo].[SB_LoadAchievementFinished]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadAchievementFinished]
	@user_id int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT achievement_id, dbo.ConvertToTimeT32(finished_time)
	FROM SB_USER_ACHIEVEMENT (READUNCOMMITTED)
	WHERE user_id = @user_id
END
GO
PRINT N'Creating [dbo].[sb_LoadAllGuildFriendship]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_LoadAllGuildFriendship] 	
AS  
BEGIN
	SET NOCOUNT ON

	SELECT guild_dbid_from, guild_dbid_to, dbo.ConvertToTimeT32(created_date)
	FROM dbo.SB_GUILD_FRIENDSHIP (READUNCOMMITTED);
END
GO
PRINT N'Creating [dbo].[sb_LoadAllGuildInfo]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_LoadAllGuildInfo]
AS  
BEGIN  
	SET NOCOUNT ON
	
	SELECT G.ID, G.name, ISNULL(U.name, N''), G.masterDBID, G.[type], G.[totype], G.mark, G.level, G.exp
		, ISNULL(GN.memberName, N'')
		, ISNULL(GN.notice, N'')
		, ISNULL(dbo.ConvertToTimeT32(GN.modify_time), 0)
		, G.sub_right, G.senior_right
		, G.junior_right, G.newbie_right
		, ISNULL(dbo.ConvertToTimeT32(G.delegate_time), 0) delegate_time
		, ISNULL(dbo.ConvertToTimeT32(G.disband_time), 0) disband_time
		, ISNULL(dbo.ConvertToTimeT32(G.recover_time),0) recover_time
		, ISNULL(dbo.ConvertToTimeT32(G.type_change_time), 0) type_change_time
		, G.war_point
		, ISNULL(G.money, 0) money
		, G.pre_season_rank
	FROM
		SB_GUILD AS G (READUNCOMMITTED)
		LEFT JOIN SB_USER AS U (READUNCOMMITTED) ON (U.ID = G.masterDBID)
		LEFT JOIN SB_GUILD_NOTICE GN (READUNCOMMITTED) ON G.ID = GN.ID
	WHERE G.deleted = 0
END
GO
PRINT N'Creating [dbo].[sb_LoadAllGuildMember]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadAllGuildMember]
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT G1.guildID, U1.ID, U1.name, A1.name, U2.lev, U1.job_type, G1.grade, U3.area_id, U3.region_id, 
		ISNULL(dbo.ConvertToTimeT32(U2.logOutTime), 0) logOutTime, ISNULL(memo, N'') memo,
		G1.kill_count, G1.death_count, ISNULL(dbo.ConvertToTimeT32(G1.join_date), 0) join_date
	FROM 
		SB_USER AS U1 (READUNCOMMITTED)
		INNER JOIN 
		SB_USER_INFO AS U2 (READUNCOMMITTED) 
		ON (U1.ID = U2.ID)
		INNER JOIN 
		SB_USER_POS AS U3 (READUNCOMMITTED) 
		ON (U1.ID = U3.ID)
		INNER JOIN 
		SB_ACCOUNT AS A1 (READUNCOMMITTED)
		ON (U1.account_id = A1.ID)
		INNER JOIN
		SB_GUILD_MEMBER AS G1(READUNCOMMITTED) 
		ON(U1.ID = G1.memberDBID)
END
GO
PRINT N'Creating [dbo].[SB_LoadAndCreateAccount]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadAndCreateAccount]
	@name NVARCHAR(64),
	@accountID BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @isNew as bit;
	SET @isNew = 0;
	
	IF NOT EXISTS (SELECT ID FROM SB_ACCOUNT (READUNCOMMITTED) WHERE ID = @accountID)
	BEGIN
		INSERT INTO SB_ACCOUNT(ID, name, created_time) values(@accountID, @name, GETDATE())
		SET @isNew = 1;
	END
	
	SELECT ID, name, @isNew
	FROM SB_ACCOUNT (READUNCOMMITTED)
	WHERE name = @name;
END
GO
PRINT N'Creating [dbo].[SB_LoadAnnounce]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SB_LoadAnnounce]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT id, type, cycle, msg FROM SB_ANNOUNCE (READUNCOMMITTED)
END
GO
PRINT N'Creating [dbo].[sb_LoadAttendanceReward]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadAttendanceReward]
	  @user_id  INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		[item_class_id], 
		[item_amount],
		[dbo].ConvertToTimeT32([attendance_time]) AS attendance_time
	FROM
		[dbo].[SB_USER_ATTENDANCE_REWARD] WITH (READUNCOMMITTED)
	WHERE
		[user_id] = @user_id
		AND [receipt_time] IS NULL
	--ORDER BY
	--	[attendance_time] DESC
	;
END
GO
PRINT N'Creating [dbo].[sb_LoadAttendanceRound]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadAttendanceRound]
	  @user_id INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT
		[total_attendance_count], 
		[number],
		[dbo].ConvertToTimeT32([start_time]) AS start_time,
		[attendance_count]
	FROM
		[dbo].[SB_USER_ATTENDANCE_ROUND] WITH (READUNCOMMITTED)
	WHERE
		[user_id] = @user_id
	;
END
GO
PRINT N'Creating [dbo].[SB_LoadBanList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadBanList]
	@user_id int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT U1.ID, U1.name
		FROM SB_USER AS U1 (READUNCOMMITTED)
		WHERE U1.ID IN (SELECT ban_id FROM SB_BAN (READUNCOMMITTED) WHERE user_id = @user_id)

END
GO
PRINT N'Creating [dbo].[SB_LoadBoundDungeonSequence]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadBoundDungeonSequence]
	@UserDBID int	
AS
BEGIN
	SET NOCOUNT ON;

    SELECT dungeon_class_id, checkpoint_seq_no, ISNULL(dbo.ConvertToTimeT32(expired_time ), 0) FROM
		[dbo].[SB_USER_BOUND_DUNGEON] (READUNCOMMITTED)
	WHERE user_db_id = @UserDBID
END
GO
PRINT N'Creating [dbo].[sb_LoadBuddyList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadBuddyList]
	@user_id int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT U1.ID, U1.name, A1.name, U2.lev, U1.job_type, ISNULL(dbo.ConvertToTimeT32(U2.logOutTime), 0) logOutTime
	FROM SB_USER AS U1 (READUNCOMMITTED)
		INNER JOIN SB_USER_INFO AS U2 (READUNCOMMITTED) ON (U1.ID = U2.ID)
		INNER JOIN SB_ACCOUNT AS A1 (READUNCOMMITTED) ON U1.account_id = A1.ID
	WHERE U1.ID IN (SELECT buddy_id FROM SB_BUDDY (READUNCOMMITTED) WHERE user_id = @user_id)
END
GO
PRINT N'Creating [dbo].[SB_LoadBuff]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadBuff]
	@user_id int
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT [buff_id], [buff_level], [accumulation], [start_time], [remain_time]
	FROM SB_USER_BUFF (READUNCOMMITTED)
	WHERE [user_id] = @user_id
END
GO
PRINT N'Creating [dbo].[sb_LoadCharacterList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadCharacterList]
	@account_id BIGINT
AS  
BEGIN
	SET NOCOUNT ON; 
		
	WITH T_ITEM_CLASS_ID (owner_id, 
		weapon, head, [upper], glove, [lower], 
		foot, special, left_ring, right_ring, necklace, 
		earring, bracelet, belt, [inner], soul_accessory, 
		corsage1, corsage2, costume, special_equip, seal_stone,
		pet_tool)
	AS
	(
		SELECT *
		FROM
			(
				SELECT owner_id, class_id, slot_index
				FROM SB_ITEM (READUNCOMMITTED)
				WHERE bag_id=-1 AND is_deleted=0 AND slot_index BETWEEN 0 AND 20
					AND owner_id IN (SELECT ID FROM SB_USER (READUNCOMMITTED) WHERE account_id=@account_id AND final_deleted = 'N')
			) s
		PIVOT(MAX(class_id) FOR slot_index IN (
			[0],[1],[2],[3],[4],
			[5],[6],[7],[8],[9],
			[10],[11],[12],[13],[14],
			[15],[16],[17],[18],[19],
			[20])) AS pvt
	)
	SELECT
		U.ID, U.name, U.job_type, ISNULL(G.guildID, 0) guild,
		I.lev, I.exp, 
		dbo.ConvertToTimeT32(U.created_time) created_time, 
		ISNULL(dbo.ConvertToTimeT32(U.deleted_time) ,0) deleted_time,			
		ISNULL(dbo.ConvertToTimeT32(I.logInTime), 0) logInTime, 
		ISNULL(dbo.ConvertToTimeT32(I.logOutTime), 0) logOutTime,
		(
			(CAST(P.area_id AS BIGINT)		* 0x100000000000000) | 
			(CAST(P.region_id AS BIGINT)	* 0x1000000000000) | 
			(CAST(P.resource_id AS BIGINT)	* 0x100000000) | 
			(CAST(P.grid_x AS BIGINT)		* 0x1000000) | 
			(CAST(P.grid_y AS BIGINT)		* 0x10000) | 
			(CAST(P.grid_z AS BIGINT)		* 0x100) | 
			(CAST(P.reserved AS BIGINT))
		) coordinate, P.x, P.y, P.z,
		
		--look
		U.face, U.body_color, U.eye, U.eye_color, U.hair, U.hair_color, U.decal, U.body_size, U.leg_size, U.head_size, U.breast_size,
		--avatar
		A.hide_special, A.hide_corsage1, A.hide_corsage2, A.hide_costume, A.hide_special_equip,
		--equipment_item
		ISNULL(T.weapon, 0) weapon, ISNULL(T.head, 0) head, ISNULL(T.[upper], 0) [upper], ISNULL(T.glove, 0) glove, ISNULL(T.[lower], 0) [lower],
		ISNULL(T.foot, 0) foot, ISNULL(T.special, 0) special, ISNULL(T.left_ring, 0) left_ring, ISNULL(T.right_ring, 0) right_ring, ISNULL(T.necklace, 0) necklace,
		ISNULL(T.earring, 0) earring, ISNULL(T.bracelet, 0) bracelet, ISNULL(T.belt, 0) belt, ISNULL(T.[inner], 0) [inner], ISNULL(T.soul_accessory, 0) soul_accessory,
		ISNULL(T.corsage1, 0) corsage1, ISNULL(T.corsage2, 0) corsage2, ISNULL(T.costume, 0) costume, ISNULL(T.special_equip, 0) special_equip, ISNULL(T.seal_stone, 0) seal_stone,
		ISNULL(T.pet_tool, 0) pet_tool
	FROM SB_USER AS U (READUNCOMMITTED)
		INNER JOIN SB_USER_INFO AS I (READUNCOMMITTED) ON I.ID = U.ID
		INNER JOIN SB_USER_POS AS P (READUNCOMMITTED) ON P.ID = U.ID
		INNER JOIN SB_USER_AVATAR_ITEM AS A (READUNCOMMITTED) ON A.ID = U.ID 
		LEFT JOIN SB_GUILD_MEMBER AS G (READUNCOMMITTED) ON G.memberDBID = U.ID
		LEFT JOIN T_ITEM_CLASS_ID AS T ON T.owner_id = U.ID
	WHERE 
		U.account_id = @account_id AND U.final_deleted = 'N'
	ORDER BY I.logInTime DESC;
END
GO
PRINT N'Creating [dbo].[SB_LoadDungeonBindInit]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadDungeonBindInit]
	@user_db_id int
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT init_id, init_used_count
	FROM SB_USER_DUNGEON_BIND_INIT (READUNCOMMITTED)
	WHERE user_db_id = @user_db_id
END
GO
PRINT N'Creating [dbo].[sb_LoadDungeonBindInitResetTime]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadDungeonBindInitResetTime]
	@user_db_id int
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT ISNULL(dbo.ConvertToTimeT32(DUNGEON_BIND_INIT_RESET_TIME), 0) FROM SB_USER_DUNGEON (READUNCOMMITTED) WHERE ID = @user_db_id
END
GO
PRINT N'Creating [dbo].[SB_LoadDungeonTicket]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SB_LoadDungeonTicket]
	@user_db_id int
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT ticket_id, ticket_used_count, addable_ticket_buy_count, paid_used_count
	FROM SB_USER_DUNGEON_TICKET (READUNCOMMITTED)
	WHERE user_db_id = @user_db_id
END
GO
PRINT N'Creating [dbo].[SB_LoadDungeonTicketBoss]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadDungeonTicketBoss]
	@user_db_id int
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT ticket_id, boss_id, is_first_kill
	FROM SB_USER_DUNGEON_TICKET_BOSS (READUNCOMMITTED)
	WHERE user_db_id = @user_db_id
END
GO
PRINT N'Creating [dbo].[sb_LoadDungeonTicketResetTime]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadDungeonTicketResetTime]
	@user_db_id int
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT ISNULL(dbo.ConvertToTimeT32(DUNGEON_TICKET_RESET_TIME), 0) FROM SB_USER_DUNGEON (READUNCOMMITTED) WHERE ID = @user_db_id
END
GO
PRINT N'Creating [dbo].[SB_LoadEquippedTransmogrify]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SB_LoadEquippedTransmogrify]
	@user_dbid int
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT *
		FROM
			(
				SELECT class_id, slot_type
				FROM SB_USER_TRANSMOGRIFY_LIST (READUNCOMMITTED)
				WHERE ID = @user_dbid AND used = 1
			) s
		PIVOT(MAX(class_id) FOR slot_type IN (
			[6],[15],[16],[17])) AS pvt
END
GO
PRINT N'Creating [dbo].[sb_LoadEventCool]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadEventCool]
	@user_id int
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT [cool_id], [remain_time]
	FROM SB_USER_EVENT_COOL (READUNCOMMITTED)
	WHERE [user_id] = @user_id
END
GO
PRINT N'Creating [dbo].[SB_LoadGiftBox]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadGiftBox]
	@user_dbid INT
	, @page_no INT
	, @count_per_page INT
AS
BEGIN
	SET NOCOUNT ON;
	
	WITH MyGiftList AS
	(
		SELECT ROW_NUMBER() OVER (ORDER BY [ID] DESC) AS rowNo
			, [ID], [gift_type], [sender_name]
			, dbo.ConvertToTimeT32([send_date]) AS send_date
			, CASE WHEN [receive_date] IS NULL THEN 0 ELSE dbo.ConvertToTimeT32([receive_date]) END AS receive_date
		FROM [dbo].[SB_SHOP_GIFT_BOX] (READUNCOMMITTED)
		WHERE [recipient_dbid] = @user_dbid
			AND [delete_date] IS NULL
	)
	
	SELECT [ID], [gift_type], [sender_name], [send_date], [receive_date]
	FROM MyGiftList
	WHERE rowNo BETWEEN ((@page_no - 1) * @count_per_page) + 1 AND (@page_no * @count_per_page)
END
GO
PRINT N'Creating [dbo].[SB_LoadGiftBoxAttached]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SB_LoadGiftBoxAttached]
	@gift_id BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT [rack_id], [selected_product_id], [rack_amount]
	FROM [dbo].[SB_SHOP_GIFT_ITEM] (READUNCOMMITTED)
	WHERE [gift_id] = @gift_id
END
GO
PRINT N'Creating [dbo].[SB_LoadGiftBoxCount]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SB_LoadGiftBoxCount]
	@user_dbid INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT COUNT(*)
	FROM [dbo].[SB_SHOP_GIFT_BOX] (READUNCOMMITTED)
	WHERE [recipient_dbid] = @user_dbid
		AND [delete_date] IS NULL
END
GO
PRINT N'Creating [dbo].[SB_LoadGiftBoxDetail]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadGiftBoxDetail]
	@user_dbid INT
	, @gift_id BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE [dbo].[SB_SHOP_GIFT_BOX]
	SET [open_date] = GETDATE()
	WHERE [ID] = @gift_id
		AND [recipient_dbid] = @user_dbid
		AND [open_date] IS NULL
	
	SELECT [gift_type], [sender_dbid], [sender_name], [message]
		, dbo.ConvertToTimeT32([send_date])
		, CASE WHEN [receive_date] IS NULL THEN 0 ELSE 1 END
	FROM [dbo].[SB_SHOP_GIFT_BOX] (READUNCOMMITTED)
	WHERE [ID] = @gift_id
		AND [recipient_dbid] = @user_dbid
		AND [delete_date] IS NULL
END
GO
PRINT N'Creating [dbo].[SB_LoadGiftBoxInfo]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SB_LoadGiftBoxInfo]
	@user_dbid INT
AS
BEGIN
	SET NOCOUNT ON;
	
	WITH MyGiftList AS
	(
		SELECT [gift_type], [open_date]
		FROM [dbo].[SB_SHOP_GIFT_BOX] (READUNCOMMITTED)
		WHERE [recipient_dbid] = @user_dbid
			AND [delete_date] IS NULL
	)

	SELECT 
		(SELECT COUNT(*) FROM MyGiftList)													-- total
		, (SELECT COUNT(*) FROM MyGiftList WHERE [open_date] IS NULL)						-- total unread
		, (SELECT COUNT(*) FROM MyGiftList WHERE [gift_type] = 0 AND [open_date] IS NULL)	-- total unread gift
		, (SELECT COUNT(*) FROM MyGiftList WHERE [gift_type] = 1 AND [open_date] IS NULL)	-- total unread nagging
END
GO
PRINT N'Creating [dbo].[sb_LoadGuildID]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadGuildID]
	@userDBID INT
AS  
BEGIN  
	SET NOCOUNT ON

	DECLARE @guildID INT	
	SELECT @guildID = guildID FROM SB_GUILD_MEMBER (READUNCOMMITTED) WHERE memberDBID = @userDBID
	SELECT ISNULL(@guildID, 0)
END
GO
PRINT N'Creating [dbo].[sb_loadGuildWar]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_loadGuildWar]  
 @guildID int
AS  
BEGIN  
	SET NOCOUNT ON
		
	SELECT targetGuildID, in_progress, declared, [dbo].ConvertToTimeT32(declare_time), kill_count, death_count 
	FROM [dbo].[SB_GUILD_WAR] (READUNCOMMITTED)
	WHERE guildID = @guildID;
				
END
GO
PRINT N'Creating [dbo].[SB_LoadGuildWarehouse]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadGuildWarehouse]
	@owner_dbid int
AS
BEGIN
	SET NOCOUNT ON

    SELECT [ID], [bag_type], [slot_index], [source_item_class_id], [max_slot_count]
    FROM SB_ITEM_BAG (READUNCOMMITTED)
    WHERE [owner_dbid] = @owner_dbid
		AND [bag_type] = 2
END
GO
PRINT N'Creating [dbo].[SB_LoadGuildWarSeason]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadGuildWarSeason]
AS  
BEGIN  
	SET NOCOUNT ON
	
	IF NOT EXISTS (SELECT season FROM dbo.SB_GUILD_WAR_SEASON (READUNCOMMITTED) )
		INSERT INTO [dbo].[SB_GUILD_WAR_SEASON] (season, season_start_time, reset_time ) VALUES(0, dbo.ConvertToDateTime32(0), GETDATE())
	
	SELECT season,
		   dbo.ConvertToTimeT32(season_start_time),
		   dbo.ConvertToTimeT32(reset_time)   
		   FROM [dbo].[SB_GUILD_WAR_SEASON] (READUNCOMMITTED)
END
GO
PRINT N'Creating [dbo].[sb_LoadINN]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadINN]  
 @user_id int
AS  
BEGIN  
 SET NOCOUNT ON  
    
 SELECT inn_id
 FROM SB_INN (READUNCOMMITTED)
 WHERE ID = @user_id
 
END
GO
PRINT N'Creating [dbo].[SB_LoadInventory]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadInventory]
	@owner_dbid int
AS
BEGIN
	SET NOCOUNT ON

    SELECT [ID], [bag_type], [slot_index], [source_item_class_id], [max_slot_count]
    FROM SB_ITEM_BAG (READUNCOMMITTED)
    WHERE [owner_dbid] = @owner_dbid
		AND [bag_type] = 0
END
GO
PRINT N'Creating [dbo].[sb_LoadItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadItem]
	@owner_id int
	, @bag_id int
AS
BEGIN
	SET NOCOUNT ON;
	--caution: see also sb_LoadItem, sb_LoadItemByDBID, sb_LoadItemByDBIDList

	SELECT
		T1.ID, T1.class_id, T1.amount, T1.slot_index, T1.created_date,
		ISNULL(T2.durability, -1) durability, ISNULL(T3.RuneClassID, 0) RuneClassID, ISNULL(T3.AttributeType, 0) AttributeTye,
		ISNULL(T6.GEM0, 0) GEM0,
		ISNULL(T6.GEM1, 0) GEM1,
		ISNULL(T6.GEM2, 0) GEM2,
		ISNULL(T2.estimated, 0) estimated,
		ISNULL(T2.reestimated, 0) reestimated,
		ISNULL(T5.Attack, 0) Attack,
		ISNULL(T5.HitRate, 0) HitRate,
		ISNULL(T5.CriticalHitRate, 0) CriticalHitRate,
		ISNULL(T5.Evasion, 0) Evasion,
		ISNULL(T5.MaxHP, 0) MaxHP,
		ISNULL(T5.Defense, 0) Defense,
		ISNULL(T5.Penetration, 0) Penetration,
		ISNULL(T5.CriticalEvasion, 0) CriticalEvasion,
		ISNULL(T5.MaxCP, 0) MaxCP,
		ISNULL(T5.RegenCP, 0) RegenCP,
		ISNULL(T5.PVPPenetration, 0) PVPPenetration,
		ISNULL(T5.PVPDefense, 0) PVPDefense,
		ISNULL(T4.seal_count, 0) seal_count, 
		ISNULL(T4.possession_status, 0) possession_status,
		CASE WHEN T7.expire_date IS NULL THEN -1 ELSE dbo.ConvertToTimeT32(T7.expire_date) END expire_date,
		ISNULL(T8.grade, 0) grade,
		ISNULL(T8.experience, 0) experience
	FROM (
			SELECT ID, class_id, amount, slot_index, dbo.ConvertToTimeT32(created_date) created_date
			FROM SB_ITEM (READUNCOMMITTED)
			WHERE owner_id = @owner_id
				AND bag_id = @bag_id
				AND is_deleted = 0
		) T1
		LEFT JOIN SB_ITEM_EQUIPMENT AS T2 (READUNCOMMITTED) ON (T1.ID = T2.ID)
		LEFT JOIN SB_ITEM_RUNE AS T3 (READUNCOMMITTED) ON (T1.ID = T3.ID)
		LEFT JOIN SB_ITEM_POSSESSION AS T4 (READUNCOMMITTED) ON (T1.ID = T4.item_dbid)
		LEFT JOIN (
			SELECT ID, 
				[0] AS Attack, [1] AS HitRate, [2] AS CriticalHitRate, [3] AS Evasion, [4] AS MaxHP, 
				[5] AS Defense, [6] AS Penetration, [7] AS CriticalEvasion, [8] AS MaxCP, [9] AS RegenCP, 
				[10] AS PVPPenetration, [11] AS PVPDefense
				--caution: see also condition BETWEEN 0 AND 11
			FROM (SELECT ID, ability_type, ability_value FROM SB_ITEM_RANDOM_ABILITY (READUNCOMMITTED) WHERE ability_type BETWEEN 0 AND 11) s
			PIVOT(SUM(ability_value) FOR ability_type IN ([0],[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11])) AS pvt
		) T5 ON (T1.ID = T5.ID)
		LEFT JOIN (
			SELECT ID, 
				[0] AS GEM0, [1] AS GEM1, [2] AS GEM2
			FROM (SELECT ID, SocketIndex, GemClassID FROM SB_ITEM_GEM (READUNCOMMITTED) WHERE SocketIndex BETWEEN 0 AND 2) s2
			PIVOT( SUM(GemClassID) FOR SocketIndex IN ([0],[1],[2])) AS pvt2
		) T6 ON (T1.ID = T6.ID)
		LEFT JOIN SB_ITEM_DURATION AS T7 (READUNCOMMITTED) ON (T1.ID = T7.item_dbid)
		LEFT JOIN SB_ITEM_REINFORCEMENT AS T8 (READUNCOMMITTED) ON (T1.ID = T8.ID)
END
GO
PRINT N'Creating [dbo].[sb_LoadItemByDBID]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadItemByDBID]
	@itemDBID bigint
AS
BEGIN
	SET NOCOUNT ON;
	--caution: see also sb_LoadItem, sb_LoadItemByDBID, sb_LoadItemByDBIDList

	SELECT
		T1.ID, T1.class_id, T1.amount, T1.slot_index, T1.created_date,
		ISNULL(T2.durability, -1) durability, ISNULL(T3.RuneClassID, 0) RuneClassID, ISNULL(T3.AttributeType, 0) AttributeTye,
		ISNULL(T6.GEM0, 0) GEM0,
		ISNULL(T6.GEM1, 0) GEM1,
		ISNULL(T6.GEM2, 0) GEM2,
		ISNULL(T2.estimated, 0) estimated,
		ISNULL(T2.reestimated, 0) reestimated,
		ISNULL(T5.Attack, 0) Attack,
		ISNULL(T5.HitRate, 0) HitRate,
		ISNULL(T5.CriticalHitRate, 0) CriticalHitRate,
		ISNULL(T5.Evasion, 0) Evasion,
		ISNULL(T5.MaxHP, 0) MaxHP,
		ISNULL(T5.Defense, 0) Defense,
		ISNULL(T5.Penetration, 0) Penetration,
		ISNULL(T5.CriticalEvasion, 0) CriticalEvasion,
		ISNULL(T5.MaxCP, 0) MaxCP,
		ISNULL(T5.RegenCP, 0) RegenCP,
		ISNULL(T5.PVPPenetration, 0) PVPPenetration,
		ISNULL(T5.PVPDefense, 0) PVPDefense,
		ISNULL(T4.seal_count, 0) seal_count, 
		ISNULL(T4.possession_status, 0) possession_status,
		CASE WHEN T7.expire_date IS NULL THEN -1 ELSE dbo.ConvertToTimeT32(T7.expire_date) END expire_date,
		ISNULL(T8.grade, 0) grade,
		ISNULL(T8.experience, 0) experience
	FROM (
			SELECT ID, class_id, amount, slot_index, dbo.ConvertToTimeT32(created_date) created_date
			FROM SB_ITEM (READUNCOMMITTED)
			WHERE ID = @itemDBID
		) T1
		LEFT JOIN SB_ITEM_EQUIPMENT AS T2 (READUNCOMMITTED) ON (T1.ID = T2.ID)
		LEFT JOIN SB_ITEM_RUNE AS T3 (READUNCOMMITTED) ON (T1.ID = T3.ID)
		LEFT JOIN SB_ITEM_POSSESSION AS T4 (READUNCOMMITTED) ON (T1.ID = T4.item_dbid)
		LEFT JOIN (
			SELECT ID, 
				[0] AS Attack, [1] AS HitRate, [2] AS CriticalHitRate, [3] AS Evasion, [4] AS MaxHP, 
				[5] AS Defense, [6] AS Penetration, [7] AS CriticalEvasion, [8] AS MaxCP, [9] AS RegenCP, 
				[10] AS PVPPenetration, [11] AS PVPDefense
				--caution: see also condition BETWEEN 0 AND 11
			FROM (SELECT ID, ability_type, ability_value FROM SB_ITEM_RANDOM_ABILITY (READUNCOMMITTED) WHERE ability_type BETWEEN 0 AND 11) s
			PIVOT(SUM(ability_value) FOR ability_type IN ([0],[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11])) AS pvt
		) T5 ON (T1.ID = T5.ID)
		LEFT JOIN (
			SELECT ID, 
				[0] AS GEM0, [1] AS GEM1, [2] AS GEM2
			FROM (SELECT ID, SocketIndex, GemClassID FROM SB_ITEM_GEM (READUNCOMMITTED) WHERE SocketIndex BETWEEN 0 AND 2) s2
			PIVOT( SUM(GemClassID) FOR SocketIndex IN ([0],[1],[2])) AS pvt2
		) T6 ON (T1.ID = T6.ID)
		LEFT JOIN SB_ITEM_DURATION AS T7 (READUNCOMMITTED) ON (T1.ID = T7.item_dbid)
		LEFT JOIN SB_ITEM_REINFORCEMENT AS T8 (READUNCOMMITTED) ON (T1.ID = T8.ID)
END
GO
PRINT N'Creating [dbo].[sb_LoadItemByDBIDList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadItemByDBIDList]
    @t_item_dbid DBIDList READONLY
AS
BEGIN
	SET NOCOUNT ON;
	--caution: see also sb_LoadItem, sb_LoadItemByDBID, sb_LoadItemByDBIDList

	SELECT 
		T1.ID, T1.class_id, T1.amount, T1.slot_index, T1.created_date,
		ISNULL(T2.durability, -1) durability, ISNULL(T3.RuneClassID, 0) RuneClassID, ISNULL(T3.AttributeType, 0) AttributeTye,
		ISNULL(T6.GEM0, 0) GEM0,
		ISNULL(T6.GEM1, 0) GEM1,
		ISNULL(T6.GEM2, 0) GEM2,
		ISNULL(T2.estimated, 0) estimated,
		ISNULL(T2.reestimated, 0) reestimated,
		ISNULL(T5.Attack, 0) Attack, 
		ISNULL(T5.HitRate, 0) HitRate,
		ISNULL(T5.CriticalHitRate, 0) CriticalHitRate,
		ISNULL(T5.Evasion, 0) Evasion,
		ISNULL(T5.MaxHP, 0) MaxHP,
		ISNULL(T5.Defense, 0) Defense,
		ISNULL(T5.Penetration, 0) Penetration,
		ISNULL(T5.CriticalEvasion, 0) CriticalEvasion,
		ISNULL(T5.MaxCP, 0) MaxCP,
		ISNULL(T5.RegenCP, 0) RegenCP,
		ISNULL(T5.PVPPenetration, 0) PVPPenetration,
		ISNULL(T5.PVPDefense, 0) PVPDefense,
		ISNULL(T4.seal_count, 0) seal_count, 
		ISNULL(T4.possession_status, 0) possession_status,
		CASE WHEN T7.expire_date IS NULL THEN -1 ELSE dbo.ConvertToTimeT32(T7.expire_date) END expire_date,
		ISNULL(T8.grade, 0) grade,
		ISNULL(T8.experience, 0) experience
	FROM (
			SELECT ID, class_id, amount, slot_index, dbo.ConvertToTimeT32(created_date) created_date
			FROM SB_ITEM (READUNCOMMITTED)
			WHERE ID IN (SELECT [dbid] FROM @t_item_dbid)
		) T1
		LEFT JOIN SB_ITEM_EQUIPMENT AS T2 (READUNCOMMITTED) ON (T1.ID = T2.ID)
		LEFT JOIN SB_ITEM_RUNE AS T3 (READUNCOMMITTED) ON (T1.ID = T3.ID)
		LEFT JOIN SB_ITEM_POSSESSION AS T4 (READUNCOMMITTED) ON (T1.ID = T4.item_dbid)
		LEFT JOIN (
			SELECT ID, 
				[0] AS Attack, [1] AS HitRate, [2] AS CriticalHitRate, [3] AS Evasion, [4] AS MaxHP, 
				[5] AS Defense, [6] AS Penetration, [7] AS CriticalEvasion, [8] AS MaxCP, [9] AS RegenCP, 
				[10] AS PVPPenetration, [11] AS PVPDefense
				--caution: see also condition BETWEEN 0 AND 11
			FROM (SELECT ID, ability_type, ability_value FROM SB_ITEM_RANDOM_ABILITY (READUNCOMMITTED) WHERE ability_type BETWEEN 0 AND 11) s
			PIVOT(SUM(ability_value) FOR ability_type IN ([0],[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11])) AS pvt
		) T5 ON (T1.ID = T5.ID)
		LEFT JOIN (
			SELECT ID, 
				[0] AS GEM0, [1] AS GEM1, [2] AS GEM2
			FROM (SELECT ID, SocketIndex, GemClassID FROM SB_ITEM_GEM (READUNCOMMITTED) WHERE SocketIndex BETWEEN 0 AND 2) s2
			PIVOT( SUM(GemClassID) FOR SocketIndex IN ([0],[1],[2])) AS pvt2
		) T6 ON (T1.ID = T6.ID)
		LEFT JOIN SB_ITEM_DURATION AS T7 (READUNCOMMITTED) ON (T1.ID = T7.item_dbid)
		LEFT JOIN SB_ITEM_REINFORCEMENT AS T8 (READUNCOMMITTED) ON (T1.ID = T8.ID)
END
GO
PRINT N'Creating [dbo].[SB_LoadItemCool]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadItemCool]
	@user_id int
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT [cool_id], [cool_time]
	FROM SB_ITEM_COOL (READUNCOMMITTED)
	WHERE [user_id] = @user_id
END
GO
PRINT N'Creating [dbo].[SB_LoadItemGem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadItemGem]
	@item_db_id bigint
AS
BEGIN
	SET NOCOUNT ON;

	SELECT GemClassID FROM SB_ITEM_GEM (READUNCOMMITTED) WHERE ID = @item_db_id
END
GO
PRINT N'Creating [dbo].[SB_LoadItemGemBySlotIndex]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadItemGemBySlotIndex]
	@owner_dbid INT,
	@slot_index INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT GemClassID
	FROM SB_ITEM_GEM (READUNCOMMITTED)
	WHERE ID = (SELECT ID FROM SB_ITEM (READUNCOMMITTED) WHERE owner_id = @owner_dbid AND bag_id = -1 AND slot_index = @slot_index AND delete_date IS NULL)
END
GO
PRINT N'Creating [dbo].[sb_LoadKeyboardConfig]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadKeyboardConfig]
(
	@user_id INT
)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT keyboard_config FROM SB_USER_KEYBOARD_CONFIG (READUNCOMMITTED) WHERE user_id = @user_id
END
GO
PRINT N'Creating [dbo].[SB_LoadLimitedRackCount]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadLimitedRackCount]
	@user_dbid INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT TOP 1000 [rack_id], [buy_amount]
	FROM [dbo].[SB_SHOP_LIMIT_COUNT] (READUNCOMMITTED)
	WHERE [user_dbid] = @user_dbid
END
GO
PRINT N'Creating [dbo].[SB_LoadLimitedRackSellInfo]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadLimitedRackSellInfo]
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT TOP 1000 [rack_id], [sell_amount]
	FROM [dbo].[SB_SHOP_LIMITED_SELL] (READUNCOMMITTED)
END
GO
PRINT N'Creating [dbo].[sb_LoadPet]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadPet]
	@user_dbid INT
AS  
BEGIN  
	SET NOCOUNT ON;
		
	SELECT pet_class_id, ID, pet_slot_index, pet_name, 
		CASE WHEN expire_date IS NULL THEN -1 ELSE dbo.ConvertToTimeT32(expire_date) END expire_date
	FROM SB_USER_PET (READUNCOMMITTED)
	WHERE owner_dbid = @user_dbid
	ORDER BY ID ASC
END
GO
PRINT N'Creating [dbo].[sb_LoadPetInventory]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadPetInventory]
	@owner_dbid int
AS
BEGIN
	SET NOCOUNT ON;

    SELECT [ID], [bag_type], [slot_index], [source_item_class_id], [max_slot_count]
    FROM SB_ITEM_BAG (READUNCOMMITTED)
    WHERE [owner_dbid] = @owner_dbid
		AND [bag_type] = 3
END
GO
PRINT N'Creating [dbo].[SB_LoadPost]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadPost]
	@user_dbid INT
	, @post_id INT
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT ID, sender_type, sender_dbid, sender_name, dbo.ConvertToTimeT32(send_time), title, text
		, CASE ISNULL(take_attached_time, 0) WHEN 0 THEN attached_money ELSE 0 END
		, CASE ISNULL(take_attached_time, 0) WHEN 0 THEN attached_item_type ELSE 0 END
	FROM SB_POST_BOX (READUNCOMMITTED)
	WHERE ID = @post_id
		AND recipient_dbid = @user_dbid
END
GO
PRINT N'Creating [dbo].[SB_LoadPostAttachedItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadPostAttachedItem]
	@user_dbid INT
	, @post_id INT
AS
BEGIN
	SET NOCOUNT ON

	SELECT item_key, item_amount
	FROM SB_POST_ATTACHED_ITEM (READUNCOMMITTED)
	WHERE post_id IN (SELECT ID FROM SB_POST_BOX (READUNCOMMITTED) WHERE ID = @post_id AND recipient_dbid = @user_dbid AND take_attached_time IS NULL)
END
GO
PRINT N'Creating [dbo].[SB_LoadPostCount]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadPostCount]
	@user_dbid INT
	, @basic_date INT
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		(SELECT COUNT(*) FROM SB_POST_BOX (READUNCOMMITTED) WHERE sender_dbid = @user_dbid AND blocked = 0 AND send_time > dbo.ConvertToDateTime32(@basic_date)) AS daily_sent_count 
		, (SELECT COUNT(*) FROM SB_POST_BOX (READUNCOMMITTED) WHERE recipient_dbid = @user_dbid AND blocked = 0 AND delete_time IS NULL) AS total_count
END
GO
PRINT N'Creating [dbo].[SB_LoadPostList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadPostList]
	@user_dbid INT
	, @page_no INT
	, @count_per_page INT
AS
BEGIN
	SET NOCOUNT ON;
	
	--SELECT ID, sender_type, sender_dbid, sender_name, dbo.ConvertToTimeT32(send_time), title
	--	, CASE ISNULL(open_time, 0) WHEN 0 THEN 0 ELSE 1 END
	--	, CASE ISNULL(take_attached_time, 0) WHEN 0 THEN attached_money ELSE 0 END
	--	, CASE ISNULL(take_attached_time, 0) WHEN 0 THEN attached_item_type ELSE 0 END
	--FROM SB_POST_BOX (READUNCOMMITTED)
	--WHERE ID IN (SELECT TOP (@page_no * @count_per_page) ID FROM SB_POST_BOX (READUNCOMMITTED) WHERE recipient_dbid = @user_dbid AND delete_time IS NULL ORDER BY ID DESC)
	--	AND ID NOT IN (SELECT TOP ((@page_no - 1) * @count_per_page) ID FROM SB_POST_BOX (READUNCOMMITTED) WHERE recipient_dbid = @user_dbid AND delete_time IS NULL ORDER BY ID DESC)
		
	WITH MyPostList AS
	(
		SELECT ROW_NUMBER() OVER (ORDER BY ID DESC) AS rowNo
			, ID, sender_type, sender_dbid, sender_name, dbo.ConvertToTimeT32(send_time) AS send_time, title
			, CASE ISNULL(open_time, 0) WHEN 0 THEN 0 ELSE 1 END AS is_opened
			, CASE ISNULL(take_attached_time, 0) WHEN 0 THEN attached_money ELSE 0 END AS attached_money
			, CASE ISNULL(take_attached_time, 0) WHEN 0 THEN attached_item_type ELSE 0 END AS attached_item_type
		FROM SB_POST_BOX (READUNCOMMITTED)
		WHERE recipient_dbid = @user_dbid
			AND delete_time IS NULL 
			AND blocked = 0
	)
	
	SELECT ID, sender_type, sender_dbid, sender_name, send_time, title, is_opened, attached_money, attached_item_type
	FROM MyPostList
	WHERE rowNo BETWEEN ((@page_no - 1) * @count_per_page) + 1 AND (@page_no * @count_per_page)
END
GO
PRINT N'Creating [dbo].[SB_LoadProfession]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadProfession]
	@user_id int
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT profession_id, grade_id, point
	FROM SB_USER_PROFESSION (READUNCOMMITTED)
	WHERE user_id = @user_id
END
GO
PRINT N'Creating [dbo].[sb_LoadQuest]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadQuest]
	@user_id int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT uq.quest_id, uq.registered, isnull(uqp.goal_id, -1), isnull(uqp.progress, -1), dbo.ConvertToTimeT32(uq.registered_date)
	FROM SB_USER_QUEST (READUNCOMMITTED) uq 
	LEFT JOIN SB_USER_QUEST_PROGRESS (READUNCOMMITTED) uqp ON uq.quest_id = uqp.quest_id AND uq.user_id = uqp.user_id
	WHERE uq.user_id = @user_id AND finished = 0 
	--ORDER BY uq.registered_date ASC
END
GO
PRINT N'Creating [dbo].[SB_LoadQuestFinished]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadQuestFinished]
	@user_id int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT quest_id
	FROM SB_USER_QUEST (READUNCOMMITTED)
	WHERE user_id = @user_id AND finished = 1
END
GO
PRINT N'Creating [dbo].[SB_LoadQuestReset]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadQuestReset]
	@user_id int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT dbo.ConvertToTimeT32(daily_quest_reset)
	FROM SB_USER_QUEST_RESET (READUNCOMMITTED)
	WHERE user_id = @user_id
END
GO
PRINT N'Creating [dbo].[sb_LoadRecipe]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadRecipe]
	@user_id INT,
	@profession_id INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT recipe_id 
	FROM SB_USER_RECIPE (READUNCOMMITTED)
	WHERE user_id = @user_id
		AND (@profession_id = 0 AND (profession_id IN (SELECT profession_id FROM SB_USER_PROFESSION (READUNCOMMITTED) WHERE user_id = @user_id))
			OR (@profession_id > 0 AND profession_id = @profession_id))
END
GO
PRINT N'Creating [dbo].[sb_LoadRecipeCool]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadRecipeCool]
	@user_id int
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT [cool_id], [cool_time]
	FROM SB_USER_RECIPE_COOL (READUNCOMMITTED)
	WHERE [user_id] = @user_id
END
GO
PRINT N'Creating [dbo].[sb_LoadSecondaryMoney]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_LoadSecondaryMoney]
	@user_id INT
AS
BEGIN
	SET NOCOUNT ON;
	
	IF NOT EXISTS (SELECT ID FROM SB_USER_SECONDARY_MONEY (READUNCOMMITTED) WHERE ID = @user_id)
		INSERT SB_USER_SECONDARY_MONEY (ID) VALUES(@user_id);
	
	SELECT 
		infinite_hunt_point, infinite_hunt_point_weekly, 
		guild_warrior_point, guild_warrior_point_weekly, 
		arena_point, arena_point_weekly,
		private_arena_point, private_arena_point_weekly,
		team_arena_point, team_arena_point_weekly,
		ISNULL(dbo.ConvertToTimeT32(reset_time), 0)
	FROM 
		SB_USER_SECONDARY_MONEY (READUNCOMMITTED)
	WHERE 
		ID = @user_id;
END
GO
PRINT N'Creating [dbo].[sb_LoadShortCut]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadShortCut]
	@user_id         INT
	, @spec_id TINYINT
AS
BEGIN
	SET NOCOUNT ON

	SELECT slot_no, reg_type, reg_id
	FROM SB_SHORT_CUT (READUNCOMMITTED)
	WHERE user_id = @user_id
		AND spec_id = @spec_id
END
GO
PRINT N'Creating [dbo].[sb_LoadSkill]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadSkill]
	@user_id INT
	, @spec_id TINYINT
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT skill_id, skill_level
	FROM SB_USER_SKILL (READUNCOMMITTED)
	WHERE ID = @user_id
		AND spec_id = @spec_id
END
GO
PRINT N'Creating [dbo].[sb_LoadSkillCool]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadSkillCool]
	@user_id int
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT [cool_id], [cool_time]
	FROM SB_USER_SKILL_COOL (READUNCOMMITTED)
	WHERE [user_id] = @user_id
END
GO
PRINT N'Creating [dbo].[sb_LoadSkillTrigger]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadSkillTrigger]
	@user_id INT
	, @spec_id TINYINT
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT trigger_id, trigger_level
	FROM SB_USER_SKILL_TRIGGER (READUNCOMMITTED)
	WHERE ID = @user_id
		AND spec_id = @spec_id
END
GO
PRINT N'Creating [dbo].[sb_LoadSoul]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadSoul]
	@user_id INT
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT soul_type, amount FROM SB_USER_SOUL (READUNCOMMITTED)
	WHERE user_id = @user_id
END
GO
PRINT N'Creating [dbo].[SB_LoadSoulGemHistory]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadSoulGemHistory]
	@user_dbid INT,
	@page_no INT,
	@count_per_page INT,
	@base_date INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @base_order_date DATETIME = dbo.ConvertToDateTime32(@base_date);
	
	WITH MyOrderList AS
	(
		SELECT ROW_NUMBER() OVER (ORDER BY [ID] DESC) AS rowNo
			, dbo.ConvertToTimeT32([order_date]) as order_date
			, [rack_id], [product_id], [amount], [price], [recipient_id], [recipient_name]
		FROM [dbo].[SB_SHOP_ORDER_HISTORY] (READUNCOMMITTED)
		WHERE [buyer_id] = @user_dbid
			AND [order_date] > @base_order_date
	)
	
	SELECT [order_date], [rack_id], [product_id], [amount], [price]
		, CASE WHEN [recipient_id] = @user_dbid THEN 0 ELSE 1 END AS is_gift, [recipient_name]
	FROM MyOrderList
	WHERE rowNo BETWEEN ((@page_no - 1) * @count_per_page) + 1 AND (@page_no * @count_per_page)
END
GO
PRINT N'Creating [dbo].[SB_LoadSoulGemHistoryCount]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadSoulGemHistoryCount]
	@user_dbid INT,
	@base_date INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @base_order_date DATETIME = dbo.ConvertToDateTime32(@base_date);
	
	SELECT COUNT(*)
	FROM [dbo].[SB_SHOP_ORDER_HISTORY] (READUNCOMMITTED)
	WHERE [buyer_id] = @user_dbid
			AND [order_date] > @base_order_date
END
GO
PRINT N'Creating [dbo].[SB_LoadSoulSkill]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadSoulSkill]
	@user_dbid INT
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT [hope_exp],[purity_exp],[courage_exp],[well_exp],[selected_soul_type],[selected_seq]
	FROM [SB_USER_SOUL_SKILL] (READUNCOMMITTED)
	WHERE [user_dbid] = @user_dbid
END
GO
PRINT N'Creating [dbo].[sb_LoadSpec]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadSpec]
	@user_id	INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT spec_id, talent, ultimate_skill_id, ultimate_soul_type FROM SB_USER_INFO_MULTI_SPEC (READUNCOMMITTED)
	WHERE user_id=@user_id
END
GO
PRINT N'Creating [dbo].[sb_LoadTax]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadTax]
	@date bigint,
	@week_start_date bigint
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @dayDate as datetime;
	SET @dayDate = dbo.ConvertToDateTime32(@date);
	
	DECLARE @weekDate as datetime;
	SET @weekDate = dbo.ConvertToDateTime32(@week_start_date);
	
	SELECT ISNULL(CUMUL.cumul, -1), ISNULL(CUR.tax, -1), ISNULL(YES.tax, -1), ISNULL(YES.tax_rate, -1), ISNULL(CUR.tax_rate, -1), ISNULL(NEX.tax_rate, -1)
	FROM (
			SELECT SUM(tax) cumul
			FROM SB_TAX (READUNCOMMITTED)
			WHERE date >= @weekDate AND date < @dayDate
		) AS CUMUL
		,
		(
			SELECT MAX(tax) tax, MAX(tax_rate) tax_rate
			FROM SB_TAX (READUNCOMMITTED)
			WHERE date = @dayDate
		) AS CUR
		,
		(
			SELECT MAX(tax) tax, MAX(tax_rate) tax_rate
			FROM SB_TAX (READUNCOMMITTED)
			WHERE date = DATEADD(day, -1, @dayDate)
		) AS YES
		,
		(
			SELECT MAX(tax_rate) tax_rate
			FROM SB_TAX (READUNCOMMITTED)
			WHERE date = DATEADD(day, 1, @dayDate)
		) AS NEX
			
END
GO
PRINT N'Creating [dbo].[sb_LoadTaxGuild]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadTaxGuild]
	@weekDate bigint
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @curWeekDate as datetime
	SET @curWeekDate = dbo.ConvertToDateTime32(@weekDate);
	
	DECLARE @weekNo AS INT;
	SET @weekNo = ISNULL((SELECT TOP 1 week_no FROM SB_TAX_GUILD (READUNCOMMITTED) WHERE week_date = @curWeekDate ORDER BY week_no DESC), -1);
	
	DECLARE @prevWeekNo AS INT; 
	set @prevWeekNo = ISNULL((SELECT TOP 1 week_no FROM SB_TAX_GUILD (READUNCOMMITTED) WHERE week_date = DATEADD(week, -1, @curWeekDate) ORDER BY week_no DESC), -1);
	
	
	DECLARE @prevPVPWinner INT;
	DECLARE @prevPVEWinner INT;
	
	SELECT @prevPVPWinner = P.pvp_winner, @prevPVEWinner = P.pve_winner
	FROM SB_TAX_GUILD P (READUNCOMMITTED) 
	WHERE P.week_no = @prevWeekNo 
	
	DECLARE @currentPVPWinner INT;
	DECLARE @currentPVEWinner INT;
	
	SELECT @currentPVPWinner = C.pvp_winner, @currentPVEWinner = C.pve_winner
	FROM SB_TAX_GUILD C (READUNCOMMITTED)
	WHERE c.week_no = @weekNo 
	
	DECLARE @nextPVPWinner INT;
	
	SELECT @nextPVPWinner = N.pvp_winner
	FROM SB_TAX_GUILD N (READUNCOMMITTED)
	WHERE n.week_no = @weekNo + 1
	
	SELECT @weekNo, @prevWeekNo, ISNULL(@prevPVPWinner, 0), ISNULL(@currentPVPWinner, 0), ISNULL(@nextPVPWinner, 0), ISNULL(@prevPVEWinner, 0), ISNULL(@currentPVEWinner, 0)

END
GO
PRINT N'Creating [dbo].[SB_LoadTransmogrifyList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SB_LoadTransmogrifyList]
	@user_dbid int
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT class_id, slot_type, used FROM SB_USER_TRANSMOGRIFY_LIST (READUNCOMMITTED) WHERE ID = @user_dbid ORDER BY create_date
END
GO
PRINT N'Creating [dbo].[sb_LoadTrustSaleRight]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadTrustSaleRight]
	@user_id INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @TSR_BASE_MAX_SLOT INT = 7
	DECLARE @TSR_BASE_MAX_SLOT_IN_WEEK INT = 999

    IF NOT EXISTS (SELECT userDBID FROM SB_USER_TRUST_SALE (READUNCOMMITTED) WHERE userDBID = @user_id)
	BEGIN
		INSERT INTO SB_USER_TRUST_SALE (userDBID, slotMax, useMaxInWeek) 
		VALUES(@user_id, @TSR_BASE_MAX_SLOT, @TSR_BASE_MAX_SLOT_IN_WEEK);		
	END
	
	SELECT slotMax
		, usedSlot
		, useMaxInWeek
		, usedUseCount
		, CASE WHEN use_count_reset_time IS NULL THEN -1 ELSE dbo.ConvertToTimeT32(use_count_reset_time) END use_count_reset_time
		, CASE WHEN free_commission_reset_time IS NULL THEN -1 ELSE dbo.ConvertToTimeT32(free_commission_reset_time) END free_commission_reset_time
		, CASE WHEN slot_max_reset_time IS NULL THEN -1 ELSE dbo.ConvertToTimeT32(slot_max_reset_time) END slot_max_reset_time
	FROM SB_USER_TRUST_SALE (READUNCOMMITTED) 
	WHERE userDBID = @user_id;
END
GO
PRINT N'Creating [dbo].[sb_LoadUltimateSKill]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadUltimateSKill]
	@user_id	INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT ultimate_skill_id, hope_exp, courage_exp, purity_exp, well_exp FROM SB_USER_ULTIMATE_SKILL (READUNCOMMITTED)
	WHERE user_id=@user_id
END
GO
PRINT N'Creating [dbo].[SB_LoadUndecidedRandomAbility]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadUndecidedRandomAbility]
	@item_dbid bigint
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ability_type, ability_value
	FROM [dbo].[SB_ITEM_RANDOM_ABILITY_UNDECIDED]
	WHERE [ID] = @item_dbid
END
GO
PRINT N'Creating [dbo].[SB_LoadUnreadGiftItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SB_LoadUnreadGiftItem]
	@user_dbid INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT TOP 500 [ID], [gift_type]
	FROM [dbo].[SB_SHOP_GIFT_BOX] (READUNCOMMITTED)
	WHERE [recipient_dbid] = @user_dbid
		AND [delete_date] IS NULL
		AND [open_date] IS NULL
END
GO
PRINT N'Creating [dbo].[SB_LoadUnreadPostDBID]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadUnreadPostDBID]
	@user_dbid INT
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT TOP 500 ID
	FROM SB_POST_BOX (READUNCOMMITTED)
	WHERE recipient_dbid = @user_dbid
		AND delete_time IS NULL
		AND open_time IS NULL
END
GO
PRINT N'Creating [dbo].[sb_LoadUnsentTax]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadUnsentTax]
	@date bigint
AS
BEGIN
	SET NOCOUNT ON;

SELECT dbo.ConvertToTimeT32(T.date), T.tax, ISNULL(PG.masterDBID, -1) pvp_master, ISNULL(EG.masterDBID, -1) pve_master
	FROM SB_TAX T (READUNCOMMITTED)
	LEFT JOIN SB_TAX_GUILD G (READUNCOMMITTED) on (T.date BETWEEN G.week_date AND DATEADD(day, 6, G.week_date))
	LEFT JOIN SB_GUILD PG (READUNCOMMITTED) on (G.pvp_winner = PG.ID)
	LEFT JOIN SB_GUILD EG (READUNCOMMITTED) on (G.pve_winner = EG.ID)
	WHERE T.date <= dbo.ConvertToDateTime32(@date) 
	and 
	((is_pvp_sent = 0 and not (G.pvp_winner = -1 or G.pvp_winner = 0)) 
	or (is_pve_sent = 0 and not (G.pve_winner = -1 or G.pve_winner = 0)))

END
GO
PRINT N'Creating [dbo].[sb_LoadUser]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_LoadUser]
	@ID INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @SBC_TALENT_MAX INT = 3

	SELECT U.ID, U.account_id, U.job_type, U.name, U.title_id,
		U.face, U.body_color, U.eye, U.eye_color, U.hair, U.hair_color, U.decal, U.body_size, U.leg_size, U.head_size, U.breast_size,		
		A.hide_special, A.hide_corsage1, A.hide_corsage2, A.hide_costume, A.hide_special_equip,
		(
			(CAST(P.area_id AS BIGINT)		* 0x100000000000000) | 
			(CAST(P.region_id AS BIGINT)	* 0x1000000000000) | 
			(CAST(P.resource_id AS BIGINT)	* 0x100000000) | 
			(CAST(P.grid_x AS BIGINT)		* 0x1000000) | 
			(CAST(P.grid_y AS BIGINT)		* 0x10000) | 
			(CAST(P.grid_z AS BIGINT)		* 0x100) | 
			(CAST(P.reserved AS BIGINT))
		), 
		P.x, P.y, P.Z, P.yaw,
		I.lev, I.exp, I.hp, I.cp, I.energy, I.satiety, I.money, I.builder_lev, W.available_slot_count, 
		L.is_alive, I.vehicle, I.rest, I.elo, ISNULL(I.refusal, 0),
		ISNULL([dbo].ConvertToTimeT32(I.logOutTime),0) logOutTime, ISNULL([dbo].ConvertToTimeT32(I.logInTime),0) logInTime, 
		--I.talent,
		ISNULL(MS.talent, @SBC_TALENT_MAX), I.spec_id, I.spec_count,
		(
			(CAST(C.area_id AS BIGINT)		* 0x100000000000000) | 
			(CAST(C.region_id AS BIGINT)	* 0x1000000000000) | 
			(CAST(C.resource_id AS BIGINT)	* 0x100000000) | 
			(CAST(C.grid_x AS BIGINT)		* 0x1000000) | 
			(CAST(C.grid_y AS BIGINT)		* 0x10000) | 
			(CAST(C.grid_z AS BIGINT)		* 0x100) | 
			(CAST(C.reserved AS BIGINT))
		),
		C.x, C.y, C.Z,
		C.yaw, D.DUNGEON_LEVEL,
		(
			(CAST(V.area_id AS BIGINT)		* 0x100000000000000) | 
			(CAST(V.region_id AS BIGINT)	* 0x1000000000000) | 
			(CAST(V.resource_id AS BIGINT)	* 0x100000000) | 
			(CAST(V.grid_x AS BIGINT)		* 0x1000000) | 
			(CAST(V.grid_y AS BIGINT)		* 0x10000) | 
			(CAST(V.grid_z AS BIGINT)		* 0x100) | 
			(CAST(V.reserved AS BIGINT))
		),
		V.x, V.y, V.Z, V.yaw, 
		D.DUNGEON_LEVEL_EX, D.DUNGEON_RAID_LEVEL,
		(
			(CAST(R.area_id AS BIGINT)		* 0x100000000000000) | 
			(CAST(R.region_id AS BIGINT)	* 0x1000000000000) | 
			(CAST(R.resource_id AS BIGINT)	* 0x100000000) | 
			(CAST(R.grid_x AS BIGINT)		* 0x1000000) | 
			(CAST(R.grid_y AS BIGINT)		* 0x10000) | 
			(CAST(R.grid_z AS BIGINT)		* 0x100) | 
			(CAST(R.reserved AS BIGINT))
		),
		R.x, R.y, R.Z, R.yaw
		, I.bf_item_point
	FROM SB_USER (READUNCOMMITTED) U
		INNER JOIN SB_USER_INFO (READUNCOMMITTED) I ON U.ID = I.ID
		INNER JOIN SB_USER_POS (READUNCOMMITTED) P ON U.ID = P.ID
		INNER JOIN SB_USER_LIFE (READUNCOMMITTED) L ON U.ID = L.ID
		INNER JOIN SB_USER_CORPSE (READUNCOMMITTED) C ON U.ID = C.master_id
		INNER JOIN SB_USER_WAREHOUSE (READUNCOMMITTED) W ON U.ID = W.owner_dbid
		INNER JOIN SB_USER_POS_VALID (READUNCOMMITTED) V ON U.ID = V.user_id
		INNER JOIN SB_USER_AVATAR_ITEM (READUNCOMMITTED) A ON U.ID = A.ID
		INNER JOIN SB_USER_POS_REVIVE (READUNCOMMITTED) R ON U.ID = R.user_id
		LEFT JOIN SB_USER_INFO_MULTI_SPEC (READUNCOMMITTED) MS ON U.ID=MS.user_id AND I.spec_id=MS.spec_id
		LEFT JOIN SB_USER_DUNGEON (READUNCOMMITTED) D ON U.ID = D.ID
	WHERE U.ID = @ID
END
GO
PRINT N'Creating [dbo].[sb_LoadUserAppearance]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadUserAppearance]
	@user_dbid INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT
		U.face, U.body_color, U.eye, U.eye_color, U.hair
		, U.hair_color, U.decal, U.body_size, U.leg_size, U.head_size
		, U.breast_size,		
		A.hide_special, A.hide_corsage1, A.hide_corsage2, A.hide_costume, A.hide_special_equip
	FROM SB_USER (READUNCOMMITTED) U 
		INNER JOIN SB_USER_AVATAR_ITEM (READUNCOMMITTED) A ON U.ID = A.ID
	WHERE U.ID = @user_dbid
END
GO
PRINT N'Creating [dbo].[sb_LoadUserBOTReportedTime]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadUserBOTReportedTime]
	@user_dbid INT
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT user_dbid, dbo.ConvertToTimeT32(reported_time), report_count
	FROM SB_USER_BOT_REPORT (READUNCOMMITTED)
	WHERE user_dbid = @user_dbid
END
GO
PRINT N'Creating [dbo].[sb_LoadUserChatReportedTime]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadUserChatReportedTime]
	@user_dbid INT
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT user_dbid, dbo.ConvertToTimeT32(reported_time), report_count, reported_count_normal, reported_count_guild
	FROM SB_USER_CHAT_REPORT (READUNCOMMITTED)
	WHERE user_dbid = @user_dbid
END
GO
PRINT N'Creating [dbo].[sb_LoadUserData]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadUserData]
	@ID INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @SBC_TALENT_MAX INT = 3

	SELECT U.ID, U.account_id, U.job_type, U.name, U.title_id
		, I.lev, I.exp, I.hp, I.cp, I.energy, I.satiety, I.rest
		, I.money, I.builder_lev, I.vehicle
		, I.elo, I.bf_item_point
		, ISNULL(I.refusal, 0)
		, ISNULL(dbo.ConvertToTimeT32(I.logOutTime), 0) logOutTime, ISNULL(dbo.ConvertToTimeT32(I.logInTime), 0) logInTime
		, W.available_slot_count
		, ISNULL(MS.talent, @SBC_TALENT_MAX), I.spec_id, I.spec_count
		, L.last_death_reason, L.is_alive
	FROM SB_USER (READUNCOMMITTED) U
		INNER JOIN SB_USER_INFO (READUNCOMMITTED) I ON U.ID = I.ID
		INNER JOIN SB_USER_LIFE (READUNCOMMITTED) L ON U.ID = L.ID
		INNER JOIN SB_USER_WAREHOUSE (READUNCOMMITTED) W ON U.ID = W.owner_dbid
		INNER JOIN SB_USER_INFO_MULTI_SPEC (READUNCOMMITTED) MS ON U.ID=MS.user_id AND I.spec_id=MS.spec_id
	WHERE U.ID = @ID
END
GO
PRINT N'Creating [dbo].[sb_LoadUserDuelHistory]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadUserDuelHistory]
	@user_id int,
	@season_no int
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT talent_type, enemy_job_type, enemy_talent_type, season_win, season_lose, season_draw
	FROM SB_DUEL_ARENA_DETAIL
	WHERE user_dbid = @user_id AND season_no = @season_no
END
GO
PRINT N'Creating [dbo].[sb_LoadUserDungeon]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadUserDungeon]
	@user_dbid INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT
		D.dungeon_level, D.dungeon_level_ex, D.dungeon_raid_level
	FROM 
		SB_USER_DUNGEON (READUNCOMMITTED) D
	WHERE D.ID = @user_dbid
END
GO
PRINT N'Creating [dbo].[sb_LoadUserForMobile]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadUserForMobile]
	@ID INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @SBC_TALENT_MAX INT = 3

	SELECT U.ID, U.account_id, AC.name, U.job_type, U.name, U.title_id,
		I.lev, I.exp, I.hp, I.cp, I.energy, I.satiety, I.money, I.builder_lev, W.available_slot_count, I.elo,
		ISNULL([dbo].ConvertToTimeT32(I.logOutTime),0) logOutTime, ISNULL([dbo].ConvertToTimeT32(I.logInTime),0) logInTime, 
		ISNULL(MS.talent, @SBC_TALENT_MAX), I.spec_id
	FROM SB_USER (READUNCOMMITTED) U
		INNER JOIN SB_USER_INFO (READUNCOMMITTED) I ON U.ID = I.ID
		INNER JOIN SB_ACCOUNT (READUNCOMMITTED) AC ON AC.ID = U.account_id
		INNER JOIN SB_USER_WAREHOUSE (READUNCOMMITTED) W ON U.ID = W.owner_dbid
		LEFT JOIN SB_USER_INFO_MULTI_SPEC (READUNCOMMITTED) MS ON U.ID=MS.user_id AND I.spec_id=MS.spec_id
	WHERE U.ID = @ID
END
GO
PRINT N'Creating [dbo].[sb_LoadUserPosition]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadUserPosition]
	@user_dbid INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT 
		(
			(CAST(P.area_id AS BIGINT)		* 0x100000000000000) | 
			(CAST(P.region_id AS BIGINT)	* 0x1000000000000) | 
			(CAST(P.resource_id AS BIGINT)	* 0x100000000) | 
			(CAST(P.grid_x AS BIGINT)		* 0x1000000) | 
			(CAST(P.grid_y AS BIGINT)		* 0x10000) | 
			(CAST(P.grid_z AS BIGINT)		* 0x100) | 
			(CAST(P.reserved AS BIGINT))
		),
		P.x, P.y, P.Z, P.yaw,
		(
			(CAST(C.area_id AS BIGINT)		* 0x100000000000000) | 
			(CAST(C.region_id AS BIGINT)	* 0x1000000000000) | 
			(CAST(C.resource_id AS BIGINT)	* 0x100000000) | 
			(CAST(C.grid_x AS BIGINT)		* 0x1000000) | 
			(CAST(C.grid_y AS BIGINT)		* 0x10000) | 
			(CAST(C.grid_z AS BIGINT)		* 0x100) | 
			(CAST(C.reserved AS BIGINT))
		),
		C.x, C.y, C.Z, C.yaw,
		(
			(CAST(V.area_id AS BIGINT)		* 0x100000000000000) | 
			(CAST(V.region_id AS BIGINT)	* 0x1000000000000) | 
			(CAST(V.resource_id AS BIGINT)	* 0x100000000) | 
			(CAST(V.grid_x AS BIGINT)		* 0x1000000) | 
			(CAST(V.grid_y AS BIGINT)		* 0x10000) | 
			(CAST(V.grid_z AS BIGINT)		* 0x100) | 
			(CAST(V.reserved AS BIGINT))
		),
		V.x, V.y, V.Z, V.yaw, 
		(
			(CAST(R.area_id AS BIGINT)		* 0x100000000000000) | 
			(CAST(R.region_id AS BIGINT)	* 0x1000000000000) | 
			(CAST(R.resource_id AS BIGINT)	* 0x100000000) | 
			(CAST(R.grid_x AS BIGINT)		* 0x1000000) | 
			(CAST(R.grid_y AS BIGINT)		* 0x10000) | 
			(CAST(R.grid_z AS BIGINT)		* 0x100) | 
			(CAST(R.reserved AS BIGINT))
		),
		R.x, R.y, R.Z, R.yaw
	FROM		
		SB_USER_POS (READUNCOMMITTED) P
		INNER JOIN SB_USER_CORPSE (READUNCOMMITTED) C ON P.ID = C.master_id
		INNER JOIN SB_USER_POS_VALID (READUNCOMMITTED) V ON P.ID = V.user_id
		INNER JOIN SB_USER_POS_REVIVE (READUNCOMMITTED) R ON P.ID = R.user_id
	WHERE P.ID = @user_dbid	
END
GO
PRINT N'Creating [dbo].[sb_LoadVehicle]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadVehicle]
	@user_dbid INT
AS  
BEGIN  
	SET NOCOUNT ON;
		
	SELECT vehicle_class_id, ID, vehicle_slot_index,
		CASE WHEN expire_date IS NULL THEN -1 ELSE dbo.ConvertToTimeT32(expire_date) END expire_date
	FROM SB_USER_VEHICLE (READUNCOMMITTED)
	WHERE owner_dbid = @user_dbid
	ORDER BY ID ASC
END
GO
PRINT N'Creating [dbo].[SB_LoadVisitedPos]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadVisitedPos]
	@user_id int
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT world_coord
	FROM SB_USER_VISITED_POS (READUNCOMMITTED)
	WHERE ID = @user_id
END
GO
PRINT N'Creating [dbo].[SB_LoadWarehouse]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadWarehouse]
	@owner_dbid int
AS
BEGIN
	SET NOCOUNT ON

    SELECT [ID], [bag_type], [slot_index], [source_item_class_id], [max_slot_count]
    FROM SB_ITEM_BAG (READUNCOMMITTED)
    WHERE [owner_dbid] = @owner_dbid
		AND [bag_type] = 1
END
GO
PRINT N'Creating [dbo].[SB_LoadWarehouseMoney]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadWarehouseMoney]
	@owner_dbid INT
AS
BEGIN
	SET NOCOUNT ON

    SELECT [money]
    FROM SB_USER_WAREHOUSE (READUNCOMMITTED)
    WHERE owner_dbid = @owner_dbid
END
GO
PRINT N'Creating [dbo].[sb_LoadWarpRegionList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_LoadWarpRegionList]  
 @user_id int
AS  
BEGIN  
 SET NOCOUNT ON  
    
 SELECT warp_region
 FROM SB_WARP (READUNCOMMITTED)
 WHERE ID = @user_id
 
END
GO
PRINT N'Creating [dbo].[SB_LoadWFAchievementFinished]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LoadWFAchievementFinished]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT achievement_id FROM SB_WORLDFIRST_ACHIEVEMENT (READUNCOMMITTED)
END
GO
PRINT N'Creating [dbo].[SB_LOGIN]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LOGIN]
	@user_id INT,
	@ip	NVARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	UPDATE SB_USER_INFO SET logInTime = GETDATE(),
		IP = @ip
		WHERE ID = @user_id	
END
GO
PRINT N'Creating [dbo].[SB_LOGOUT]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_LOGOUT]
	@user_id int
AS
BEGIN
	SET NOCOUNT ON	
	
	UPDATE SB_USER_INFO SET logOutTime = GETDATE()
		WHERE ID = @user_id	
	
END
GO
PRINT N'Creating [dbo].[SB_MagicTimeLoad]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_MagicTimeLoad]
	@user_id int
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT play_time, dbo.ConvertToTimeT32(last_reset_time)
	FROM SB_MAGIC_TIME (READUNCOMMITTED)
	WHERE user_id = @user_id
END
GO
PRINT N'Creating [dbo].[SB_MagicTimeReset]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_MagicTimeReset]
	@user_id int,
	@reset_time int
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE SB_MAGIC_TIME
	SET play_time = 0, last_reset_time = dbo.ConvertToDateTime32(@reset_time)
	WHERE user_id = @user_id
	
	IF @@ROWCOUNT = 0
	BEGIN
		INSERT INTO SB_MAGIC_TIME (user_id, play_time, last_reset_time)
		VALUES (@user_id, 0, dbo.ConvertToDateTime32(@reset_time))
	END
END
GO
PRINT N'Creating [dbo].[SB_MagicTimeSave]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_MagicTimeSave]
	@user_id int,
	@play_time int
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE SB_MAGIC_TIME
	SET play_time = @play_time
	WHERE user_id = @user_id
	
	IF @@ROWCOUNT = 0
	BEGIN
		INSERT INTO SB_MAGIC_TIME (user_id, play_time, last_reset_time)
		VALUES (@user_id, @play_time, dbo.ConvertToDateTime32(0))
	END
END
GO
PRINT N'Creating [dbo].[SB_MakeNewGiftItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_MakeNewGiftItem]
	@gift_type INT
	, @sender_dbid INT
	, @sender_name NVARCHAR(64)
	, @recipient_dbid INT
	, @recipient_name NVARCHAR(64)
	, @message NVARCHAR(64)
	, @nagging_dbid BIGINT
	, @gift_list TripleIntParam READONLY
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @gift_id INT = 0
	
	SELECT @recipient_dbid = ID
	FROM dbo.SB_USER (READUNCOMMITTED)
	WHERE name = @recipient_name
		AND deleted_time IS NULL
		AND final_deleted = 'N'
		
	IF @recipient_dbid = 0
	BEGIN
		SELECT @gift_id, @recipient_dbid, -507	-- Shop::DB_UNKNOWN_RECIPIENT
		RETURN
	END

	INSERT INTO [SB_SHOP_GIFT_BOX] ([gift_type], [sender_dbid], [sender_name], [recipient_dbid], [recipient_name], [message])
	VALUES (@gift_type, @sender_dbid, @sender_name, @recipient_dbid, @recipient_name, @message)
	
	SET @gift_id = SCOPE_IDENTITY()

	INSERT INTO [SB_SHOP_GIFT_ITEM] ([gift_id], [rack_id], [rack_amount], [selected_product_id])
	SELECT @gift_id, [first], [second], [third]
	FROM @gift_list
	
	UPDATE [SB_SHOP_GIFT_BOX]
	SET receive_date = GETDATE()
	WHERE ID = @nagging_dbid
		AND gift_type = 1		-- USER_NAGGING
		AND receive_date IS NULL
	
	SELECT @gift_id, @recipient_dbid, 0
END
GO
PRINT N'Creating [dbo].[sb_MakeTaxUnsent]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_MakeTaxUnsent]
	@date bigint
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @dayDate as datetime;
	SET @dayDate = dbo.ConvertToDateTime32(@date);
	
	UPDATE SB_TAX SET is_pvp_sent = 0, is_pve_sent = 0 WHERE date = @dayDate;
	
END
GO
PRINT N'Creating [dbo].[sb_ManipulateAddItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ManipulateAddItem] 
	@add ItemParam READONLY
AS
BEGIN
	SET NOCOUNT ON

	MERGE SB_ITEM WITH (HOLDLOCK) T
	USING (SELECT * FROM @add) AS S (item_oid, item_dbid, owner_dbid, bag_dbid, class_id, amount, slot_index, repository_type)
		ON T.ID = S.item_dbid
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (owner_id, bag_id, class_id, amount, slot_index) 
		VALUES (S.owner_dbid, S.bag_dbid, S.class_id, S.amount, S.slot_index)
	OUTPUT S.item_oid, inserted.ID, inserted.owner_id, inserted.bag_id, inserted.class_id, inserted.amount, inserted.slot_index, S.repository_type
	;
END
GO
PRINT N'Creating [dbo].[sb_ManipulateAddOneItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ManipulateAddOneItem] 
	@item_oid BIGINT
	, @item_dbid BIGINT
	, @owner_dbid INT
	, @bag_dbid INT
	, @item_class_id INT
	, @item_amount INT
	, @slot_index INT
	, @repository_type INT
AS
BEGIN
	SET NOCOUNT ON

	INSERT INTO SB_ITEM (owner_id, bag_id, class_id, amount, slot_index) 
	VALUES (@owner_dbid, @bag_dbid, @item_class_id, @item_amount, @slot_index)

	SELECT @item_oid, SCOPE_IDENTITY(), @owner_dbid, @bag_dbid, @item_class_id, @item_amount, @slot_index, @repository_type
END
GO
PRINT N'Creating [dbo].[sb_ManipulateDeleteItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ManipulateDeleteItem] 
	@delete ItemParam READONLY
AS
BEGIN
	SET NOCOUNT ON

	UPDATE SB_ITEM
	SET is_deleted = 1
		, delete_date = GETDATE()
		OUTPUT d.item_oid, inserted.ID item_dbid, deleted.owner_id owner_dbid, deleted.bag_id, deleted.class_id, deleted.amount, deleted.slot_index, d.repository_type
	FROM SB_ITEM
		INNER JOIN @delete AS d ON (SB_ITEM.ID = d.item_dbid)
	WHERE is_deleted = 0
END
GO
PRINT N'Creating [dbo].[SB_ManipulateDeleteItemRollback]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_ManipulateDeleteItemRollback] 
	@deleted ItemParam READONLY
AS
BEGIN
	SET NOCOUNT ON

	UPDATE SB_ITEM
	SET is_deleted = 0
		, delete_date = NULL
	WHERE ID in (SELECT item_dbid FROM @deleted) AND is_deleted = 1
END
GO
PRINT N'Creating [dbo].[sb_ManipulateDeleteOneItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ManipulateDeleteOneItem] 
	@item_oid BIGINT
	, @item_dbid BIGINT
	, @owner_dbid INT
	, @bag_dbid INT
	, @item_class_id INT
	, @item_amount INT
	, @slot_index INT
	, @repository_type INT
AS
BEGIN
	SET NOCOUNT ON

	UPDATE SB_ITEM
	SET is_deleted = 1
		, delete_date = GETDATE()
	OUTPUT @item_oid, inserted.ID item_dbid, deleted.owner_id owner_dbid, deleted.bag_id, deleted.class_id, deleted.amount, deleted.slot_index, @repository_type
	WHERE ID = @item_dbid
		AND is_deleted = 0
END
GO
PRINT N'Creating [dbo].[sb_ManipulateDeleteOneItemRollback]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ManipulateDeleteOneItemRollback] 
	@item_oid BIGINT
	, @item_dbid BIGINT
	, @owner_dbid INT
	, @bag_dbid INT
	, @item_class_id INT
	, @item_amount INT
	, @slot_index INT
	, @repository_type INT
AS
BEGIN
	SET NOCOUNT ON

	UPDATE SB_ITEM
	SET is_deleted = 0
		, delete_date = NULL
	WHERE ID = @item_dbid AND is_deleted = 1
END
GO
PRINT N'Creating [dbo].[sb_ManipulateUpdateItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ManipulateUpdateItem] 
	@update ItemParam READONLY
AS
BEGIN
	SET NOCOUNT ON

	UPDATE SB_ITEM
	SET owner_id = up.owner_dbid
		, bag_id = up.bag_dbid
		, class_id = up.class_id
		, amount = SB_ITEM.amount + up.amount
		, slot_index = up.slot_index
		OUTPUT up.item_oid, inserted.ID item_dbid, deleted.owner_id owner_dbid, deleted.bag_id, deleted.class_id, -up.amount amount, deleted.slot_index, up.repository_type
	FROM SB_ITEM
		INNER JOIN @update AS up ON (SB_ITEM.ID = up.item_dbid)
	WHERE SB_ITEM.amount + up.amount > 0
	-- amount = for rollback
END
GO
PRINT N'Creating [dbo].[sb_ManipulateUpdateOneItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ManipulateUpdateOneItem] 
	@item_oid BIGINT
	, @item_dbid BIGINT
	, @owner_dbid INT
	, @bag_dbid INT
	, @item_class_id INT
	, @item_amount INT
	, @slot_index INT
	, @repository_type INT
AS
BEGIN
	SET NOCOUNT ON

	UPDATE SB_ITEM
	SET owner_id = @owner_dbid
		, bag_id = @bag_dbid
		, class_id = @item_class_id
		, amount = amount + @item_amount
		, slot_index = @slot_index
	OUTPUT @item_oid, inserted.ID item_dbid, deleted.owner_id owner_dbid, deleted.bag_id, deleted.class_id, -@item_amount, deleted.slot_index, @repository_type
	WHERE ID = @item_dbid
		AND 0 < amount + @item_amount
END
GO
PRINT N'Creating [dbo].[SB_MarkPostAttachmentTaken]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_MarkPostAttachmentTaken]
	@user_dbid INT
	, @post_id INT
AS
BEGIN
	SET NOCOUNT ON
	
	UPDATE SB_POST_BOX
	SET take_attached_time = GETDATE()
	WHERE ID = @post_id
		AND recipient_dbid = @user_dbid
		
	SELECT @@ROWCOUNT
END
GO
PRINT N'Creating [dbo].[SB_MarkPostDeleted]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_MarkPostDeleted]
	@user_dbid INT
	, @basic_date INT
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @deleted_post_dbid TABLE (post_id INT)
	DECLARE @now DATETIME = dbo.ConvertToDateTime32(@basic_date)
	DECLARE @expired_date DATETIME = DATEADD(DAY, -30, @now)
	DECLARE @sys_expired_date DATETIME = DATEADD(DAY, -90, @now)

	UPDATE SB_POST_BOX
	SET delete_time = @now
	OUTPUT DELETED.ID
	INTO @deleted_post_dbid (post_id)
	WHERE recipient_dbid = @user_dbid
		AND ((send_time <= @expired_date AND sender_type IN (0,1)) OR (send_time <= @sys_expired_date AND sender_type IN (3,4)))

	SELECT post_id
	FROM @deleted_post_dbid
END
GO
PRINT N'Creating [dbo].[SB_MarkPostOpened]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_MarkPostOpened]
	@user_dbid INT
	, @post_id INT
AS
BEGIN
	SET NOCOUNT ON
	
	UPDATE SB_POST_BOX
	SET open_time = GETDATE()
	WHERE ID = @post_id
		AND recipient_dbid = @user_dbid
		
	SELECT @@ROWCOUNT
END
GO
PRINT N'Creating [dbo].[sb_MarkVisitedPos]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_MarkVisitedPos]
	@user_dbid INT,
	@coord BIGINT
AS
BEGIN
	SET NOCOUNT ON

	MERGE SB_USER_VISITED_POS WITH (HOLDLOCK) T
	USING (VALUES (@user_dbid, @coord)) AS S (user_dbid, world_coord)
		ON T.ID = S.user_dbid AND T.world_coord = S.world_coord
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (ID, world_coord, area_id, region_id, resource_id, grid_x, grid_y, grid_z, reserved)
		VALUES (@user_dbid, @coord, (@coord & 0xff00000000000000) / 0xffffffffffffff,
			(@coord & 0xff000000000000) / 0xffffffffffff,
			(@coord & 0xffff00000000) / 0xffffffff,
			(@coord & 0xff000000) / 0xffffff,
			(@coord & 0xff0000) / 0xffff,
			(@coord & 0xff00) / 0xff,
			(@coord & 0xff))
	;
END
GO
PRINT N'Creating [dbo].[SB_MobileBuddyAdd]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_MobileBuddyAdd]
	@user_id INT,
	@buddy_name NVARCHAR(64)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @result INT = 0		-- success
	DECLARE @buddy_id INT = 0
	DECLARE @char_builder_level INT = 0
	
	SELECT @buddy_id = ID FROM SB_USER (READUNCOMMITTED) WHERE name = @buddy_name
	IF @buddy_id = 0
	BEGIN
		SET @result = 1			-- not user
	END
	
	SELECT @char_builder_level = I.builder_lev 
	FROM SB_USER U (READUNCOMMITTED) INNER JOIN SB_USER_INFO I (READUNCOMMITTED) ON U.ID = I.ID
	WHERE U.name = @buddy_name
	IF @char_builder_level > 0
	BEGIN
		SET @result = 4			-- builder
	END
	
	IF @result = 0
	BEGIN
		IF NOT EXISTS (SELECT user_id FROM SB_BUDDY (READUNCOMMITTED) WHERE user_id = @user_id AND buddy_id = @buddy_id)
		BEGIN
			INSERT INTO SB_BUDDY(user_id, buddy_id) VALUES(@user_id, @buddy_id)
		END
		ELSE
		BEGIN
			SET @result = 2		-- exist buddy
		END
	END
	
	
	SELECT @result, U1.ID, U1.name, U2.lev, U1.job_type, U3.area_id, U3.region_id, ISNULL(dbo.ConvertToTimeT32(U2.logOutTime), 0) logOutTime
		FROM SB_USER AS U1 (READUNCOMMITTED)
		INNER JOIN SB_USER_INFO AS U2 (READUNCOMMITTED) ON (U1.ID = U2.ID)
		INNER JOIN SB_USER_POS AS U3 (READUNCOMMITTED) ON (U1.ID = U3.ID)
		WHERE U1.ID = @buddy_id
		
END
GO
PRINT N'Creating [dbo].[SB_MobileBuddyDelete]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_MobileBuddyDelete]
	@user_id INT,
	@buddy_name NVARCHAR(64)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @buddy_id INT = 0
	SELECT @buddy_id = ID FROM SB_USER (READUNCOMMITTED) WHERE name = @buddy_name
	
	IF EXISTS (SELECT user_id FROM SB_BUDDY (READUNCOMMITTED) WHERE user_id = @user_id AND buddy_id = @buddy_id)
	BEGIN
		DELETE SB_BUDDY WHERE user_id = @user_id AND buddy_id = @buddy_id
		SELECT 1;	
	END
	ELSE
	BEGIN
		SELECT 0;	
	END

END
GO
PRINT N'Creating [dbo].[sb_MonthlySubscriptionActivate]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_MonthlySubscriptionActivate]
	@user_db_id int,
	@last_provide_time int,
	@activate_time int,
	@expired_time int
AS
BEGIN
	SET NOCOUNT ON
	
	UPDATE SB_USER_MONTHLY_SUBSCRIPTION 
	SET 
		last_provided_basis_time    = dbo.ConvertToDateTime32(@last_provide_time),
		activated_subscription_time = dbo.ConvertToDateTime32(@activate_time),
		expired_subscription_time   = dbo.ConvertToDateTime32(@expired_time)
	WHERE user_db_id = @user_db_id
	
	INSERT INTO SB_USER_MONTHLY_SUBSCRIPTION_HISTORY(user_db_id, provided_time, provided_basis_time)
	values(@user_db_id, getdate(), dbo.ConvertToDateTime32(@last_provide_time))
END
GO
PRINT N'Creating [dbo].[sb_MonthlySubscriptionLoad]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_MonthlySubscriptionLoad]
	@user_db_id int
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT 
		dbo.ConvertToTimeT32(last_provided_basis_time), 
		dbo.ConvertToTimeT32(activated_subscription_time), 
		dbo.ConvertToTimeT32(expired_subscription_time)
	FROM SB_USER_MONTHLY_SUBSCRIPTION (READUNCOMMITTED)
	WHERE user_db_id = @user_db_id
END
GO
PRINT N'Creating [dbo].[sb_MonthlySubscriptionProvideItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_MonthlySubscriptionProvideItem]  
 @user_db_id int,  
 @last_provide_basis_time int  
AS  
BEGIN  
 SET NOCOUNT ON  
   
 UPDATE SB_USER_MONTHLY_SUBSCRIPTION   
 SET   
  last_provided_basis_time = dbo.ConvertToDateTime32(@last_provide_basis_time)  
 WHERE user_db_id = @user_db_id  
   
 INSERT INTO SB_USER_MONTHLY_SUBSCRIPTION_HISTORY(user_db_id, provided_time, provided_basis_time)  
 values(@user_db_id, getdate(), dbo.ConvertToDateTime32(@last_provide_basis_time))  
END
GO
PRINT N'Creating [dbo].[sb_NoviceGuildCreate]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_NoviceGuildCreate]
	@guildID		INT,
	@name			NVARCHAR(64),
	@juniorRight	INT,
	@newbieRight    INT
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO 
		SB_GUILD(ID, name, masterDBID, type, totype, mark, level, exp, sub_right, senior_right, junior_right, newbie_right, war_point, money)	
	VALUES(@guildID, @name, 0, 2, 0, 0, 5, 0, 0, 0, @juniorRight, @newbieRight, 0, 0)
END
GO
PRINT N'Creating [dbo].[sb_PackagePointLoad]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_PackagePointLoad]
	@user_dbid INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT item_class_id, package_point
	FROM SB_USER_PACKAGE_POINT (READUNCOMMITTED)
	WHERE user_dbid = @user_dbid
END
GO
PRINT N'Creating [dbo].[sb_PackagePointSave]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_PackagePointSave]
	@user_dbid INT
	, @item_class_id INT 
	, @point_delta INT
AS
BEGIN
	SET NOCOUNT ON;
	
	MERGE SB_USER_PACKAGE_POINT T
	USING 
		(SELECT @user_dbid, @item_class_id, @point_delta) 
			AS S (user_dbid, item_class_id, point_delta)
		ON S.user_dbid = T.user_dbid AND S.item_class_id = T.item_class_id
	WHEN MATCHED AND T.package_point = -S.point_delta THEN
		DELETE
	WHEN MATCHED THEN
		UPDATE 
		SET T.package_point = T.package_point + S.point_delta		
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_dbid, item_class_id, package_point)
		VALUES (S.user_dbid, S.item_class_id, S.point_delta)
	;
END
GO
PRINT N'Creating [dbo].[sb_PrintCoord]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_PrintCoord]
(@coord BIGINT)
AS
BEGIN
	SELECT (@coord & 0xff00000000000000) / 0xffffffffffffff area_id,
		(@coord & 0xff000000000000) / 0xffffffffffff region_id,
		(@coord & 0xffff00000000) / 0xffffffff resource_id,
		(@coord & 0xff000000) / 0xffffff grid_x,
		(@coord & 0xff0000) / 0xffff grid_y,
		(@coord & 0xff00) / 0xff grid_z,
		(@coord & 0xff) reserved
END
GO
PRINT N'Creating [dbo].[sb_PrivateArenaLoad]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_PrivateArenaLoad]
	@season_no INT,
	@week_no INT,
	@user_dbid INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT ISNULL(A.season_win, 0), ISNULL(A.season_lose, 0), ISNULL(A.season_draw, 0), ISNULL(A.season_win_in_row, 0), ISNULL(A.season_lose_in_row, 0), ISNULL(A.season_elo, 1200)
	, ISNULL(W.week_win, 0), ISNULL(W.week_lose, 0), ISNULL(W.week_draw, 0), ISNULL(A.season_award, 0)
	FROM SB_PRIVATE_ARENA (READUNCOMMITTED) A
		LEFT JOIN 
		SB_PRIVATE_ARENA_WEEK (READUNCOMMITTED) W
			ON W.user_dbid = A.user_dbid AND W.season_no = A.season_no AND W.week_no = @week_no
	WHERE A.user_dbid = @user_dbid AND A.season_no = @season_no	
END
GO
PRINT N'Creating [dbo].[sb_PrivateArenaSave]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_PrivateArenaSave]
	@season_no INT,
	@week_no INT,
	@user_dbid INT,
	@win_delta INT, 
	@lose_delta INT, 
	@draw_delta INT, 
	@win_in_row_delta INT, 
	@lose_in_row_delta INT, 
	@elo_delta INT,
	@award_delta BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	
	MERGE SB_PRIVATE_ARENA A
	USING 
		(SELECT @user_dbid, @season_no, @win_delta, @lose_delta, @draw_delta, @win_in_row_delta, @lose_in_row_delta, @elo_delta, @award_delta) 
			AS T (user_dbid, season_no, season_win, season_lose, season_draw, season_win_in_row, season_lose_in_row, season_elo, season_award)
		ON A.user_dbid = T.user_dbid AND A.season_no = T.season_no
	WHEN MATCHED THEN
		UPDATE 
		SET
			A.season_win = A.season_win + T.season_win,
			A.season_lose = A.season_lose + T.season_lose,
			A.season_draw = A.season_draw + T.season_draw,
			A.season_win_in_row = A.season_win_in_row + T.season_win_in_row,
			A.season_lose_in_row = A.season_lose_in_row + T.season_lose_in_row,
			A.season_elo = A.season_elo + T.season_elo,
			A.season_award = A.season_award + T.season_award
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (season_no, user_dbid, season_win, season_lose, season_draw, season_win_in_row, season_lose_in_row, season_elo, season_award)
		VALUES (T.season_no, T.user_dbid, T.season_win, T.season_lose, T.season_draw, T.season_win_in_row, T.season_lose_in_row, 1200 + T.season_elo, T.season_award)
	;
	
	MERGE SB_PRIVATE_ARENA_WEEK W
	USING	
		(SELECT @user_dbid, @season_no, @week_no, @win_delta, @lose_delta, @draw_delta) 
			AS T (user_dbid, season_no, week_no, week_win, week_lose, week_draw)
		ON W.user_dbid = T.user_dbid AND W.season_no = T.season_no AND W.week_no = T.week_no
	WHEN MATCHED THEN
		UPDATE 
		SET
			W.week_win = W.week_win + T.week_win,
			W.week_lose = W.week_lose + T.week_lose,
			W.week_draw = W.week_draw + T.week_draw
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_dbid, season_no, week_no, week_win, week_lose, week_draw)
		VALUES (T.user_dbid, T.season_no, T.week_no, T.week_win, T.week_lose, T.week_draw)
	;
		
END
GO
PRINT N'Creating [dbo].[sb_PrivateArenaSeasonRecordReset]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_PrivateArenaSeasonRecordReset]
	@season_no INT,
	@user_dbid INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DELETE FROM SB_PRIVATE_ARENA
	WHERE user_dbid = @user_dbid AND season_no = @season_no
	
	DELETE FROM SB_PRIVATE_ARENA_WEEK
	WHERE user_dbid = @user_dbid AND season_no = @season_no
		
END
GO
PRINT N'Creating [dbo].[sb_PurgeExpiredPost]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_PurgeExpiredPost]
	@PURGE_PERIOD		INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @now 						DATETIME;
	DECLARE @purge_date					DATETIME;	
	
	SET @now 		= GETDATE();
	SET @purge_date	= DATEADD(DAY, -@PURGE_PERIOD, @now);
	
	DECLARE @tmp_purged_post_list TABLE (ID int)
	
	-- Collect purged post list
	INSERT INTO @tmp_purged_post_list (ID) 
		SELECT ID FROM [dbo].[SB_POST_BOX_EXPIRED] (READUNCOMMITTED) 
		WHERE 
			[expired_date] <= @purge_date;
	
	
	DELETE FROM [dbo].[SB_POST_ATTACHED_ITEM_EXPIRED] WHERE [post_id] IN (SELECT ID FROM @tmp_purged_post_list)
	DELETE FROM [dbo].[SB_POST_BOX_EXPIRED] WHERE [ID] IN (SELECT ID FROM @tmp_purged_post_list)	
	
	DECLARE @purged_count AS INT = 0;

	SELECT @purged_count = COUNT(*)   FROM @tmp_purged_post_list;
	SELECT @purged_count AS PurgedCount;	
END
GO
PRINT N'Creating [dbo].[SB_PutTheGemIntoSocket]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SB_PutTheGemIntoSocket] 
	@ID bigint,
	@GemClassID int,
	@SocketIndex int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    delete from SB_ITEM_GEM where ID = @ID and SocketIndex = @SocketIndex;
    
    insert into SB_ITEM_GEM(ID, GemClassID, SocketIndex) values (@ID, @GemClassID, @SocketIndex);
	
END
GO
PRINT N'Creating [dbo].[sb_QueryExpiredPostCount]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_QueryExpiredPostCount]
	@normal_post_expiration_period		INT,
	@sys_post_expiration_period			INT	
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @now DATETIME
	DECLARE @normal_expired_date		DATETIME
	DECLARE @sys_expired_date			DATETIME
	
	SET @now = GETDATE()
	SET @normal_expired_date			= DATEADD(DAY, -@normal_post_expiration_period, @now)
	SET @sys_expired_date				= DATEADD(DAY, -@sys_post_expiration_period, @now)	
	
	DECLARE @expired_post_count AS BIGINT = 0;
	
	SELECT @expired_post_count = COUNT(*) FROM SB_POST_BOX (READUNCOMMITTED) 
		WHERE 
			([send_time] <= @normal_expired_date AND sender_type IN (1,2)) OR
			([send_time] <= @sys_expired_date    AND sender_type IN (3,4)) OR
			[delete_time] IS NOT NULL;
	
	SELECT @expired_post_count
END
GO
PRINT N'Creating [dbo].[sb_ReadGuildHistory]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ReadGuildHistory]
	@guildID			INT,
	@maxHistory			INT,
	@historyTypeBegin	INT,
	@historyTypeEnd		INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT	TOP(@maxHistory)
			historyType, 
			memberName, 
			targetGuildName, 
			targetMemberName, 
			itemClassID, 
			itemAmount,
			fromGrade, 
			toGrade, 
			guildLevel, 
			[money], 
			[dbo].ConvertToTimeT32(logTime) AS logTime
	FROM [dbo].[SB_GUILD_HISTORY] (READUNCOMMITTED)
	
	WHERE guildID = @guildID AND
		  historyType >= @historyTypeBegin  AND
		  historyType < @historyTypeEnd
END
GO
PRINT N'Creating [dbo].[SB_ReceiveGift]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SB_ReceiveGift]
	@user_dbid INT
	, @gift_id BIGINT
AS
BEGIN
	SET NOCOUNT ON
	
	UPDATE [dbo].[SB_SHOP_GIFT_BOX]
	SET [receive_date] = GETDATE()
	WHERE [ID] = @gift_id
		AND [recipient_dbid] = @user_dbid
		AND [receive_date] IS NULL
		
	SELECT @@ROWCOUNT
END
GO
PRINT N'Creating [dbo].[SB_RecordServerHistory]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SB_RecordServerHistory]
	-- Add the parameters for the stored procedure here
	@peer_name NVARCHAR(50),
	@up_down_flag NVARCHAR(1)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO SB_SERVER_HISTORY (peer_name, up_down_flag)
	VALUES (@peer_name, @up_down_flag);
END
GO
PRINT N'Creating [dbo].[sb_RecoveryGuildDominionSpotInfo]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_RecoveryGuildDominionSpotInfo]
	@weekNo INT
AS  
BEGIN 
	SET NOCOUNT ON
	
	SELECT spotID, ownerGuildDBID FROM SB_GUILD_DOMINION (READUNCOMMITTED) WHERE weekNo = @weekNo

END
GO
PRINT N'Creating [dbo].[sb_RecoveryGuildDominionTime]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_RecoveryGuildDominionTime]
	@weekNo INT
AS  
BEGIN  
	DECLARE	@SAVE_TIME_SLOT int
	SET @SAVE_TIME_SLOT = 99
	
	SELECT ownerGuildDBID FROM SB_GUILD_DOMINION (READUNCOMMITTED) WHERE weekNo = @weekNo and spotID = @SAVE_TIME_SLOT

END
GO
PRINT N'Creating [dbo].[sb_ReduceVehiclePeriodForBuilder]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_ReduceVehiclePeriodForBuilder]
	@user_dbid INT,
	@vehicle_dbid INT,
	@reduce_min INT
AS  
BEGIN  
	SET NOCOUNT ON;

	UPDATE SB_USER_VEHICLE SET expire_date = DATEADD(MINUTE, -@reduce_min, expire_date) WHERE owner_dbid = @user_dbid AND ID = @vehicle_dbid 
END
GO
PRINT N'Creating [dbo].[SB_RegisterBag]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_RegisterBag]
	@owner_dbid INT,
	@bag_type INT,
	@slot_index INT,
	@source_item_class_id INT,
	@max_slot_count INT
AS
BEGIN
	SET NOCOUNT ON

	INSERT INTO SB_ITEM_BAG([owner_dbid], [bag_type], [slot_index], [source_item_class_id], [max_slot_count])
	VALUES (@owner_dbid, @bag_type, @slot_index, @source_item_class_id, @max_slot_count)
	
	SELECT SCOPE_IDENTITY(), @bag_type, @slot_index, @source_item_class_id, @max_slot_count
END
GO
PRINT N'Creating [dbo].[sb_RegisterINN]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_RegisterINN]  
 @user_id int, 
 @inn int
AS  
BEGIN  
	SET NOCOUNT ON  

	IF NOT EXISTS (SELECT TOP 1 * FROM SB_INN (READUNCOMMITTED) WHERE ID = @user_id)
	BEGIN
		INSERT INTO SB_INN (ID, inn_id)
		VALUES (@user_id, @inn)
	END
	ELSE
		UPDATE SB_INN SET inn_id = @inn WHERE ID = @user_id;
END
GO
PRINT N'Creating [dbo].[sb_RegisterPet]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_RegisterPet]
	@user_dbid INT,
	@pet_class_id INT,
	@pet_slot_index INT,
	@pet_name NVARCHAR(64),
	@minutes_to_expire INT
AS  
BEGIN  
	SET NOCOUNT ON;
	
	DECLARE @RPRT_ABUSIVE_NAME INT = -1
		,	@RPRT_SAME_NAME INT = -2
		,	@SLOT_INVALID_INDEX INT = -1
	
	IF EXISTS (SELECT ID FROM SB_USER_PET (READUNCOMMITTED) WHERE owner_dbid=@user_dbid AND pet_name = @pet_name)
	BEGIN
		SELECT 0, @RPRT_SAME_NAME, @SLOT_INVALID_INDEX, N'';
		RETURN
	END
		
	DECLARE @expired_date DATETIME = NULL	
	IF 0 < @minutes_to_expire
		SET @expired_date = DATEADD(MINUTE, @minutes_to_expire, GETDATE())
	
	INSERT SB_USER_PET (owner_dbid, pet_class_id, pet_slot_index, pet_name, expire_date)
	VALUES (@user_dbid, @pet_class_id, @pet_slot_index, @pet_name, @expired_date)
	
	DECLARE @pet_id INT = SCOPE_IDENTITY()
	IF @@ROWCOUNT > 0
		EXEC sb_WritePetHistory @user_dbid, @pet_id, 1, @minutes_to_expire
		
	SELECT @pet_class_id, @pet_id, @pet_slot_index, @pet_name, 
		CASE WHEN @expired_date IS NULL THEN -1 ELSE dbo.ConvertToTimeT32(@expired_date) END expire_date
END
GO
PRINT N'Creating [dbo].[sb_RegisterTelPoint]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_RegisterTelPoint]
	@telPointName NVARCHAR(256),
	@WorldCoord BIGINT,
	@x FLOAT,
	@y FLOAT,
	@z FLOAT
AS
BEGIN
	SET NOCOUNT ON;
	
	MERGE SB_TELEPORT_POINT WITH (HOLDLOCK) T
	USING (VALUES (@telPointName, 
				(@WorldCoord & 0xff00000000000000) / 0xffffffffffffff,
				(@WorldCoord & 0xff000000000000) / 0xffffffffffff,
				(@WorldCoord & 0xffff00000000) / 0xffffffff,
				(@WorldCoord & 0xff000000) / 0xffffff,
				(@WorldCoord & 0xff0000) / 0xffff,
				(@WorldCoord & 0xff00) / 0xff,
				(@WorldCoord & 0xff),
				@x,
				@y,
				@z)) 
		AS S (name, 
				area_id, 
				region_id, 
				resource_id, 
				grid_x, 
				grid_y, 
				grid_z, 
				reserved,
				x, y, z)
		ON T.name = S.name
	WHEN MATCHED THEN
		UPDATE SET 
				area_id = (@WorldCoord & 0xff00000000000000) / 0xffffffffffffff,
				region_id = (@WorldCoord & 0xff000000000000) / 0xffffffffffff,
				resource_id = (@WorldCoord & 0xffff00000000) / 0xffffffff,
				grid_x = (@WorldCoord & 0xff000000) / 0xffffff,
				grid_y = (@WorldCoord & 0xff0000) / 0xffff,
				grid_z =(@WorldCoord & 0xff00) / 0xff,
				reserved = (@WorldCoord & 0xff),
				x = @x,
				y = @y,
				z = @z
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (name, 
				area_id, 
				region_id, 
				resource_id, 
				grid_x, 
				grid_y, 
				grid_z, 
				reserved,
				x, y, z)
		VALUES (@telPointName, 
				(@WorldCoord & 0xff00000000000000) / 0xffffffffffffff,
				(@WorldCoord & 0xff000000000000) / 0xffffffffffff,
				(@WorldCoord & 0xffff00000000) / 0xffffffff,
				(@WorldCoord & 0xff000000) / 0xffffff,
				(@WorldCoord & 0xff0000) / 0xffff,
				(@WorldCoord & 0xff00) / 0xff,
				(@WorldCoord & 0xff),
				@x,
				@y,
				@z)
	--OUTPUT $action, Inserted.*, Deleted.*
	;
	
	SELECT @@ROWCOUNT
END
GO
PRINT N'Creating [dbo].[SB_RegisterTransmogrify]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SB_RegisterTransmogrify]
	@user_dbid int,
	@class_id int,
	@slot_type int
AS
BEGIN
	SET NOCOUNT ON;
	
	INSERT INTO SB_USER_TRANSMOGRIFY_LIST (ID, class_id, slot_type, used, create_date) VALUES (@user_dbid, @class_id, @slot_type, 0, GETDATE());
END
GO
PRINT N'Creating [dbo].[sb_RegisterVehicle]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_RegisterVehicle]
	@user_dbid INT,
	@vehicle_class_id INT,
	@vehicle_slot_index INT,
	@minutes_to_expire INT
AS  
BEGIN  
	SET NOCOUNT ON;
	
	DECLARE @SLOT_INVALID_INDEX INT = -1
	
	IF EXISTS (SELECT ID FROM SB_USER_VEHICLE (READUNCOMMITTED) WHERE owner_dbid = @user_dbid AND vehicle_slot_index = @vehicle_slot_index)
	BEGIN
		SELECT 0, 0, @SLOT_INVALID_INDEX, -1;
		RETURN
	END
		
	DECLARE @expired_date DATETIME = NULL	
	IF 0 < @minutes_to_expire
		SET @expired_date = DATEADD(MINUTE, @minutes_to_expire, GETDATE())
	
	INSERT SB_USER_VEHICLE (owner_dbid, vehicle_class_id, vehicle_slot_index, expire_date)
	VALUES (@user_dbid, @vehicle_class_id, @vehicle_slot_index, @expired_date)
	
	DECLARE @vehicle_id INT = SCOPE_IDENTITY()
	IF @@ROWCOUNT > 0
		EXEC sb_WriteVehicleHistory @user_dbid, @vehicle_id, 1, @minutes_to_expire
		
	SELECT @vehicle_class_id, @vehicle_id, @vehicle_slot_index,  
		CASE WHEN @expired_date IS NULL THEN -1 ELSE dbo.ConvertToTimeT32(@expired_date) END expire_date
END
GO
PRINT N'Creating [dbo].[sb_RegisterWarpRegion]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_RegisterWarpRegion]  
 @user_id int, 
 @region int
AS  
BEGIN  
	SET NOCOUNT ON  

	IF NOT EXISTS (SELECT TOP 1 * FROM SB_WARP (READUNCOMMITTED) WHERE ID = @user_id AND warp_region = @region)
	BEGIN
		INSERT INTO SB_WARP (ID, warp_region)
		VALUES (@user_id, @region)
	END
END
GO
PRINT N'Creating [dbo].[sb_RegisterWarpRegionList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_RegisterWarpRegionList]  
	@user_id INT,
	@region_list IntTable READONLY
AS  
BEGIN  
	SET NOCOUNT ON  
	
	MERGE SB_WARP WITH (HOLDLOCK) AS T
	USING (SELECT ID FROM @region_list) AS S (warp_id)
		ON T.ID = @user_id AND T.warp_region=S.warp_id
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (ID, warp_region) VALUES (@user_id, S.warp_id)
	--OUTPUT $action, Inserted.*, Deleted.*
	;
END
GO
PRINT N'Creating [dbo].[sb_RemoveCharacterPermanently]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_RemoveCharacterPermanently]  
	@user_id INT
AS  
BEGIN  
	SET NOCOUNT ON;

	--ALL TABLE
	--select * from sys.objects where type = 'U' order by 1

	DELETE FROM SB_USER_SPVP WHERE user_id = @user_id
	
	DELETE FROM SB_BAN WHERE user_id = @user_id
	DELETE FROM SB_BAN WHERE ban_id = @user_id
	
	DELETE FROM SB_BUDDY WHERE user_id = @user_id
	DELETE FROM SB_BUDDY WHERE buddy_id = @user_id
	
	DELETE FROM SB_INN WHERE ID = @user_id
	
	DELETE FROM SB_ITEM_BAG WHERE owner_dbid = @user_id
	DELETE FROM SB_ITEM_COOL WHERE user_id = @user_id
	DELETE FROM SB_ITEM_DURATION WHERE item_dbid IN (SELECT ID FROM SB_ITEM WHERE owner_id = @user_id)
	DELETE FROM SB_ITEM_EQUIPMENT WHERE ID IN (SELECT ID FROM SB_ITEM WHERE owner_id = @user_id)
	DELETE FROM SB_ITEM_GEM WHERE ID IN (SELECT ID FROM SB_ITEM WHERE owner_id = @user_id)
	DELETE FROM SB_ITEM_POSSESSION WHERE item_dbid IN (SELECT ID FROM SB_ITEM WHERE owner_id = @user_id)
	DELETE FROM SB_ITEM_RANDOM_ABILITY WHERE ID IN (SELECT ID FROM SB_ITEM WHERE owner_id = @user_id)
	DELETE FROM SB_ITEM_RANDOM_ABILITY_UNDECIDED WHERE ID IN (SELECT ID FROM SB_ITEM WHERE owner_id = @user_id)
	DELETE FROM SB_ITEM_RUNE WHERE ID IN (SELECT ID FROM SB_ITEM WHERE owner_id = @user_id)
	
	DELETE FROM SB_POST_ATTACHED_ITEM WHERE post_id IN (SELECT ID FROM SB_POST_BOX WHERE recipient_dbid = @user_id)
	DELETE FROM SB_POST_BOX WHERE recipient_dbid = @user_id

	DELETE FROM SB_SHOP_GIFT_ITEM WHERE gift_id IN (SELECT ID FROM SB_SHOP_GIFT_BOX WHERE recipient_dbid = @user_id)
	DELETE FROM SB_SHOP_GIFT_BOX WHERE recipient_dbid = @user_id
	DELETE FROM SB_SHOP_LIMIT_COUNT where user_dbid = @user_id

	DELETE FROM SB_SHORT_CUT WHERE user_id = @user_id

	DELETE FROM SB_USER WHERE ID = @user_id
	DELETE FROM SB_USER_ABILITY WHERE ID = @user_id
	DELETE FROM SB_USER_ACHIEVEMENT WHERE user_id = @user_id
	DELETE FROM SB_USER_ACHIEVEMENT_PROGRESS WHERE user_id = @user_id
	DELETE FROM SB_USER_AVATAR_ITEM WHERE ID = @user_id
	DELETE FROM SB_USER_BUFF WHERE user_id = @user_id
	DELETE FROM SB_USER_CORPSE WHERE MASTER_ID = @user_id
	DELETE FROM SB_USER_DUNGEON WHERE ID = @user_id
	DELETE FROM SB_USER_DUNGEON_BIND_INIT WHERE user_db_id = @user_id
	DELETE FROM SB_USER_DUNGEON_TICKET WHERE user_db_id = @user_id
	DELETE FROM SB_USER_DUNGEON_TICKET_BOSS WHERE user_db_id = @user_id
	DELETE FROM SB_USER_EVENT_COOL WHERE user_id = @user_id
	DELETE FROM SB_USER_FATIGUE WHERE user_id = @user_id
	DELETE FROM SB_USER_INFO WHERE ID = @user_id
	DELETE FROM SB_USER_INFO_MULTI_SPEC WHERE user_id = @user_id
	DELETE FROM SB_USER_KEYBOARD_CONFIG WHERE user_id = @user_id
	DELETE FROM SB_USER_LEVELUP_HISTORY WHERE ID = @user_id
	DELETE FROM SB_USER_LIFE WHERE ID = @user_id
	DELETE FROM SB_USER_PET WHERE owner_dbid = @user_id
	DELETE FROM SB_USER_PLAYTIME_PER_DAY WHERE user_id = @user_id
	DELETE FROM SB_USER_POS WHERE ID = @user_id
	DELETE FROM SB_USER_POS_REVIVE WHERE user_id = @user_id
	DELETE FROM SB_USER_POS_VALID WHERE user_id = @user_id
	DELETE FROM SB_USER_PROFESSION WHERE user_id = @user_id
	DELETE FROM SB_USER_QUEST WHERE user_id = @user_id
	DELETE FROM SB_USER_QUEST_PROGRESS WHERE user_id = @user_id
	DELETE FROM SB_USER_QUEST_RESET WHERE user_id = @user_id
	DELETE FROM SB_USER_RECIPE WHERE user_id = @user_id
	DELETE FROM SB_USER_RECIPE_COOL WHERE user_id = @user_id
	DELETE FROM SB_USER_SECONDARY_MONEY WHERE ID = @user_id
	DELETE FROM SB_USER_SKILL WHERE ID = @user_id
	DELETE FROM SB_USER_SKILL_COOL WHERE user_id = @user_id
	DELETE FROM SB_USER_SKILL_TRIGGER WHERE ID = @user_id
	DELETE FROM SB_USER_SOUL WHERE user_id = @user_id
	DELETE FROM SB_USER_SOUL_SKILL WHERE user_dbid = @user_id
	DELETE FROM SB_USER_TITLE WHERE user_id = @user_id
	DELETE FROM SB_USER_TRUST_SALE WHERE userDBID = @user_id
	DELETE FROM SB_USER_ULTIMATE_SKILL WHERE user_id = @user_id
	DELETE FROM SB_USER_VISITED_POS WHERE ID = @user_id
	DELETE FROM SB_USER_WAREHOUSE WHERE owner_dbid = @user_id
	DELETE FROM SB_WARP WHERE ID = @user_id
END
GO
PRINT N'Creating [dbo].[sb_RemoveProfession]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_RemoveProfession]
	@user_id int,
	@profession_id int
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM SB_USER_PROFESSION
	WHERE user_id = @user_id AND profession_id = @profession_id
	
	DELETE FROM SB_USER_RECIPE
	WHERE user_id = @user_id AND profession_id = @profession_id	
END
GO
PRINT N'Creating [dbo].[sb_RemoveWarpRegionList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_RemoveWarpRegionList]  
 @user_id int
AS  
BEGIN  
 SET NOCOUNT ON  
    
 DELETE FROM SB_WARP WHERE ID = @user_id
 
END
GO
PRINT N'Creating [dbo].[SB_ReplaceBag]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_ReplaceBag]
	@bag_dbid INT
	, @source_item_class_id INT
	, @max_slot_index INT
AS
BEGIN
	SET NOCOUNT ON

	UPDATE dbo.SB_ITEM_BAG
	SET source_item_class_id = @source_item_class_id
		, max_slot_count = @max_slot_index
	WHERE ID = @bag_dbid
END
GO
PRINT N'Creating [dbo].[SB_ReserveGuildType]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_ReserveGuildType]  
 @guildID int,
 @type int, 
 @time bigint
AS  
BEGIN  
	SET NOCOUNT ON
	
	UPDATE [dbo].[SB_GUILD] SET totype = @type, type_change_time = [dbo].ConvertToDateTime32(@time) WHERE ID = @guildID;	
	
END
GO
PRINT N'Creating [dbo].[SB_ResetAchievement]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_ResetAchievement]
	@user_id int,
	@achievement_id int
AS
BEGIN
	SET NOCOUNT ON;

IF @achievement_id = -1
BEGIN
	DELETE FROM SB_USER_ACHIEVEMENT 
	WHERE user_id = @user_id
	
	DELETE FROM SB_USER_ACHIEVEMENT_PROGRESS
	WHERE user_id = @user_id
END
ELSE
	DELETE FROM SB_USER_ACHIEVEMENT 
	WHERE user_id = @user_id AND achievement_id = @achievement_id
	
	DELETE FROM SB_USER_ACHIEVEMENT_PROGRESS
	WHERE user_id = @user_id AND achievement_id = @achievement_id
END
GO
PRINT N'Creating [dbo].[sb_ResetAttendance]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ResetAttendance]
	  @user_id INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DELETE FROM 
		[dbo].[SB_USER_ATTENDANCE_ROUND]
	WHERE
		[user_id] = @user_id

	DELETE FROM
		[dbo].[SB_USER_ATTENDANCE_REWARD]
	WHERE
		[user_id] = @user_id
END
GO
PRINT N'Creating [dbo].[sb_UpdateUserTalent]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_UpdateUserTalent]
	@user_id	INT
	, @spec_id	TINYINT
	, @talent	INT
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE SB_USER_INFO_MULTI_SPEC SET talent = @talent 
	WHERE user_id = @user_id AND spec_id = @spec_id
END
GO
PRINT N'Creating [dbo].[sb_ResetBuiltSkill]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ResetBuiltSkill]
	@user_dbid        INT
	, @spec_id		  TINYINT	
	, @talent         INT
	, @t_skill_build  IDLevKeyTable READONLY
	, @t_short_cut    ShortCutTable READONLY
AS
BEGIN
	SET NOCOUNT ON

	EXEC dbo.sb_UpdateUserTalent @user_dbid, @spec_id, @talent
	
	DELETE FROM SB_USER_SKILL
	WHERE ID = @user_dbid
		AND spec_id = @spec_id
		AND skill_id NOT IN (SELECT skill_id FROM @t_skill_build)
	
	DELETE FROM SB_USER_SKILL_TRIGGER 
	WHERE ID = @user_dbid
		AND spec_id = @spec_id
	
	DELETE FROM SB_SHORT_CUT
	WHERE user_id = @user_dbid
		AND spec_id = @spec_id
		AND slot_no NOT IN (SELECT slot_no FROM @t_short_cut)
END
GO
PRINT N'Creating [dbo].[sb_ResetDungeonBindInit]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ResetDungeonBindInit]
	@user_db_id int,
	@reset_time int
AS
BEGIN
	SET NOCOUNT ON
	
	DELETE FROM SB_USER_DUNGEON_BIND_INIT WHERE user_db_id = @user_db_id
	UPDATE SB_USER_DUNGEON SET DUNGEON_BIND_INIT_RESET_TIME = dbo.ConvertToDateTime32(@reset_time) WHERE ID = @user_db_id
END
GO
PRINT N'Creating [dbo].[sb_ResetDungeonTicket]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ResetDungeonTicket]
	@user_db_id int,
	@reset_time int
AS
BEGIN
	SET NOCOUNT ON
	
	DELETE 
	FROM 
		SB_USER_DUNGEON_TICKET 
	WHERE 
		user_db_id = @user_db_id

	DELETE 
	FROM 
		SB_USER_DUNGEON_TICKET_BOSS
	WHERE 
		user_db_id = @user_db_id
		
	UPDATE SB_USER_DUNGEON SET DUNGEON_TICKET_RESET_TIME = dbo.ConvertToDateTime32(@reset_time) WHERE ID = @user_db_id
END
GO
PRINT N'Creating [dbo].[sb_ResetGuildDominionSpotInfo]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_ResetGuildDominionSpotInfo]

AS  
BEGIN
	SET NOCOUNT ON
	
	UPDATE SB_GUILD_DOMINION SET ownerGuildDBID = 0, weekNo = 0
END
GO
PRINT N'Creating [dbo].[sb_ResetGuildWarSeason]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ResetGuildWarSeason]	
	@guildID			int
	
AS
BEGIN
	SET NOCOUNT ON;

    -- DELETE Current War
	DELETE FROM [dbo].SB_GUILD_WAR    WHERE guildID = @guildID  AND in_progress = 1;

    -- CHANGE War Status
	UPDATE [dbo].SB_GUILD_WAR SET in_progress = 1 WHERE guildID = @guildID AND in_progress = 0;
	
	-- Reset Members Info
	UPDATE [dbo].[SB_GUILD_MEMBER] SET kill_count = 0, death_count = 0 WHERE guildID = @guildID ;
END
GO
PRINT N'Creating [dbo].[SB_ResetLoginTimeForBuilder]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_ResetLoginTimeForBuilder]
	@user_id INT
AS
BEGIN
	SET NOCOUNT ON
	
	UPDATE SB_USER_INFO 
	SET logInTime = NULL
	WHERE ID = @user_id	
	
END
GO
PRINT N'Creating [dbo].[sb_ResetShortCut]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ResetShortCut]
	@user_id INT
	, @spec_id TINYINT
	, @reg_type INT
AS
BEGIN
	SET NOCOUNT ON

	IF @reg_type = 0
		DELETE SB_SHORT_CUT 
		WHERE [user_id] = @user_id
			AND spec_id = @spec_id
	ELSE
		DELETE SB_SHORT_CUT 
		WHERE [user_id] = @user_id 
			AND [reg_type] = @reg_type
			AND spec_id = @spec_id

	SELECT slot_no, reg_type, reg_id
	FROM SB_SHORT_CUT (READUNCOMMITTED)
	WHERE user_id = @user_id
		AND spec_id = @spec_id
END
GO
PRINT N'Creating [dbo].[sb_ResetSkill]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ResetSkill]
	@user_id INT,
	@spec_id TINYINT
AS
BEGIN
	SET NOCOUNT ON

	DELETE FROM SB_USER_SKILL 
	WHERE ID = @user_id 
		AND spec_id = @spec_id
	
	DELETE FROM SB_USER_SKILL_TRIGGER 
	WHERE ID = @user_id 
		AND spec_id = @spec_id
END
GO
PRINT N'Creating [dbo].[sb_ResetWeeklySecondaryMoney]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_ResetWeeklySecondaryMoney]
	@user_id INT,
	@reset_time INT
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE 
		SB_USER_SECONDARY_MONEY 
	SET
		infinite_hunt_point_weekly = 0, 
		guild_warrior_point_weekly = 0, 
		arena_point_weekly = 0,
		private_arena_point_weekly = 0,
		team_arena_point_weekly = 0,
		reset_time = dbo.ConvertToDateTime32(@reset_time)
	WHERE ID = @user_id;
END
GO
PRINT N'Creating [dbo].[SB_RestoreDeletedCharacter]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_RestoreDeletedCharacter]  
	@user_id INT
AS  
BEGIN  
	SET NOCOUNT ON;  
	
	DECLARE @deletedName	NVARCHAR(64)
	DECLARE @trimID			NVARCHAR(64)
	DECLARE @trimAccountID	NVARCHAR(64)
	
	SELECT @deletedName = name
	FROM SB_USER (READUNCOMMITTED)
	WHERE ID = @user_id
		AND deleted_time IS NOT NULL
	
	IF @deletedName IS NULL
	BEGIN
		RETURN
	END
	
	SET @trimID			= LEFT(@deletedName, LEN(@deletedName) - CHARINDEX(N'_', REVERSE(@deletedName)))
	SET @trimAccountID	= LEFT(@trimID, LEN(@trimID) - CHARINDEX(N'_', REVERSE(@trimID)))

	UPDATE SB_USER
	SET deleted_time = NULL
		, final_deleted = 'N'
		, name = @trimAccountID
	WHERE ID = @user_id;
END
GO
PRINT N'Creating [dbo].[SB_SaveAchievementProgress]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_SaveAchievementProgress]
	@user_id INT,
	@achievement_id INT,
	@goal_id tinyint,
	@progress INT	
AS
BEGIN
	SET NOCOUNT ON;

	MERGE SB_USER_ACHIEVEMENT_PROGRESS WITH (HOLDLOCK) uap
	USING (SELECT @user_id, @achievement_id, @goal_id) AS t (user_id, achievement_id, goal_id)
		ON uap.user_id = t.user_id AND uap.achievement_id = t.achievement_id AND uap.goal_id = t.goal_id
	WHEN MATCHED THEN
		UPDATE SET uap.progress = uap.progress + @progress
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_id, achievement_id, goal_id, progress)
		VALUES (@user_id, @achievement_id, @goal_id, @progress);
END
GO
PRINT N'Creating [dbo].[SB_SaveAndBackupItemRandomAbility]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_SaveAndBackupItemRandomAbility]
	@item_dbid BIGINT
	, @ability TinyintIntPair READONLY
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM [dbo].[SB_ITEM_RANDOM_ABILITY_UNDECIDED] WHERE [ID] = @item_dbid;
	
	INSERT INTO SB_ITEM_RANDOM_ABILITY_UNDECIDED (ID, ability_type, ability_value)
	SELECT ID, ability_type, ability_value
	FROM SB_ITEM_RANDOM_ABILITY (READUNCOMMITTED)
	WHERE ID = @item_dbid;
	
	DELETE FROM [dbo].[SB_ITEM_RANDOM_ABILITY] WHERE [ID] = @item_dbid
	
	INSERT INTO [dbo].[SB_ITEM_RANDOM_ABILITY](ID, ability_type, ability_value)
	SELECT @item_dbid, param1, param2
	FROM @ability;

	MERGE INTO dbo.SB_ITEM_EQUIPMENT WITH (HOLDLOCK) AS DEST
	USING (VALUES (@item_dbid)) AS SRC (ID)
	ON DEST.ID = SRC.ID
	WHEN MATCHED
		THEN UPDATE SET DEST.estimated = 1, DEST.reestimated = 1
	WHEN NOT MATCHED
		THEN INSERT (ID, estimated, reestimated) VALUES (@item_dbid, 1, 1);
END
GO
PRINT N'Creating [dbo].[sb_SaveAnnounce]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveAnnounce]
	@announce_id INT
	, @announce_type INT
	, @announce_cycle INT
	, @announce_msg NVARCHAR(1024)
AS
BEGIN
	SET NOCOUNT ON;
	
	MERGE SB_ANNOUNCE WITH (HOLDLOCK) T
	USING (VALUES (@announce_id, @announce_type, @announce_cycle, @announce_msg)) AS S (id, type, cycle, msg)
		ON T.id = S.id
	WHEN MATCHED THEN
		UPDATE SET msg = @announce_msg, [type] = @announce_type, cycle = @announce_cycle
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (type, cycle, msg) VALUES (S.type, S.cycle, S.msg)
	--OUTPUT $action, Inserted.*, Deleted.*
	;
END
GO
PRINT N'Creating [dbo].[sb_SaveAttendance]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveAttendance]
	    @user_id         INT
	  , @item_class_id   INT
	  , @item_amount     INT
	  , @attendance_time INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @now DATETIME = [dbo].ConvertToDateTime32(@attendance_time);
	
	MERGE INTO [dbo].[SB_USER_ATTENDANCE_REWARD] WITH (HOLDLOCK) AS T
	USING (VALUES (@user_id, @now)) AS S ([user_id], [attendance_time])
		ON
			T.[user_id] = S.[user_id]
			AND T.[attendance_time] = S.[attendance_time]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([user_id], [attendance_time], [item_class_id], [item_amount]) 
		VALUES (S.[user_id], S.[attendance_time], @item_class_id, @item_amount)
	;
	
	IF @@ROWCOUNT > 0
	BEGIN
		UPDATE [dbo].[SB_USER_ATTENDANCE_ROUND]
		SET
			  [total_attendance_count] = [total_attendance_count] + 1
			, [attendance_count] = [attendance_count] + 1
		WHERE
			[user_id] = @user_id
	END
	
	EXEC sb_LoadAttendanceRound @user_id;
END
GO
PRINT N'Creating [dbo].[sb_SaveBOTReportedTime]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveBOTReportedTime]
	@user_dbid INT,
	@reported_time INT
AS
BEGIN
	SET NOCOUNT ON;
	
	MERGE SB_USER_BOT_REPORT WITH (HOLDLOCK) T
	USING (SELECT @user_dbid, @reported_time) AS S (user_dbid, reported_time)
		ON T.user_dbid = S.user_dbid
	WHEN MATCHED THEN
		UPDATE SET T.reported_time = dbo.ConvertToDateTime32(S.reported_time), T.report_count = T.report_count + 1
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_dbid, reported_time, report_count) VALUES (S.user_dbid, dbo.ConvertToDateTime32(S.reported_time), 1)
		;
END
GO
PRINT N'Creating [dbo].[sb_SaveChatReportedTime]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveChatReportedTime]
	@user_dbid INT,
	@reportee_dbid INT,
	@reported_time INT,
	@delta_count_normal INT,
	@delta_count_guild INT
AS
BEGIN
	SET NOCOUNT ON;
	/* reporter */
	MERGE dbo.SB_USER_CHAT_REPORT WITH (HOLDLOCK) T
	USING (SELECT @user_dbid, @reported_time) AS S (user_dbid, reported_time)
		ON T.user_dbid = S.user_dbid
	WHEN MATCHED THEN
		UPDATE SET T.reported_time = [dbo].ConvertToDateTime32(S.reported_time), T.report_count = T.report_count + 1
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_dbid, reported_time, report_count) VALUES (S.user_dbid, dbo.ConvertToDateTime32(S.reported_time), 1)
		;
	
	/* reportee */
	MERGE dbo.SB_USER_CHAT_REPORT WITH (HOLDLOCK) T
	USING (SELECT @reportee_dbid, @delta_count_normal, @delta_count_guild) AS S(reportee_dbid, delta_count_normal, delta_count_guild)
		ON T.user_dbid = S.reportee_dbid
	WHEN MATCHED THEN
		UPDATE SET T.reported_count_normal = T.reported_count_normal + S.delta_count_normal, T.reported_count_guild = T.reported_count_guild + S.delta_count_guild
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_dbid, reported_count_normal, reported_count_guild) VALUES (S.reportee_dbid, S.delta_count_normal, S.delta_count_guild)
		;
END
GO
PRINT N'Creating [dbo].[SB_SaveDungeonLevel]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_SaveDungeonLevel]
	-- Add the parameters for the stored procedure here
	@ID int,
	@DungeonLevel int,
	@DungeonLevelEx int,
	@DungeonRaidLevel int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE SB_USER_DUNGEON
	SET
	DUNGEON_LEVEL    = @DungeonLevel,
	DUNGEON_LEVEL_EX = @DungeonLevelEx,
	DUNGEON_RAID_LEVEL = @DungeonRaidLevel
	WHERE ID = @ID
END
GO
PRINT N'Creating [dbo].[sb_SaveDungeonTicket]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_SaveDungeonTicket]
	@user_db_id INT,
	@ticket_id INT,
	@all_used_count INT,
	@paid_used_count INT
AS
BEGIN
	SET NOCOUNT ON
	
	MERGE SB_USER_DUNGEON_TICKET WITH (HOLDLOCK) T
	USING (SELECT @user_db_id, @ticket_id) AS S (user_db_id, ticket_id)
		ON T.user_db_id= S.user_db_id AND T.ticket_id = S.ticket_id
	WHEN MATCHED THEN
		UPDATE SET ticket_used_count = @all_used_count, paid_used_count = @paid_used_count
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_db_id, ticket_id, ticket_used_count, addable_ticket_buy_count, paid_used_count) 
		VALUES (@user_db_id, @ticket_id, @all_used_count, 0, @paid_used_count);
		
	DELETE FROM SB_USER_DUNGEON_TICKET_BOSS
	WHERE
		user_db_id = @user_db_id AND ticket_id = @ticket_id
END
GO
PRINT N'Creating [dbo].[sb_SaveDungeonTicketBoss]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveDungeonTicketBoss]
	@user_db_id INT,
	@ticket_id INT,
	@dead_boss_id INT,
	@is_first_kill INT
AS
BEGIN
	SET NOCOUNT ON
	
	MERGE SB_USER_DUNGEON_TICKET_BOSS WITH (HOLDLOCK) T
	USING (SELECT @user_db_id, @ticket_id, @dead_boss_id) AS S (user_db_id, ticket_id, boss_id)
		ON 
			T.user_db_id	= S.user_db_id 
			AND T.ticket_id = S.ticket_id
			AND T.boss_id	= S.boss_id
	WHEN MATCHED THEN
		UPDATE SET is_first_kill = 0
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_db_id, ticket_id, boss_id, is_first_kill) 
		VALUES (@user_db_id, @ticket_id, @dead_boss_id, @is_first_kill);
END
GO
PRINT N'Creating [dbo].[sb_SaveDungeonTicketBossDie]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveDungeonTicketBossDie]
	@user_db_id INT,
	@ticket_id INT,
	@dead_boss_id INT
AS
BEGIN
	SET NOCOUNT ON
	
	MERGE SB_USER_DUNGEON_TICKET_BOSS WITH (HOLDLOCK) T
	USING (SELECT @user_db_id, @ticket_id, @dead_boss_id) AS S (user_db_id, ticket_id, boss_id)
		ON 
			T.user_db_id	= S.user_db_id 
			AND T.ticket_id = S.ticket_id
			AND T.boss_id	= S.boss_id
	WHEN MATCHED THEN
		UPDATE SET is_first_kill = 0
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_db_id, ticket_id, boss_id, is_first_kill) 
		VALUES (@user_db_id, @ticket_id, @dead_boss_id, 1);
END
GO
PRINT N'Creating [dbo].[sb_SaveDungeonTicketTemporarily]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_SaveDungeonTicketTemporarily]
	@user_db_id INT,
	@ticket_id INT,
	@all_used_count INT,
	@paid_used_count INT
AS
BEGIN
	SET NOCOUNT ON
	
	MERGE SB_USER_DUNGEON_TICKET WITH (HOLDLOCK) T
	USING (SELECT @user_db_id, @ticket_id) AS S (user_db_id, ticket_id)
		ON T.user_db_id= S.user_db_id AND T.ticket_id = S.ticket_id
	WHEN MATCHED THEN
		UPDATE SET ticket_used_count = @all_used_count,
		paid_used_count = @paid_used_count
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_db_id, ticket_id, ticket_used_count, addable_ticket_buy_count, paid_used_count) 
		VALUES (@user_db_id, @ticket_id, @all_used_count, 0, @paid_used_count);
		
	DELETE FROM SB_USER_DUNGEON_TICKET_BOSS
	WHERE
		user_db_id = @user_db_id AND ticket_id = @ticket_id
END
GO
PRINT N'Creating [dbo].[sb_SaveEventCool]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveEventCool]  
 @user_id INT  
 , @cool_id INT  
 , @remain_time BIGINT  
AS  
BEGIN  
 SET NOCOUNT ON  
   
 DELETE SB_USER_EVENT_COOL WHERE user_id = @user_id AND cool_id != @cool_id  
   
 MERGE SB_USER_EVENT_COOL WITH (HOLDLOCK) T  
 USING (SELECT @user_id, @cool_id, @remain_time) AS S (user_id, cool_id, remain_time)  
  ON T.user_id=S.user_id AND T.cool_id=S.cool_id  
 WHEN MATCHED THEN  
  UPDATE SET remain_time = S.remain_time  
 WHEN NOT MATCHED BY TARGET THEN  
  INSERT (user_id, cool_id, remain_time) VALUES (@user_id, @cool_id, @remain_time)  
 --OUTPUT $action, Inserted.*, Deleted.*  
 ;  
END
GO
PRINT N'Creating [dbo].[sb_SaveGuildDominionSpotInfo]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_SaveGuildDominionSpotInfo]
	@weekNo INT,
	@spotID INT,
	@ownerGuildDBID INT
AS  
BEGIN  
	SET NOCOUNT ON
	
	IF EXISTS (SELECT ownerGuildDBID FROM SB_GUILD_DOMINION (READUNCOMMITTED) where spotID = @spotID)
		BEGIN
			UPDATE SB_GUILD_DOMINION SET ownerGuildDBID = @ownerGuildDBID, weekNo = @weekNo WHERE spotID = @spotID
		END
	ELSE
		BEGIN
			INSERT SB_GUILD_DOMINION (weekNo, spotID, ownerGuildDBID)
			VALUES (@weekNo, @spotID, @ownerGuildDBID)
		END
END
GO
PRINT N'Creating [dbo].[sb_SaveItemCool]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveItemCool]
	@user_id INT
	, @cool_id INT
	, @cool_time BIGINT
AS
BEGIN
	SET NOCOUNT ON
	
	MERGE SB_ITEM_COOL WITH (HOLDLOCK) T
	USING (SELECT @user_id, @cool_id, @cool_time) AS S (user_id, cool_id, cool_time)
		ON T.user_id=S.user_id AND T.cool_id=S.cool_id
	WHEN MATCHED AND @cool_time = 0 THEN 
		DELETE
	WHEN MATCHED THEN
		UPDATE SET cool_time = S.cool_time
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_id, cool_id, cool_time) VALUES (@user_id, @cool_id, @cool_time)
	--OUTPUT $action, Inserted.*, Deleted.*
	;
END
GO
PRINT N'Creating [dbo].[sb_SaveItemPossession]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveItemPossession]
	@item_dbid BIGINT
	, @seal_count INT
	, @possession_status INT
AS
BEGIN
	SET NOCOUNT ON

	MERGE SB_ITEM_POSSESSION WITH (HOLDLOCK) T
	USING (VALUES (@item_dbid, @seal_count, @possession_status)) AS S (item_dbid, seal_count, possession_status)
		ON T.item_dbid = S.item_dbid
	WHEN MATCHED THEN
		UPDATE SET seal_count = S.seal_count, possession_status = S.possession_status
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (item_dbid, seal_count, possession_status) VALUES (S.item_dbid, S.seal_count, S.possession_status)
	--OUTPUT $action, Inserted.*, Deleted.*
	;
END
GO
PRINT N'Creating [dbo].[SB_SaveItemRandomAbility]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_SaveItemRandomAbility]
	@item_dbid BIGINT
	, @ability TinyintIntPair READONLY
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM [dbo].[SB_ITEM_RANDOM_ABILITY] WHERE [ID] = @item_dbid
	DELETE FROM [dbo].[SB_ITEM_RANDOM_ABILITY_UNDECIDED] WHERE [ID] = @item_dbid
	
	INSERT INTO [dbo].[SB_ITEM_RANDOM_ABILITY](ID, ability_type, ability_value)
	SELECT @item_dbid, param1, param2
	FROM @ability;
	
	MERGE INTO dbo.SB_ITEM_EQUIPMENT WITH (HOLDLOCK) AS DEST
	USING (VALUES (@item_dbid)) AS SRC (ID)
		ON DEST.ID = SRC.ID
	WHEN MATCHED
		THEN UPDATE SET DEST.estimated = 1, DEST.reestimated = 0
	WHEN NOT MATCHED
		THEN INSERT (ID, estimated, reestimated) VALUES (@item_dbid, 1, 0);
END
GO
PRINT N'Creating [dbo].[sb_SaveKeyboardConfig]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveKeyboardConfig]
(
	@user_id INT
	, @keyboard_config NVARCHAR(MAX)
)
AS
BEGIN	
	SET NOCOUNT ON
	
	MERGE SB_USER_KEYBOARD_CONFIG WITH (HOLDLOCK) T
	USING (VALUES (@user_id, @keyboard_config)) AS S (user_id, keyboard_config)
		ON T.user_id = S.user_id
	WHEN MATCHED THEN
		UPDATE SET T.keyboard_config = S.keyboard_config
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_id, keyboard_config)
		VALUES (S.user_id, S.keyboard_config);
END
GO
PRINT N'Creating [dbo].[SB_SaveProfession]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_SaveProfession]
	@user_id int,
	@profession_id int,
	@grade_id int,
	@point int
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO SB_USER_PROFESSION (user_id, profession_id, grade_id, point)
	VALUES (@user_id, @profession_id, @grade_id, @point)
END
GO
PRINT N'Creating [dbo].[SB_SaveQuestAccept]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_SaveQuestAccept]
	@user_id int,
	@quest_id int
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO SB_USER_QUEST (user_id, quest_id, finished, registered)
	VALUES (@user_id, @quest_id, 0, 0)
END
GO
PRINT N'Creating [dbo].[SB_SaveQuestDailyReset]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_SaveQuestDailyReset]
	@user_id INT,
	@reset_time INT
AS
BEGIN
	SET NOCOUNT ON;
	
	MERGE SB_USER_QUEST_RESET WITH (HOLDLOCK) uqr
	USING (SELECT @user_id) AS t (user_id)
		ON uqr.user_id = t.user_id
	WHEN MATCHED THEN
		UPDATE SET uqr.daily_quest_reset = dbo.ConvertToDateTime32(@reset_time)
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_id, daily_quest_reset)
		VALUES (@user_id, dbo.ConvertToDateTime32(@reset_time));
END
GO
PRINT N'Creating [dbo].[SB_SaveQuestFinish]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_SaveQuestFinish]
	@user_id INT
	, @quest_id INT
AS
BEGIN
	SET NOCOUNT ON;
	
	MERGE SB_USER_QUEST WITH (HOLDLOCK) T
	USING (VALUES (@user_id, @quest_id, 1, 0, GETDATE())) AS S (user_id, quest_id, finished, registered, finished_date)
		ON T.user_id = S.user_id AND T.quest_id = S.quest_id
	WHEN MATCHED THEN
		UPDATE SET finished = S.finished, finished_date = S.finished_date	--S.finished = 1
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_id, quest_id, finished, registered, finished_date) VALUES (S.user_id, S.quest_id, S.finished, S.registered, S.finished_date)
	--OUTPUT $action, Inserted.*, Deleted.*
	;
END
GO
PRINT N'Creating [dbo].[SB_SaveQuestProgress]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_SaveQuestProgress]
	@user_id INT
	, @quest_id INT
	, @goal_id INT
	, @progress INT
AS
BEGIN
	SET NOCOUNT ON;
	
	MERGE SB_USER_QUEST_PROGRESS WITH (HOLDLOCK) T
	USING (VALUES (@user_id, @quest_id, @goal_id, @progress)) AS S (user_id, quest_id, goal_id, progress)
		ON T.user_id = S.user_id AND T.quest_id = S.quest_id AND T.goal_id = S.goal_id
	WHEN MATCHED THEN
		UPDATE SET T.progress = T.progress + S.progress
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_id, quest_id, goal_id, progress) VALUES (S.user_id, S.quest_id, S.goal_id, S.progress)
	--OUTPUT $action, Inserted.*, Deleted.*
	;
END
GO
PRINT N'Creating [dbo].[SB_SaveQuestRegister]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_SaveQuestRegister]
	@user_id int,
	@quest_id int,
	@registered tinyint
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE SB_USER_QUEST
	SET registered = @registered, registered_date = GETDATE()
	WHERE user_id = @user_id AND quest_id = @quest_id	
END
GO
PRINT N'Creating [dbo].[SB_SaveRecipe]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_SaveRecipe]
	@user_id int,
	@recipe_id int,
	@profession_id int
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO SB_USER_RECIPE (user_id, recipe_id, profession_id)
	VALUES (@user_id, @recipe_id, @profession_id)
END
GO
PRINT N'Creating [dbo].[sb_SaveRecipeCool]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveRecipeCool]
	@user_id INT
	, @cool_id INT
	, @cool_time BIGINT
AS
BEGIN
	SET NOCOUNT ON
	
	MERGE SB_USER_RECIPE_COOL WITH (HOLDLOCK) T
	USING (SELECT @user_id, @cool_id, @cool_time) AS S (user_id, cool_id, cool_time)
		ON T.user_id=S.user_id AND T.cool_id=S.cool_id
	WHEN MATCHED AND @cool_time = 0 THEN 
		DELETE
	WHEN MATCHED THEN
		UPDATE SET cool_time = S.cool_time
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_id, cool_id, cool_time) VALUES (@user_id, @cool_id, @cool_time)
	--OUTPUT $action, Inserted.*, Deleted.*
	;
END
GO
PRINT N'Creating [dbo].[sb_SaveReinforceResult]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveReinforceResult]
	@item_dbid BIGINT,
	@grade INT,
	@experience FLOAT,
	@ability TinyintIntPair READONLY
AS
BEGIN
	SET NOCOUNT ON;

	MERGE [dbo].[SB_ITEM_RANDOM_ABILITY] WITH (HOLDLOCK) AS T
	USING (SELECT @item_dbid, param1, param2 FROM @ability) AS S (ID, ability_type, ability_value)
	ON T.ID = S.ID AND T.ability_type = S.ability_type
	WHEN MATCHED THEN
		UPDATE SET T.ability_value = S.ability_value
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (ID, ability_type, ability_value) VALUES (S.ID, S.ability_type, S.ability_value)
	; 
	
	MERGE [dbo].[SB_ITEM_REINFORCEMENT] WITH (HOLDLOCK) AS T
	USING (VALUES (@item_dbid, @grade, @experience)) AS S (ID, grade, experience)
		ON T.ID = S.ID
	WHEN MATCHED THEN
		UPDATE SET T.grade = S.grade, T.experience = S.experience
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (ID, grade, experience) VALUES (S.ID, S.grade, S.experience)
	;
END
GO
PRINT N'Creating [dbo].[sb_SaveRemainBoughtDungeonTicket]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_SaveRemainBoughtDungeonTicket]
	@user_db_id INT,
	@ticket_id INT,
	@remain_count INT
AS
BEGIN
	SET NOCOUNT ON
	
	MERGE SB_USER_DUNGEON_TICKET WITH (HOLDLOCK) T
	USING (SELECT @user_db_id, @ticket_id) AS S (user_db_id, ticket_id)
		ON T.user_db_id= S.user_db_id AND T.ticket_id = S.ticket_id
	WHEN MATCHED THEN
		UPDATE SET addable_ticket_buy_count = @remain_count
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_db_id, ticket_id, ticket_used_count, addable_ticket_buy_count, paid_used_count) 
		VALUES (@user_db_id, @ticket_id, 0, @remain_count, 0);
END
GO
PRINT N'Creating [dbo].[SB_SaveRestBonus]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_SaveRestBonus]
 @owner_id int,
 @rest float
AS  
BEGIN  
 SET NOCOUNT ON;  
 
 UPDATE SB_USER_INFO SET rest = @rest WHERE ID = @owner_id
 
END
GO
PRINT N'Creating [dbo].[sb_SaveShortCut]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveShortCut]
	@user_id INT
	, @spec_id TINYINT	
	, @slot_no TINYINT
	, @reg_type TINYINT
	, @reg_id INT
AS
BEGIN
	SET NOCOUNT ON;

	MERGE SB_SHORT_CUT WITH (HOLDLOCK) S
	USING (SELECT @user_id, @spec_id, @slot_no, @reg_type, @reg_id) AS N (user_id, spec_id, slot_no, reg_type, reg_id)
		ON S.user_id=N.user_id AND S.slot_no=N.slot_no AND S.spec_id=N.spec_id
	WHEN MATCHED THEN
		UPDATE SET reg_type=N.reg_type, reg_id=N.reg_id
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_id, spec_id, slot_no, reg_type, reg_id) VALUES (@user_id, @spec_id, @slot_no, @reg_type, @reg_id)
	--OUTPUT $action, Inserted.*, Deleted.*
	;
END
GO
PRINT N'Creating [dbo].[sb_SaveSkillCool]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveSkillCool]
	@user_id INT
	, @cool_id INT
	, @cool_time BIGINT
AS
BEGIN
	SET NOCOUNT ON
	
	MERGE SB_USER_SKILL_COOL WITH (HOLDLOCK) T
	USING (SELECT @user_id, @cool_id, @cool_time) AS S (user_id, cool_id, cool_time)
		ON T.user_id=S.user_id AND T.cool_id=S.cool_id
	WHEN MATCHED AND @cool_time = 0 THEN 
		DELETE
	WHEN MATCHED THEN
		UPDATE SET cool_time = S.cool_time
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_id, cool_id, cool_time) VALUES (@user_id, @cool_id, @cool_time)
	--OUTPUT $action, Inserted.*, Deleted.*
	;
END
GO
PRINT N'Creating [dbo].[sb_SaveSpecCount]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveSpecCount]
	@user_id INT
	, @spec_count TINYINT
AS
BEGIN
	UPDATE SB_USER_INFO SET spec_count=@spec_count WHERE ID=@user_id
END
GO
PRINT N'Creating [dbo].[sb_SaveTax]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveTax]
	@tax bigint,
	@date bigint
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @dayDate as datetime;
	SET @dayDate = DATEADD(day, DATEDIFF(day, 0, dbo.ConvertToDateTime32(@date)), 0);
	
		
	MERGE SB_TAX WITH (HOLDLOCK) T
	USING (SELECT @dayDate, @tax) AS S (date, tax)
		ON T.date = S.date
	WHEN MATCHED AND T.tax < S.tax THEN
		UPDATE SET tax = S.tax
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (date, tax, tax_rate, is_pvp_sent, is_pve_sent) VALUES (S.date, S.tax, -1, 0, 0);

END
GO
PRINT N'Creating [dbo].[sb_SaveTaxPVEGuild]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveTaxPVEGuild]
	@weekNo int,
	@weekDate bigint
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @PVEGuild AS int;
	
	SET @PVEGuild = ISNULL((SELECT TOP 1 guild_db_id FROM SB_GUILD_LAIR_TIME_ATTACK ORDER BY elapsed_seconds ASC), -1);
	
	EXEC sb_GuildLairTimeAttackClearAll
	
	MERGE SB_TAX_GUILD WITH (HOLDLOCK) T
	USING (SELECT @weekNo, dbo.ConvertToDateTime32(@weekDate), @PVEGuild) AS S (week_no, week_date, pve_winner)
		ON T.week_no = S.week_no
	WHEN MATCHED THEN
		UPDATE SET pve_winner = S.pve_winner
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (week_no, week_date, pvp_winner, pve_winner) VALUES (S.week_no, S.week_date, 0, S.pve_winner);
		
	
	SELECT pve_winner FROM SB_TAX_GUILD (READUNCOMMITTED) WHERE week_no = @weekNo;

END
GO
PRINT N'Creating [dbo].[sb_SaveTaxPVPGuild]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveTaxPVPGuild]
	@weekNo int,
	@weekDate bigint,
	@PVPGuild int
AS
BEGIN
	SET NOCOUNT ON;
	
	MERGE SB_TAX_GUILD WITH (HOLDLOCK) T
	USING (SELECT @weekNo, dbo.ConvertToDateTime32(@weekDate), @PVPGuild) AS S (week_no, week_date, pvp_winner)
		ON T.week_no = S.week_no
	WHEN MATCHED THEN
		UPDATE SET pvp_winner = S.pvp_winner
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (week_no, week_date, pvp_winner, pve_winner) VALUES (S.week_no, S.week_date, S.pvp_winner, 0);

END
GO
PRINT N'Creating [dbo].[sb_SaveTaxRate]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveTaxRate]
	@taxRate int,
	@date bigint
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @dayDate as datetime;
	SET @dayDate = dbo.ConvertToDateTime32(@date);
	
	MERGE SB_TAX WITH (HOLDLOCK) T
	USING (SELECT @dayDate, 0, @taxRate) AS S (date, tax, tax_rate)
		ON T.date = S.date
	WHEN MATCHED THEN
		UPDATE SET tax_rate = S.tax_rate
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (date, tax, tax_rate) VALUES (@dayDate, 0, S.tax_rate);

END
GO
PRINT N'Creating [dbo].[SB_SaveUserAbility]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_SaveUserAbility]
	@ID INT
	, @base_run_speed INT
	, @run_speed INT
	, @base_walk_speed INT
	, @walk_speed INT
	, @attack_speed INT
	, @attack INT
	, @hit_rate INT
	, @critical_hit_rate INT
	, @evasion INT
	, @critical_evasion INT
	, @defense INT
	, @attr_attack_type INT
	, @attr_attack INT
	, @attr_defense_fire INT
	, @attr_defense_water INT
	, @attr_defense_earth INT
	, @attr_defense_wind INT
	, @regen_CP INT
	, @regen_HP INT
	, @penetration INT
	, @pvp_penetration INT
	, @pvp_defense INT
AS
BEGIN
	SET NOCOUNT ON
	
	MERGE SB_USER_ABILITY WITH (HOLDLOCK) T
	USING (VALUES (@ID,@base_run_speed,@run_speed,@base_walk_speed,@walk_speed
				,@attack_speed,@attack,@hit_rate,@critical_hit_rate,@evasion,@critical_evasion,@defense
				,@attr_attack_type,@attr_attack,@attr_defense_fire,@attr_defense_water,@attr_defense_earth,@attr_defense_wind
				,@regen_CP,@regen_HP,@penetration,@pvp_penetration,@pvp_defense))
		AS S (ID,base_run_speed,run_speed,base_walk_speed,walk_speed
				,attack_speed,attack,hit_rate,critical_hit_rate,evasion,critical_evasion,defense
				,attr_attack_type,attr_attack,attr_defense_fire,attr_defense_water,attr_defense_earth,attr_defense_wind
				,regen_CP,regen_HP,penetration,pvp_penetration,pvp_defense)
		ON T.ID = S.ID
	WHEN MATCHED THEN
		UPDATE SET base_run_speed = @base_run_speed
				, run_speed = @run_speed
				, base_walk_speed = @base_walk_speed
				, walk_speed = @walk_speed
				, attack_speed = @attack_speed
				, attack = @attack
				, hit_rate = @hit_rate
				, critical_hit_rate = @critical_hit_rate
				, evasion = @evasion
				, critical_evasion = @critical_evasion
				, defense = @defense
				, attr_attack_type = @attr_attack_type
				, attr_attack = @attr_attack
				, attr_defense_fire = @attr_defense_fire
				, attr_defense_water = @attr_defense_water
				, attr_defense_earth = @attr_defense_earth
				, attr_defense_wind = @attr_defense_wind
				, regen_CP = @regen_CP
				, regen_HP = @regen_HP
				, penetration = @penetration
				, pvp_penetration = @pvp_penetration
				, pvp_defense = @pvp_defense
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (ID,base_run_speed,run_speed,base_walk_speed,walk_speed
				,attack_speed,attack,hit_rate,critical_hit_rate,evasion,critical_evasion,defense
				,attr_attack_type,attr_attack,attr_defense_fire,attr_defense_water,attr_defense_earth,attr_defense_wind
				,regen_CP,regen_HP,penetration,pvp_penetration,pvp_defense)
		VALUES (@ID,@base_run_speed,@run_speed,@base_walk_speed,@walk_speed
				,@attack_speed,@attack,@hit_rate,@critical_hit_rate,@evasion,@critical_evasion,@defense
				,@attr_attack_type,@attr_attack,@attr_defense_fire,@attr_defense_water,@attr_defense_earth,@attr_defense_wind
				,@regen_CP,@regen_HP,@penetration,@pvp_penetration,@pvp_defense)
	--OUTPUT $action, Inserted.*, Deleted.*
	;
END
GO
PRINT N'Creating [dbo].[SB_SaveUserCorpse]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SB_SaveUserCorpse]
	-- Add the parameters for the stored procedure here
	@MasterID int,
	@WorldCoord bigint,
	@x float,
	@y float,
	@z float,
	@yaw int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE SB_USER_CORPSE
	SET 
	area_id = (@WorldCoord & 0xff00000000000000) / 0xffffffffffffff,
	region_id = (@WorldCoord & 0xff000000000000) / 0xffffffffffff,
	resource_id = (@WorldCoord & 0xffff00000000) / 0xffffffff,
	grid_x = (@WorldCoord & 0xff000000) / 0xffffff,
	grid_y = (@WorldCoord & 0xff0000) / 0xffff,
	grid_z =(@WorldCoord & 0xff00) / 0xff,
	reserved = (@WorldCoord & 0xff),
	x = @x,
	y = @y,
	z = @z,
	yaw = @yaw
	WHERE
		master_id = @MasterID
END
GO
PRINT N'Creating [dbo].[sb_SaveUserEnergy]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveUserEnergy]
	@ID INT,
	@energy INT
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE SB_USER_INFO
	SET energy = @energy
	WHERE ID = @ID 
END
GO
PRINT N'Creating [dbo].[SB_SaveUserLife]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SB_SaveUserLife]
	@ID as int,
	@LIFE as bit,
	@DeathReason as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE 
		SB_USER_LIFE
	SET
		is_alive = @LIFE
	WHERE
		ID = @ID

	IF (@LIFE = 0)
	BEGIN
		UPDATE
			SB_USER_LIFE
		SET
			last_time_of_death = GETDATE(),
			last_death_reason = @DeathReason
		WHERE
			ID = @ID
	END
END
GO
PRINT N'Creating [dbo].[sb_SaveUserPlaytimePerDay]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveUserPlaytimePerDay]
	@user_dbid INT,
	@play_day INT,
	@playtime BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @now_day DATE = CAST(dbo.ConvertToDateTime32(@play_day) AS DATE)

	MERGE SB_USER_PLAYTIME_PER_DAY WITH (HOLDLOCK) T
	USING (VALUES (@user_dbid, @now_day, @playtime)) AS S (user_dbid, play_day, playtime)
		ON T.user_id = S.user_dbid AND T.play_day = S.play_day
	WHEN MATCHED THEN
		UPDATE SET T.playtime = T.playtime + S.playtime
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_id, play_day, playtime) VALUES (S.user_dbid, S.play_day, S.playtime)
	--OUTPUT $action, Inserted.*, Deleted.*
	;
END
GO
PRINT N'Creating [dbo].[SB_SaveUserPos]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_SaveUserPos]
	-- Add the parameters for the stored procedure here
	@ID int,
	@WorldCoord bigint,
	@x float,
	@y float,
	@z float,
	@yaw int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @old_worldcoord BIGINT
    SELECT @old_worldcoord = 
			(
				(cast(area_id as bigint)	* 0x100000000000000) | 
				(cast(region_id as bigint)	* 0x1000000000000) | 
				(cast(resource_id as bigint)* 0x100000000) | 
				(cast(grid_x as bigint)		* 0x1000000) | 
				(cast(grid_y as bigint)		* 0x10000) | 
				(cast(grid_z as bigint)		* 0x100) | 
				(cast(reserved as bigint))
			)
	FROM SB_USER_POS (READUNCOMMITTED)
	WHERE ID = @ID
	
	UPDATE SB_USER_POS 
	SET 
	area_id = (@WorldCoord & 0xff00000000000000) / 0xffffffffffffff,
	region_id = (@WorldCoord & 0xff000000000000) / 0xffffffffffff,
	resource_id = (@WorldCoord & 0xffff00000000) / 0xffffffff,
	grid_x = (@WorldCoord & 0xff000000) / 0xffffff,
	grid_y = (@WorldCoord & 0xff0000) / 0xffff,
	grid_z =(@WorldCoord & 0xff00) / 0xff,
	reserved = (@WorldCoord & 0xff),
	x = @x,
	y = @y,
	z = @z,
	yaw = @yaw
	WHERE ID = @ID

	IF @old_worldcoord != @WorldCoord
	BEGIN
		UPDATE SB_USER_POS_VALID 
		SET 
		area_id = (@WorldCoord & 0xff00000000000000) / 0xffffffffffffff,
		region_id = (@WorldCoord & 0xff000000000000) / 0xffffffffffff,
		resource_id = (@WorldCoord & 0xffff00000000) / 0xffffffff,
		grid_x = (@WorldCoord & 0xff000000) / 0xffffff,
		grid_y = (@WorldCoord & 0xff0000) / 0xffff,
		grid_z =(@WorldCoord & 0xff00) / 0xff,
		reserved = (@WorldCoord & 0xff),
		x = @x,
		y = @y,
		z = @z,
		yaw = @yaw
		WHERE user_id = @ID
	END
END
GO
PRINT N'Creating [dbo].[sb_SaveUserRefusal]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveUserRefusal]
	@ID INT
	, @refusal INT
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE SB_USER_INFO
	SET refusal = @refusal
	WHERE ID = @ID
END
GO
PRINT N'Creating [dbo].[SB_SaveUserReviveLocation]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_SaveUserReviveLocation]
	@user_id INT,
	@world_coord BIGINT,
	@x FLOAT,
	@y FLOAT,
	@z FLOAT,
	@yaw INT
AS
BEGIN
	SET NOCOUNT ON;

	MERGE SB_USER_POS_REVIVE WITH (HOLDLOCK) R
	USING (SELECT 
		@user_id,
		@x,
		@y,
		@z,
		(@world_coord & 0xff00000000000000) / 0xffffffffffffff, 
		(@world_coord & 0xff000000000000) / 0xffffffffffff,
		(@world_coord & 0xffff00000000) / 0xffffffff,
		(@world_coord & 0xff000000) / 0xffffff,
		(@world_coord & 0xff0000) / 0xffff,
		(@world_coord & 0xff00) / 0xff,
		(@world_coord & 0xff),
		@yaw
		) AS S (user_id, x, y, z, area_id, region_id, resource_id, grid_x, grid_y, grid_z, reserved, yaw)
		ON R.user_id = S.user_id
	WHEN MATCHED THEN
		UPDATE SET
			x = S.x,
			y = S.y,
			z = S.z,
			area_id = S.area_id,
			region_id = S.region_id,
			resource_id = S.resource_id,		
			grid_x = S.grid_x,
			grid_y = S.grid_y,
			grid_z = S.grid_z,
			reserved = S.reserved,
			yaw = S.yaw
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_id, x, y, z, area_id, region_id, resource_id, grid_x, grid_y, grid_z, reserved, yaw)
		VALUES (
			@user_id,
			@x,
			@y,
			@z,
			(@world_coord & 0xff00000000000000) / 0xffffffffffffff, 
			(@world_coord & 0xff000000000000) / 0xffffffffffff,
			(@world_coord & 0xffff00000000) / 0xffffffff,
			(@world_coord & 0xff000000) / 0xffffff,
			(@world_coord & 0xff0000) / 0xffff,
			(@world_coord & 0xff00) / 0xff,
			(@world_coord & 0xff),
			@yaw)
	;

END
GO
PRINT N'Creating [dbo].[sb_SaveUserSatiety]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveUserSatiety]
	@ID INT,
	@satiety INT
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE SB_USER_INFO
	SET satiety = @satiety
	WHERE ID = @ID 
END
GO
PRINT N'Creating [dbo].[sb_SaveUserStat]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SaveUserStat]
	@ID INT,
	@play_time_in_sec BIGINT,
	@lev SMALLINT,
	@exp INT,
	@hp INT,
	@cp INT,
	@energy INT,
	@satiety SMALLINT
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE SB_USER_INFO
	SET /*lev = @lev,*/	exp = @exp,	hp = @hp, cp = @cp,
		energy = @energy, satiety = @satiety,
		elapsed_play_time_in_sec = elapsed_play_time_in_sec + @play_time_in_sec
	WHERE ID = @ID AND lev = @lev
	
	/* lev changed */
	IF @@ROWCOUNT = 0
	BEGIN
		UPDATE SB_USER_INFO
		SET lev = @lev, exp = @exp, hp = @hp, cp = @cp,
			energy = @energy, satiety = @satiety,
			elapsed_play_time_in_sec = elapsed_play_time_in_sec + @play_time_in_sec
		WHERE ID = @ID
		
		DECLARE @play_time BIGINT = (SELECT elapsed_play_time_in_sec FROM SB_USER_INFO (READUNCOMMITTED) WHERE ID = @ID)			
		DECLARE @lev_play_time BIGINT = (SELECT SUM(play_time) FROM SB_USER_LEVELUP_HISTORY (READUNCOMMITTED) WHERE ID = @ID AND lev < @Lev)
					
		MERGE SB_USER_LEVELUP_HISTORY WITH (HOLDLOCK) T
		USING (SELECT @ID, @lev, ISNULL(@play_time - @lev_play_time, 0)) AS S (ID, lev, play_time)
			ON T.ID = S.ID AND T.lev = S.lev
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (ID, lev, play_time) VALUES (S.ID, S.Lev, S.play_time)
		--OUTPUT $action, Inserted.*, Deleted.*
		;
	END	
END
GO
PRINT N'Creating [dbo].[SB_SelectSoulSkill]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_SelectSoulSkill]
	@user_dbid INT
	, @selected_soul_type INT
	, @selected_seq INT
AS
BEGIN
	SET NOCOUNT ON
	
	MERGE SB_USER_SOUL_SKILL WITH (HOLDLOCK) T
	USING (VALUES (@user_dbid, @selected_soul_type, @selected_seq)) AS S (user_dbid, selected_soul_type, selected_seq)
		ON T.user_dbid = S.user_dbid
	WHEN MATCHED THEN
		UPDATE SET selected_soul_type = S.selected_soul_type, selected_seq = S.selected_seq
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_dbid, selected_soul_type, selected_seq) VALUES (S.user_dbid, S.selected_soul_type, S.selected_seq)
	--OUTPUT $action, Inserted.*, Deleted.*
	;
END
GO
PRINT N'Creating [dbo].[sb_SelectUltimateSkillSoulType]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SelectUltimateSkillSoulType]
	@user_id INT
	, @spec_id TINYINT
	, @ultimate_skill_id INT
	, @selected_soul_type INT
AS
BEGIN
	SET NOCOUNT ON
	
	UPDATE SB_USER_INFO_MULTI_SPEC SET ultimate_skill_id = @ultimate_skill_id, ultimate_soul_type = @selected_soul_type
	WHERE user_id = @user_id AND spec_id = @spec_id
	
	EXEC sb_AcquireUltimateSoulExp @user_id, @ultimate_skill_id, 0, 0, 0, 0
END
GO
PRINT N'Creating [dbo].[sb_SendTax]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SendTax]
	@date bigint,
	@sender_type int,
	@sender_dbid int,
	@sender_name nvarchar(64),
	@recipient_dbid int,
	@title NVARCHAR(50),
	@text NVARCHAR(500),
	@attached_money BIGINT,
	@guildType int
	
AS
BEGIN
	SET NOCOUNT ON;
	
	IF @guildType = 0
	BEGIN
		UPDATE SB_TAX SET is_pvp_sent = 1 WHERE date = dbo.ConvertToDateTime32(@date) AND is_pvp_sent = 0;
	END
	ELSE
	BEGIN
		UPDATE SB_TAX SET is_pve_sent = 1 WHERE date = dbo.ConvertToDateTime32(@date) AND is_pve_sent = 0;
	END
	
	IF @@ROWCOUNT = 0
	BEGIN
		SELECT 0, 0, 1
		RETURN;
	END
	
	DECLARE @recipient_name NVARCHAR(64) = ''
	
	DECLARE @post_id INT = 0
	
		SELECT @recipient_name = name
		FROM dbo.SB_USER (READUNCOMMITTED)
		WHERE ID = @recipient_dbid
			AND deleted_time IS NULL
			AND final_deleted = 'N'
		
		IF @recipient_name = ''
		BEGIN
			SELECT @post_id, @recipient_dbid, 1
			RETURN
		END
		
	
	INSERT INTO SB_POST_BOX (sender_type, sender_dbid, sender_name, recipient_dbid, recipient_name, title, text, attached_money, attached_item_type)
	VALUES (@sender_type, @sender_dbid, @sender_name, @recipient_dbid, @recipient_name, @title, @text, @attached_money, 0)
	
	SET @post_id = SCOPE_IDENTITY()
	
	SELECT @post_id, @recipient_dbid, 0
END
GO
PRINT N'Creating [dbo].[SB_SetBuilder]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SB_SetBuilder]
 @id INT,
 @level INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE SB_USER_INFO SET builder_lev = @level
	WHERE id = @id
END
GO
PRINT N'Creating [dbo].[SB_SetBuilderLevel]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_SetBuilderLevel]  
	@user_name NVARCHAR(64),
	@level INT
AS  
BEGIN  
	SET NOCOUNT ON;

	UPDATE SB_USER_INFO SET builder_lev = @level
	WHERE id = (SELECT id FROM SB_USER (READUNCOMMITTED) WHERE name = @user_name)
END
GO
PRINT N'Creating [dbo].[SB_SetLevel]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_SetLevel]  
	@user_id int, 
	@level int
AS  
BEGIN  
	SET NOCOUNT ON  

	UPDATE SB_USER_INFO  SET [lev] = @level
	WHERE ID = @user_id
END
GO
PRINT N'Creating [dbo].[SB_SetTransmogrify]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SB_SetTransmogrify]
	@user_dbid int,
	@class_id int,
	@slot_type int
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE SB_USER_TRANSMOGRIFY_LIST SET used = 0 WHERE ID = @user_dbid AND slot_type = @slot_type AND used = 1
	UPDATE SB_USER_TRANSMOGRIFY_LIST SET used = 1 WHERE ID = @user_dbid AND class_id = @class_id
END
GO
PRINT N'Creating [dbo].[sb_SoulMoneyLoad]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_SoulMoneyLoad]
	@user_db_id INT
AS
BEGIN
	SET NOCOUNT ON;
	
	IF NOT EXISTS (SELECT user_db_id FROM SB_USER_SOUL_MONEY (READUNCOMMITTED) WHERE user_db_id = @user_db_id)
		INSERT SB_USER_SOUL_MONEY (user_db_id) VALUES(@user_db_id);
	
	SELECT 
		soul_money
	FROM 
		SB_USER_SOUL_MONEY (READUNCOMMITTED)
	WHERE 
		user_db_id = @user_db_id;
END
GO
PRINT N'Creating [dbo].[sb_SoulMoneyUpdate]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SoulMoneyUpdate]
	@user_db_id INT,
	@money BIGINT
AS  
BEGIN  
	SET NOCOUNT ON;  

	UPDATE SB_USER_SOUL_MONEY SET soul_money += @money 
	WHERE user_db_id = @user_db_id
END
GO
PRINT N'Creating [dbo].[sb_SPVPInfoLoad]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SPVPInfoLoad]
	@user_dbid int
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT bf_daily_play_count, play_count_reset_time FROM SB_USER_SPVP_INFO(READUNCOMMITTED) WHERE ID = @user_dbid;
	
END
GO
PRINT N'Creating [dbo].[sb_SPVPInfoUpdate]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_SPVPInfoUpdate]
	@user_dbid int,
	@play_count int,
	@reset_time bigint
AS
BEGIN
	SET NOCOUNT ON;
	
	MERGE SB_USER_SPVP_INFO T
	USING (SELECT @user_dbid ID, @play_count bf_daily_play_count, @reset_time play_count_reset_time) AS S
	ON (T.ID = s.ID)
	WHEN MATCHED THEN
		UPDATE SET bf_daily_play_count = S.bf_daily_play_count, T.play_count_reset_time = S.play_count_reset_time
	
	WHEN NOT MATCHED THEN
		INSERT(ID, bf_daily_play_count, play_count_reset_time) VALUES (S.ID, S.bf_daily_play_count, S.play_count_reset_time)
	;
	
END
GO
PRINT N'Creating [dbo].[sb_SPVPLoad]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_SPVPLoad]
	@user_id INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT bf_class_id
		, win_count, lost_count, win_streak_count, lost_streak_count
		, mvp_count, resource_mvp_count, kill_count, assist_count, occupy_count
		, weekly_afk_count, afk_count 
	FROM SB_USER_SPVP (READUNCOMMITTED)
	WHERE user_id = @user_id
END
GO
PRINT N'Creating [dbo].[sb_SPVPReset]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_SPVPReset]
	@user_id INT
AS
BEGIN
	SET NOCOUNT ON;

    UPDATE SB_USER_SPVP SET weekly_afk_count = 0 WHERE user_id = @user_id;
END
GO
PRINT N'Creating [dbo].[sb_SPVPUpdate]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_SPVPUpdate]
	@user_id INT,
	@bf_class_id INT,
	@win_count INT,
	@lost_count INT,
	@win_streak_count INT,
	@lost_streak_count INT,
	@combat_mvp_count INT,
	@resource_mvp_count INT,
	@kill_count INT,
	@assist_count INT,
	@occupy_count INT,
	@weekly_afk_count INT
AS
BEGIN
	SET NOCOUNT ON;
	
	MERGE SB_USER_SPVP WITH (HOLDLOCK) T
	USING (SELECT @user_id, @bf_class_id) AS S (user_id, bf_class_id)
		ON T.user_id = S.user_id AND T.bf_class_id = S.bf_class_id
	WHEN MATCHED THEN
		UPDATE SET win_count += @win_count, lost_count += @lost_count, win_streak_count = @win_streak_count, lost_streak_count = @lost_streak_count
			, mvp_count += @combat_mvp_count, resource_mvp_count += @resource_mvp_count, kill_count += @kill_count, assist_count += @assist_count, occupy_count += @occupy_count
			, weekly_afk_count += @weekly_afk_count, afk_count += @weekly_afk_count
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_id, bf_class_id
			, win_count, lost_count, win_streak_count, lost_streak_count
			, mvp_count, resource_mvp_count, kill_count, assist_count, occupy_count
			, weekly_afk_count, afk_count)
		VALUES (@user_id, @bf_class_id
			, @win_count, @lost_count, @win_streak_count, @lost_streak_count
			, @combat_mvp_count, @resource_mvp_count, @kill_count, @assist_count, @occupy_count
			, @weekly_afk_count, @weekly_afk_count)
	--OUTPUT $action, Inserted.*, Deleted.*
	;
END
GO
PRINT N'Creating [dbo].[sb_StartNextAttendanceRound]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_StartNextAttendanceRound]
	  @user_id    INT,
	  @start_time INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @now DATETIME = [dbo].ConvertToDateTime32(@start_time);
	
	MERGE INTO [dbo].[SB_USER_ATTENDANCE_ROUND] WITH (HOLDLOCK) AS T
	USING (VALUES (@user_id)) AS S ([user_id])
		ON
			T.[user_id] = S.[user_id]
	WHEN MATCHED THEN
		UPDATE SET
			  T.[number]           = T.[number] + 1
			, T.[start_time]       = @now
			, T.[attendance_count] = 0
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([user_id], [total_attendance_count], [number], [start_time], [attendance_count]) 
		VALUES (S.[user_id], 0, 1, @now, 0)
	--OUTPUT
	--	INSERTED.[number]
	;
END
GO
PRINT N'Creating [dbo].[SB_SwapBagSlot]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_SwapBagSlot]
	@from_bag_dbid INT
	, @from_bag_slot_index INT
	, @to_bag_dbid INT
	, @to_bag_slot_index INT
AS
BEGIN
	SET NOCOUNT ON

	UPDATE dbo.SB_ITEM_BAG
	SET slot_index = CASE ID
		WHEN @from_bag_dbid THEN @from_bag_slot_index
		WHEN @to_bag_dbid THEN @to_bag_slot_index
		END
	WHERE ID in (@from_bag_dbid, @to_bag_dbid)
END
GO
PRINT N'Creating [dbo].[SB_Trade]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_Trade]  
	@from_user int
	, @to_user int
	, @tradeMoney bigint
AS  
BEGIN
	SET NOCOUNT ON
	
	UPDATE SB_USER_INFO
	SET [money] = CASE ID 
					WHEN @from_user THEN [money] - @tradeMoney
					ELSE [money] + @tradeMoney
					END
	WHERE ID in (@from_user, @to_user)
END
GO
PRINT N'Creating [dbo].[SB_TrainProfession]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_TrainProfession]
	@user_id int,
	@profession_id int,
	@delta int
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE SB_USER_PROFESSION
	SET point = point + @delta
	WHERE user_id = @user_id AND profession_id = @profession_id
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleApplyChangeSlotMax]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleApplyChangeSlotMax]
	@user_id INT
	, @delta_slot_max INT
	, @minute_to_expire INT	-- minute
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @TSR_BASE_MAX_SLOT INT = 7
	DECLARE @expire_date DATETIME = DATEADD(MINUTE, @minute_to_expire, GETDATE())
	
	UPDATE SB_USER_TRUST_SALE 
	SET slotMax = @TSR_BASE_MAX_SLOT + @delta_slot_max
		, slot_max_reset_time = @expire_date
	WHERE userDBID = @user_id;
	
	SELECT 
		CASE WHEN slot_max_reset_time IS NULL THEN -1 ELSE dbo.ConvertToTimeT32(slot_max_reset_time) END slot_max_reset_time
	FROM SB_USER_TRUST_SALE (READUNCOMMITTED) 
	WHERE userDBID = @user_id
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleApplyFreeCommission]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleApplyFreeCommission]
	@user_id INT
	, @minute_to_expire INT	-- minute
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @expire_date DATETIME = DATEADD(MINUTE, @minute_to_expire, GETDATE())	
	UPDATE SB_USER_TRUST_SALE SET free_commission_reset_time = @expire_date WHERE userDBID = @user_id
   	
	SELECT 
		CASE WHEN free_commission_reset_time IS NULL THEN -1 ELSE dbo.ConvertToTimeT32(free_commission_reset_time) END free_commission_reset_time
	FROM SB_USER_TRUST_SALE (READUNCOMMITTED) 
	WHERE userDBID = @user_id
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleBuy]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleBuy]
	@ts_id INT
AS
BEGIN
	SET NOCOUNT ON;

	--DECLARE @SS_ON_SALE INT = 0
	--DECLARE @SS_SOLD_OUT INT = 1
	--DECLARE @SS_UNREGISTERED INT = 2
	DECLARE @SS_SELL_TRANSACTION INT = 3
	
	MERGE SB_TRUST_SALE WITH (HOLDLOCK) T
	USING (SELECT @ts_id, @SS_SELL_TRANSACTION) AS S (ts_id, status)
		ON T.ts_id = S.ts_id
	WHEN MATCHED /*AND expire_date > GETDATE() AND blocked = 0*/ THEN
		UPDATE SET status = S.status 
	OUTPUT Inserted.item_id
	;
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleBuyCommit]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleBuyCommit]
	@ts_id INT
	, @success BIT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @SS_ON_SALE INT = 0
	DECLARE @SS_SOLD_OUT INT = 1
	--DECLARE @SS_UNREGISTERED INT = 2
	DECLARE @SS_SELL_TRANSACTION INT = 3
	
	DECLARE @status INT
	IF @success = 1
		SET @status = @SS_SOLD_OUT
	ELSE
		SET @status = @SS_ON_SALE	
	
	UPDATE SB_TRUST_SALE SET status=@status WHERE ts_id=@ts_id AND status=@SS_SELL_TRANSACTION;
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleCancel]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleCancel]
	@ts_id INT
AS
BEGIN
	SET NOCOUNT ON;

	--DECLARE @SS_ON_SALE INT = 0
	--DECLARE @SS_SOLD_OUT INT = 1
	--DECLARE @SS_UNREGISTERED INT = 2
		
	--UPDATE SB_TRUST_SALE SET status = 2 WHERE ts_id = @ts_id AND blocked = 0;
	--SELECT item_id FROM SB_TRUST_SALE WHERE ts_id = @ts_id AND blocked = 0;
	
	MERGE SB_TRUST_SALE WITH (HOLDLOCK) T
	USING (SELECT @ts_id, 2) AS S (ts_id, status)
		ON T.ts_id = S.ts_id
	WHEN MATCHED AND blocked = 0 THEN
		UPDATE SET status = S.status 
	OUTPUT Inserted.item_id
	;
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleCancelAll]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleCancelAll]
	@t_ts_id DBIDList READONLY
AS
BEGIN
	SET NOCOUNT ON;

	--DECLARE @SS_ON_SALE INT = 0
	--DECLARE @SS_SOLD_OUT INT = 1
	--DECLARE @SS_UNREGISTERED INT = 2
		
	MERGE SB_TRUST_SALE WITH (HOLDLOCK) T
	USING (SELECT dbid, 2 FROM @t_ts_id) AS S (ts_id, status)
		ON T.ts_id = S.ts_id
	WHEN MATCHED AND blocked = 0 THEN
		UPDATE SET status = S.status 
	OUTPUT Inserted.ts_id
	;
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleCurrencyBuy]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleCurrencyBuy]
	@buyer_dbid INT,
	@tsc_dbid INT
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE SB_TRUST_SALE_CURRENCY
	SET status = 1, buyer_dbid = @buyer_dbid, buy_date = GETDATE()
	OUTPUT INSERTED.seller_dbid, INSERTED.sell_type
	WHERE tsc_dbid = @tsc_dbid AND status = 0 AND blocked = 0
	;
	
	IF @@ROWCOUNT > 0
	BEGIN
		INSERT INTO SB_TRUST_SALE_CURRENCY_HISTORY
			SELECT tsc_dbid, seller_dbid, sell_type, sell_amount,
				buy_type, buy_amount_one, buy_amount_total, buyer_dbid, buy_date
			FROM SB_TRUST_SALE_CURRENCY
			WHERE tsc_dbid = @tsc_dbid
	END	
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleCurrencyBuyList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleCurrencyBuyList]
	@buyer_dbid INT,
	@currency_type TINYINT,
	@page INT,
	@page_size INT,
	@sort_type INT,
	@valid_day_count INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @row_count INT
	DECLARE @valid_date DATETIME = DATEADD(DD, -@valid_day_count, GETDATE())
	
	SELECT @row_count = COUNT(*) FROM SB_TRUST_SALE_CURRENCY_HISTORY (READUNCOMMITTED)
	WHERE buy_date >= @valid_date AND buyer_dbid = @buyer_dbid AND sell_type = @currency_type

	DECLARE @max_row INT = (((@page - 1) * @page_size) + @page_size)
	SET ROWCOUNT @max_row;

	--todo:zamoa ROWCOUNT deprecated? use TOP
	WITH T_SEARCH_RESULT AS
	(
		SELECT ROW_NUMBER() OVER
			(ORDER BY
				CASE WHEN @sort_type = 4 THEN buy_amount_one END DESC,
				CASE WHEN @sort_type = 5 THEN buy_amount_one END,
				CASE WHEN @sort_type = 6 THEN buy_amount_total END DESC,
				CASE WHEN @sort_type = 7 THEN buy_amount_total END,
				CASE WHEN @sort_type = 8 THEN buy_date END DESC,
				CASE WHEN @sort_type = 9 THEN buy_date END) AS row_num,
			T1.sell_type, T1.sell_amount,
			T1.buy_type, buy_amount_total, T1.buy_date
		FROM
		(
			SELECT TOP(100) PERCENT *
			FROM SB_TRUST_SALE_CURRENCY_HISTORY (READUNCOMMITTED)
			WHERE buy_date >= @valid_date AND buyer_dbid = @buyer_dbid AND sell_type = @currency_type
		) T1
	)
	SELECT @row_count, sell_type, sell_amount, 
		buy_type, buy_amount_total, dbo.ConvertToTimeT32(buy_date)
	FROM T_SEARCH_RESULT
    WHERE row_num BETWEEN ((@page - 1) * @page_size) + 1 AND @page * @page_size
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleCurrencyCalculate]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleCurrencyCalculate]
	@tsc_dbid INT
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE SB_TRUST_SALE_CURRENCY
	SET status = 4
	OUTPUT INSERTED.sell_type
	WHERE tsc_dbid = @tsc_dbid AND status = 1 AND blocked = 0
	;
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleCurrencyCalculateRollback]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleCurrencyCalculateRollback]
	@tsc_dbid INT
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE SB_TRUST_SALE_CURRENCY
	SET status = 1
	OUTPUT INSERTED.sell_type
	WHERE tsc_dbid = @tsc_dbid AND status = 4
	;
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleCurrencyCancel]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleCurrencyCancel]
	@tsc_dbid INT
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE SB_TRUST_SALE_CURRENCY
	SET status = 2
	OUTPUT INSERTED.sell_type
	WHERE tsc_dbid = @tsc_dbid AND status = 0 AND blocked = 0
	;
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleCurrencyCleanUp]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleCurrencyCleanUp]
	@valid_day_count INT
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO SB_TRUST_SALE_CURRENCY_OLD
		SELECT * FROM SB_TRUST_SALE_CURRENCY 
		WHERE status = 2 OR status = 4	-- UNREGISTERED or CALCULATED
		
	DELETE FROM SB_TRUST_SALE_CURRENCY
	WHERE status = 2 OR status = 4	-- UNREGISTERED or CALCULATED
	
	DECLARE @valid_date DATETIME = DATEADD(DD, -@valid_day_count, GETDATE())
	
	DELETE FROM SB_TRUST_SALE_CURRENCY_HISTORY
	WHERE buy_date < @valid_date
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleCurrencyLoad]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleCurrencyLoad]
	@user_dbid INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT tsc_dbid, sell_type, sell_amount, buy_type, buy_amount_total,
		dbo.ConvertToTimeT32(expire_date), status
	FROM SB_TRUST_SALE_CURRENCY (READUNCOMMITTED)
	WHERE seller_dbid = @user_dbid AND (status = 0 OR status = 1) AND blocked = 0
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleCurrencyRegister]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleCurrencyRegister]
	@seller_dbid INT,
	@sell_type TINYINT,
	@sell_amount BIGINT,
	@buy_type TINYINT,
	@buy_amount_total BIGINT,
	@duration_hour INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @reg_date DATETIME = GETDATE()
	DECLARE @exp_date DATETIME = DATEADD(HH, @duration_hour, @reg_date)
	DECLARE @time_t INT = dbo.ConvertToTimeT32(@exp_date)
	
	INSERT INTO SB_TRUST_SALE_CURRENCY
		(seller_dbid, seller_name, status, registered_date, expire_date
		, sell_type, sell_amount, buy_type, buy_amount_one, buy_amount_total)
	OUTPUT
		INSERTED.tsc_dbid, @sell_type, @sell_amount, @buy_type, @buy_amount_total
		, @time_t, INSERTED.status
	VALUES 
		(@seller_dbid, ISNULL((SELECT name FROM SB_USER (READUNCOMMITTED) WHERE ID=@seller_dbid), '')
		, 0, @reg_date, @exp_date
		, @sell_type, @sell_amount
		, @buy_type, @buy_amount_total / @sell_amount, @buy_amount_total
		)
	;
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleCurrencySearch]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleCurrencySearch]
	@currency_type TINYINT,
	@page INT,
	@page_size INT,
	@sort_type INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @row_count INT = 0
	
	SELECT @row_count = COUNT(*) FROM SB_TRUST_SALE_CURRENCY (READUNCOMMITTED)
	WHERE expire_date > GETDATE() AND status = 0 AND sell_type = @currency_type AND blocked = 0

	DECLARE @max_row INT = (((@page - 1) * @page_size) + @page_size)
	SET ROWCOUNT @max_row;

	--todo:zamoa ROWCOUNT deprecated? use TOP
	WITH T_SEARCH_RESULT AS
	(
		SELECT ROW_NUMBER() OVER
			(ORDER BY
				CASE WHEN @sort_type = 2 THEN seller_name END DESC,
				CASE WHEN @sort_type = 3 THEN seller_name END,
				CASE WHEN @sort_type = 4 THEN buy_amount_one END DESC,
				CASE WHEN @sort_type = 5 THEN buy_amount_one END,
				CASE WHEN @sort_type = 6 THEN buy_amount_total END DESC,
				CASE WHEN @sort_type = 7 THEN buy_amount_total END) AS row_num,
			T1.tsc_dbid, T1.sell_type, T1.sell_amount,
			T1.buy_type, buy_amount_total, T1.expire_date, 
			T1.seller_dbid, T1.seller_name
		FROM
		(
			SELECT TOP(100) PERCENT *
			FROM SB_TRUST_SALE_CURRENCY (READUNCOMMITTED)
			WHERE expire_date > GETDATE() AND status = 0 AND sell_type = @currency_type AND blocked = 0
		) T1
	)
	SELECT @row_count, tsc_dbid, sell_type, sell_amount, 
		buy_type, buy_amount_total, dbo.ConvertToTimeT32(expire_date), 
		seller_dbid, seller_name
	FROM T_SEARCH_RESULT
    WHERE row_num BETWEEN ((@page - 1) * @page_size) + 1 AND @page * @page_size
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleCurrencySellList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleCurrencySellList]
	@seller_dbid INT,
	@currency_type TINYINT,
	@page INT,
	@page_size INT,
	@sort_type INT,
	@valid_day_count INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @row_count INT
	DECLARE @valid_date DATETIME = DATEADD(DD, -@valid_day_count, GETDATE())
	
	SELECT @row_count = COUNT(*) FROM SB_TRUST_SALE_CURRENCY_HISTORY (READUNCOMMITTED)
	WHERE buy_date >= @valid_date AND seller_dbid = @seller_dbid AND sell_type = @currency_type

	DECLARE @max_row INT = (((@page - 1) * @page_size) + @page_size)
	SET ROWCOUNT @max_row;

	--todo:zamoa ROWCOUNT deprecated? use TOP
	WITH T_SEARCH_RESULT AS
	(
		SELECT ROW_NUMBER() OVER
			(ORDER BY
				CASE WHEN @sort_type = 4 THEN buy_amount_one END DESC,
				CASE WHEN @sort_type = 5 THEN buy_amount_one END,
				CASE WHEN @sort_type = 6 THEN buy_amount_total END DESC,
				CASE WHEN @sort_type = 7 THEN buy_amount_total END,
				CASE WHEN @sort_type = 8 THEN buy_date END DESC,
				CASE WHEN @sort_type = 9 THEN buy_date END) AS row_num,
			T1.sell_type, T1.sell_amount,
			T1.buy_type, buy_amount_total, T1.buy_date
		FROM
		(
			SELECT TOP(100) PERCENT *
			FROM SB_TRUST_SALE_CURRENCY_HISTORY (READUNCOMMITTED)
			WHERE buy_date >= @valid_date AND seller_dbid = @seller_dbid AND sell_type = @currency_type
		) T1
	)
	SELECT @row_count, sell_type, sell_amount, 
		buy_type, buy_amount_total, dbo.ConvertToTimeT32(buy_date)
	FROM T_SEARCH_RESULT
    WHERE row_num BETWEEN ((@page - 1) * @page_size) + 1 AND @page * @page_size
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleGetAllSoldItemInfo]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleGetAllSoldItemInfo]
	@user_id INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 1, 
		T1.ts_id, T1.user_id, T1.user_name,
		T1.price, T1.status, ISNULL(dbo.ConvertToTimeT32(T1.expire_date), 0) expire_date,
		T1.item_id
	FROM SB_TRUST_SALE T1 (READUNCOMMITTED)
	WHERE T1.user_id = @user_id 
		AND T1.status = 1 AND T1.blocked = 0;
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleGetInfo]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleGetInfo]
	@ts_id INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 1, 
		T1.ts_id, T1.user_id, T1.user_name,
		T1.price, T1.status, ISNULL(dbo.ConvertToTimeT32(T1.expire_date), 0) expire_date,
		T1.item_id
	FROM SB_TRUST_SALE T1 (READUNCOMMITTED)
	WHERE T1.ts_id = @ts_id 
		AND T1.blocked = 0;
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleGetMyList]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleGetMyList]
	@user_id INT
AS
BEGIN
	SET NOCOUNT ON;

	--DECLARE @SS_UNREGISTERED INT = 2
	
	SELECT ts_id, price, status, dbo.ConvertToTimeT32(expire_date) expire_date, item_id, item_class_id, item_amount
	FROM SB_TRUST_SALE (READUNCOMMITTED)
	WHERE user_id = @user_id
		AND status != 2
		AND blocked = 0;
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleRegister]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleRegister]
	@user_id INT,
	@item_id BIGINT,
	@item_class_id INT,
	@item_amount INT,
	@price BIGINT,
	@item_level INT,
	@item_grade INT,
	@job_type INT,
	@duration INT,
	@category1 INT,
	@category2 INT,
	@category3 INT
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO SB_TRUST_SALE 
		(user_id, user_name, item_id, item_class_id, item_amount
		, price, price_per_item, item_level, item_grade, job_type
		, category1, category2, category3, status
		, registered_date, expire_date)
	OUTPUT
		1 package_count, 
		INSERTED.ts_id, INSERTED.user_id, INSERTED.user_name, INSERTED.price, INSERTED.status
		, ISNULL(DATEDIFF(SECOND, DATEADD(HOUR, DATEDIFF(HOUR, GETUTCDATE(), GETDATE()), '1970-01-01 00:00:00'), INSERTED.expire_date), 0) expire_date
		--, ISNULL(dbo.ConvertToTimeT32(INSERTED.expire_date), 0) expire_date
		, INSERTED.item_id
	VALUES 
		(@user_id, ISNULL((SELECT name FROM SB_USER (READUNCOMMITTED) WHERE ID=@user_id), ''), @item_id, @item_class_id, @item_amount
		, @price, (CONVERT(FLOAT, @price) / @item_amount), @item_level, @item_grade, @job_type
		, @category1, @category2, @category3, 0
		, GETDATE(), DATEADD(HH, @duration, GETDATE()));
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleRemoveChangeSlotMax]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleRemoveChangeSlotMax]
	@user_id INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @TSR_BASE_MAX_SLOT INT = 7

   	UPDATE SB_USER_TRUST_SALE 
   	SET slotMax = @TSR_BASE_MAX_SLOT
   		, slot_max_reset_time = NULL 
   	WHERE userDBID = @user_id AND slot_max_reset_time < DATEADD(MINUTE, 5, GETDATE());
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleRemoveFreeCommission]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleRemoveFreeCommission]
	@user_id INT
AS
BEGIN
	SET NOCOUNT ON;

   	UPDATE SB_USER_TRUST_SALE 
   	SET free_commission_reset_time = NULL 
   	WHERE userDBID = @user_id AND free_commission_reset_time < DATEADD(MINUTE, 5, GETDATE());
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleSearch]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleSearch]
	@page INT,
	@page_size INT,
	@user_id INT,
	@t_items SearchItem READONLY,
	@sort_type INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @row_count INT
	
	SELECT @row_count = COUNT(*) FROM SB_TRUST_SALE (READUNCOMMITTED)
	WHERE expire_date > GETDATE()
		AND status = 0 AND blocked = 0
		AND item_class_id in (SELECT item FROM @t_items)

	DECLARE @max_row INT = (((@page - 1) * @page_size) + @page_size)
	SET ROWCOUNT @max_row;

	--todo:zamoa ROWCOUNT deprecated? use TOP
	WITH T_SEARCH_RESULT AS
	(
		SELECT ROW_NUMBER() OVER
			(ORDER BY
				CASE WHEN @sort_type = 0 THEN item_level END DESC,
				CASE WHEN @sort_type = 1 THEN item_level END,
				CASE WHEN @sort_type = 2 THEN user_name END DESC,
				CASE WHEN @sort_type = 3 THEN user_name END,
				CASE WHEN @sort_type = 4 THEN price_per_item END DESC,
				CASE WHEN @sort_type = 5 THEN price_per_item END,
				CASE WHEN @sort_type = 6 THEN price END DESC,
				CASE WHEN @sort_type = 7 THEN price END) AS row_num,
			T1.ts_id, T1.user_id, T1.user_name,
			T1.price, status, ISNULL(dbo.ConvertToTimeT32(T1.expire_date), 0) expire_date,
			T1.item_id
		FROM
		(
			SELECT TOP(100) PERCENT *
			FROM SB_TRUST_SALE (READUNCOMMITTED)
			WHERE expire_date > GETDATE()
				AND status = 0 AND blocked = 0				
				AND item_class_id in (SELECT item FROM @t_items)
		) T1
	)
	SELECT @row_count, ts_id, user_id, user_name, price, status, expire_date, item_id
	FROM T_SEARCH_RESULT
    WHERE row_num BETWEEN ((@page - 1) * @page_size) + 1 AND @page * @page_size
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleSearchAll]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleSearchAll]
	@page INT,
	@page_size INT,
	@user_id INT,
	@sort_type INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @row_count INT
	SELECT @row_count = COUNT(*) FROM SB_TRUST_SALE (READUNCOMMITTED)
	WHERE expire_date > GETDATE()
		AND status = 0 AND blocked = 0

	DECLARE @max_row INT = (((@page - 1) * @page_size) + @page_size)
	SET ROWCOUNT @max_row;

	WITH T_SEARCH_RESULT AS
	(
		SELECT ROW_NUMBER() OVER
			(ORDER BY
				CASE WHEN @sort_type = 0 THEN item_level END DESC,
				CASE WHEN @sort_type = 1 THEN item_level END,
				CASE WHEN @sort_type = 2 THEN user_name END DESC,
				CASE WHEN @sort_type = 3 THEN user_name END,
				CASE WHEN @sort_type = 4 THEN price_per_item END DESC,
				CASE WHEN @sort_type = 5 THEN price_per_item END,
				CASE WHEN @sort_type = 6 THEN price END DESC,
				CASE WHEN @sort_type = 7 THEN price END) AS row_num,
			T1.ts_id, T1.user_id, T1.user_name,
			T1.price, T1.status, ISNULL(dbo.ConvertToTimeT32(T1.expire_date), 0) expire_date,
			T1.item_id
		FROM
		(
			SELECT TOP(100) PERCENT *
			FROM SB_TRUST_SALE (READUNCOMMITTED)
			WHERE expire_date > GETDATE()
				AND status = 0 AND blocked = 0
		) T1
	)
	SELECT @row_count, ts_id, user_id, user_name, price, status, expire_date, item_id
	FROM T_SEARCH_RESULT
    WHERE row_num BETWEEN ((@page - 1) * @page_size) + 1 AND @page * @page_size
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleSearchByCategory1]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleSearchByCategory1]
	@page INT,
	@page_size INT,
	@user_id INT,
	@min_item_level INT,
	@max_item_level INT,
	@job_type INT,
	@category INT,
	@sort_type INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @row_count INT
	SELECT @row_count = COUNT(*) FROM SB_TRUST_SALE (READUNCOMMITTED)
	WHERE expire_date > GETDATE()
		AND status = 0 AND blocked = 0
		AND item_level BETWEEN @min_item_level AND @max_item_level
		--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
		AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
		AND category1 = @category

	DECLARE @max_row INT = (((@page - 1) * @page_size) + @page_size)
	SET ROWCOUNT @max_row;

	WITH T_SEARCH_RESULT AS
	(
		SELECT ROW_NUMBER() OVER
			(ORDER BY
				CASE WHEN @sort_type = 0 THEN item_level END DESC,
				CASE WHEN @sort_type = 1 THEN item_level END,
				CASE WHEN @sort_type = 2 THEN user_name END DESC,
				CASE WHEN @sort_type = 3 THEN user_name END,
				CASE WHEN @sort_type = 4 THEN price_per_item END DESC,
				CASE WHEN @sort_type = 5 THEN price_per_item END,
				CASE WHEN @sort_type = 6 THEN price END DESC,
				CASE WHEN @sort_type = 7 THEN price END) AS row_num,
			T1.ts_id, T1.user_id, T1.user_name,
			T1.price, T1.status, ISNULL(dbo.ConvertToTimeT32(T1.expire_date), 0) expire_date,
			T1.item_id
		FROM
		(
			SELECT TOP(100) PERCENT *
			FROM SB_TRUST_SALE (READUNCOMMITTED)
			WHERE expire_date > GETDATE() 
				AND status = 0 AND blocked = 0
				AND item_level BETWEEN @min_item_level AND @max_item_level
				--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
				AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
				AND category1 = @category
		) T1
	)
	SELECT @row_count, ts_id, user_id, user_name, price, status, expire_date, item_id
	FROM T_SEARCH_RESULT
    WHERE row_num BETWEEN ((@page - 1) * @page_size) + 1 AND @page * @page_size
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleSearchByCategory12]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleSearchByCategory12]
	@page INT,
	@page_size INT,
	@user_id INT,
	@min_item_level INT,
	@max_item_level INT,
	@job_type INT,
	@category1 INT,
	@category2 INT,
	@sort_type INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @row_count INT
	SELECT @row_count = COUNT(*) FROM SB_TRUST_SALE (READUNCOMMITTED)
	WHERE expire_date > GETDATE()
		AND status = 0 AND blocked = 0
		AND item_level BETWEEN @min_item_level AND @max_item_level
		--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
		AND CASE WHEN job_type = 0 THEN 1
			WHEN @job_type = 0 THEN 1
			WHEN job_type = @job_type THEN 1
			ELSE 0 END = 1
		AND category1 = @category1 AND category2 = @category2

	DECLARE @max_row INT = (((@page - 1) * @page_size) + @page_size)
	SET ROWCOUNT @max_row;

	WITH T_SEARCH_RESULT AS
	(
		SELECT ROW_NUMBER() OVER
			(ORDER BY
				CASE WHEN @sort_type = 0 THEN item_level END DESC,
				CASE WHEN @sort_type = 1 THEN item_level END,
				CASE WHEN @sort_type = 2 THEN user_name END DESC,
				CASE WHEN @sort_type = 3 THEN user_name END,
				CASE WHEN @sort_type = 4 THEN price_per_item END DESC,
				CASE WHEN @sort_type = 5 THEN price_per_item END,
				CASE WHEN @sort_type = 6 THEN price END DESC,
				CASE WHEN @sort_type = 7 THEN price END) AS row_num,
			T1.ts_id, T1.user_id, T1.user_name,
			T1.price, T1.status, ISNULL(dbo.ConvertToTimeT32(T1.expire_date), 0) expire_date,
			T1.item_id
		FROM
		(
			SELECT TOP(100) PERCENT *
			FROM SB_TRUST_SALE (READUNCOMMITTED)
			WHERE expire_date > GETDATE()
				AND status = 0 AND blocked = 0
				AND item_level BETWEEN @min_item_level AND @max_item_level
				--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
				AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
				AND category1 = @category1 AND category2 = @category2
		) T1
	)
	SELECT @row_count, ts_id, user_id, user_name, price, status, expire_date, item_id
	FROM T_SEARCH_RESULT
    WHERE row_num BETWEEN ((@page - 1) * @page_size) + 1 AND @page * @page_size
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleSearchByCategory123]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleSearchByCategory123]
	@page INT,
	@page_size INT,
	@user_id INT,
	@min_item_level INT,
	@max_item_level INT,
	@job_type INT,
	@category1 INT,
	@category2 INT,
	@category3 INT,
	@sort_type INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @row_count INT
	SELECT @row_count = COUNT(*) FROM SB_TRUST_SALE (READUNCOMMITTED)
	WHERE expire_date > GETDATE()
		AND status = 0 AND blocked = 0
		AND item_level BETWEEN @min_item_level AND @max_item_level
		--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
		AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
		AND category1 = @category1 AND category2 = @category2 AND category3 = @category3

	DECLARE @max_row INT
	SET @max_row = (((@page - 1) * @page_size) + @page_size)
	SET ROWCOUNT @max_row;

	WITH T_SEARCH_RESULT AS
	(
		SELECT ROW_NUMBER() OVER
			(ORDER BY
				CASE WHEN @sort_type = 0 THEN item_level END DESC,
				CASE WHEN @sort_type = 1 THEN item_level END,
				CASE WHEN @sort_type = 2 THEN user_name END DESC,
				CASE WHEN @sort_type = 3 THEN user_name END,
				CASE WHEN @sort_type = 4 THEN price_per_item END DESC,
				CASE WHEN @sort_type = 5 THEN price_per_item END,
				CASE WHEN @sort_type = 6 THEN price END DESC,
				CASE WHEN @sort_type = 7 THEN price END) AS row_num,
			T1.ts_id, T1.user_id, T1.user_name,
			T1.price, T1.status, ISNULL(dbo.ConvertToTimeT32(T1.expire_date), 0) expire_date,
			T1.item_id
		FROM
		(
			SELECT TOP(100) PERCENT *
			FROM SB_TRUST_SALE (READUNCOMMITTED)
			WHERE expire_date > GETDATE()
				AND status = 0 AND blocked = 0
				AND item_level BETWEEN @min_item_level AND @max_item_level
				--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
				AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
				AND category1 = @category1 AND category2 = @category2 AND category3 = @category3
		) T1
	)
	SELECT @row_count, ts_id, user_id, user_name, price, status, expire_date, item_id
	FROM T_SEARCH_RESULT
    WHERE row_num BETWEEN ((@page - 1) * @page_size) + 1 AND @page * @page_size
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleSearchByGrade]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleSearchByGrade]
	@page INT,
	@page_size INT,
	@user_id INT,
	@min_item_level INT,
	@max_item_level INT,
	@job_type INT,
	@item_grade INT,
	@sort_type INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @row_count INT
	SELECT @row_count = COUNT(*) FROM SB_TRUST_SALE (READUNCOMMITTED)
	WHERE expire_date > GETDATE()
		AND status = 0 AND blocked = 0
		AND item_level BETWEEN @min_item_level AND @max_item_level
		--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
		AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
		AND item_grade >= @item_grade

	DECLARE @max_row INT = (((@page - 1) * @page_size) + @page_size)
	SET ROWCOUNT @max_row;

	WITH T_SEARCH_RESULT AS
	(
		SELECT ROW_NUMBER() OVER
			(ORDER BY
				CASE WHEN @sort_type = 0 THEN item_level END DESC,
				CASE WHEN @sort_type = 1 THEN item_level END,
				CASE WHEN @sort_type = 2 THEN user_name END DESC,
				CASE WHEN @sort_type = 3 THEN user_name END,
				CASE WHEN @sort_type = 4 THEN price_per_item END DESC,
				CASE WHEN @sort_type = 5 THEN price_per_item END,
				CASE WHEN @sort_type = 6 THEN price END DESC,
				CASE WHEN @sort_type = 7 THEN price END) AS row_num,
			T1.ts_id, T1.user_id, T1.user_name,
			T1.price, T1.status, ISNULL(dbo.ConvertToTimeT32(T1.expire_date), 0) expire_date,
			T1.item_id
		FROM
		(
			SELECT TOP(100) PERCENT *
			FROM SB_TRUST_SALE (READUNCOMMITTED)
			WHERE expire_date > GETDATE()
				AND status = 0 AND blocked = 0
				AND item_level BETWEEN @min_item_level AND @max_item_level
				--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
				AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
				AND item_grade >= @item_grade
		) T1
	)
	SELECT @row_count, ts_id, user_id, user_name, price, status, expire_date, item_id
	FROM T_SEARCH_RESULT
    WHERE row_num BETWEEN ((@page - 1) * @page_size) + 1 AND @page * @page_size
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleSearchByGradeCategory1]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleSearchByGradeCategory1]
	@page INT,
	@page_size INT,
	@user_id INT,
	@min_item_level INT,
	@max_item_level INT,
	@job_type INT,
	@item_grade INT,
	@category1 INT,
	@sort_type INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @row_count INT
	SELECT @row_count = COUNT(*) FROM SB_TRUST_SALE (READUNCOMMITTED)
	WHERE expire_date > GETDATE()
		AND status = 0 AND blocked = 0
		AND item_level BETWEEN @min_item_level AND @max_item_level
		--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
		AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
		AND item_grade >= @item_grade
		AND category1 = @category1

	DECLARE @max_row INT = (((@page - 1) * @page_size) + @page_size)
	SET ROWCOUNT @max_row;

	WITH T_SEARCH_RESULT AS
	(
		SELECT ROW_NUMBER() OVER
			(ORDER BY
				CASE WHEN @sort_type = 0 THEN item_level END DESC,
				CASE WHEN @sort_type = 1 THEN item_level END,
				CASE WHEN @sort_type = 2 THEN user_name END DESC,
				CASE WHEN @sort_type = 3 THEN user_name END,
				CASE WHEN @sort_type = 4 THEN price_per_item END DESC,
				CASE WHEN @sort_type = 5 THEN price_per_item END,
				CASE WHEN @sort_type = 6 THEN price END DESC,
				CASE WHEN @sort_type = 7 THEN price END) AS row_num,
			T1.ts_id, T1.user_id, T1.user_name,
			T1.price, T1.status, ISNULL(dbo.ConvertToTimeT32(T1.expire_date), 0) expire_date,
			T1.item_id
		FROM
		(
			SELECT TOP(100) PERCENT *
			FROM SB_TRUST_SALE (READUNCOMMITTED)
			WHERE expire_date > GETDATE()
				AND status = 0 AND blocked = 0
				AND item_level BETWEEN @min_item_level AND @max_item_level
				--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
				AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
				AND item_grade >= @item_grade
				AND category1 = @category1
		) T1
	)
	SELECT @row_count, ts_id, user_id, user_name, price, status, expire_date, item_id
	FROM T_SEARCH_RESULT
    WHERE row_num BETWEEN ((@page - 1) * @page_size) + 1 AND @page * @page_size
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleSearchByGradeCategory12]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleSearchByGradeCategory12]
	@page INT,
	@page_size INT,
	@user_id INT,
	@min_item_level INT,
	@max_item_level INT,
	@job_type INT,
	@item_grade INT,
	@category1 INT,
	@category2 INT,
	@sort_type INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @row_count INT
	SELECT @row_count = COUNT(*) FROM SB_TRUST_SALE (READUNCOMMITTED)
	WHERE expire_date > GETDATE()
		AND status = 0 AND blocked = 0
		AND item_level BETWEEN @min_item_level AND @max_item_level
		--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
		AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
		AND item_grade >= @item_grade
		AND category1 = @category1 AND category2 = @category2

	DECLARE @max_row INT = (((@page - 1) * @page_size) + @page_size)
	SET ROWCOUNT @max_row;

	WITH T_SEARCH_RESULT AS
	(
		SELECT ROW_NUMBER() OVER
			(ORDER BY
				CASE WHEN @sort_type = 0 THEN item_level END DESC,
				CASE WHEN @sort_type = 1 THEN item_level END,
				CASE WHEN @sort_type = 2 THEN user_name END DESC,
				CASE WHEN @sort_type = 3 THEN user_name END,
				CASE WHEN @sort_type = 4 THEN price_per_item END DESC,
				CASE WHEN @sort_type = 5 THEN price_per_item END,
				CASE WHEN @sort_type = 6 THEN price END DESC,
				CASE WHEN @sort_type = 7 THEN price END) AS row_num,
			T1.ts_id, T1.user_id, T1.user_name,
			T1.price, T1.status, ISNULL(dbo.ConvertToTimeT32(T1.expire_date), 0) expire_date,
			T1.item_id
		FROM
		(
			SELECT TOP(100) PERCENT *
			FROM SB_TRUST_SALE (READUNCOMMITTED)
			WHERE expire_date > GETDATE()
				AND status = 0 AND blocked = 0
				AND item_level BETWEEN @min_item_level AND @max_item_level
				--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
				AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
				AND item_grade >= @item_grade
				AND category1 = @category1 AND category2 = @category2
		) T1
	)
	SELECT @row_count, ts_id, user_id, user_name, price, status, expire_date, item_id
	FROM T_SEARCH_RESULT
    WHERE row_num BETWEEN ((@page - 1) * @page_size) + 1 AND @page * @page_size
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleSearchByGradeCategory123]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleSearchByGradeCategory123]
	@page INT,
	@page_size INT,
	@user_id INT,
	@min_item_level INT,
	@max_item_level INT,
	@job_type INT,
	@item_grade INT,
	@category1 INT,
	@category2 INT,
	@category3 INT,
	@sort_type INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @row_count INT
	SELECT @row_count = COUNT(*) FROM SB_TRUST_SALE (READUNCOMMITTED)
	WHERE expire_date > GETDATE()
		AND status = 0 AND blocked = 0
		AND item_level BETWEEN @min_item_level AND @max_item_level
		--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
		AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
		AND item_grade >= @item_grade
		AND category1 >= @category1 AND category2 = @category2 AND category3 = @category3

	DECLARE @max_row INT = (((@page - 1) * @page_size) + @page_size)
	SET ROWCOUNT @max_row;

	WITH T_SEARCH_RESULT AS
	(
		SELECT ROW_NUMBER() OVER
			(ORDER BY
				CASE WHEN @sort_type = 0 THEN item_level END DESC,
				CASE WHEN @sort_type = 1 THEN item_level END,
				CASE WHEN @sort_type = 2 THEN user_name END DESC,
				CASE WHEN @sort_type = 3 THEN user_name END,
				CASE WHEN @sort_type = 4 THEN price_per_item END DESC,
				CASE WHEN @sort_type = 5 THEN price_per_item END,
				CASE WHEN @sort_type = 6 THEN price END DESC,
				CASE WHEN @sort_type = 7 THEN price END) AS row_num,
			T1.ts_id, T1.user_id, T1.user_name,
			T1.price, T1.status, ISNULL(dbo.ConvertToTimeT32(T1.expire_date), 0) expire_date,
			T1.item_id
		FROM
		(
			SELECT TOP(100) PERCENT *
			FROM SB_TRUST_SALE (READUNCOMMITTED)
			WHERE expire_date > GETDATE()
				AND status = 0 AND blocked = 0
				AND item_level BETWEEN @min_item_level AND @max_item_level
				--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
				AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
				AND item_grade >= @item_grade
				AND category1 >= @category1 AND category2 = @category2 AND category3 = @category3
		) T1
	)
	SELECT @row_count, ts_id, user_id, user_name, price, status, expire_date, item_id
	FROM T_SEARCH_RESULT
    WHERE row_num BETWEEN ((@page - 1) * @page_size) + 1 AND @page * @page_size
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleSearchByItemCategory1]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleSearchByItemCategory1]
	@page INT,
	@page_size INT,
	@user_id INT,
	@min_item_level INT,
	@max_item_level INT,
	@job_type INT,
	@category INT,
	@t_items SearchItem READONLY,
	@sort_type INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @row_count INT
	SELECT @row_count = COUNT(*) FROM SB_TRUST_SALE (READUNCOMMITTED)
	WHERE expire_date > GETDATE()
		AND status = 0 AND blocked = 0
		AND item_level BETWEEN @min_item_level AND @max_item_level
		--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
		AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
		AND category1 = @category
		AND item_class_id in (SELECT item FROM @t_items)

	DECLARE @max_row INT = (((@page - 1) * @page_size) + @page_size)
	SET ROWCOUNT @max_row;

	WITH T_SEARCH_RESULT AS
	(
		SELECT ROW_NUMBER() OVER
			(ORDER BY
				CASE WHEN @sort_type = 0 THEN item_level END DESC,
				CASE WHEN @sort_type = 1 THEN item_level END,
				CASE WHEN @sort_type = 2 THEN user_name END DESC,
				CASE WHEN @sort_type = 3 THEN user_name END,
				CASE WHEN @sort_type = 4 THEN price_per_item END DESC,
				CASE WHEN @sort_type = 5 THEN price_per_item END,
				CASE WHEN @sort_type = 6 THEN price END DESC,
				CASE WHEN @sort_type = 7 THEN price END) AS row_num,
			T1.ts_id, T1.user_id, T1.user_name,
			T1.price, T1.status, ISNULL(dbo.ConvertToTimeT32(T1.expire_date), 0) expire_date,
			T1.item_id
		FROM
		(
			SELECT TOP(100) PERCENT *
			FROM SB_TRUST_SALE (READUNCOMMITTED)
			WHERE expire_date > GETDATE() 
				AND status = 0 AND blocked = 0
				AND item_level BETWEEN @min_item_level AND @max_item_level
				--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
				AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
				AND category1 = @category
				AND item_class_id in (SELECT item FROM @t_items)
		) T1
	)
	SELECT @row_count, ts_id, user_id, user_name, price, status, expire_date, item_id
	FROM T_SEARCH_RESULT
    WHERE row_num BETWEEN ((@page - 1) * @page_size) + 1 AND @page * @page_size
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleSearchByItemCategory12]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleSearchByItemCategory12]
	@page INT,
	@page_size INT,
	@user_id INT,
	@min_item_level INT,
	@max_item_level INT,
	@job_type INT,
	@category1 INT,
	@category2 INT,
	@t_items SearchItem READONLY,
	@sort_type INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @row_count INT
	SELECT @row_count = COUNT(*) FROM SB_TRUST_SALE (READUNCOMMITTED)
	WHERE expire_date > GETDATE()
		AND status = 0 AND blocked = 0
		AND item_level BETWEEN @min_item_level AND @max_item_level
		--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
		AND CASE WHEN job_type = 0 THEN 1
			WHEN @job_type = 0 THEN 1
			WHEN job_type = @job_type THEN 1
			ELSE 0 END = 1
		AND category1 = @category1 AND category2 = @category2
		AND item_class_id in (SELECT item FROM @t_items)

	DECLARE @max_row INT = (((@page - 1) * @page_size) + @page_size)
	SET ROWCOUNT @max_row;

	WITH T_SEARCH_RESULT AS
	(
		SELECT ROW_NUMBER() OVER
			(ORDER BY
				CASE WHEN @sort_type = 0 THEN item_level END DESC,
				CASE WHEN @sort_type = 1 THEN item_level END,
				CASE WHEN @sort_type = 2 THEN user_name END DESC,
				CASE WHEN @sort_type = 3 THEN user_name END,
				CASE WHEN @sort_type = 4 THEN price_per_item END DESC,
				CASE WHEN @sort_type = 5 THEN price_per_item END,
				CASE WHEN @sort_type = 6 THEN price END DESC,
				CASE WHEN @sort_type = 7 THEN price END) AS row_num,
			T1.ts_id, T1.user_id, T1.user_name,
			T1.price, T1.status, ISNULL(dbo.ConvertToTimeT32(T1.expire_date), 0) expire_date,
			T1.item_id
		FROM
		(
			SELECT TOP(100) PERCENT *
			FROM SB_TRUST_SALE (READUNCOMMITTED)
			WHERE expire_date > GETDATE()
				AND status = 0 AND blocked = 0
				AND item_level BETWEEN @min_item_level AND @max_item_level
				--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
				AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
				AND category1 = @category1 AND category2 = @category2
				AND item_class_id in (SELECT item FROM @t_items)
		) T1
	)
	SELECT @row_count, ts_id, user_id, user_name, price, status, expire_date, item_id
	FROM T_SEARCH_RESULT
    WHERE row_num BETWEEN ((@page - 1) * @page_size) + 1 AND @page * @page_size
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleSearchByItemCategory123]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleSearchByItemCategory123]
	@page INT,
	@page_size INT,
	@user_id INT,
	@min_item_level INT,
	@max_item_level INT,
	@job_type INT,
	@category1 INT,
	@category2 INT,
	@category3 INT,
	@t_items SearchItem READONLY,
	@sort_type INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @row_count INT
	SELECT @row_count = COUNT(*) FROM SB_TRUST_SALE (READUNCOMMITTED)
	WHERE expire_date > GETDATE()
		AND status = 0 AND blocked = 0
		AND item_level BETWEEN @min_item_level AND @max_item_level
		--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
		AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
		AND category1 = @category1 AND category2 = @category2 AND category3 = @category3
		AND item_class_id in (SELECT item FROM @t_items)

	DECLARE @max_row INT
	SET @max_row = (((@page - 1) * @page_size) + @page_size)
	SET ROWCOUNT @max_row;

	WITH T_SEARCH_RESULT AS
	(
		SELECT ROW_NUMBER() OVER
			(ORDER BY
				CASE WHEN @sort_type = 0 THEN item_level END DESC,
				CASE WHEN @sort_type = 1 THEN item_level END,
				CASE WHEN @sort_type = 2 THEN user_name END DESC,
				CASE WHEN @sort_type = 3 THEN user_name END,
				CASE WHEN @sort_type = 4 THEN price_per_item END DESC,
				CASE WHEN @sort_type = 5 THEN price_per_item END,
				CASE WHEN @sort_type = 6 THEN price END DESC,
				CASE WHEN @sort_type = 7 THEN price END) AS row_num,
			T1.ts_id, T1.user_id, T1.user_name,
			T1.price, T1.status, ISNULL(dbo.ConvertToTimeT32(T1.expire_date), 0) expire_date,
			T1.item_id
		FROM
		(
			SELECT TOP(100) PERCENT *
			FROM SB_TRUST_SALE (READUNCOMMITTED)
			WHERE expire_date > GETDATE()
				AND status = 0 AND blocked = 0
				AND item_level BETWEEN @min_item_level AND @max_item_level
				--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
				AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
				AND category1 = @category1 AND category2 = @category2 AND category3 = @category3
				AND item_class_id in (SELECT item FROM @t_items)
		) T1
	)
	SELECT @row_count, ts_id, user_id, user_name, price, status, expire_date, item_id
	FROM T_SEARCH_RESULT
    WHERE row_num BETWEEN ((@page - 1) * @page_size) + 1 AND @page * @page_size
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleSearchByItemGrade]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleSearchByItemGrade]
	@page INT,
	@page_size INT,
	@user_id INT,
	@min_item_level INT,
	@max_item_level INT,
	@job_type INT,
	@item_grade INT,
	@t_items SearchItem READONLY,
	@sort_type INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @row_count INT
	SELECT @row_count = COUNT(*) FROM SB_TRUST_SALE (READUNCOMMITTED)
	WHERE expire_date > GETDATE()
		AND status = 0 AND blocked = 0
		AND item_level BETWEEN @min_item_level AND @max_item_level
		--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
		AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
		AND item_grade >= @item_grade
		AND item_class_id in (SELECT item FROM @t_items)

	DECLARE @max_row INT = (((@page - 1) * @page_size) + @page_size)
	SET ROWCOUNT @max_row;

	WITH T_SEARCH_RESULT AS
	(
		SELECT ROW_NUMBER() OVER
			(ORDER BY
				CASE WHEN @sort_type = 0 THEN item_level END DESC,
				CASE WHEN @sort_type = 1 THEN item_level END,
				CASE WHEN @sort_type = 2 THEN user_name END DESC,
				CASE WHEN @sort_type = 3 THEN user_name END,
				CASE WHEN @sort_type = 4 THEN price_per_item END DESC,
				CASE WHEN @sort_type = 5 THEN price_per_item END,
				CASE WHEN @sort_type = 6 THEN price END DESC,
				CASE WHEN @sort_type = 7 THEN price END) AS row_num,
			T1.ts_id, T1.user_id, T1.user_name,
			T1.price, T1.status, ISNULL(dbo.ConvertToTimeT32(T1.expire_date), 0) expire_date,
			T1.item_id
		FROM
		(
			SELECT TOP(100) PERCENT *
			FROM SB_TRUST_SALE (READUNCOMMITTED)
			WHERE expire_date > GETDATE()
				AND status = 0 AND blocked = 0
				AND item_level BETWEEN @min_item_level AND @max_item_level
				--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
				AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
				AND item_grade >= @item_grade
				AND item_class_id in (SELECT item FROM @t_items)
		) T1
	)
	SELECT @row_count, ts_id, user_id, user_name, price, status, expire_date, item_id
	FROM T_SEARCH_RESULT
    WHERE row_num BETWEEN ((@page - 1) * @page_size) + 1 AND @page * @page_size
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleSearchByItemGradeCategory1]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleSearchByItemGradeCategory1]
	@page INT,
	@page_size INT,
	@user_id INT,
	@min_item_level INT,
	@max_item_level INT,
	@job_type INT,
	@item_grade INT,
	@category1 INT,
	@t_items SearchItem READONLY,
	@sort_type INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @row_count INT
	SELECT @row_count = COUNT(*) FROM SB_TRUST_SALE (READUNCOMMITTED)
	WHERE expire_date > GETDATE()
		AND status = 0 AND blocked = 0
		AND item_level BETWEEN @min_item_level AND @max_item_level
		--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
		AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
		AND item_grade >= @item_grade
		AND category1 = @category1
		AND item_class_id in (SELECT item FROM @t_items)

	DECLARE @max_row INT = (((@page - 1) * @page_size) + @page_size)
	SET ROWCOUNT @max_row;

	WITH T_SEARCH_RESULT AS
	(
		SELECT ROW_NUMBER() OVER
			(ORDER BY
				CASE WHEN @sort_type = 0 THEN item_level END DESC,
				CASE WHEN @sort_type = 1 THEN item_level END,
				CASE WHEN @sort_type = 2 THEN user_name END DESC,
				CASE WHEN @sort_type = 3 THEN user_name END,
				CASE WHEN @sort_type = 4 THEN price_per_item END DESC,
				CASE WHEN @sort_type = 5 THEN price_per_item END,
				CASE WHEN @sort_type = 6 THEN price END DESC,
				CASE WHEN @sort_type = 7 THEN price END) AS row_num,
			T1.ts_id, T1.user_id, T1.user_name,
			T1.price, T1.status, ISNULL(dbo.ConvertToTimeT32(T1.expire_date), 0) expire_date,
			T1.item_id
		FROM
		(
			SELECT TOP(100) PERCENT *
			FROM SB_TRUST_SALE (READUNCOMMITTED)
			WHERE expire_date > GETDATE()
				AND status = 0 AND blocked = 0
				AND item_level BETWEEN @min_item_level AND @max_item_level
				--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
				AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
				AND item_grade >= @item_grade
				AND category1 = @category1
				AND item_class_id in (SELECT item FROM @t_items)
		) T1
	)
	SELECT @row_count, ts_id, user_id, user_name, price, status, expire_date, item_id
	FROM T_SEARCH_RESULT
    WHERE row_num BETWEEN ((@page - 1) * @page_size) + 1 AND @page * @page_size
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleSearchByItemGradeCategory12]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleSearchByItemGradeCategory12]
	@page INT,
	@page_size INT,
	@user_id INT,
	@min_item_level INT,
	@max_item_level INT,
	@job_type INT,
	@item_grade INT,
	@category1 INT,
	@category2 INT,
	@t_items SearchItem READONLY,
	@sort_type INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @row_count INT
	SELECT @row_count = COUNT(*) FROM SB_TRUST_SALE (READUNCOMMITTED)
	WHERE expire_date > GETDATE()
		AND status = 0 AND blocked = 0
		AND item_level BETWEEN @min_item_level AND @max_item_level
		--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
		AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
		AND item_grade >= @item_grade
		AND category1 = @category1 AND category2 = @category2
		AND item_class_id in (SELECT item FROM @t_items)

	DECLARE @max_row INT = (((@page - 1) * @page_size) + @page_size)
	SET ROWCOUNT @max_row;

	WITH T_SEARCH_RESULT AS
	(
		SELECT ROW_NUMBER() OVER
			(ORDER BY
				CASE WHEN @sort_type = 0 THEN item_level END DESC,
				CASE WHEN @sort_type = 1 THEN item_level END,
				CASE WHEN @sort_type = 2 THEN user_name END DESC,
				CASE WHEN @sort_type = 3 THEN user_name END,
				CASE WHEN @sort_type = 4 THEN price_per_item END DESC,
				CASE WHEN @sort_type = 5 THEN price_per_item END,
				CASE WHEN @sort_type = 6 THEN price END DESC,
				CASE WHEN @sort_type = 7 THEN price END) AS row_num,
			T1.ts_id, T1.user_id, T1.user_name,
			T1.price, T1.status, ISNULL(dbo.ConvertToTimeT32(T1.expire_date), 0) expire_date,
			T1.item_id
		FROM
		(
			SELECT TOP(100) PERCENT *
			FROM SB_TRUST_SALE (READUNCOMMITTED)
			WHERE expire_date > GETDATE()
				AND status = 0 AND blocked = 0
				AND item_level BETWEEN @min_item_level AND @max_item_level
				--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
				AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
				AND item_grade >= @item_grade
				AND category1 = @category1 AND category2 = @category2
				AND item_class_id in (SELECT item FROM @t_items)
		) T1
	)
	SELECT @row_count, ts_id, user_id, user_name, price, status, expire_date, item_id
	FROM T_SEARCH_RESULT
    WHERE row_num BETWEEN ((@page - 1) * @page_size) + 1 AND @page * @page_size
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleSearchByItemGradeCategory123]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleSearchByItemGradeCategory123]
	@page INT,
	@page_size INT,
	@user_id INT,
	@min_item_level INT,
	@max_item_level INT,
	@job_type INT,
	@item_grade INT,
	@category1 INT,
	@category2 INT,
	@category3 INT,
	@t_items SearchItem READONLY,
	@sort_type INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @row_count INT
	SELECT @row_count = COUNT(*) FROM SB_TRUST_SALE (READUNCOMMITTED)
	WHERE expire_date > GETDATE()
		AND status = 0 AND blocked = 0
		AND item_level BETWEEN @min_item_level AND @max_item_level
		--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
		AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
		AND item_grade >= @item_grade
		AND category1 >= @category1 AND category2 = @category2 AND category3 = @category3
		AND item_class_id in (SELECT item FROM @t_items)

	DECLARE @max_row INT = (((@page - 1) * @page_size) + @page_size)
	SET ROWCOUNT @max_row;

	WITH T_SEARCH_RESULT AS
	(
		SELECT ROW_NUMBER() OVER
			(ORDER BY
				CASE WHEN @sort_type = 0 THEN item_level END DESC,
				CASE WHEN @sort_type = 1 THEN item_level END,
				CASE WHEN @sort_type = 2 THEN user_name END DESC,
				CASE WHEN @sort_type = 3 THEN user_name END,
				CASE WHEN @sort_type = 4 THEN price_per_item END DESC,
				CASE WHEN @sort_type = 5 THEN price_per_item END,
				CASE WHEN @sort_type = 6 THEN price END DESC,
				CASE WHEN @sort_type = 7 THEN price END) AS row_num,
			T1.ts_id, T1.user_id, T1.user_name,
			T1.price, T1.status, ISNULL(dbo.ConvertToTimeT32(T1.expire_date), 0) expire_date,
			T1.item_id
		FROM
		(
			SELECT TOP(100) PERCENT *
			FROM SB_TRUST_SALE (READUNCOMMITTED)
			WHERE expire_date > GETDATE()
				AND status = 0 AND blocked = 0
				AND item_level BETWEEN @min_item_level AND @max_item_level
				--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
				AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
				AND item_grade >= @item_grade
				AND category1 >= @category1 AND category2 = @category2 AND category3 = @category3
				AND item_class_id in (SELECT item FROM @t_items)
		) T1
	)
	SELECT @row_count, ts_id, user_id, user_name, price, status, expire_date, item_id
	FROM T_SEARCH_RESULT
    WHERE row_num BETWEEN ((@page - 1) * @page_size) + 1 AND @page * @page_size
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleSearchByItemLevel]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleSearchByItemLevel]
	@page INT,
	@page_size INT,
	@user_id INT,
	@min_item_level INT,
	@max_item_level INT,
	@job_type INT,
	@t_items SearchItem READONLY,
	@sort_type INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @row_count INT
	SELECT @row_count = COUNT(*) FROM SB_TRUST_SALE (READUNCOMMITTED)
	WHERE expire_date > GETDATE()
		AND status = 0 AND blocked = 0
		AND item_level BETWEEN @min_item_level AND @max_item_level
		--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
		AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
		AND item_class_id in (SELECT item FROM @t_items)

	DECLARE @max_row INT = (((@page - 1) * @page_size) + @page_size)
	SET ROWCOUNT @max_row;

	WITH T_SEARCH_RESULT AS
	(
		SELECT ROW_NUMBER() OVER
			(ORDER BY
				CASE WHEN @sort_type = 0 THEN item_level END DESC,
				CASE WHEN @sort_type = 1 THEN item_level END,
				CASE WHEN @sort_type = 2 THEN user_name END DESC,
				CASE WHEN @sort_type = 3 THEN user_name END,
				CASE WHEN @sort_type = 4 THEN price_per_item END DESC,
				CASE WHEN @sort_type = 5 THEN price_per_item END,
				CASE WHEN @sort_type = 6 THEN price END DESC,
				CASE WHEN @sort_type = 7 THEN price END) AS row_num,
			T1.ts_id, T1.user_id, T1.user_name,
			T1.price, T1.status, ISNULL(dbo.ConvertToTimeT32(T1.expire_date), 0) expire_date,
			T1.item_id
		FROM
		(
			SELECT TOP(100) PERCENT *
			FROM SB_TRUST_SALE (READUNCOMMITTED)
			WHERE expire_date > GETDATE()
				AND status = 0 AND blocked = 0
				AND item_level BETWEEN @min_item_level AND @max_item_level
				--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
				AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
				AND item_class_id in (SELECT item FROM @t_items)
		) T1
	)
	SELECT @row_count, ts_id, user_id, user_name, price, status, expire_date, item_id
	FROM T_SEARCH_RESULT
    WHERE row_num BETWEEN ((@page - 1) * @page_size) + 1 AND @page * @page_size
END
GO
PRINT N'Creating [dbo].[sb_TrustSaleSearchByLevel]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TrustSaleSearchByLevel]
	@page INT,
	@page_size INT,
	@user_id INT,
	@min_item_level INT,
	@max_item_level INT,
	@job_type INT,
	@sort_type INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @row_count INT
	SELECT @row_count = COUNT(*) FROM SB_TRUST_SALE (READUNCOMMITTED)
	WHERE expire_date > GETDATE()
		AND status = 0 AND blocked = 0
		AND item_level BETWEEN @min_item_level AND @max_item_level
		--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
		AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END

	DECLARE @max_row INT = (((@page - 1) * @page_size) + @page_size)
	SET ROWCOUNT @max_row;

	WITH T_SEARCH_RESULT AS
	(
		SELECT ROW_NUMBER() OVER
			(ORDER BY
				CASE WHEN @sort_type = 0 THEN item_level END DESC,
				CASE WHEN @sort_type = 1 THEN item_level END,
				CASE WHEN @sort_type = 2 THEN user_name END DESC,
				CASE WHEN @sort_type = 3 THEN user_name END,
				CASE WHEN @sort_type = 4 THEN price_per_item END DESC,
				CASE WHEN @sort_type = 5 THEN price_per_item END,
				CASE WHEN @sort_type = 6 THEN price END DESC,
				CASE WHEN @sort_type = 7 THEN price END) AS row_num,
			T1.ts_id, T1.user_id, T1.user_name,
			T1.price, T1.status, ISNULL(dbo.ConvertToTimeT32(T1.expire_date), 0) expire_date,
			T1.item_id
		FROM
		(
			SELECT TOP(100) PERCENT *
			FROM SB_TRUST_SALE (READUNCOMMITTED)
			WHERE expire_date > GETDATE()
				AND status = 0 AND blocked = 0
				AND item_level BETWEEN @min_item_level AND @max_item_level
				--AND (job_type = @job_type OR @job_type = 0 OR job_type = 0)
				AND 1 = CASE WHEN job_type = 0 THEN 1 WHEN @job_type = 0 THEN 1 WHEN job_type = @job_type THEN 1 ELSE 0 END
		) T1
	)
	SELECT @row_count, ts_id, user_id, user_name, price, status, expire_date, item_id
	FROM T_SEARCH_RESULT
    WHERE row_num BETWEEN ((@page - 1) * @page_size) + 1 AND @page * @page_size
END
GO
PRINT N'Creating [dbo].[SB_TryFinishWFAchievement]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_TryFinishWFAchievement]
	@achievement_id int,
	@finished_time int,
	@t_user_dbid DBIDList READONLY
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @t_summary TABLE(Change VARCHAR(20));
	DECLARE @finished_date DATETIME = dbo.ConvertToDateTime32(@finished_time)

	MERGE SB_WORLDFIRST_ACHIEVEMENT WITH (HOLDLOCK) T
	USING (SELECT @achievement_id, @finished_date) AS S (achievement_id, finished_time)
		ON T.achievement_id=S.achievement_id
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (achievement_id, finished_time) VALUES (S.achievement_id, S.finished_time)		
	OUTPUT $action INTO @t_summary
	;
	
	DECLARE @changed VARCHAR(20)
	SELECT @changed = Change FROM @t_summary
	
	IF @changed = 'INSERT' BEGIN
		INSERT SB_USER_ACHIEVEMENT (user_id, achievement_id, finished_time)
			SELECT dbid, @achievement_id, @finished_date FROM @t_user_dbid
		
		SELECT 1
	END 
	ELSE BEGIN
		SELECT 0
	END
END
GO
PRINT N'Creating [dbo].[sb_TryResetWFAchievement]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_TryResetWFAchievement]
	@achievement_id int
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM SB_WORLDFIRST_ACHIEVEMENT 
	WHERE achievement_id = @achievement_id
	
	SELECT @@ROWCOUNT
END
GO
PRINT N'Creating [dbo].[SB_UnblockItem]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_UnblockItem]
	@sender_type INT
	, @sender_dbid INT
	, @sender_name NVARCHAR(64)
	, @recipient_dbid INT
	, @recipient_name NVARCHAR(64)
	, @max_receive_count INT
	, @title NVARCHAR(50)
	, @text NVARCHAR(500)
	, @attached_item_type INT
	, @item_key BIGINT
	, @item_amount INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @post_id INT = 0 
	
	IF @attached_item_type = 1
	BEGIN
		UPDATE SB_ITEM SET bag_id = -9 where ID = @item_key
	END

	INSERT INTO SB_POST_BOX (sender_type, sender_dbid, sender_name, recipient_dbid, recipient_name, title, text, attached_money, attached_item_type)
	VALUES (@sender_type, @sender_dbid, @sender_name, @recipient_dbid, @recipient_name, @title, @text, 0, @attached_item_type)
	
	SET @post_id = SCOPE_IDENTITY()

	INSERT INTO SB_POST_ATTACHED_ITEM (post_id, item_key, item_amount)
	VALUES (@post_id, @item_key, @item_amount)
	
	SELECT @post_id, @recipient_dbid, 0
END
GO
PRINT N'Creating [dbo].[sb_UnblockPost]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sb_UnblockPost]
	@id INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    UPDATE SB_POST_BOX SET blocked = 0 WHERE ID = @id
END
GO
PRINT N'Creating [dbo].[sb_UnblockTrustSale]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_UnblockTrustSale]
	@ts_id INT
AS
BEGIN
	SET NOCOUNT ON;

    UPDATE SB_TRUST_SALE SET blocked = 0 WHERE ts_id = @ts_id
END
GO
PRINT N'Creating [dbo].[SB_UnregisterBag]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_UnregisterBag]
	@ID INT
AS
BEGIN
	SET NOCOUNT ON

	DELETE FROM dbo.SB_ITEM_BAG WHERE ID = @ID
END
GO
PRINT N'Creating [dbo].[sb_UnregisterPet]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_UnregisterPet]
	@user_dbid INT,
	@pet_dbid INT
AS  
BEGIN  
	SET NOCOUNT ON;
	
	EXEC sb_WritePetHistory @user_dbid, @pet_dbid, 2, 0
		
	DELETE FROM SB_USER_PET WHERE owner_dbid=@user_dbid AND ID=@pet_dbid
END
GO
PRINT N'Creating [dbo].[sb_UnregisterVehicle]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_UnregisterVehicle]
	@user_dbid INT,
	@vehicle_dbid INT
AS  
BEGIN  
	SET NOCOUNT ON;

	EXEC sb_WriteVehicleHistory @user_dbid, @vehicle_dbid, 2, 0
	
	DELETE FROM SB_USER_VEHICLE WHERE owner_dbid=@user_dbid AND ID=@vehicle_dbid

END
GO
PRINT N'Creating [dbo].[sb_UpdateArenaPoint]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_UpdateArenaPoint]
 @owner_id int,
 @point bigint
AS  
BEGIN  
 SET NOCOUNT ON;  
 
 UPDATE SB_USER_SECONDARY_MONEY SET arena_point += @point WHERE ID = @owner_id
   
 SELECT arena_point FROM SB_USER_SECONDARY_MONEY (READUNCOMMITTED) WHERE ID = @owner_id
 
END
GO
PRINT N'Creating [dbo].[SB_UpdateBag]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_UpdateBag]
	@ID INT
	, @bag_type INT
	, @slot_index INT
	, @source_item_class_id INT
	, @max_slot_count INT
AS
BEGIN
	SET NOCOUNT ON

	UPDATE dbo.SB_ITEM_BAG
	SET bag_type = @bag_type
		, slot_index = @slot_index
		, source_item_class_id = @source_item_class_id
		, max_slot_count = @max_slot_count
	WHERE ID = @ID
END
GO
PRINT N'Creating [dbo].[SB_UpdateBoundDungeonSequence]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SB_UpdateBoundDungeonSequence]
	@UserDBID int,
	@DungeonClassID int,
	@CheckPointSeqNo int,
	@ResetTime int
AS
BEGIN
	SET NOCOUNT ON;

MERGE SB_USER_BOUND_DUNGEON WITH (HOLDLOCK) T
	USING (SELECT @UserDBID, @DungeonClassID) AS S (user_db_id, dungeon_class_id)
		ON T.user_db_id = S.user_db_id AND T.dungeon_class_id = S.dungeon_class_id
	WHEN MATCHED and T.expired_time <= dbo.ConvertToDateTime32(@ResetTime) THEN
		UPDATE SET 
			checkpoint_seq_no = @CheckPointSeqNo,
			expired_time = dbo.ConvertToDateTime32(@ResetTime)
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_db_id, dungeon_class_id, checkpoint_seq_no, expired_time) 
		VALUES (@UserDBID, @DungeonClassID, @CheckPointSeqNo, dbo.ConvertToDateTime32(@ResetTime));
END
GO
PRINT N'Creating [dbo].[sb_UpdateDungeonPoint]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_UpdateDungeonPoint]
 @owner_id int,
 @point bigint
AS  
BEGIN  
 SET NOCOUNT ON;  
 
 UPDATE SB_USER_SECONDARY_MONEY SET infinite_hunt_point += @point WHERE ID = @owner_id
   
 SELECT infinite_hunt_point FROM SB_USER_SECONDARY_MONEY (READUNCOMMITTED) WHERE ID = @owner_id
 
END
GO
PRINT N'Creating [dbo].[sb_UpdateELO]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_UpdateELO]
	@user_id INT,
	@elo_point INT,
	@item_point INT = 0
AS
BEGIN
	SET NOCOUNT ON;

    UPDATE SB_USER_INFO 
    SET elo = @elo_point
		, bf_item_point = 
			CASE WHEN @item_point = 0 THEN bf_item_point 
				WHEN @item_point < bf_item_point THEN 
					CASE WHEN CONVERT(INT, CONVERT(FLOAT, bf_item_point) * 0.9) > @item_point THEN CONVERT(INT, CONVERT(FLOAT, bf_item_point) * 0.9)
					ELSE @item_point END
				ELSE @item_point END
    WHERE ID = @user_id;
END
GO
PRINT N'Creating [dbo].[sb_UpdateGuildLevel]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_UpdateGuildLevel]
	@guildID int,
	@level int,
	@exp int
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE [dbo].SB_GUILD SET [level] = @level, [exp] = @exp WHERE ID = @guildID;

END
GO
PRINT N'Creating [dbo].[SB_UpdateGuildMark]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_UpdateGuildMark]
	@guildID int,
	@mark int
AS  
BEGIN  
	SET NOCOUNT ON
	
	UPDATE [dbo].SB_GUILD SET mark = @mark WHERE ID = @guildID;
	
END
GO
PRINT N'Creating [dbo].[sb_UpdateGuildNotice]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_UpdateGuildNotice]
	@guildID INT,
	@memberName NVARCHAR (50),
	@notice NVARCHAR(512),
	@modify_time BIGINT
AS
BEGIN
	SET NOCOUNT ON;
		
	MERGE SB_GUILD_NOTICE WITH (HOLDLOCK) T
	USING (SELECT @guildID, @memberName, @notice, @modify_time) AS S (guildID, memberName, notice, modify_time)
		ON T.ID = S.guildID
	WHEN MATCHED THEN
		UPDATE SET memberName = S.memberName, notice = S.notice, modify_time = dbo.ConvertToDateTime32(@modify_time)
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (ID, memberName, notice, modify_time) VALUES (@guildID, @memberName, @notice, dbo.ConvertToDateTime32(@modify_time))
	--OUTPUT $action, Inserted.*, Deleted.*
	;
END
GO
PRINT N'Creating [dbo].[SB_UpdateGuildWar]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_UpdateGuildWar]  
 @guildID int,
 @kill int,
 @death int
AS  
BEGIN  
	SET NOCOUNT ON
	
	UPDATE [dbo].[SB_GUILD_WAR] SET kill_count += @kill, death_count += @death
	WHERE guildID = @guildID;
				
END
GO
PRINT N'Creating [dbo].[SB_UpdateGuildWarehouseMoney]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_UpdateGuildWarehouseMoney]
	@guild_dbid INT
	, @user_dbid INT
	, @money BIGINT
AS
BEGIN
	SET NOCOUNT ON

    UPDATE SB_GUILD
    SET [money] = [money] + @money
    WHERE ID = @guild_dbid
    
    DECLARE @subtract_money BIGINT = -@money
    EXEC dbo.SB_UpdateMoney @user_dbid, @subtract_money
END
GO
PRINT N'Creating [dbo].[sb_UpdateGuildWarriorPoint]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_UpdateGuildWarriorPoint]
 @owner_id int,
 @point bigint
AS  
BEGIN  
 SET NOCOUNT ON;  
 
 UPDATE SB_USER_SECONDARY_MONEY SET guild_warrior_point += @point WHERE ID = @owner_id
   
 SELECT guild_warrior_point FROM SB_USER_SECONDARY_MONEY (READUNCOMMITTED) WHERE ID = @owner_id
 
END
GO
PRINT N'Creating [dbo].[sb_UpdateGuildWarSeason]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**
 * [sb_UpdateGuildWarSeason] .................................
 */
CREATE PROCEDURE [dbo].[sb_UpdateGuildWarSeason]
	@season INT,
	@season_start_time	BIGINT,
	@reset_time			BIGINT
AS  
BEGIN  
	SET NOCOUNT ON
	
	
	UPDATE 
		[dbo].[SB_GUILD_WAR_SEASON] 
	SET
		season = @season,
		season_start_time = dbo.ConvertToDateTime32(@season_start_time),
		reset_time        = dbo.ConvertToDateTime32(@reset_time);
	
	-- CHANGE Guild Type	
	UPDATE [dbo].[SB_GUILD] SET type = totype;
		
	-- DELETE Current War for all guild
	DELETE FROM [dbo].SB_GUILD_WAR    WHERE in_progress = 1;
	
	-- CHANGE War Status for all guild
	UPDATE [dbo].SB_GUILD_WAR SET in_progress = 1 WHERE in_progress = 0;
	
	-- Reset Members Info for all guild
	UPDATE [dbo].[SB_GUILD_MEMBER] SET kill_count = 0, death_count = 0  ;
	
	SELECT season,
		   dbo.ConvertToTimeT32(season_start_time),
		   dbo.ConvertToTimeT32(reset_time)   
		   FROM [dbo].[SB_GUILD_WAR_SEASON] (READUNCOMMITTED);
		
END
GO
PRINT N'Creating [dbo].[sb_UpdateLogInTime]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sb_UpdateLogInTime]
	-- Add the parameters for the stored procedure here
	@accountID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update SB_ACCOUNT set login_time = GETDATE()  where ID = @accountID
END
GO
PRINT N'Creating [dbo].[sb_UpdateLogOutTime]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sb_UpdateLogOutTime]
	-- Add the parameters for the stored procedure here
	@accountID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update SB_ACCOUNT set logout_time = GETDATE() where ID = @accountID
END
GO
PRINT N'Creating [dbo].[SB_UpdateProfession]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_UpdateProfession]
	@user_id int,
	@profession_id int,
	@grade_id int,
	@point int
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE SB_USER_PROFESSION
	SET point = @point, grade_id = @grade_id
	WHERE user_id = @user_id AND profession_id = @profession_id
END
GO
PRINT N'Creating [dbo].[sb_UpdateSoul]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_UpdateSoul]
	@user_id INT
	, @soul_type INT
	, @amount INT
AS
BEGIN
	SET NOCOUNT ON
	
	MERGE SB_USER_SOUL WITH (HOLDLOCK) T
	USING (SELECT @user_id, @soul_type, @amount) AS S (user_id, soul_type, amount)
		ON T.user_id = S.user_id AND T.soul_type = S.soul_type
	WHEN MATCHED THEN
		UPDATE SET T.amount = T.amount + @amount
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_id, soul_type, amount) VALUES (S.user_id, S.soul_type, S.amount)
	--OUTPUT $action, Inserted.*, Deleted.*
	;
END
GO
PRINT N'Creating [dbo].[sb_UpdateSPVPELO]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_UpdateSPVPELO]
	@user_id INT,
	@elo_point INT,
	@item_point INT = 0
AS
BEGIN
	SET NOCOUNT ON;

    UPDATE SB_USER_INFO 
    SET elo = @elo_point
		, bf_item_point = CASE WHEN @item_point = 0 THEN bf_item_point ELSE @item_point END
    WHERE ID = @user_id;
END
GO
PRINT N'Creating [dbo].[sb_UpdateTrustSaleRight]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_UpdateTrustSaleRight]
	@user_id INT
	, @slot INT
	, @use_count INT
	, @minute_to_expire INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @expire_date DATETIME = DATEADD(MINUTE, @minute_to_expire, GETDATE())

	UPDATE SB_USER_TRUST_SALE 
	SET usedSlot = @slot
		, usedUseCount = @use_count
		, use_count_reset_time = CASE WHEN @minute_to_expire = -1 THEN use_count_reset_time ELSE @expire_date END
	WHERE userDBID = @user_id;
	
	SELECT 
		CASE WHEN use_count_reset_time IS NULL THEN -1 ELSE dbo.ConvertToTimeT32(use_count_reset_time) END use_count_reset_time
	FROM SB_USER_TRUST_SALE (READUNCOMMITTED) 
	WHERE userDBID = @user_id
END
GO
PRINT N'Creating [dbo].[sb_UpdateUserDungeonBindInit]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_UpdateUserDungeonBindInit]
	@user_db_id int,
	@init_id int,
	@init_used_count int
AS
BEGIN
	SET NOCOUNT ON
	
	UPDATE SB_USER_DUNGEON_BIND_INIT SET init_used_count = @init_used_count WHERE user_db_id = @user_db_id and init_id = @init_id
END
GO
PRINT N'Creating [dbo].[sb_UpdateUserDungeonTicket]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_UpdateUserDungeonTicket]
	@user_db_id int,
	@ticket_id int,
	@ticket_used_count int,
	@addable_ticket_buy_count int
AS
BEGIN
	SET NOCOUNT ON
	
	UPDATE SB_USER_DUNGEON_TICKET SET ticket_used_count = @ticket_used_count, addable_ticket_buy_count = @addable_ticket_buy_count WHERE user_db_id = @user_db_id and ticket_id = @ticket_id
END
GO
PRINT N'Creating [dbo].[SB_UpdateVehicle]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_UpdateVehicle]
	-- Add the parameters for the stored procedure here
	@id int,
	@vehicle int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE [dbo].[SB_USER_INFO] SET vehicle = @vehicle WHERE ID = @id;
END
GO
PRINT N'Creating [dbo].[SB_UpdateWarehouseMoney]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_UpdateWarehouseMoney]
	@owner_dbid INT
	, @money BIGINT
AS
BEGIN
	SET NOCOUNT ON

    UPDATE SB_USER_WAREHOUSE
    SET [money] = [money] + @money
    WHERE owner_dbid = @owner_dbid
    
    DECLARE @subtract_money BIGINT = -@money
    EXEC dbo.SB_UpdateMoney @owner_dbid, @subtract_money
END
GO
PRINT N'Creating [dbo].[SB_UpgradeProfession]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_UpgradeProfession]
	@user_id int,
	@profession_id int,
	@grade_id int
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE SB_USER_PROFESSION
	SET grade_id = @grade_id
	WHERE user_id = @user_id AND profession_id = @profession_id
END
GO
PRINT N'Creating [dbo].[sb_UseDungeonBindInit]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_UseDungeonBindInit]
	@init_id INT,
	@user_db_id INT
AS
BEGIN
	SET NOCOUNT ON
	
	MERGE SB_USER_DUNGEON_BIND_INIT WITH (HOLDLOCK) T
	USING (SELECT @user_db_id, @init_id) AS S (user_db_id, init_id)
		ON T.user_db_id= S.user_db_id AND T.init_id = S.init_id
	WHEN MATCHED THEN
		UPDATE SET init_used_count = init_used_count + 1
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_db_id, init_id, init_used_count) 
		VALUES (@user_db_id, @init_id, 1);
END
GO
PRINT N'Creating [dbo].[sb_UserBehaviorItemInFiniteDungeon]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_UserBehaviorItemInFiniteDungeon]
	@user_dbid INT,
	@class_id INT,
	@joint_type INT,
	@grade_type INT
AS
BEGIN
	SET NOCOUNT ON;

	MERGE SB_USER_BEHAVIOR_ITEM_IN_FINITE_DUNGEON WITH (HOLDLOCK) D
	USING	
		(SELECT @user_dbid, @class_id, @grade_type, @joint_type, 1) 
			AS T (user_dbid, class_id, grade_type, joint_type, item_count)
		ON D.user_dbid = D.user_dbid AND D.class_id = T.class_id AND D.grade_type = T.grade_type
	WHEN MATCHED THEN
		UPDATE 
		SET
			D.item_count = D.item_count + T.item_count
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_dbid, class_id, grade_type, joint_type, item_count)
		VALUES (T.user_dbid, T.class_id, T.grade_type, T.joint_type, T.item_count)
	;
		
END
GO
PRINT N'Creating [dbo].[sb_UserBehaviorItemInInfiniteDungeon]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_UserBehaviorItemInInfiniteDungeon]
	@user_dbid INT,
	@level_ex INT,
	@joint_type INT,
	@grade_type INT
AS
BEGIN
	SET NOCOUNT ON;

	MERGE SB_USER_BEHAVIOR_ITEM_IN_INFINITE_DUNGEON WITH (HOLDLOCK) D
	USING	
		(SELECT @user_dbid, @level_ex, @joint_type, @grade_type, 1) 
			AS T (user_dbid, level_ex, joint_type, grade_type, item_count)
		ON D.user_dbid = D.user_dbid AND D.level_ex = T.level_ex AND D.joint_type = T.joint_type AND D.grade_type = T.grade_type
	WHEN MATCHED THEN
		UPDATE 
		SET
			D.item_count = D.item_count + T.item_count
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_dbid, level_ex, joint_type, grade_type, item_count)
		VALUES (T.user_dbid, T.level_ex, T.joint_type, T.grade_type, T.item_count)
	;
		
END
GO
PRINT N'Creating [dbo].[sb_UserBehaviorStartFiniteDungeon]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_UserBehaviorStartFiniteDungeon]
	@user_dbid INT,
	@class_id INT,
	@joint_type INT
AS
BEGIN
	SET NOCOUNT ON;

	MERGE SB_USER_BEHAVIOR_START_FINITE_DUNGEON WITH (HOLDLOCK) D
	USING	
		(SELECT @user_dbid, @class_id, @joint_type, 1) 
			AS T (user_dbid, class_id, joint_type, start_count)
		ON D.user_dbid = D.user_dbid AND D.class_id = T.class_id
	WHEN MATCHED THEN
		UPDATE 
		SET
			D.start_count = D.start_count + T.start_count
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_dbid, class_id, joint_type, start_count)
		VALUES (T.user_dbid, T.class_id, T.joint_type, T.start_count)
	;
		
END
GO
PRINT N'Creating [dbo].[sb_UserBehaviorStartInfiniteDungeon]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_UserBehaviorStartInfiniteDungeon]
	@user_dbid INT,
	@level_ex INT,
	@joint_type INT
AS
BEGIN
	SET NOCOUNT ON;

	MERGE SB_USER_BEHAVIOR_START_INFINITE_DUNGEON WITH (HOLDLOCK) D
	USING	
		(SELECT @user_dbid, @level_ex, @joint_type, 1) 
			AS T (user_dbid, level_ex, joint_type, start_count)
		ON D.user_dbid = D.user_dbid AND D.level_ex = T.level_ex AND D.joint_type = T.joint_type
	WHEN MATCHED THEN
		UPDATE 
		SET
			D.start_count = D.start_count + T.start_count
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_dbid, level_ex, joint_type, start_count)
		VALUES (T.user_dbid, T.level_ex, T.joint_type, T.start_count)
	;
		
END
GO
PRINT N'Creating [dbo].[SB_UserFatigueLoad]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_UserFatigueLoad]
	@user_id int
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT fatigue, dbo.ConvertToTimeT32(last_reset_time)
	FROM SB_USER_FATIGUE (READUNCOMMITTED)
	WHERE user_id = @user_id
END
GO
PRINT N'Creating [dbo].[SB_UserFatigueReset]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_UserFatigueReset]
	@user_id int,
	@fatigue int,
	@reset_time int
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE SB_USER_FATIGUE 
	SET fatigue = @fatigue, last_reset_time = dbo.ConvertToDateTime32(@reset_time)
	WHERE user_id = @user_id
	
	IF @@ROWCOUNT = 0
	BEGIN
		INSERT INTO SB_USER_FATIGUE (user_id, fatigue, last_reset_time)
		VALUES (@user_id, @fatigue, dbo.ConvertToDateTime32(@reset_time))
	END	
END
GO
PRINT N'Creating [dbo].[SB_UserFatigueSave]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_UserFatigueSave]
	@user_id int,
	@fatigue int
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE SB_USER_FATIGUE 
	SET fatigue = @fatigue
	WHERE user_id = @user_id
	
	IF @@ROWCOUNT = 0
	BEGIN
		INSERT INTO SB_USER_FATIGUE (user_id, fatigue, last_reset_time)
		VALUES (@user_id, @fatigue, dbo.ConvertToDateTime32(0))
	END
END
GO
PRINT N'Creating [dbo].[sb_UserHonorGrade]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_UserHonorGrade]
	@season_no INT,
	@week_no INT,
	@max_candidate_count INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @max_ranking AS INT = 0;
	DECLARE @total_candidate_count AS INT = 0;
	DECLARE @temp TABLE 
		(user_dbid INT, season_honor BIGINT, ranking INT, grade INT);

	-- Calculate ranking with season_honor
	WITH CTE AS 
	(
		SELECT user_dbid, season_honor, RANK() OVER(ORDER BY season_honor DESC) AS ranking, -1 grade
		FROM SB_USER_HONOR_SEASON (READUNCOMMITTED) AS H
			INNER JOIN SB_USER (READUNCOMMITTED) AS U ON H.user_dbid = U.ID
		WHERE U.deleted_time IS NULL
			AND H.season_no = @season_no AND H.season_honor > 0		
	)
	INSERT INTO @temp 
		SELECT user_dbid, season_honor, ranking, grade FROM CTE
		
	-- Select candidate count
	SELECT  @total_candidate_count = COUNT(*) FROM @temp
	
	-- select max ranking
	SELECT @max_ranking= 
		CASE WHEN @total_candidate_count > @max_candidate_count THEN @max_candidate_count ELSE @total_candidate_count END	

	IF @max_ranking > 0 BEGIN
		UPDATE @temp SET
			grade = CASE WHEN ranking = 1 THEN 1							-- 1st
				WHEN ranking <= @max_ranking * 0.01 AND grade = -1 THEN 2	-- 1%
				WHEN ranking <= @max_ranking * 0.04 AND grade = -1 THEN 3	-- 4%
				WHEN ranking <= @max_ranking * 0.10 AND grade = -1 THEN 4	-- 10%
				WHEN ranking <= @max_ranking * 0.20 AND grade = -1 THEN 5	-- 20%
				WHEN ranking <= @max_ranking * 0.32 AND grade = -1 THEN 6	-- 32%
				WHEN ranking <= @max_ranking * 0.46 AND grade = -1 THEN 7	-- 46%
				WHEN ranking <= @max_ranking * 0.62 AND grade = -1 THEN 8	-- 62%
				WHEN ranking <= @max_ranking * 0.80 AND grade = -1 THEN 9	-- 80%
				WHEN grade = -1 THEN 10	-- 100%
				END;
		
		MERGE SB_USER_HONOR_WEEK WITH (HOLDLOCK) W
		USING	
			(
			SELECT user_dbid 
				, @season_no AS season_no
				, @week_no + 1 AS new_week_no				
				, grade
				, ranking
			FROM @temp WHERE ranking <= @max_ranking
			) AS T			
			ON W.user_dbid = T.user_dbid AND W.season_no = T.season_no AND W.week_no = T.new_week_no
		
		WHEN MATCHED THEN
			UPDATE SET
				W.grade = T.grade, W.ranking = T.grade
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (user_dbid, season_no, week_no, week_honor, grade, ranking)
			VALUES (T.user_dbid, T.season_no, T.new_week_no, 0, T.grade, T.ranking)	
		 ;		 
	END	
	
	SELECT @max_ranking as max_ranking, @total_candidate_count as total_candidate_count
END
GO
PRINT N'Creating [dbo].[sb_UserHonorLoad]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_UserHonorLoad]
	@season_no INT,
	@week_no INT,
	@user_dbid INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT ISNULL(W.grade, -1), ISNULL(W.ranking, -1),
		ISNULL(S.season_honor, 0), ISNULL(W.week_honor, 0)
	FROM SB_USER_HONOR_SEASON (READUNCOMMITTED) S
		LEFT JOIN
		SB_USER_HONOR_WEEK (READUNCOMMITTED) W
			ON W.user_dbid = S.user_dbid AND W.season_no = S.season_no AND W.week_no = @week_no
	WHERE S.user_dbid = @user_dbid AND S.season_no = @season_no
END
GO
PRINT N'Creating [dbo].[sb_UserHonorMaxRankingLoad]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_UserHonorMaxRankingLoad]
	@season_no INT,
	@week_no INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT ISNULL(MAX(ranking), 0)
	FROM SB_USER_HONOR_WEEK (READUNCOMMITTED)
	WHERE season_no = @season_no 
	AND week_no = @week_no
END
GO
PRINT N'Creating [dbo].[sb_UserHonorReset]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_UserHonorReset]
	@season_no INT,
	@user_dbid INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DELETE FROM SB_USER_HONOR_SEASON
	WHERE user_dbid = @user_dbid AND season_no = @season_no	

	DELETE FROM SB_USER_HONOR_WEEK
	WHERE user_dbid = @user_dbid AND season_no = @season_no	
END
GO
PRINT N'Creating [dbo].[sb_UserHonorSave]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_UserHonorSave]
	@season_no INT,
	@week_no INT,
	@user_dbid INT,
	@honor_delta INT
AS
BEGIN
	SET NOCOUNT ON;

	MERGE SB_USER_HONOR_SEASON WITH (HOLDLOCK) S
	USING	
		(SELECT @user_dbid, @season_no, @week_no, @honor_delta) 
			AS T (user_dbid, season_no, week_no, honor_delta)
		ON S.user_dbid = T.user_dbid AND S.season_no = T.season_no
	WHEN MATCHED THEN
		UPDATE 
		SET
			S.season_honor = S.season_honor + T.honor_delta
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_dbid, season_no, season_honor)
		VALUES (T.user_dbid, T.season_no, T.honor_delta)
	;

	MERGE SB_USER_HONOR_WEEK WITH (HOLDLOCK) W
	USING	
		(SELECT @user_dbid, @season_no, @week_no, @honor_delta) 
			AS T (user_dbid, season_no, week_no, honor_delta)
		ON W.user_dbid = T.user_dbid AND W.season_no = T.season_no AND W.week_no = T.week_no
	WHEN MATCHED THEN
		UPDATE 
		SET
			W.week_honor = W.week_honor + T.honor_delta
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (user_dbid, season_no, week_no, week_honor)
		VALUES (T.user_dbid, T.season_no, T.week_no, T.honor_delta)
	;
		
END
GO
PRINT N'Creating [dbo].[sb_UserTimeAttackLoad]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_UserTimeAttackLoad]
@userDBID int
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT infinite_dungeon_set_name, dungeon_level_ex, dungeon_class_id, complete_seconds
	FROM SB_USER_TIME_ATTACK (READUNCOMMITTED)
	WHERE user_db_id = @userDBID
END
GO
PRINT N'Creating [dbo].[sb_UserTimeAttackSave]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_UserTimeAttackSave]
	@userDBID int,
	@infiniteDungeonSetName nvarchar(64),
	@dungeonLevelEx int,
	@dungeonClassID int,
	@completeSeconds int
AS
BEGIN
	SET NOCOUNT ON
	
	if @dungeonLevelEx = 0
		begin
		MERGE SB_USER_TIME_ATTACK WITH (HOLDLOCK) T
		USING (SELECT @userDBID, @dungeonLevelEx, @dungeonClassID) AS S (user_db_id, dungeon_level_ex, dungeon_class_id)
			ON T.user_db_id = S.user_db_id AND T.dungeon_level_ex = S.dungeon_level_ex and T.dungeon_class_id = S.dungeon_class_id
		WHEN MATCHED and complete_seconds > @completeSeconds THEN
			UPDATE SET complete_seconds = @completeSeconds, update_time = GETDATE()
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (user_db_id, infinite_dungeon_set_name, dungeon_level_ex, dungeon_class_id, complete_seconds, update_time) 
			values (@userDBID, @infiniteDungeonSetName, @dungeonLevelEx, @dungeonClassID, @completeSeconds, GETDATE());
		end
	else
		begin
		MERGE SB_USER_TIME_ATTACK WITH (HOLDLOCK) T
		USING (SELECT @userDBID, @dungeonLevelEx, @infiniteDungeonSetName) AS S (user_db_id, dungeon_level_ex, infinite_dungeon_set_name)
			ON T.user_db_id = S.user_db_id AND T.dungeon_level_ex = S.dungeon_level_ex and T.infinite_dungeon_set_name = S.infinite_dungeon_set_name
		WHEN MATCHED and complete_seconds > @completeSeconds THEN
			UPDATE SET complete_seconds = @completeSeconds, dungeon_class_id = @dungeonClassID, update_time = GETDATE()
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (user_db_id, infinite_dungeon_set_name, dungeon_level_ex, dungeon_class_id, complete_seconds, update_time) 
			values (@userDBID, @infiniteDungeonSetName, @dungeonLevelEx, @dungeonClassID, @completeSeconds, GETDATE());
		end
END
GO
PRINT N'Creating [dbo].[SB_UserTitleChange]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_UserTitleChange]
	@user_id int,
	@title_id int
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE SB_USER
	SET title_id = @title_id
	WHERE ID = @user_id
END
GO
PRINT N'Creating [dbo].[SB_UserTitleLoad]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_UserTitleLoad]
	@user_id int
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT title_id
	FROM SB_USER_TITLE (READUNCOMMITTED)
	WHERE user_id = @user_id
END
GO
PRINT N'Creating [dbo].[SB_UserTitleRemove]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_UserTitleRemove]
	@user_id int,
	@title_id int
AS
BEGIN
	SET NOCOUNT ON;
	
	IF @title_id = -1 
	BEGIN
		DELETE FROM SB_USER_TITLE
		WHERE user_id = @user_id
	END
	ELSE
		DELETE FROM SB_USER_TITLE
		WHERE user_id = @user_id
		AND title_id = @title_id
END
GO
PRINT N'Creating [dbo].[SB_UserTitleSave]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_UserTitleSave]
	@user_id int,
	@title_id int
AS
BEGIN
	SET NOCOUNT ON;

	INSERT SB_USER_TITLE (user_id, title_id)
	VALUES (@user_id, @title_id)
END
GO
PRINT N'Creating [dbo].[sb_ViewTelPoint]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sb_ViewTelPoint]
	@page_no int
AS
BEGIN
	SET NOCOUNT ON;
	
	WITH ordered AS
	(
		SELECT ROW_NUMBER() OVER (ORDER BY NAME) AS row_no
			, *
		FROM dbo.SB_TELEPORT_POINT (READUNCOMMITTED)
	)
	SELECT NAME
		, (
				(cast(area_id as bigint)	* 0x100000000000000) | 
				(cast(region_id as bigint)	* 0x1000000000000) | 
				(cast(resource_id as bigint)* 0x100000000) | 
				(cast(grid_x as bigint)		* 0x1000000) | 
				(cast(grid_y as bigint)		* 0x10000) | 
				(cast(grid_z as bigint)		* 0x100) | 
				(cast(reserved as bigint))
			)
		, x, y, z
	FROM ordered
	WHERE row_no BETWEEN (@page_no * 10 - 9) AND (@page_no * 10)
END
GO
PRINT N'Creating [dbo].[sb_WorldTimeAttackLoadSolo]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_WorldTimeAttackLoadSolo]
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT job_type, talent_type, infinite_dungeon_set_name, dungeon_level_ex, dungeon_class_id, user_name, complete_seconds
	FROM SB_WORLD_TIME_ATTACK_SOLO (READUNCOMMITTED)
END
GO
PRINT N'Creating [dbo].[sb_WorldTimeAttackLoadUserGroup]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_WorldTimeAttackLoadUserGroup]
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT infinite_dungeon_set_name, dungeon_level_ex, dungeon_class_id, user_name, complete_seconds
	FROM SB_WORLD_TIME_ATTACK_USER_GROUP (READUNCOMMITTED)
END
GO
PRINT N'Creating [dbo].[sb_WorldTimeAttackSaveSolo]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_WorldTimeAttackSaveSolo]
	@jobType int,
	@talentType int,
	@infiniteDungeonSetName nvarchar(64),
	@dungeonLevelEx int,
	@dungeonClassID int,
	@userName varchar(64),
	@completeSeconds int
AS
BEGIN
	SET NOCOUNT ON
	
	if @dungeonLevelEx = 0
		begin
		MERGE SB_WORLD_TIME_ATTACK_SOLO WITH (HOLDLOCK) T
		USING (SELECT @jobType, @talentType, @dungeonLevelEx, @dungeonClassID) AS S (job_type, talent_type, dungeon_level_ex, dungeon_class_id)
			ON T.job_type = S.job_type AND T.talent_type = S.talent_type AND T.dungeon_level_ex = S.dungeon_level_ex and T.dungeon_class_id = S.dungeon_class_id
		WHEN MATCHED and complete_seconds >= @completeSeconds THEN
			UPDATE SET complete_seconds = @completeSeconds, user_name = @userName, update_time = GETDATE()
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (job_type, talent_type, infinite_dungeon_set_name, dungeon_level_ex, dungeon_class_id, user_name, complete_seconds, update_time) 
			values (@jobType, @talentType, @infiniteDungeonSetName, @dungeonLevelEx, @dungeonClassID, @userName, @completeSeconds, GETDATE());
		end
	else
		begin
		MERGE SB_WORLD_TIME_ATTACK_SOLO WITH (HOLDLOCK) T
		USING (SELECT @jobType, @talentType, @dungeonLevelEx, @infiniteDungeonSetName) AS S (job_type, talent_type, dungeon_level_ex, infinite_dungeon_set_name)
			ON T.job_type = S.job_type AND T.talent_type = S.talent_type AND T.dungeon_level_ex = S.dungeon_level_ex and T.infinite_dungeon_set_name = S.infinite_dungeon_set_name
		WHEN MATCHED and complete_seconds >= @completeSeconds THEN
			UPDATE SET complete_seconds = @completeSeconds, user_name = @userName, dungeon_class_id = @dungeonClassID, update_time = GETDATE()
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (job_type, talent_type, infinite_dungeon_set_name, dungeon_level_ex, dungeon_class_id, user_name, complete_seconds, update_time) 
			values (@jobType, @talentType, @infiniteDungeonSetName, @dungeonLevelEx, @dungeonClassID, @userName, @completeSeconds, GETDATE());
		end
END
GO
PRINT N'Creating [dbo].[sb_WorldTimeAttackSaveUserGroup]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sb_WorldTimeAttackSaveUserGroup]
	@dungeonClassID int,
	@infiniteDungeonSetName nvarchar(64),
	@dungeonLevelEx int,
	@completeSeconds int,
	@userDBIDs DBIDList READONLY
AS
BEGIN
	SET NOCOUNT ON
	
	--데이터가 있으면 
		--completeSeconds 보다 같거나 큰 데이터일 때만 삭제하고 추가한다.
	    --더 높은 값이 있으면 아무것도 안한다.
	--데이터가 없으면 
		--그냥 추가한다.
	if @dungeonLevelEx = 0
		-- classID 를 키로 작업
		begin
		if exists(select 1 from SB_WORLD_TIME_ATTACK_USER_GROUP where dungeon_class_id = @dungeonClassID and dungeon_level_ex = @dungeonLevelEx)
			begin
			if exists(
					select 1 from SB_WORLD_TIME_ATTACK_USER_GROUP where dungeon_class_id = @dungeonClassID  and dungeon_level_ex = @dungeonLevelEx
					and complete_seconds >= @completeSeconds)
				begin
				delete from SB_WORLD_TIME_ATTACK_USER_GROUP 
				where dungeon_class_id = @dungeonClassID and dungeon_level_ex = @dungeonLevelEx
				
				INSERT into SB_WORLD_TIME_ATTACK_USER_GROUP(infinite_dungeon_set_name, dungeon_level_ex, dungeon_class_id, user_name, complete_seconds, update_time) 
				select @infiniteDungeonSetName, @dungeonLevelEx, @dungeonClassID, su.name, @completeSeconds, GETDATE()
				from @userDBIDs as ud, SB_USER (READUNCOMMITTED) as su
				where ud.dbid = su.ID
				end
			end
		else
			begin
				INSERT into SB_WORLD_TIME_ATTACK_USER_GROUP(infinite_dungeon_set_name, dungeon_level_ex, dungeon_class_id, user_name, complete_seconds, update_time) 
				select @infiniteDungeonSetName, @dungeonLevelEx, @dungeonClassID, su.name, @completeSeconds, GETDATE()
				from @userDBIDs as ud, SB_USER (READUNCOMMITTED) as su
				where ud.dbid = su.ID
			end
		end
	else
		begin
		-- setName 과 levelEx 를 키로 작업
		if exists(select 1 from SB_WORLD_TIME_ATTACK_USER_GROUP where dungeon_level_ex = @dungeonLevelEx 
				and infinite_dungeon_set_name = @infiniteDungeonSetName )
			begin
			if exists(
					select 1 from SB_WORLD_TIME_ATTACK_USER_GROUP where dungeon_level_ex = @dungeonLevelEx 
						and infinite_dungeon_set_name = @infiniteDungeonSetName and complete_seconds >= @completeSeconds)
				begin
				delete from SB_WORLD_TIME_ATTACK_USER_GROUP 
				where dungeon_level_ex = @dungeonLevelEx and infinite_dungeon_set_name = @infiniteDungeonSetName
				
				INSERT into SB_WORLD_TIME_ATTACK_USER_GROUP(infinite_dungeon_set_name, dungeon_level_ex, dungeon_class_id, user_name, complete_seconds, update_time) 
				select @infiniteDungeonSetName, @dungeonLevelEx, @dungeonClassID, su.name, @completeSeconds, GETDATE()
				from @userDBIDs as ud, SB_USER (READUNCOMMITTED) as su
				where ud.dbid = su.ID
				end
			end
		else
			begin
				INSERT into SB_WORLD_TIME_ATTACK_USER_GROUP(infinite_dungeon_set_name, dungeon_level_ex, dungeon_class_id, user_name, complete_seconds, update_time) 
				select @infiniteDungeonSetName, @dungeonLevelEx, @dungeonClassID, su.name, @completeSeconds, GETDATE()
				from @userDBIDs as ud, SB_USER (READUNCOMMITTED) as su
				where ud.dbid = su.ID
			end
		end
END
GO
PRINT N'Creating [dbo].[SB_WriteGuildHistory]'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SB_WriteGuildHistory]
	@guildID INT,
	@type INT,
	@memberName NVARCHAR(64),
	@targetGuildName NVARCHAR(64),
	@targetMemberName NVARCHAR(64),
	@itemDBID BIGINT,
	@itemClassID INT,
	@itemAmount INT,
	@fromGrade INT,
	@toGrade INT,
	@guildLevel INT,
	@money bigint,
	@logTime bigint
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO [dbo].[SB_GUILD_HISTORY] (guildID, historyType, memberName, targetGuildName, targetMemberName, itemDBID, itemClassID, itemAmount, fromGrade, toGrade, guildLevel, [money], logTime)
	VALUES (@guildID, @type, @memberName, @targetGuildName, @targetMemberName, @itemDBID, @itemClassID, @itemAmount, @fromGrade, @toGrade, @guildLevel, @money, [dbo].ConvertToDateTime32(@logTime));
END
GO
PRINT N'Database[GameDB] is created...'
GO
