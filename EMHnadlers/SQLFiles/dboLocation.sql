CREATE TABLE [dboLocation]
(
	[LocationId] INTEGER PRIMARY KEY, 
    [AddressId] INT NOT NULL UNIQUE, 
    [Name] NVARCHAR(50) NOT NULL
)
