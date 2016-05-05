using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMSystemModels.Models;

namespace EMSystemModels.Commands
{
    public class CreateNewEmployee
    {
        public Employee Employee { get; set; }
        public List<Address> Adresses { get; set; }
        public List<EmployeeRecord> Records { get; set; }
    }
}
