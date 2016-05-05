using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace EMSystemModels.Commands
{
    public interface ICommand
    {

    }

    public class EmployeeCommand : ICommand
    {
        [Required]
        public int EmployeeId { get; set; }
    }

    public class DepartmentCommand : ICommand
    {
        [Required]
        public int DepartmentId { get; set; }
    }

    public class LocationCommand : ICommand
    {
        [Required]
        public int LocationId { get; set; }
    }
}
