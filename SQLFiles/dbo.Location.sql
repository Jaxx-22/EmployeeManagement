CREATE TABLE [dbo].[Location]
(
	[LocationId] INT NOT NULL PRIMARY KEY, 
    [AddressId] INT NOT NULL UNIQUE, 
    [Name] NVARCHAR(50) NOT NULL
)
