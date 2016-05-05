using EMSystemModels.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EMSystemModels.Commands
{
    public class UpdatePersonalInformation : EmployeeCommand
    {
        public Employee Employee { get; set; }
    }
}
