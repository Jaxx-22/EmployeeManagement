using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EMSystemModels.Models
{
    public class Location
    {
        public int LocationId { get; set; }
        public Address Address { get; set; }
        public string Name { get; set; }
    }
}
