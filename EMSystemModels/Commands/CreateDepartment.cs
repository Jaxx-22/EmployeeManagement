using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace EMSystemModels.Commands
{
    public class CreateDepartment : DepartmentCommand
    {
        public string Name { get; set; }
    }
}
