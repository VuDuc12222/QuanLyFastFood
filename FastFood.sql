USE [master]
GO
/****** Object:  Database [QuanLyFastFood]   ******/
CREATE DATABASE [QuanLyFastFood]

GO
ALTER DATABASE [QuanLyFastFood] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyFastFood] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyFastFood] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyFastFood] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyFastFood] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyFastFood] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QuanLyFastFood] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyFastFood] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyFastFood] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyFastFood] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyFastFood] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyFastFood] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyFastFood] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyFastFood] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyFastFood] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyFastFood] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyFastFood] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyFastFood] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyFastFood] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyFastFood] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyFastFood] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyFastFood] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyFastFood] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuanLyFastFood] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyFastFood] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyFastFood] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyFastFood] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyFastFood] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuanLyFastFood] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QuanLyFastFood] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QuanLyFastFood', N'ON'
GO
ALTER DATABASE [QuanLyFastFood] SET QUERY_STORE = ON
GO
ALTER DATABASE [QuanLyFastFood] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [QuanLyFastFood]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) 
RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput 
DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) 
SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) 
SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int 
DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) 
BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) 
BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) 
ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) 
BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[UserName] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[PassWord] [nvarchar](1000) NOT NULL,
	[Type] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DateCheckIn] [date] NOT NULL,
	[DateCheckOut] [date] NULL,
	[idTable] [int] NOT NULL,
	[status] [int] NOT NULL,
	[discount] [int] NULL,
	[totalPrice] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillInfo]  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idBill] [int] NOT NULL,
	[idFood] [int] NOT NULL,
	[count] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Food]    Script Date: 8/4/2023 1:56:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[idCategory] [int] NOT NULL,
	[price] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FoodCategory]     ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TableFood]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableFood](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[status] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'Admin', N'Admin', N'1962026656160185351301320480154111117132155', 1)
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'VuHoaDuc', N'VuHoaDuc', N'1962026656160185351301320480154111117132155', 1)

