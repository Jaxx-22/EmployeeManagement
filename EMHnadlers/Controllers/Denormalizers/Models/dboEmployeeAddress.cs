﻿using PetaPoco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EMAPIHandlers.Controllers.Denormalizers.Models
{
    [TableName("dboEmployeeAddresses")]
    public class dboEmployeeAddress
    {
        public int EmployeeId { get; set; }
        public int AddressId { get; set; }
    }
}