using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EMSystemModels.Models
{
    public class EmployeeRecord
    {
        public Department Department { get; set; }
        public Location Location { get; set; }
        public bool IsSupervisor { get; set; }
        public double Salary { get; set; }
        public Supervisor Supervisor { get; set; }
        public DateTime HireDate { get; set; }
    }
}