GO
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (25, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 1, 1, 0, 150000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (26, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 2, 1, 0, 250000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (27, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 3, 1, 10, 252000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (28, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 4, 1, 10, 216000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (29, CAST(N'2024-05-24' AS Date), CAST(N'2024-05-24' AS Date), 6, 1, 20, 112000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (30, CAST(N'2024-05-23' AS Date), CAST(N'2024-05-23' AS Date), 2, 1, 0, 60000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (31, CAST(N'2024-05-23' AS Date), CAST(N'2024-05-23' AS Date), 1, 1, 0, 35000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (32, CAST(N'2024-05-23' AS Date), CAST(N'2024-05-23' AS Date), 18, 1, 0, 80000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (33, CAST(N'2024-05-23' AS Date), CAST(N'2024-05-23' AS Date), 6, 1, 0, 90000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (34, CAST(N'2024-05-24' AS Date), NULL, 8, 0, 0, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (35, CAST(N'2024-05-22' AS Date), CAST(N'2024-05-22' AS Date), 2, 1, 0, 155000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (36, CAST(N'2024-05-22' AS Date), CAST(N'2024-05-22' AS Date), 6, 1, 0, 90000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (37, CAST(N'2024-05-22' AS Date), CAST(N'2024-05-22' AS Date), 7, 1, 1, 257400)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (38, CAST(N'2024-05-24' AS Date), NULL, 2, 0, 0, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (39, CAST(N'2024-05-22' AS Date), CAST(N'2024-05-22' AS Date), 1, 1, 0, 370000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (40, CAST(N'2024-05-21' AS Date), CAST(N'2024-05-21' AS Date), 4, 1, 0, 170000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (41, CAST(N'2024-05-21' AS Date), CAST(N'2024-05-21' AS Date), 9, 1, 2, 166600)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (42, CAST(N'2024-05-21' AS Date), CAST(N'2024-05-21' AS Date), 6, 1, 0, 390000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (43, CAST(N'2024-05-21' AS Date), CAST(N'2024-05-21' AS Date), 1, 1, 2, 137200)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (44, CAST(N'2024-05-21' AS Date), CAST(N'2024-05-21' AS Date), 21, 1, 2, 235200)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (45, CAST(N'2024-05-20' AS Date), CAST(N'2024-05-20' AS Date), 10, 1, 2, 98000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (46, CAST(N'2024-05-20' AS Date), NULL, 23, 0, 0, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (47, CAST(N'2024-05-20' AS Date), CAST(N'2024-05-20' AS Date), 25, 1, 0, 50000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (48, CAST(N'2024-05-20' AS Date), CAST(N'2024-05-20' AS Date), 21, 1, 2, 117600)
SET IDENTITY_INSERT [dbo].[Bill] OFF
GO
SET IDENTITY_INSERT [dbo].[BillInfo] ON 

INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (47, 25, 5, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (49, 26, 3, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (50, 26, 5, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (51, 27, 5, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (52, 27, 3, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (56, 29, 5, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (57, 29, 6, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (58, 29, 3, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (61, 30, 5, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (63, 31, 8, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (67, 32, 5, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (68, 32, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (70, 33, 6, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (71, 33, 18, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (73, 34, 19, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (74, 34, 3, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (75, 34, 13, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (77, 35, 14, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (78, 35, 5, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (79, 35, 6, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (80, 36, 6, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (81, 36, 2, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (84, 37, 9, 7)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (85, 37, 10, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (87, 38, 13, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (88, 38, 6, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (89, 39, 6, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (90, 40, 6, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (91, 41, 21, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (92, 39, 5, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (93, 39, 25, 4)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (94, 40, 17, 7)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (95, 40, 19, 4)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (96, 42, 20, 4)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (97, 42, 22, 4)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (98, 42, 11, 7)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (99, 42, 5, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (100, 43, 12, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (101, 43, 6, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (102, 43, 20, 4)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (103, 43, 26, 4)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (104, 44, 26, 4)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (105, 44, 5, 4)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (106, 44, 7, 4)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (107, 45, 8, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (108, 38, 8, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (109, 41, 12, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (110, 34, 12, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (111, 46, 12, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (112, 47, 12, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (113, 41, 27, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (114, 41, 6, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (115, 48, 6, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (116, 48, 21, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (117, 37, 12, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (118, 37, 6, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (119, 37, 29, 4)
SET IDENTITY_INSERT [dbo].[BillInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[Food] ON 

INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (1, N'Gà rán vị truyền thống', 2, 30000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (2, N'Kimbap chay', 3, 30000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (3, N'CocaCola', 4, 10000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (4, N'Kimbap cuộn nhân xúc xích', 3, 35000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (5, N'Pizza bò trứng phô mai', 1, 50000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (6, N'Pizza gà nấm rơm', 1, 40000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (7, N'Pizza xúc xích phô mai chảy', 1, 45000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (8, N'Đùi gà rán giòn vị phô mai', 2, 45000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (9, N'Cánh gà giòn', 2, 30000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (10, N'Má đùi gà sốt mù tạt', 2, 45000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (11, N'7Up', 4, 10000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (12, N'Sprite', 4, 10000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (13, N'Pepssi', 4, 10000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (14, N'StrongBow Táo', 4, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (15, N'StrongBow Dâu', 4, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (16, N'Kimbap trứng', 3, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (17, N'Kimbap rau củ', 3, 30000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (18, N'Kimbap tam giác cá ngừ', 3, 30000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (19, N'Pizza rau củ', 1, 30000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (20, N'Pizza thịt bằm', 1, 30000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (21, N'Xúc xích chiên', 10, 10000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (22, N'Khoai tây chiên', 10, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (23, N'Cá viên chiên', 10, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (24, N'Đậu hũ non chiên', 10, 30000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (26, N'Bánh mì thập cẩm', 6, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (26, N'Bánh mì thịt nướng', 6, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (27, N'Bánh mì chả cá', 6, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (28, N'Hamburger bò Mỹ', 5, 30000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (29, N'Pizzaksfhl', 1, 100000)
SET IDENTITY_INSERT [dbo].[Food] OFF
GO
SET IDENTITY_INSERT [dbo].[FoodCategory] ON 

INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (1, N'Pizza')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (2, N'Gà rán')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (3, N'Kimbap')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (4, N'Nước uống có ga')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (5, N'Hamburger')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (6, N'Bánh mì')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (9, N'Pizza nhiều')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (10, N'Đồ chiên')
SET IDENTITY_INSERT [dbo].[FoodCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[TableFood] ON 

INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (1, N'Bàn 1', N' ')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (2, N'Bàn 2', N' ')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (3, N'Bàn 3', N' ')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (4, N'Bàn 4', N' ')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (5, N'Bàn 5', N' ')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (6, N'Bàn 6', N' ')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (7, N'Bàn 7', N' ')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (8, N'Bàn 8', N' ')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (9, N'Bàn 9', N' ')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (10, N'Bàn 10', N' ')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (11, N'Bàn Vip 1', N' ')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (12, N'Bàn Vip 2', N' ')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (13, N'Bàn VVip 1', N' ')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (14, N'Bàn VVip 2', N' ')
SET IDENTITY_INSERT [dbo].[TableFood] OFF
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT (N'HoaDuc') FOR [DisplayName]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [PassWord]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [Type]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT (getdate()) FOR [DateCheckIn]
GO
ALTER TABLE [dbo].[BillInfo] ADD  DEFAULT ((0)) FOR [count]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[FoodCategory] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Bàn chưa có tên') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Trống') FOR [status]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([idTable])
REFERENCES [dbo].[TableFood] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idBill])
REFERENCES [dbo].[Bill] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idFood])
REFERENCES [dbo].[Food] ([id])
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD FOREIGN KEY([idCategory])
REFERENCES [dbo].[FoodCategory] ([id])
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAccountByUserName]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetAccountByUserName]
@userName nvarchar(100)
AS
begin
	select * from Account where UserName = @userName
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDate]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetListBillByDate]
@checkIn date, @checkOut date
as
begin
	select t.name as [Tên bàn] , b.totalPrice as [Tổng tiền] , DateCheckIn as [Ngày vào], DateCheckOut as [Ngày ra], discount as [Giảm giá]
	from dbo.Bill as b, dbo.TableFood as t
	where DateCheckIn >= @checkIn and DateCheckOut <= @checkOut and b.status = 1
	and t.id = b.idTable
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDateReport]  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetListBillByDateReport]
@checkIn date, @checkOut date
as
begin
	select t.name  , b.totalPrice  , DateCheckIn , DateCheckOut , discount 
	from dbo.Bill as b, dbo.TableFood as t
	where DateCheckIn >= @checkIn and DateCheckOut <= @checkOut and b.status = 1
	and t.id = b.idTable
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListFoodByCategory]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_GetListFoodByCategory]
@namef nvarchar(100)
as
begin
	select    b.name  , b.id , price
	from dbo.Food as b, dbo.FoodCategory as t
	
	where  @namef = t.name and t.id = b.idCategory 
	
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetTableList]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetTableList]
as select * from dbo.TableFood
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBill]     ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[USP_InsertBill]
@idTable Int
as
begin
	insert dbo.Bill (DateCheckIn, DateCheckOut, idTable, status, discount)
	values (GETDATE(), Null, @idTable,0,0)
	end
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfo]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_InsertBillInfo]
@idBill Int, @idFood int, @count int
as
begin

	declare @isEXitsBillInfo int
	declare @foodCount int = 1

	select @isEXitsBillInfo = id, @foodCount = b.count
	from dbo.BillInfo as b
	where idBill = @idBill and idFood = @idFood

	if(@isEXitsBillInfo > 0)
	begin
		declare @newCount int = @foodCount + @count
		if(@newCount > 0)
		update dbo.BillInfo set count = @foodCount + @count 
		where idFood = @idFood
		else
		delete dbo.BillInfo where idBill = @idBill and idFood = @idFood
		end
		else
		begin
			insert dbo.BillInfo(idBill, idFood, count)
			values (@idBill, @idFood, @count)
		end
		end
GO
/****** Object:  StoredProcedure [dbo].[USP_Login]     ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_Login]
@userName nvarchar(100), @passWord nvarchar(100)
as
begin
	select * from dbo.Account WHERE UserName = @userName AND PassWord = @passWord
end
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccount]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_UpdateAccount]
@userName NVARCHAR(100), @displayName NVARCHAR(100), @password NVARCHAR(100), @newPassword NVARCHAR(100)
AS
BEGIN
	DECLARE @isRightPass INT = 0
	
	SELECT @isRightPass = COUNT(*) FROM dbo.Account WHERE USERName = @userName AND PassWord = @password
	
	IF (@isRightPass = 1)
	BEGIN
		IF (@newPassword = NULL OR @newPassword = '')
		BEGIN
			UPDATE dbo.Account SET DisplayName = @displayName WHERE UserName = @userName
		END		
		ELSE
			UPDATE dbo.Account SET DisplayName = @displayName, PassWord = @newPassword WHERE UserName = @userName
	end
END
GO
USE [master]
GO
ALTER DATABASE [QuanLyFastFood] SET  READ_WRITE 
GO
