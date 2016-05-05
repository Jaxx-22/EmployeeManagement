﻿using PetaPoco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EMHandlers.Denormalizers.Models
{
    [TableName("dbo.EmployeeRecord")]
    public class dboEmployeeRecord
    {
        public int EmployeeId { get; set; }
        public int DepartmentId { get; set; }
        public int LocatonId { get; set; }
        public int SupervisorId { get; set; }
        public bool IsSupervisor { get; set; }
        public double Salary { get; set; }
        public DateTime HireDate { get; set; }
    }
}