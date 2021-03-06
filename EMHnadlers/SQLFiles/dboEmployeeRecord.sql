﻿CREATE TABLE [dboEmployeeRecord] (
    [EmployeeId]   INT      NOT NULL,
    [DepartmentId] INT      NOT NULL,
    [LocationId]   INT      NOT NULL,
    [SupervisorId] INT      NULL,
    [Salary]       MONEY    NOT NULL,
    [HireDate]     DATETIME NOT NULL,
    [IsSupervisor] BIT      NOT NULL,
    [SupervisorName] NVARCHAR(50) NULL, 
    PRIMARY KEY ([EmployeeId], [DepartmentId])
);

