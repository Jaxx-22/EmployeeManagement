using EMSystemModels.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EMSystemModels.Commands
{
    public class UpdateRecord : EmployeeCommand
    {
        public List<EmployeeRecord> Records { get; set; }
        public List<int> RemovedRecords { get; set; }
    }
}
