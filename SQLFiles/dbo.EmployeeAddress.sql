CREATE TABLE [dbo].[EmployeeAddresses]
(
	[EmployeeId] INT NOT NULL,
    [AddressId] INT NOT NULL,
	PRIMARY KEY(EmployeeId, AddressId)
)
