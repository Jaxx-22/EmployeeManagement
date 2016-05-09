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
        public UpdateRecord()
        {
            Records = new List<EmployeeRecord>();
            RemovedRecords = new List<int>();
        }
        public List<EmployeeRecord> Records { get; set; }
        public List<int> RemovedRecords { get; set; }
    }
}
