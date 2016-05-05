using PetaPoco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EMHandlers.Denormalizers.Models
{
    [TableName("dbo.EmployeeAddress")]
    public class dboEmployeeAddress
    {
        public int EmployeeId { get; set; }
        public int AddressId { get; set; }
    }
}