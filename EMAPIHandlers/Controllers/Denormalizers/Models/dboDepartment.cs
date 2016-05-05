using PetaPoco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EMAPIHandlers.Controllers.Denormalizers.Models
{
    [TableName("dbo.Department")]
    public class dboDepartment
    {
        public int DepartmentId { get; set; }
        public string Name { get; set; }
    }
}