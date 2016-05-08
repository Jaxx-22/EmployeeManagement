CREATE TABLE [dboPersonalInformation] (
    [EmployeeId]           INT           NOT NULL PRIMARY KEY,
    [Name]                 NVARCHAR (50) NOT NULL,
    [DateOfBirth]          DATETIME      NOT NULL,
    [SocialSecurityNumber] NCHAR (11)    NOT NULL
)

