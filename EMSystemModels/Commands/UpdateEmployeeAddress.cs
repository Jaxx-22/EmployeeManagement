using EMSystemModels.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EMSystemModels.Commands
{
    public class UpdateEmployeeAddress : EmployeeCommand
    {
        public UpdateEmployeeAddress()
        {
            Address = new List<Address>();
            RemovedAddress = new List<int>();
        }
        public List<Address> Address { get; set; }
        public List<int> RemovedAddress { get; set; }
    }
}
