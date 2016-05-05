CREATE TABLE [dbo].[Adress]
(
	[AddressId] INT NOT NULL PRIMARY KEY, 
    [Street] NVARCHAR(100) NOT NULL, 
    [City] NVARCHAR(50) NOT NULL, 
    [State] NCHAR(2) NOT NULL, 
    [Zip] NVARCHAR(5) NOT NULL
)
