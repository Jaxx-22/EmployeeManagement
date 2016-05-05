using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;

namespace EMSystemModels.Commands
{
    [DataContract]
    public class UpdateDepartment : DepartmentCommand
    {
        [DataMember]
        public string Name { get; set; }
    }
}
