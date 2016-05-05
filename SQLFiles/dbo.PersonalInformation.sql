CREATE TABLE [dbo].[PersonalInformation] (
    [EmployeeId]           INT           NOT NULL,
    [Name]                 NVARCHAR (50) NOT NULL,
    [DateOfBirth]          DATETIME      NOT NULL,
    [SocialSecurityNumber] NCHAR (11)    NOT NULL,
    PRIMARY KEY CLUSTERED ([EmployeeId] ASC)
);

